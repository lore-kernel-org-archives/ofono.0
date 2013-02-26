Content-Type: multipart/mixed; boundary="===============7704354547910645479=="
MIME-Version: 1.0
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [PATCH] bluez4: Increase Bluez 4 D-Bus timeouts to 60 seconds
Date: Tue, 26 Feb 2013 13:15:52 +0200
Message-ID: <1361877352-2728-1-git-send-email-patrik.flykt@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7704354547910645479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RequestAuthorization method call may trigger pairing and/or pop up a
dialog in the remote device to which the user needs to react. Thus
increase D-Bus timeouts to 60 seconds for the Bluez 4 plugin.
---
 plugins/bluez4.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/bluez4.h b/plugins/bluez4.h
index 4fc16ad..3b60cba 100644
--- a/plugins/bluez4.h
+++ b/plugins/bluez4.h
@@ -29,7 +29,7 @@
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 #define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

-#define DBUS_TIMEOUT 15
+#define DBUS_TIMEOUT 60
 =

 #define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
-- =

1.7.10.4


--===============7704354547910645479==--

