FasdUAS 1.101.10   ��   ��    k             l     ��  ��    $  Export all connections to CSV     � 	 	 <   E x p o r t   a l l   c o n n e c t i o n s   t o   C S V   
  
 l     ��������  ��  ��        l    � ����  O     �    k    �       l   ��  ��      Get file to write to     �   *   G e t   f i l e   t o   w r i t e   t o      r        c        l    ����  I   ���� 
�� .sysonwflfile    ��� null��    ��   
�� 
prmt  m     ! ! � " "  E x p o r t   a s   C S V   �� # $
�� 
dfnm # m    	 % % � & & ( R o y a l   T S X   E x p o r t . c s v $ �� '��
�� 
dflc ' I  
 �� (��
�� .earsffdralis        afdr ( m   
 ��
�� afdrdesk��  ��  ��  ��    m    ��
�� 
ctxt  o      ���� 0 csvfilepath csvFilePath   ) * ) l   ��������  ��  ��   *  + , + l   �� - .��   - 3 - Append .csv if file path does not contain it    . � / / Z   A p p e n d   . c s v   i f   f i l e   p a t h   d o e s   n o t   c o n t a i n   i t ,  0 1 0 Z   ( 2 3���� 2 H     4 4 D     5 6 5 o    ���� 0 csvfilepath csvFilePath 6 m     7 7 � 8 8  . c s v 3 r    $ 9 : 9 b    " ; < ; o     ���� 0 csvfilepath csvFilePath < m     ! = = � > >  . c s v : o      ���� 0 csvfilepath csvFilePath��  ��   1  ? @ ? l  ) )��������  ��  ��   @  A B A l  ) )�� C D��   C , & Get IDs properties of all connections    D � E E L   G e t   I D s   p r o p e r t i e s   o f   a l l   c o n n e c t i o n s B  F G F r   ) 2 H I H n   ) . J K J 1   , .��
�� 
ID00 K 2  ) ,��
�� 
RCON I o      ���� 0 conids conIds G  L M L l  3 3��������  ��  ��   M  N O N l  3 3�� P Q��   P   Write CSV Header    Q � R R "   W r i t e   C S V   H e a d e r O  S T S r   3 M U V U n  3 I W X W I   4 I�� Y���� 0 createcsvrow createCSVRow Y  Z [ Z J   4 < \ \  ] ^ ] m   4 7 _ _ � ` `  N a m e ^  a�� a m   7 : b b � c c  U R I��   [  d e d m   < =��
�� boovfals e  f g f m   = @ h h � i i  ; g  j�� j 1   @ C��
�� 
quot��  ��   X  f   3 4 V o      ���� 0 	csvheader 	csvHeader T  k l k n  N \ m n m I   O \�� o���� 0 writetofile writeToFile o  p q p b   O V r s r o   O R���� 0 	csvheader 	csvHeader s 1   R U��
�� 
lnfd q  t u t o   V W���� 0 csvfilepath csvFilePath u  v�� v m   W X��
�� boovfals��  ��   n  f   N O l  w x w l  ] ]��������  ��  ��   x  y z y l  ] ]�� { |��   { &   Loop through all connection IDs    | � } } @   L o o p   t h r o u g h   a l l   c o n n e c t i o n   I D s z  ~�� ~ X   ] � �� �  k   s � � �  � � � l  s s�� � ���   �    Get the connection's Name    � � � � 4   G e t   t h e   c o n n e c t i o n ' s   N a m e �  � � � r   s � � � � I  s ����� �
�� .GETPROP0null��� ��� null��   � �� � �
�� 
OFKE � m   w z � � � � �  N a m e � �� ���
�� 
FRID � o   } ~���� 0 conid conId��   � o      ���� 0 conname conName �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Get the connection's URI    � � � � 2   G e t   t h e   c o n n e c t i o n ' s   U R I �  � � � r   � � � � � I  � ����� �
�� .GETPROP0null��� ��� null��   � �� � �
�� 
OFKE � m   � � � � � � �  U R I � �� ���
�� 
FRID � o   � ����� 0 conid conId��   � o      ���� 0 conuri conUri �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Write line to CSV file    � � � � .   W r i t e   l i n e   t o   C S V   f i l e �  � � � r   � � � � � n  � � � � � I   � ��� ����� 0 createcsvrow createCSVRow �  � � � J   � � � �  � � � o   � ����� 0 conname conName �  ��� � o   � ����� 0 conuri conUri��   �  � � � m   � ���
�� boovfals �  � � � m   � � � � � � �  ; �  ��� � 1   � ���
�� 
quot��  ��   �  f   � � � o      ���� 0 csvline csvLine �  ��� � n  � � � � � I   � ��� ����� 0 writetofile writeToFile �  � � � b   � � � � � o   � ����� 0 csvline csvLine � 1   � ���
�� 
lnfd �  � � � o   � ����� 0 csvfilepath csvFilePath �  ��� � m   � ���
�� boovtrue��  ��   �  f   � ���  �� 0 conid conId � o   ` c���� 0 conids conIds��    m      � �L                                                                                      @ alis    �  OSX                        ��ʞH+  ':�RoyalTSX.app                                                   " <�Yv        ����  	                Debug     ��~      �YY�    ,':� #� #� #� #� �� �< �l � �( e  iOSX:Users: fx: Development: Mono: RoyalFamily: RoyalTSX: Managed: App: RoyalTSX: bin: Debug: RoyalTSX.app     R o y a l T S X . a p p    O S X  ZUsers/fx/Development/Mono/RoyalFamily/RoyalTSX/Managed/App/RoyalTSX/bin/Debug/RoyalTSX.app  /    	��  ��  ��     � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   Helper functions    � � � � "   H e l p e r   f u n c t i o n s �  � � � l     ��������  ��  ��   �  � � � i      � � � I      �� ����� 0 createcsvrow createCSVRow �  � � � o      ���� 0 thelist theList �  � � � o      ���� 0 alwaysquote alwaysQuote �  � � � o      ����  0 fieldseparator fieldSeparator �  ��� � o      ���� 0 textindicator textIndicator��  ��   � k     ? � �  � � � Y     $ ��� � ��� � r     � � � I    �� ����� 0 quotecsvfield quoteCSVField �  � � � n     � � � 4    �� �
�� 
cobj � o    ���� 0 x   � o    ���� 0 thelist theList �  � � � o    ���� 0 alwaysquote alwaysQuote �  � � � o    ����  0 fieldseparator fieldSeparator �  �� � o    �~�~ 0 textindicator textIndicator�  ��   � n       � � � 4    �} �
�} 
cobj � o    �|�| 0 x   � o    �{�{ 0 thelist theList�� 0 x   � m    �z�z  � I   	�y ��x
�y .corecnte****       **** � o    �w�w 0 thelist theList�x  ��   �  � � � l  % %�v�u�t�v  �u  �t   �  � � � r   % * � � � n  % ( � � � 1   & (�s
�s 
txdl � 1   % &�r
�r 
ascr � o      �q�q 0 oldtid oldTID �  �  � r   + 0 o   + ,�p�p  0 fieldseparator fieldSeparator n      1   - /�o
�o 
txdl 1   , -�n
�n 
ascr   r   1 6 c   1 4	
	 o   1 2�m�m 0 thelist theList
 m   2 3�l
�l 
TEXT o      �k�k 0 csvrow csvRow  r   7 < o   7 8�j�j 0 oldtid oldTID n      1   9 ;�i
�i 
txdl 1   8 9�h
�h 
ascr �g L   = ? o   = >�f�f 0 csvrow csvRow�g   �  l     �e�d�c�e  �d  �c    i     I      �b�a�b 0 quotecsvfield quoteCSVField  o      �`�` 0 plainstring plainString  o      �_�_ 0 alwaysquote alwaysQuote  o      �^�^  0 fieldseparator fieldSeparator  �]  o      �\�\ 0 textindicator textIndicator�]  �a   Z     E!"�[#! G     $%$ G     	&'& o     �Z�Z 0 alwaysquote alwaysQuote' E    ()( o    �Y�Y 0 plainstring plainString) o    �X�X  0 fieldseparator fieldSeparator% E    *+* o    �W�W 0 plainstring plainString+ o    �V�V 0 textindicator textIndicator" k    @,, -.- r    /0/ n   121 1    �U
�U 
txdl2 1    �T
�T 
ascr0 o      �S�S 0 oldtid oldTID. 343 r    565 o    �R�R 0 textindicator textIndicator6 n     787 1    �Q
�Q 
txdl8 1    �P
�P 
ascr4 9:9 r     %;<; n     #=>= 2  ! #�O
�O 
citm> o     !�N�N 0 plainstring plainString< o      �M�M 0 	textitems 	textItems: ?@? r   & -ABA b   & )CDC o   & '�L�L 0 textindicator textIndicatorD o   ' (�K�K 0 textindicator textIndicatorB n     EFE 1   * ,�J
�J 
txdlF 1   ) *�I
�I 
ascr@ GHG r   . 3IJI c   . 1KLK o   . /�H�H 0 	textitems 	textItemsL m   / 0�G
�G 
TEXTJ o      �F�F 0 str  H MNM r   4 9OPO o   4 5�E�E 0 oldtid oldTIDP n     QRQ 1   6 8�D
�D 
txdlR 1   5 6�C
�C 
ascrN S�BS L   : @TT b   : ?UVU b   : =WXW o   : ;�A�A 0 textindicator textIndicatorX o   ; <�@�@ 0 str  V o   = >�?�? 0 textindicator textIndicator�B  �[  # L   C EYY o   C D�>�> 0 plainstring plainString Z[Z l     �=�<�;�=  �<  �;  [ \�:\ i    ]^] I      �9_�8�9 0 writetofile writeToFile_ `a` o      �7�7 0 	this_data  a bcb o      �6�6 0 target_file  c d�5d o      �4�4 0 append_data  �5  �8  ^ l    Yefge Q     Yhijh k    :kk lml r    non c    pqp l   r�3�2r o    �1�1 0 target_file  �3  �2  q m    �0
�0 
ctxto l     s�/�.s o      �-�- 0 target_file  �/  �.  m tut r   	 vwv l 	 	 x�,�+x I  	 �*yz
�* .rdwropenshor       filey 4   	 �){
�) 
file{ o    �(�( 0 target_file  z �'|�&
�' 
perm| m    �%
�% boovtrue�&  �,  �+  w l     }�$�#} o      �"�" 0 open_target_file  �$  �#  u ~~ Z   '���!� � =   ��� o    �� 0 append_data  � m    �
� boovfals� l 	  #���� I   #���
� .rdwrseofnull���     ****� l   ���� o    �� 0 open_target_file  �  �  � ���
� 
set2� m    ��  �  �  �  �!  �    ��� I  ( 1���
� .rdwrwritnull���     ****� o   ( )�� 0 	this_data  � ���
� 
refn� l  * +���� o   * +�� 0 open_target_file  �  �  � ���
� 
wrat� m   , -�
� rdwreof �  � ��� I  2 7���

� .rdwrclosnull���     ****� l  2 3��	�� o   2 3�� 0 open_target_file  �	  �  �
  � ��� L   8 :�� m   8 9�
� boovtrue�  i R      ���
� .ascrerr ****      � ****�  �  j k   B Y�� ��� Q   B V���� I  E M� ���
�  .rdwrclosnull���     ****� 4   E I���
�� 
file� o   G H���� 0 target_file  ��  � R      ������
�� .ascrerr ****      � ****��  ��  �  � ���� L   W Y�� m   W X��
�� boovfals��  f - ' (string, file path as string, boolean)   g ��� N   ( s t r i n g ,   f i l e   p a t h   a s   s t r i n g ,   b o o l e a n )�:       ���������  � ���������� 0 createcsvrow createCSVRow�� 0 quotecsvfield quoteCSVField�� 0 writetofile writeToFile
�� .aevtoappnull  �   � ****� �� ����������� 0 createcsvrow createCSVRow�� ����� �  ���������� 0 thelist theList�� 0 alwaysquote alwaysQuote��  0 fieldseparator fieldSeparator�� 0 textindicator textIndicator��  � ���������������� 0 thelist theList�� 0 alwaysquote alwaysQuote��  0 fieldseparator fieldSeparator�� 0 textindicator textIndicator�� 0 x  �� 0 oldtid oldTID�� 0 csvrow csvRow� ��������������
�� .corecnte****       ****
�� 
cobj�� �� 0 quotecsvfield quoteCSVField
�� 
ascr
�� 
txdl
�� 
TEXT�� @ #k�j  kh *��/����+ ��/F[OY��O��,E�O���,FO��&E�O���,FO�� ������������ 0 quotecsvfield quoteCSVField�� ����� �  ���������� 0 plainstring plainString�� 0 alwaysquote alwaysQuote��  0 fieldseparator fieldSeparator�� 0 textindicator textIndicator��  � ���������������� 0 plainstring plainString�� 0 alwaysquote alwaysQuote��  0 fieldseparator fieldSeparator�� 0 textindicator textIndicator�� 0 oldtid oldTID�� 0 	textitems 	textItems�� 0 str  � ����������
�� 
bool
�� 
ascr
�� 
txdl
�� 
citm
�� 
TEXT�� F�
 ���&
 ���& 1��,E�O���,FO��-E�O��%��,FO��&E�O���,FO��%�%Y �� ��^���������� 0 writetofile writeToFile�� ����� �  �������� 0 	this_data  �� 0 target_file  �� 0 append_data  ��  � ���������� 0 	this_data  �� 0 target_file  �� 0 append_data  �� 0 open_target_file  � ����������������������������
�� 
ctxt
�� 
file
�� 
perm
�� .rdwropenshor       file
�� 
set2
�� .rdwrseofnull���     ****
�� 
refn
�� 
wrat
�� rdwreof �� 
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****��  ��  �� Z <��&E�O*�/�el E�O�f  ��jl Y hO����� 
O�j OeW X   *�/j W X  hOf� �����������
�� .aevtoappnull  �   � ****� k     ���  ����  ��  ��  � ���� 0 conid conId� & ��� !�� %�������������� 7 =������ _ b h�������������������� ������� ��� ���
�� 
prmt
�� 
dfnm
�� 
dflc
�� afdrdesk
�� .earsffdralis        afdr�� 
�� .sysonwflfile    ��� null
�� 
ctxt�� 0 csvfilepath csvFilePath
�� 
RCON
�� 
ID00�� 0 conids conIds
�� 
quot�� �� 0 createcsvrow createCSVRow�� 0 	csvheader 	csvHeader
�� 
lnfd�� 0 writetofile writeToFile
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
OFKE
�� 
FRID
�� .GETPROP0null��� ��� null�� 0 conname conName�� 0 conuri conUri�� 0 csvline csvLine�� �� �*������j � 	�&E�O�� 
��%E�Y hO*�-�,E` O)a a lvfa _ a + E` O)_ _ %�fm+ O o_ [a a l kh  *a a a �a   E` !O*a a "a �a   E` #O)_ !_ #lvfa $_ a + E` %O)_ %_ %�em+ [OY��Uascr  ��ޭ