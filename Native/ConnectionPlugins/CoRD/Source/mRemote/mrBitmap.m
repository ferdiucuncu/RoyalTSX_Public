//
//  mrBitmap.m
//  mRemoteMac
//
//  Created by Felix Deimel on 16.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Quartz/Quartz.h>

#import "mrBitmap.h"
#import "remojoRdesktopController.h"
#import "mrShared.h"
#import "mrSessionView.h"

@implementation mrBitmap

// Currently is adequately optimized: only somewhat critical
- (id)initWithBitmapData:(const unsigned char *)sourceBitmap size:(NSSize)s view:(mrSessionView *)v
{
	if (!(self = [super init]))
		return nil;
    
	int bitsPerPixel = [v bitsPerPixel],  bytesPerPixel = (bitsPerPixel + 7) / 8;
	
	uint8 *outputBitmap, *nc;
	const uint8 *p, *end;
	unsigned realLength, newLength;
	unsigned int *colorMap;
	int width = (int)s.width, height = (int)s.height;
	
	realLength = width * height * bytesPerPixel;
	newLength = width * height * 4;
	
	p = sourceBitmap;
	end = p + realLength;
	
	nc = outputBitmap = malloc(newLength);
	
	if (bitsPerPixel == 8)
	{
		colorMap = [v colorMap];
		while (p < end)
		{
			nc[0] = 255;
			nc[1] = colorMap[*p] & 0xff;
			nc[2] = (colorMap[*p] >> 8) & 0xff;
			nc[3] = (colorMap[*p] >> 16) & 0xff;
			
			p++;
			nc += 4;
		}
	}
	else if (bitsPerPixel == 16)
	{
		while (p < end)
		{
			unsigned short c = p[0] | (p[1] << 8);
            
			nc[0] = 255;
			nc[1] = (( (c >> 11) & 0x1f) * 255 + 15) / 31;
			nc[2] = (( (c >> 5) & 0x3f) * 255 + 31) / 63;
			nc[3] = ((c & 0x1f) * 255 + 15) / 31;
			
			p += bytesPerPixel;
			nc += 4;
		}
	}
	else if (bitsPerPixel == 15)
	{
		while (p < end)
		{
			unsigned short c = p[0] | (p[1] << 8);
            
			nc[0] = 255;
			nc[1] = (( (c >> 10) & 0x1f) * 255 + 15) / 31;
			nc[2] = (( (c >> 5) & 0x1f) * 255 + 15) / 31;
			nc[3] = ((c & 0x1f) * 255 + 15) / 31;
			
			p += bytesPerPixel;
			nc += 4;
		}
	}
	else if (bitsPerPixel == 24 || bitsPerPixel == 32)
	{
		while (p < end)
		{
			nc[0] = 255;
			nc[1] = p[2];
			nc[2] = p[1];
			nc[3] = p[0];
			
			p += bytesPerPixel;
			nc += 4;
		}
	}
	
	data = [[NSData alloc] initWithBytesNoCopy:(void *)outputBitmap length:newLength];
	
	unsigned char *planes[2] = {(unsigned char *)[data bytes], NULL};
	
	NSBitmapImageRep *bitmap = [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes
                                                                        pixelsWide:width
                                                                        pixelsHigh:height
                                                                     bitsPerSample:8
                                                                   samplesPerPixel:4
                                                                          hasAlpha:YES
                                                                          isPlanar:NO
                                                                    colorSpaceName:NSDeviceRGBColorSpace
                                                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                                                       bytesPerRow:width * 4
                                                                      bitsPerPixel:32] autorelease];
	
	image = [[NSImage alloc] init];
	[image addRepresentation:bitmap];
	[image setFlipped:YES];
	
	return self;
}

// Somewhat critical region: many glyph mrBitmaps are created, one for each character drawn, as well as some when patterns are drawn. Currently efficient enough.
- (id)initWithGlyphData:(const unsigned char *)d size:(NSSize)s view:(mrSessionView *)v
{	
	if (!(self = [super init]))
		return nil;
	
	int width = s.width, height = s.height, scanline = ((int)width + 7) / 8;
	
	data = [[NSData alloc] initWithBytes:d length:scanline * height];
    
	unsigned char *planes[2] = {(unsigned char *)[data bytes], (unsigned char *)[data bytes]};
	
	NSBitmapImageRep *bitmap = [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes
                                                                        pixelsWide:width
                                                                        pixelsHigh:height
                                                                     bitsPerSample:1
                                                                   samplesPerPixel:2
                                                                          hasAlpha:YES
                                                                          isPlanar:YES
                                                                    colorSpaceName:NSDeviceBlackColorSpace
                                                                       bytesPerRow:scanline
                                                                      bitsPerPixel:0] autorelease];	
	
	image = [[NSImage alloc] init];
	[image addRepresentation:bitmap];
	[image setFlipped:YES];
	[self setColor:[NSColor blackColor]];
	
	return self;
}

// Not a performance critical region
- (id)initWithCursorData:(const unsigned char *)xorMask alpha:(const unsigned char *)andMask size:(NSSize)s hotspot:(NSPoint)hotspot view:(mrSessionView *)v bpp:(int)bpp
{	
	if (!(self = [super init]))
		return nil;
    
	int w = roundf(s.width), h = roundf(s.height);
	
	if (!w || !h)
	{
		image = [[NSImage alloc] initWithSize:NSMakeSize(1,1)];		
		cursor = [[NSCursor alloc] initWithImage:image hotSpot:hotspot];
		return self;
	}
    
	int andScanlineLength = mrRoundUpToEven(s.width/8.0f), xorScanlineLength = mrRoundUpToEven(s.width * bpp / 8.0f);
	const uint8 *d = xorMask, *a = andMask;
    
	data = [[NSMutableData alloc] initWithCapacity:(int)s.width * (int)s.height * 4];
	uint8 *np = (uint8 *)[data bytes];
	
	unsigned short c;
	unsigned int alphaBit, alphaIndex, x, *colorMap = [v colorMap];
    
	for (int i = 0; i < h; i++)
	{
		a = andMask + andScanlineLength * i;
		d = xorMask + xorScanlineLength * i;
		
		for (int j = 0; j < w; j++)
		{
			alphaBit = a[j/8] & (0x80 >> (j % 8));
			
			switch (bpp)
			{
				case 1:
					x = (d[j/8] & (0x80 >> (j % 8))) ^ alphaBit;
					np[0] = np[1] = np[2] = x ? 0xff : 0;					
					np[3] = (alphaBit && x) ? 0 : 0xff;
					break;
					
				case 4: // two colormap indices packed into each byte
					if (j % 2)
					{
						c = ((*d) & 0xf0) >> 4;
						d++;
					}
					else
						c = *d & 0xf;
					
					np[0] = colorMap[c] & 0xff;
					np[1] = (colorMap[c] >> 8) & 0xff;
					np[2] = (colorMap[c] >> 16) & 0xff;
					np[3] = alphaBit ? 0 : 0xff;
					break;
                    
				case 8:
					np[0] = colorMap[*d] & 0xff;
					np[1] = (colorMap[*d] >> 8) & 0xff;
					np[2] = (colorMap[*d] >> 16) & 0xff;
					np[3] = alphaBit ? 0 : 0xff;
					d++;	
					break;
					
				case 15:
					c = d[0] | (d[1] << 8);
                    
					np[0] = (( (c >> 10) & 0x1f) * 255 + 15) / 31;
					np[1] = (( (c >> 5) & 0x1f) * 255 + 15) / 31;
					np[2] = ((c & 0x1f) * 255 + 15) / 31;
					np[3] = alphaBit ? 0 : 0xff;
					break;
					
				case 16:
					c = d[0] | (d[1] << 8);
					
					np[0] = (( (c >> 11) & 0x1f) * 255 + 15) / 31;
					np[1] = (( (c >> 5) & 0x3f) * 255 + 31) / 63;
					np[2] = ((c & 0x1f) * 255 + 15) / 31;
					np[3] = alphaBit ? 0 : 0xff;
					
					d += 2;		
					break;
					
				case 24:
					np[0] = d[2];
					np[1] = d[1];
					np[2] = d[0]; 
					np[3] = alphaBit ? 0 : 0xff; 
					d += 3;
					break;
                    
				case 32:
					np[0] = d[2];
					np[1] = d[1];
					np[2] = d[0];
					np[3] = d[3];			
					d += 4;
					break;
                    
                    
				default:
					mrLog(mrLogLevelError, @"Error Rendering Cursor - Unknown Bitrate: %i", bpp);
					np[0] = np[1] = np[2] = 0;
					np[3] = 0xff;
					break;
			}
            
			np += 4;
		}
	}
	
	
	unsigned char *planes[2] = {(unsigned char *)[data bytes], NULL};
	NSBitmapImageRep *bitmap = [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes
                                                                        pixelsWide:s.width
                                                                        pixelsHigh:s.height
                                                                     bitsPerSample:8
                                                                   samplesPerPixel:4
                                                                          hasAlpha:YES
                                                                          isPlanar:NO
                                                                    colorSpaceName:NSDeviceRGBColorSpace
                                                                       bytesPerRow:w * 4
                                                                      bitsPerPixel:0] autorelease];	
	
	image = [[NSImage alloc] init];
	[image addRepresentation:bitmap];
	
	if (bpp != 1)
		[image setFlipped:YES];
	
	cursor = [[NSCursor alloc] initWithImage:image hotSpot:hotspot];
    
	return self;
}

- (id)initWithImage:(NSImage *)img
{
	if (!(self = [super init]))
        return nil;
	
	image = [img retain];
	
	return self;
}

#pragma mark -
#pragma mark Drawing the mrBitmap

// The most critical region of this class and one of the most critical paths in the connection thread
- (void)drawInRect:(NSRect)dstRect fromRect:(NSRect)srcRect operation:(NSCompositingOperation)op
{
	[image drawInRect:dstRect fromRect:srcRect operation:op fraction:1.0];
}


#pragma mark -
#pragma mark Manipulating the bitmap

- (void)overlayColor:(NSColor *)c
{
	[image lockFocus]; {
		[c setFill];
		NSRectFillUsingOperation(mrRectFromSize([image size]), NSCompositeSourceAtop);
	} [image unlockFocus];
}

- (mrBitmap *)invert
{ 
	NSData *tiffData = [image TIFFRepresentation];
	CIImage *ci = [CIImage imageWithData:tiffData];
    
	if([image isFlipped]) {
		NSAffineTransform *affineTransform = [NSAffineTransform transform];
		[affineTransform translateXBy:0 yBy:128];
		[affineTransform scaleXBy:1 yBy:-1];
        
		CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
		[transform setValue:ci forKey:@"inputImage"];
		[transform setValue:affineTransform forKey:@"inputTransform"];
        
		// get the new CIImage, flipped and ready to serve
		ci = [transform valueForKey:@"outputImage"];
	}
    
	CIFilter *invert = [CIFilter filterWithName:@"CIColorInvert"];
	[invert setValue:ci forKey:@"inputImage"];
	ci = [invert valueForKey:@"outputImage"];
    
	int width = [ci extent].size.width;
	int rows = [ci extent].size.height;
	int rowBytes = (width * 4);
	
	NSBitmapImageRep* rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil pixelsWide:width pixelsHigh:rows bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace bitmapFormat:0 bytesPerRow:rowBytes bitsPerPixel:0];
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName ( kCGColorSpaceGenericRGB );
	CGContextRef context = CGBitmapContextCreate([rep bitmapData], width, rows, 8, rowBytes, colorSpace, kCGImageAlphaPremultipliedLast );
    
	CIContext* ciContext = [CIContext contextWithCGContext:context options:nil];
	[ciContext drawImage:ci atPoint:CGPointZero fromRect: [ci extent]];
    
	CGContextRelease( context );
	CGColorSpaceRelease( colorSpace );
    
	NSImage *invertedImage = [[[NSImage alloc] initWithSize:NSMakeSize([ci extent].size.width, [ci extent].size.height)] autorelease];
	[invertedImage addRepresentation:rep];
	[rep release];
    
	return [[[mrBitmap alloc] initWithImage:invertedImage] autorelease];
} 

#pragma mark -
#pragma mark Accessors
-(NSImage *)image
{
	return image;
}

-(void)dealloc
{
	[cursor release];
	[image release];
	[data release];
	[color release];
	[super dealloc];
}

-(void)setColor:(NSColor *)c
{
	if (c == color)
		return;
    
	[color release];
	color = [c retain];
}

-(NSColor *)color
{
	return color;
}

-(NSCursor *)cursor
{
	return cursor;
}

@end
