Content-Type: multipart/mixed; boundary="===============4456251430553334897=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2 04/11] bluetooth: Add Serial interface definition
Date: Fri, 09 Dec 2011 17:35:39 +0100
Message-ID: <1323448546-2728-5-git-send-email-wagi@monom.org>
In-Reply-To: <1323448546-2728-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4456251430553334897==
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


--===============4456251430553334897==--

