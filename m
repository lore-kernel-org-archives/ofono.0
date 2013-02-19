Content-Type: multipart/mixed; boundary="===============6138889771967089701=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 03/11] dbus: Move oFono error define to dbus.h
Date: Tue, 19 Feb 2013 17:44:44 -0300
Message-ID: <1361306692-959-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6138889771967089701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h | 1 +
 src/dbus.c     | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 44faa7f..8208125 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -29,6 +29,7 @@ extern "C" {
 #include <dbus/dbus.h>
 =

 #define OFONO_SERVICE	"org.ofono"
+#define OFONO_ERROR_INTERFACE "org.ofono.Error"
 #define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
 #define OFONO_MANAGER_PATH "/"
 #define OFONO_MODEM_INTERFACE "org.ofono.Modem"
diff --git a/src/dbus.c b/src/dbus.c
index 1558a51..c705b67 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -28,8 +28,6 @@
 =

 #include "ofono.h"
 =

-#define OFONO_ERROR_INTERFACE "org.ofono.Error"
-
 static DBusConnection *g_connection;
 =

 struct error_mapping_entry {
-- =

1.7.11.7


--===============6138889771967089701==--

