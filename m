Content-Type: multipart/mixed; boundary="===============8795460851072787022=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 1/6] bluetooth: Add define for SCO voice settings
Date: Thu, 15 Aug 2013 23:26:04 -0300
Message-ID: <1376619969-15080-2-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8795460851072787022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add defines for SCO voice setting (Air Coding). Air mode "Transparent
Data" shall be supported if wide band speech is supported.
---
 src/bluetooth.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/bluetooth.h b/src/bluetooth.h
index af6f02c..825da3e 100644
--- a/src/bluetooth.h
+++ b/src/bluetooth.h
@@ -34,6 +34,15 @@
 =

 #define BT_DEFER_SETUP		7
 =

+
+#define BT_VOICE		11
+struct bt_voice {
+	uint16_t setting;
+};
+
+#define BT_VOICE_TRANSPARENT			0x0003
+#define BT_VOICE_CVSD_16BIT			0x0060
+
 /* BD Address */
 typedef struct {
 	uint8_t b[6];
-- =

1.8.3.4


--===============8795460851072787022==--

