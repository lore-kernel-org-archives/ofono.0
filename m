Content-Type: multipart/mixed; boundary="===============4168182584112024968=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 1/3] isimodem: Allow network registration automatically
Date: Wed, 03 Aug 2011 11:13:08 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB24216@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4168182584112024968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 41246b3..85ae2b0 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -1140,6 +1140,7 @@ const char *net_message_id_name(enum net_message_id v=
alue)
 		_(NET_SET_RESP);
 		_(NET_RSSI_GET_REQ);
 		_(NET_RSSI_GET_RESP);
+        _(NET_CS_STATE_IND);
 		_(NET_RSSI_IND);
 		_(NET_CIPHERING_IND);
 		_(NET_TIME_IND);
@@ -1147,10 +1148,14 @@ const char *net_message_id_name(enum net_message_id=
 value)
 		_(NET_RAT_IND);
 		_(NET_RAT_REQ);
 		_(NET_RAT_RESP);
+        _(NET_CS_STATE_REQ);
+        _(NET_CS_STATE_RESP);
 		_(NET_CELL_INFO_GET_REQ);
 		_(NET_CELL_INFO_GET_RESP);
 		_(NET_CELL_INFO_IND);
 		_(NET_NITZ_NAME_IND);
+        _(NET_NW_ACCESS_CONF_REQ);
+        _(NET_NW_ACCESS_CONF_RESP);
 		_(NET_REG_STATUS_GET_REQ);
 		_(NET_REG_STATUS_GET_RESP);
 		_(NET_REG_STATUS_IND);

--===============4168182584112024968==--

