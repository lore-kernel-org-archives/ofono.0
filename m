Content-Type: multipart/mixed; boundary="===============6685983914645730164=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 03/13] bluez5: Add DUN_UUID
Date: Mon, 04 Mar 2013 16:33:04 -0300
Message-ID: <1362425590-26075-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1362425590-26075-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6685983914645730164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluez5.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index f7f3d7e..09654b7 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -25,6 +25,7 @@
 #define BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device1"
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

+#define DUN_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

-- =

1.7.9.5


--===============6685983914645730164==--

