Content-Type: multipart/mixed; boundary="===============8981213478606208266=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add send vcal test
Date: Thu, 28 Apr 2011 14:05:48 +0200
Message-ID: <1303992348-22676-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8981213478606208266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-vcal |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100755 test/send-vcal

diff --git a/test/send-vcal b/test/send-vcal
new file mode 100755
index 0000000..7ccd2f6
--- /dev/null
+++ b/test/send-vcal
@@ -0,0 +1,32 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+if len(sys.argv) < 3:
+	print "Usage: %s [modem] <to> <vcal file>" % (sys.argv[0])
+	sys.exit(1)
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Send vcal using modem %s ..." % path
+
+sm =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.SmartMessaging')
+
+if len(sys.argv) =3D=3D 4:
+	vcal =3D file(sys.argv[3]).read()
+	path =3D sm.SendAppointment(sys.argv[2], vcal)
+else:
+	vcal =3D file(sys.argv[2]).read()
+	path =3D sm.SendAppointment(sys.argv[1], vcal)
+
+print path
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8981213478606208266==--

