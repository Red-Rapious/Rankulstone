GDPC                                                                             #   <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�P      �      �p��<f��r�g��.�    res://Scenes/Battle_Screen.tscn p
      e      {B�K{��Xf�@�uO$   res://Scenes/Menus/Group/Top.tscn   �      g      �b~ /�Ӳ�$����*$   res://Scenes/Menus/Join_Screen.tscn P      �      �'X��ɪY{}���I��$   res://Scenes/Menus/Lobby_Screen.tscn�            ��`1T�x�8<\1"�e$   res://Scenes/Menus/Title_Screen.tscn&      �	      ��q5y�B8���O���(   res://Scenes/Menus/Waiting_Screen.tscn   0      b      �"veO�����+��,   res://Scripts/Buttons/Back_Button.gd.remap  �`      6       x�C"4=������k(   res://Scripts/Buttons/Back_Button.gdc   p8            S���Q{�x>����0   res://Scripts/Buttons/Collection_Button.gd.remap a      <       cC9A�Շ�n�a�Y[,   res://Scripts/Buttons/Collection_Button.gdc �9      �       rA+�H������o�,   res://Scripts/Buttons/Create_Button.gd.remap@a      8       Y4&�U��WA�TቲY(   res://Scripts/Buttons/Create_Button.gdc �:      �       !x��ٿs?EG�C��,   res://Scripts/Buttons/Fight_Button.gd.remap �a      7       �q�k��.�W�Ed�S(   res://Scripts/Buttons/Fight_Button.gdc  p;      �       !���G.�pSDK(   res://Scripts/Buttons/IP_Button.gd.remap�a      4       ^ȍ�L��S�D50t��$   res://Scripts/Buttons/IP_Button.gdc P<      �      �XK��e5,������x,   res://Scripts/Buttons/Join_Button.gd.remap   b      6       )�M�1�L4��1S�(   res://Scripts/Buttons/Join_Button.gdc    >      �       m���ux-<O�K�V�0   res://Scripts/Buttons/Options_Button.gd.remap   @b      9       /����ZZrܵˣx(   res://Scripts/Buttons/Options_Button.gdc�>      �       ���9� sت<��I:��,   res://Scripts/Buttons/Quit_Button.gd.remap  �b      6       ����"z�B�D��]�(   res://Scripts/Buttons/Quit_Button.gdc   �?            ��x��J��N�,�p(   res://Scripts/Menus/Join_Screen.gd.remap�b      4       ��Zl�dG4�G�&u+�$   res://Scripts/Menus/Join_Screen.gdc �@      K      �T���p�`#X{X,   res://Scripts/Menus/Waiting_Screen.gd.remap  c      7       ���}33$;�g�����o(   res://Scripts/Menus/Waiting_Screen.gdc   C      ?      A;���{�	̉�f    res://Scripts/global.gd.remap   @c      )       ���ÿ�N)�0���q�/   res://Scripts/global.gdc`D      d       !�J��XU���Z9?    res://Scripts/network.gd.remap  pc      *       ��!��'k�B`��?   res://Scripts/network.gdc   �D            p�U@��=U�ϣ��   res://default_env.tres  �O      �       um�`�N��<*ỳ�8   res://icon.png  �c      i      ����󈘥Ey��
�   res://icon.png.import   @^      �      �����%��(#AB�   res://project.binaryq      �      ���C�{j�v���	�8[            [gd_scene format=2]

[node name="Battle_Screen" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="All" type="HBoxContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 20.0
margin_top = 10.0
margin_right = -20.0
margin_bottom = -10.0
custom_constants/separation = 0

[node name="Left" type="VBoxContainer" parent="All"]
margin_right = 207.0
margin_bottom = 580.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Opponent" type="VBoxContainer" parent="All/Left"]
margin_right = 207.0
margin_bottom = 288.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Self" type="VBoxContainer" parent="All/Left"]
margin_top = 292.0
margin_right = 207.0
margin_bottom = 580.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Center" type="VBoxContainer" parent="All"]
margin_left = 207.0
margin_right = 828.0
margin_bottom = 580.0
size_flags_horizontal = 3
size_flags_vertical = 3
size_flags_stretch_ratio = 3.0

[node name="Opponent_Hand" type="HBoxContainer" parent="All/Center"]
margin_right = 621.0
margin_bottom = 114.0
size_flags_horizontal = 3
size_flags_vertical = 3
size_flags_stretch_ratio = 0.5

[node name="Board" type="VBoxContainer" parent="All/Center"]
margin_top = 118.0
margin_right = 621.0
margin_bottom = 346.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Self_Hand" type="HBoxContainer" parent="All/Center"]
margin_top = 350.0
margin_right = 621.0
margin_bottom = 580.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Right" type="VBoxContainer" parent="All"]
margin_left = 828.0
margin_right = 984.0
margin_bottom = 580.0
size_flags_horizontal = 3
size_flags_vertical = 3
size_flags_stretch_ratio = 0.75

[node name="Right_Button" type="Button" parent="All/Right"]
margin_top = 280.0
margin_right = 156.0
margin_bottom = 300.0
size_flags_vertical = 6
text = "Fin de tour"
           [gd_scene load_steps=3 format=2]

[ext_resource path="res://Scripts/Buttons/Back_Button.gd" type="Script" id=1]
[ext_resource path="res://Scripts/Buttons/Options_Button.gd" type="Script" id=2]

[node name="Top" type="HBoxContainer"]
margin_right = 1024.0
margin_bottom = 131.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Back_Button" type="Button" parent="."]
margin_top = 55.0
margin_right = 71.0
margin_bottom = 75.0
size_flags_vertical = 4
text = "<- Retour"
script = ExtResource( 1 )

[node name="Rankulstone_Logo" type="Label" parent="."]
margin_left = 75.0
margin_right = 957.0
margin_bottom = 131.0
size_flags_horizontal = 3
size_flags_vertical = 5
text = "RANKULSTONE"
align = 1
valign = 1

[node name="Options_Button" type="Button" parent="."]
margin_left = 961.0
margin_top = 55.0
margin_right = 1024.0
margin_bottom = 75.0
size_flags_vertical = 4
text = "Options"
script = ExtResource( 2 )
[connection signal="pressed" from="Back_Button" to="Back_Button" method="_on_Back_Button_pressed"]
[connection signal="pressed" from="Options_Button" to="Options_Button" method="_on_Options_Button_pressed"]
         [gd_scene load_steps=3 format=2]

[ext_resource path="res://Scripts/Menus/Join_Screen.gd" type="Script" id=1]
[ext_resource path="res://Scenes/Menus/Group/Top.tscn" type="PackedScene" id=2]

[node name="Join_Screen" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource( 1 )

[node name="All" type="VBoxContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Top" parent="All" instance=ExtResource( 2 )]
margin_bottom = 147.0

[node name="Join_Label" type="Label" parent="All"]
margin_top = 151.0
margin_right = 1024.0
margin_bottom = 298.0
size_flags_horizontal = 3
size_flags_vertical = 7
text = "Rejoindre une partie"
align = 1
valign = 1

[node name="HBoxContainer" type="HBoxContainer" parent="All"]
margin_top = 302.0
margin_right = 1024.0
margin_bottom = 449.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="IP_Label" type="Label" parent="All/HBoxContainer"]
margin_top = 66.0
margin_right = 406.0
margin_bottom = 80.0
size_flags_horizontal = 3
text = "Adresse IP de l'autre joueur :"
align = 2
valign = 1

[node name="LineEdit" type="LineEdit" parent="All/HBoxContainer"]
margin_left = 410.0
margin_top = 61.0
margin_right = 613.0
margin_bottom = 85.0
size_flags_horizontal = 3
size_flags_vertical = 6
size_flags_stretch_ratio = 0.5
text = "192.168.1.191"

[node name="Join_Button" type="Button" parent="All/HBoxContainer"]
margin_left = 617.0
margin_top = 63.0
margin_right = 690.0
margin_bottom = 83.0
size_flags_horizontal = 2
size_flags_vertical = 6
text = "Rejoindre"

[node name="Instructions" type="Label" parent="All"]
margin_top = 453.0
margin_right = 1024.0
margin_bottom = 600.0
size_flags_horizontal = 3
size_flags_vertical = 7
text = "Pour jouer avec quelqu'un, il doit avoir préalablement créé une partie depuis le lobby, et t'avoir partagé son adresse IP. 
Ensuite, tu n'as qu'à rentrer son IP dans le champ ci-dessus, et laisser faire les 10 000 lignes de code magiques."
align = 1
valign = 1
[connection signal="text_entered" from="All/HBoxContainer/LineEdit" to="." method="_on_LineEdit_text_entered"]
[connection signal="pressed" from="All/HBoxContainer/Join_Button" to="." method="_on_Join_Button_pressed"]
           [gd_scene load_steps=4 format=2]

[ext_resource path="res://Scenes/Menus/Group/Top.tscn" type="PackedScene" id=1]
[ext_resource path="res://Scripts/Buttons/Create_Button.gd" type="Script" id=2]
[ext_resource path="res://Scripts/Buttons/Join_Button.gd" type="Script" id=3]

[node name="Lobby_Screen" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="All" type="VBoxContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Top" parent="All" instance=ExtResource( 1 )]

[node name="Buttons" type="HBoxContainer" parent="All"]
margin_top = 135.0
margin_right = 1024.0
margin_bottom = 332.0
size_flags_horizontal = 3
size_flags_vertical = 3
size_flags_stretch_ratio = 1.5

[node name="Create_Button" type="Button" parent="All/Buttons"]
margin_left = 191.0
margin_top = 88.0
margin_right = 318.0
margin_bottom = 108.0
size_flags_horizontal = 6
size_flags_vertical = 6
text = "+ Créer une partie"
script = ExtResource( 2 )

[node name="Join_Button" type="Button" parent="All/Buttons"]
margin_left = 689.0
margin_top = 88.0
margin_right = 848.0
margin_bottom = 108.0
size_flags_horizontal = 6
size_flags_vertical = 6
text = "-> Rejoindre une partie"
script = ExtResource( 3 )

[node name="Deck_Container" type="HBoxContainer" parent="All"]
margin_top = 336.0
margin_right = 1024.0
margin_bottom = 600.0
size_flags_horizontal = 3
size_flags_vertical = 3
size_flags_stretch_ratio = 2.0

[node name="Panel" type="Panel" parent="All/Deck_Container"]
margin_right = 1024.0
margin_bottom = 264.0
size_flags_horizontal = 3
size_flags_vertical = 3
[connection signal="pressed" from="All/Buttons/Create_Button" to="All/Buttons/Create_Button" method="_on_Create_Button_pressed"]
[connection signal="pressed" from="All/Buttons/Join_Button" to="All/Buttons/Join_Button" method="_on_Join_Button_pressed"]
   [gd_scene load_steps=4 format=2]

[ext_resource path="res://Scripts/Buttons/Fight_Button.gd" type="Script" id=1]
[ext_resource path="res://Scripts/Buttons/Collection_Button.gd" type="Script" id=2]
[ext_resource path="res://Scripts/Buttons/Options_Button.gd" type="Script" id=3]

[node name="Title_Screen" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="All" type="VBoxContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Rankulstone_Logo" type="Label" parent="All"]
margin_right = 1024.0
margin_bottom = 136.0
size_flags_vertical = 7
size_flags_stretch_ratio = 0.75
text = "RANKULSTONE"
align = 1
valign = 1

[node name="Buttons" type="HBoxContainer" parent="All"]
margin_top = 140.0
margin_right = 1024.0
margin_bottom = 504.0
size_flags_vertical = 3
size_flags_stretch_ratio = 2.0
custom_constants/separation = 100

[node name="Fight_Button" type="Button" parent="All/Buttons"]
margin_right = 274.0
margin_bottom = 364.0
size_flags_horizontal = 3
size_flags_vertical = 3
text = "Partie Rapide"
script = ExtResource( 1 )

[node name="Collection_Button" type="Button" parent="All/Buttons"]
margin_left = 374.0
margin_right = 648.0
margin_bottom = 364.0
size_flags_horizontal = 3
size_flags_vertical = 3
text = "Collection"
script = ExtResource( 2 )

[node name="Options_Button" type="Button" parent="All/Buttons"]
margin_left = 748.0
margin_right = 1024.0
margin_bottom = 364.0
size_flags_horizontal = 3
size_flags_vertical = 3
text = "Options"
script = ExtResource( 3 )

[node name="Down_text" type="HBoxContainer" parent="All"]
editor/display_folded = true
margin_top = 508.0
margin_right = 1024.0
margin_bottom = 600.0
size_flags_vertical = 3
size_flags_stretch_ratio = 0.5

[node name="Version" type="Label" parent="All/Down_text"]
margin_top = 39.0
margin_right = 510.0
margin_bottom = 53.0
size_flags_horizontal = 3
text = "Version 0.0.1"
align = 1
valign = 1

[node name="Copyright" type="Label" parent="All/Down_text"]
margin_left = 514.0
margin_top = 39.0
margin_right = 1024.0
margin_bottom = 53.0
size_flags_horizontal = 3
text = "© Copyright 2019 Extasy Team"
align = 1
valign = 1
[connection signal="pressed" from="All/Buttons/Fight_Button" to="All/Buttons/Fight_Button" method="_on_Fight_Button_pressed"]
[connection signal="pressed" from="All/Buttons/Collection_Button" to="All/Buttons/Collection_Button" method="_on_Collection_Button_pressed"]
[connection signal="pressed" from="All/Buttons/Options_Button" to="All/Buttons/Options_Button" method="_on_Options_Button_pressed"]
         [gd_scene load_steps=5 format=2]

[ext_resource path="res://Scripts/Menus/Waiting_Screen.gd" type="Script" id=1]
[ext_resource path="res://Scenes/Menus/Group/Top.tscn" type="PackedScene" id=2]
[ext_resource path="res://Scripts/Buttons/Quit_Button.gd" type="Script" id=3]
[ext_resource path="res://Scripts/Buttons/IP_Button.gd" type="Script" id=4]

[node name="Waiting_Screen" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource( 1 )

[node name="All" type="VBoxContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Top" parent="All" instance=ExtResource( 2 )]
margin_bottom = 147.0

[node name="Label" type="Label" parent="All"]
margin_top = 217.0
margin_right = 1024.0
margin_bottom = 231.0
size_flags_horizontal = 3
size_flags_vertical = 6
text = "En attente d'un joueur..."
align = 1
valign = 1

[node name="Buttons" type="HBoxContainer" parent="All"]
margin_top = 302.0
margin_right = 1024.0
margin_bottom = 449.0
size_flags_horizontal = 3
size_flags_vertical = 3

[node name="Quit_Button" type="Button" parent="All/Buttons"]
margin_left = 226.0
margin_right = 284.0
margin_bottom = 20.0
size_flags_horizontal = 6
size_flags_vertical = 2
text = "Quitter"
script = ExtResource( 3 )

[node name="IP_Button" type="Button" parent="All/Buttons"]
margin_left = 686.0
margin_right = 851.0
margin_bottom = 20.0
size_flags_horizontal = 6
size_flags_vertical = 2
text = "Afficher mon adresse IP"
script = ExtResource( 4 )

[node name="Instructions" type="Label" parent="All"]
margin_top = 453.0
margin_right = 1024.0
margin_bottom = 600.0
size_flags_horizontal = 3
size_flags_vertical = 3
text = "Pour jouer contre quelqu'un, il doit cliquer sur le bouton \"Rejoindre une partie\" du lobby, puis rentrer ton adresse IP dans le champ dédié. 
Tu peux afficher ton IP en cliquant sur le bouton \"Afficher mon IP\", j'espère que t'avais compris."
align = 1
valign = 1
[connection signal="pressed" from="All/Buttons/Quit_Button" to="All/Buttons/Quit_Button" method="_on_Quit_Button_pressed"]
[connection signal="pressed" from="All/Buttons/IP_Button" to="All/Buttons/IP_Button" method="_on_IP_Button_pressed"]
              GDSC                  �����ض�   ����������������������Ҷ   ������ݶ   �������������ݶ�   �������Ӷ���   �����������Ӷ���      Scenes/Menus/Title_Screen.tscn                           
                  3YYY0�  PQV�  �  T�  PQ�  �  PQT�  PQY`            GDSC                  �����ض�    ����������������������������Ҷ��   �������Ӷ���   �����������Ӷ���   #   Scenes/Menus/Collection_Screen.tscn                          
                  3YYY0�  PQV�  -�  �  PQT�  PQY`          GDSC                  �����ض�   ������������������������Ҷ��   �������Ӷ���   �����������Ӷ���       Scenes/Menus/Waiting_Screen.tscn                   	            3YY0�  PQV�  �  PQT�  PQY`        GDSC                  �����ض�   �����������������������Ҷ���   �������Ӷ���   �����������Ӷ���      Scenes/Menus/Lobby_Screen.tscn                     	            3YY0�  PQV�  �  PQT�  PQY`        GDSC            8      �����ض�   ������ƶ   ��������������������Ҷ��   ����������¶   ���¶���             Afficher mon adresse IP       www.whatismyip.com                                 	                           	      
   $      (      +      ,      2      6      3YY;�  YY0�  PQV�  �  PQ�  Y0�  PQV�  &�  V�  T�  �  �  �  �  (V�  �  T�  �  �  �  �  Y`     GDSC                  �����ض�   ����������������������Ҷ   �������Ӷ���   �����������Ӷ���      Scenes/Menus/Join_Screen.tscn                      	      3YY0�  PQV�  �  PQT�  PQ`     GDSC                  �����ض�   �������������������������Ҷ�   �������Ӷ���   �����������Ӷ���       Scenes/Menus/Options_Screen.tscn                         
                  3YYY0�  PQV�  -�  �  PQT�  PQY`  GDSC                  �����ض�   ����������������������Ҷ   ������ݶ   �������������ݶ�   �������Ӷ���   �����������Ӷ���      Scenes/Menus/Lobby_Screen.tscn                     	                  3YY0�  PQV�  �  T�  PQ�  �  PQT�  PQY`     GDSC            G      ������ڶ   ����������������������Ҷ   ��������Ӷ��   ��ڶ   ������������Ķ��   �������¶���   ���¶���   ������������������������Ҷ��   �������¶���   �ƶ�   ������ݶ   ������������¶��   ���������Ҷ�   ���������ڶ�   #   CHARGEMENT DE LA PARTIE EN COURS...                    	                        "      #   	   *   
   1      2      3      9      B      C      D      E      3YY0�  PQV�  �  PW�  �  �  T�  QYY0�  P�  QV�  �  P�  Q�  Y0�  P�	  QV�  �
  T�  P�	  QYYY0�  PQV�  W�  �  T�  YYYY`     GDSC   	         "      ������ڶ   �����϶�   ������ݶ   ������������Ķ��   ����������������Ҷ��   �Ҷ�   ��ڶ   ����ڶ��   ���¶���   #   CHARGEMENT DE LA PARTIE EN COURS...                    	                               3YY0�  PQV�  �  T�  PQ�  Y0�  P�  QV�  W�  �  T�  Y` GDSC            	      ���Ӷ���   ��������      0.0.1                      3YY:�  `            GDSC         A   �     ���Ӷ���   ���ⶶ��   ������������Ķ��   ���ƶ���   ���涶��   ����   �������Ķ���   ���������������Ѷ���   ���Ķ���   �����������������������¶���   �������Ӷ���   ���������������Ķ���   ������¶   ����������������Ӷ��   ������������¶��   �ƶ�   �������������ݶ�   ����������������Ҷ��   �Ҷ�   ��ն   �����ڶ�   ��������   �������������������Ҷ���   ���������Ҷ�   ������Ҷ   ����������Ӷ   �����������Ӷ���   �����������ض���   ������ض   �        Discover the network with          port... Output:       �              InternetGatewayDevice      (   Add the port to port mapping... Output:             Successfully created a server         network_peer_connected        _player_connected         network_peer_disconnected         _player_disconnected      Connecting to:        connected_to_server    
   _connected        connection_failed         _failed           Player     ,    is connected. We can finaly start the game!      send_version       leaved the game   %   Successfully connected to the server!         Connection failed...      Scenes/Battle_Screen.tscn      #   No version conflict, game accepted.       launch_game    e   Version conflict, you or your opponent need to update Rankulstone to the last version. Game canceled.         Scenes/Menus/Lobby_Screen.tscn                           	                        3   	   B   
   C      L      U      ^      c      d      w      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &     '     (     )     *     +   !  ,   *  -   +  .   ,  /   2  0   7  1   8  2   >  3   C  4   D  5   E  6   L  7   U  8   V  9   ^  :   f  ;   k  <   o  =   t  >   w  ?   |  @   �  A   3YY:�  YY0�  PQV�  �  ;�  �  T�  PQ�  �8  P�  �7  P�  Q�  �7  P�  T�  P�  R�  R�  QQQ�  �8  P�  �7  P�  T�  P�  QQQ�  �  ;�  �	  T�  PQ�  �  T�  P�  R�  Q�  �
  PQT�  P�  Q�  �8  P�  Q�  �  �
  PQT�  P�	  R�
  PQT�  PQR�
  Q�  �
  PQT�  P�	  RR�
  Q�  �
  PQT�  P�  RR�  Q�  �  Y0�  P�  QV�  �8  P�  �  Q�  �
  PQT�  P�  RR�  Q�  �
  PQT�  P�  R�
  PQT�  PQR�  Q�  �
  PQT�  P�  RR�  Q�  �  ;�  �	  T�  PQ�  �  �  T�  P�  R�  Q�  �  �  �  �
  PQT�  P�  QYY0�  PQV�  �
  PQT�  P�  Q�  Y0�  P�  QV�  �8  P�  R�  R�  Q�  �  P�  R�  T�  Q�  �  Y0�  P�  QV�  �8  P�  R�  R�  QYYY0�  PQV�  �8  P�  Q�  Y0�  PQV�  �8  P�  Q�  �  YD0�  PQV�  �
  PQT�  P�  Q�  YD0�  P�  QV�  &�  �  T�  V�  �8  P�  Q�  �  PQ�  �  P�  Q�  (V�  �8  P�  Q�  �
  PQT�  P�  Q�  �
  PQT�  P�  Q`           [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @           |  PNG �PNG

   IHDR   @   @   �iq�  ?IDATx��{pTU�����;�N7	�����%"fyN�8��r\]fEgةf���X�g��F�Y@Wp\]|,�D@��	$$���	��I�n���ҝt����JW�s��}�=���|�D(���W@T0^����f��	��q!��!i��7�C���V�P4}! ���t�ŀx��dB.��x^��x�ɏN��贚�E�2�Z�R�EP(�6�<0dYF���}^Ѡ�,	�3=�_<��(P&�
tF3j�Q���Q�B�7�3�D�@�G�U��ĠU=� �M2!*��[�ACT(�&�@0hUO�u��U�O�J��^FT(Qit �V!>%���9 J���jv	�R�@&��g���t�5S��A��R��OO^vz�u�L�2�����lM��>tH
�R6��������dk��=b�K�љ�]�י�F*W�볃�\m=�13� �Є,�ˏy��Ic��&G��k�t�M��/Q]�أ]Q^6o��r�h����Lʳpw���,�,���)��O{�:א=]� :LF�[�*���'/���^�d�Pqw�>>��k��G�g���No���\��r����/���q�̾��	�G��O���t%L�:`Ƶww�+���}��ݾ ۿ��SeŔ����  �b⾻ǰ��<n_�G��/��8�Σ�l]z/3��g����sB��tm�tjvw�:��5���l~�O���v��]ǚ��֩=�H	u���54�:�{"������}k����d���^��`�6�ev�#Q$�ήǞ��[�Ặ�e�e��Hqo{�59i˲����O+��e������4�u�r��z�q~8c
 �G���7vr��tZ5�X�7����_qQc�[����uR��?/���+d��x�>r2����P6����`�k��,7�8�ɿ��O<Ė��}AM�E%�;�SI�BF���}��@P�yK�@��_:����R{��C_���9������
M��~����i����������s���������6�,�c�������q�����`����9���W�pXW]���:�n�aұt~9�[���~e�;��f���G���v0ԣ� ݈���y�,��:j%gox�T
�����kְ�����%<��A`���Jk?���� gm���x�*o4����o��.�����逊i�L����>���-���c�����5L����i�}�����4����usB������67��}����Z�ȶ�)+����)+H#ۢ�RK�AW�xww%��5�lfC�A���bP�lf��5����>���`0ċ/oA-�,�]ĝ�$�峋P2/���`���;����[Y��.&�Y�QlM���ƌb+��,�s�[��S ��}<;���]�:��y��1>'�AMm����7q���RY%9)���ȡI�]>�_l�C����-z�� ;>�-g�dt5іT�Aͺy�2w9���d�T��J�}u�}���X�Ks���<@��t��ebL������w�aw�N����c����F���3
�2먭�e���PQ�s�`��m<1u8�3�#����XMڈe�3�yb�p�m��܇+��x�%O?CmM-Yf��(�K�h�بU1%?I�X�r��� ��n^y�U�����1�玒�6..e��RJrRz�Oc������ʫ��]9���ZV�\�$IL�OŨ��{��M�p�L56��Wy��J�R{���FDA@
��^�y�������l6���{�=��ή�V�hM�V���JK��:��\�+��@�l/���ʧ����pQ��������׷Q^^�(�T������|.���9�?I�M���>���5�f欙X�VƎ-f͚ո���9����=�m���Y���c��Z�̚5��k~���gHHR�Ls/l9²���+ ����:��杧��"9�@��ad�ŝ��ѽ�Y���]O�W_�`Ֆ#Դ8�z��5-N^�r�Z����h���ʆY���=�`�M���Ty�l���.	�/z��fH���������֗�H�9�f������G� ̛<��q��|�]>ں}�N�3�;i�r"�(2RtY���4X���F�
�����8 �[�\锰�b`�0s�:���v���2�f��k�Zp��Ω&G���=��6em.mN�o.u�fԐc��i����C���u=~{�����a^�UH������¡,�t(jy�Q�ɋ����5�Gaw��/�Kv?�|K��(��SF�h�����V��xȩ2St쯹���{6b�M/�t��@0�{�Ԫ�"�v7�Q�A�(�ľR�<	�w�H1D�|8�]�]�Ո%����jҢ꯸hs�"~꯸P�B�� �%I}}��+f�����O�cg�3rd���P�������qIڻ]�h�c9��xh )z5��� �ƾ"1:3���j���'1;��#U�失g���0I}�u3.)@�Q�A�ĠQ`I�`�(1h��t*�:�>'��&v��!I?�/.)@�S�%q�\���l�TWq�������լ�G�5zy6w��[��5�r���L`�^���/x}�>��t4���cݦ�(�H�g��C�EA�g�)�Hfݦ��5�;q-���?ư�4�����K����XQ*�av�F��������񵏷�;>��l�\F��Þs�c�hL�5�G�c�������=q�P����E �.���'��8Us�{Ǎ���#������q�HDA`b��%����F�hog���|�������]K�n��UJ�}������Dk��g��8q���&G����A�RP�e�$'�i��I3j�w8������?�G�&<	&䪬R��lb1�J����B$�9�꤮�ES���[�������8�]��I�B!
�T
L:5�����d���K30"-	�(��D5�v��#U�����jԔ�QR�GIaó�I3�nJVk���&'��q����ux��AP<�"�Q�����H�`Jң�jP(D��]�����`0��+�p�inm�r�)��,^�_�rI�,��H>?M-44���x���"� �H�T��zIty����^B�.��%9?E����П�($@H!�D��#m�e���vB(��t �2.��8!���s2Tʡ �N;>w'����dq�"�2����O�9$�P	<(��z�Ff�<�z�N��/yD�t�/?�B.��A��>��i%�ǋ"�p n� ���]~!�W�J���a�q!n��V X*�c �TJT*%�6�<d[�    IEND�B`�        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
[remap]

path="res://Scripts/Buttons/Back_Button.gdc"
          [remap]

path="res://Scripts/Buttons/Collection_Button.gdc"
    [remap]

path="res://Scripts/Buttons/Create_Button.gdc"
        [remap]

path="res://Scripts/Buttons/Fight_Button.gdc"
         [remap]

path="res://Scripts/Buttons/IP_Button.gdc"
            [remap]

path="res://Scripts/Buttons/Join_Button.gdc"
          [remap]

path="res://Scripts/Buttons/Options_Button.gdc"
       [remap]

path="res://Scripts/Buttons/Quit_Button.gdc"
          [remap]

path="res://Scripts/Menus/Join_Screen.gdc"
            [remap]

path="res://Scripts/Menus/Waiting_Screen.gdc"
         [remap]

path="res://Scripts/global.gdc"
       [remap]

path="res://Scripts/network.gdc"
      �PNG

   IHDR   @   @   �iq�  0IDATx��}pTU����L����W�$�@HA�%"fa��Yw�)��A��Egةf���X�g˱��tQ���Eq�!�|K�@BHH:�t>�;�����1!ݝn�A�_UWw����{λ��sϽO�q汤��X,�q�z�<�q{cG.;��]�_�`9s��|o���:��1�E�V� ~=�	��ݮ����g[N�u�5$M��NI��-
�"(U*��@��"oqdYF�y�x�N�e�2���s����KҦ`L��Z)=,�Z}"
�A�n{�A@%$��R���F@�$m������[��H���"�VoD��v����Kw�d��v	�D�$>	�J��;�<�()P�� �F��
�< �R����&�կ��� ����������%�u̚VLNfڠus2�̚VL�~�>���mOMJ���J'R��������X����׬X�Ϲ虾��6Pq������j���S?�1@gL���±����(�2A�l��h��õm��Nb�l_�U���+����_����p�)9&&e)�0 �2{��������1���@LG�A��+���d�W|x�2-����Fk7�2x��y,_�_��}z��rzy��%n�-]l����L��;
�s���:��1�sL0�ڳ���X����m_]���BJ��im�  �d��I��Pq���N'�����lYz7�����}1�sL��v�UIX���<��Ó3���}���nvk)[����+bj�[���k�������cݮ��4t:= $h�4w:qz|A��٧�XSt�zn{�&��õmQ���+�^�j�*��S��e���o�V,	��q=Y�)hԪ��F5~����h�4 *�T�o��R���z�o)��W�]�Sm銺#�Qm�]�c�����v��JO��?D��B v|z�կ��܈�'�z6?[� ���p�X<-���o%�32����Ρz�>��5�BYX2���ʦ�b��>ǣ������SI,�6���|���iXYQ���U�҅e�9ma��:d`�iO����{��|��~����!+��Ϧ�u�n��7���t>�l捊Z�7�nвta�Z���Ae:��F���g�.~����_y^���K�5��.2�Zt*�{ܔ���G��6�Y����|%�M	���NPV.]��P���3�8g���COTy�� ����AP({�>�"/��g�0��<^��K���V����ϫ�zG�3K��k���t����)�������6���a�5��62Mq����oeJ�R�4�q�%|�� ������z���ä�>���0�T,��ǩ�����"lݰ���<��fT����IrX>� � ��K��q�}4���ʋo�dJ��م�X�sؘ]hfJ�����Ŧ�A�Gm߽�g����YG��X0u$�Y�u*jZl|p������*�Jd~qcR�����λ�.�
�r�4���zپ;��AD�eЪU��R�:��I���@�.��&3}l
o�坃7��ZX��O�� 2v����3��O���j�t	�W�0�n5����#è����%?}����`9۶n���7"!�uf��A�l܈�>��[�2��r��b�O�������gg�E��PyX�Q2-7���ʕ������p��+���~f��;����T	�*�(+q@���f��ϫ����ѓ���a��U�\.��&��}�=dd'�p�l�e@y��
r�����zDA@����9�:��8�Y,�����=�l�֮��F|kM�R��GJK��*�V_k+��P�,N.�9��K~~~�HYY��O��k���Q�����|rss�����1��ILN��~�YDV��-s�lfB֬Y�#.�=�>���G\k֬fB�f3��?��k~���f�IR�lS'�m>²9y���+ �v��y��M;NlF���A���w���w�b���Л�j�d��#T��b���e��[l<��(Z�D�NMC���k|Zi�������Ɗl��@�1��v��Щ�!曣�n��S������<@̠7�w�4X�D<A`�ԑ�ML����jw���c��8��ES��X��������ƤS�~�׾�%n�@��( Zm\�raҩ���x��_���n�n���2&d(�6�,8^o�TcG���3���emv7m6g.w��W�e
�h���|��Wy��~���̽�!c� �ݟO�)|�6#?�%�,O֫9y������w��{r�2e��7Dl �ׇB�2�@���ĬD4J)�&�$
�HԲ��
/�߹�m��<JF'!�>���S��PJ"V5!�A�(��F>SD�ۻ�$�B/>lΞ�.Ϭ�?p�l6h�D��+v�l�+v$Q�B0ūz����aԩh�|9�p����cƄ,��=Z�����������Dc��,P��� $ƩЩ�]��o+�F$p�|uM���8R��L�0�@e'���M�]^��jt*:��)^�N�@�V`�*�js�up��X�n���tt{�t:�����\�]>�n/W�\|q.x��0���D-���T��7G5jzi���[��4�r���Ij������p�=a�G�5���ͺ��S���/��#�B�EA�s�)HO`���U�/QM���cdz
�,�!�(���g�m+<R��?�-`�4^}�#>�<��mp��Op{�,[<��iz^�s�cü-�;���쾱d����xk瞨eH)��x@���h�ɪZNU_��cxx�hƤ�cwzi�p]��Q��cbɽcx��t�����M|�����x�=S�N���
Ͽ�Ee3HL�����gg,���NecG�S_ѠQJf(�Jd�4R�j��6�|�6��s<Q��N0&Ge
��Ʌ��,ᮢ$I�痹�j���Nc���'�N�n�=>|~�G��2�)�D�R U���&ՠ!#1���S�D��Ǘ'��ೃT��E�7��F��(?�����s��F��pC�Z�:�m�p�l-'�j9QU��:��a3@0�*%�#�)&�q�i�H��1�'��vv���q8]t�4����j��t-}IـxY�����C}c��-�"?Z�o�8�4Ⱦ���J]/�v�g���Cȷ2]�.�Ǣ ��Ս�{0
�>/^W7�_�����mV铲�
i���FR��$>��}^��dُ�۵�����%��*C�'�x�d9��v�ߏ � ���ۣ�Wg=N�n�~������/�}�_��M��[���uR�N���(E�	� ������z��~���.m9w����c����
�?���{�    IEND�B`�       ECFG      _global_script_classes             _global_script_class_icons             application/config/name         Rankulstone    application/run/main_scene,      $   res://Scenes/Menus/Title_Screen.tscn   application/config/icon         res://icon.png     autoload/network$         *res://Scripts/network.gd      autoload/global          *res://Scripts/global.gd'   debug/gdscript/warnings/unused_variable          -   debug/gdscript/warnings/unused_class_variable          '   debug/gdscript/warnings/unused_argument          %   debug/gdscript/warnings/unused_signal          .   debug/gdscript/warnings/return_value_discarded          )   rendering/environment/default_environment          res://default_env.tres                GDPC