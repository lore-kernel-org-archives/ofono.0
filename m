Content-Type: multipart/mixed; boundary="===============2982155010668981578=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 01/16] bluetooth: Add Serial interface definition
Date: Tue, 22 May 2012 18:33:09 +0200
Message-ID: <1337704404-5260-2-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2982155010668981578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/bluetooth.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index daa1873..4fc16ad 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -27,6 +27,7 @@
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
+#define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

 #define DBUS_TIMEOUT 15
 =

-- =

1.7.10.130.g36e6c


--===============2982155010668981578==--

