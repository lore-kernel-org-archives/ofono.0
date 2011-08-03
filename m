Content-Type: multipart/mixed; boundary="===============2754950870189999178=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 3/3] isimodem: Allow network registration automatically
Date: Wed, 03 Aug 2011 11:14:06 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB24269@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2754950870189999178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index 45f61ae..7af843e 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -42,6 +42,7 @@ enum net_message_id {
 	NET_SET_RESP =3D					0x08,
 	NET_RSSI_GET_REQ =3D				0x0B,
 	NET_RSSI_GET_RESP =3D				0x0C,
+    NET_CS_STATE_IND =3D              0x19,
 	NET_RSSI_IND =3D					0x1E,
 	NET_CIPHERING_IND =3D				0x20,
 	NET_TIME_IND =3D					0x27,
@@ -51,10 +52,14 @@ enum net_message_id {
 	NET_RAT_IND =3D					0x35,
 	NET_RAT_REQ =3D					0x36,
 	NET_RAT_RESP =3D					0x37,
-	NET_CELL_INFO_GET_REQ =3D				0x40,
+    NET_CS_STATE_REQ =3D              0x3A,
+    NET_CS_STATE_RESP =3D             0x3B,
+    NET_CELL_INFO_GET_REQ =3D				0x40,
 	NET_CELL_INFO_GET_RESP =3D			0x41,
 	NET_CELL_INFO_IND =3D				0x42,
 	NET_NITZ_NAME_IND =3D				0x43,
+	NET_NW_ACCESS_CONF_REQ =3D 	0x48,
+	NET_NW_ACCESS_CONF_RESP =3D 	0x49,
 	NET_REG_STATUS_GET_REQ =3D			0xE0,
 	NET_REG_STATUS_GET_RESP =3D			0xE1,
 	NET_REG_STATUS_IND =3D				0xE2,
@@ -197,6 +202,11 @@ enum net_select_mode {
 	NET_SELECT_MODE_NO_SELECTION =3D			0x04,
 };
 =

+enum net_cs_states {
+    NET_CS_INACTIVE =3D       0x00,
+    NET_CS_ACTIVE =3D         0x01,
+    };
+
 enum net_isi_cause {
 	NET_CAUSE_OK =3D					0x00,
 	NET_CAUSE_COMMUNICATION_ERROR =3D			0x01,
--===============2754950870189999178==--

