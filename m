Content-Type: multipart/mixed; boundary="===============5277006633391941782=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] test: tweak monitor-ofono to display special characters
Date: Tue, 07 Aug 2012 16:02:32 +0200
Message-ID: <1344348152-20479-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1344348152-20479-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5277006633391941782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-ofono |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index 1f3fc56..f3c765a 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -2,8 +2,10 @@
 =

 import gobject
 =

+import sys
 import dbus
 import dbus.mainloop.glib
+locale =3D sys.stdout.encoding
 =

 _dbus2py =3D {
 	dbus.String : unicode,
@@ -73,7 +75,7 @@ def message(msg, args, member, path, interface):
 =

 def ussd(msg, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, msg)
+	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
 =

 def value(value, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-- =

1.7.5.4


--===============5277006633391941782==--

