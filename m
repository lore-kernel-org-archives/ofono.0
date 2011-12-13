Content-Type: multipart/mixed; boundary="===============5766560981065572289=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 08/16] bluetooth: Add Serial interface definition
Date: Tue, 13 Dec 2011 16:00:02 +0100
Message-ID: <1323788410-9988-9-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5766560981065572289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/bluetooth.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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

1.7.8.110.g4cb5d1


--===============5766560981065572289==--

