Content-Type: multipart/mixed; boundary="===============0563539212570539537=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 03/13] bluez5: Add DUN_UUID
Date: Thu, 14 Mar 2013 10:32:44 -0300
Message-ID: <1363267974-13518-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0563539212570539537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluez5.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 573a54c..898a010 100644
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


--===============0563539212570539537==--

