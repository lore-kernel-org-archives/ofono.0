Content-Type: multipart/mixed; boundary="===============1374836131493176021=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] test: Tweak hangup script to clear waiting active and
 held calls
Date: Mon, 30 Jul 2012 17:45:09 +0200
Message-ID: <1343663109-5542-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1343663109-5542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1374836131493176021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/hangup |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/test/hangup b/test/hangup
index 6444b23..60858a8 100755
--- a/test/hangup
+++ b/test/hangup
@@ -3,6 +3,16 @@
 import sys
 import dbus
 =

+if (len(sys.argv) < 2):
+	print "Usage: %s <call state>" % (sys.argv[0])
+	sys.exit(1)
+
+cstate =3D sys.argv[1]
+
+if cstate !=3D "active" and cstate !=3D "waiting" and cstate !=3D "held":
+	print "Valid <call state> is active / waiting / held"
+	sys.exit(1)
+
 bus =3D dbus.SystemBus()
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
@@ -20,7 +30,7 @@ for path, properties in calls:
 		state =3D properties["State"]
 		print "[ %s ] %s" % (path, state)
 =

-		if state !=3D "active":
+		if state !=3D cstate:
 			continue
 =

 		call =3D dbus.Interface(bus.get_object('org.ofono', path),
-- =

1.7.5.4


--===============1374836131493176021==--

