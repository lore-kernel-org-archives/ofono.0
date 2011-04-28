Content-Type: multipart/mixed; boundary="===============5624929653038865827=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Modify send sms test to be able to set the modem to use
Date: Thu, 28 Apr 2011 11:54:20 +0200
Message-ID: <1303984460-21948-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5624929653038865827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-sms |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/test/send-sms b/test/send-sms
index bd1fae5..968824b 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -3,22 +3,32 @@
 import sys
 import dbus
 =

+if len(sys.argv) < 4:
+	print "Usage: %s [modem] <to> <message> <delivery report>" %\
+					(sys.argv[0])
+	sys.exit(1)
+
 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
+if len(sys.argv) =3D=3D 5:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Send message using modem %s ..." % path
 =

-modems =3D manager.GetModems()
-path =3D modems[0][0]
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+mm =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.MessageManager')
 =

-if len(sys.argv) =3D=3D 4:
-	manager.SetProperty("UseDeliveryReports",
-					dbus.Boolean(int(sys.argv[1])))
-	path =3D manager.SendMessage(sys.argv[1], sys.argv[2])
+if len(sys.argv) =3D=3D 5:
+	mm.SetProperty("UseDeliveryReports",
+					dbus.Boolean(int(sys.argv[4])))
+	path =3D mm.SendMessage(sys.argv[2], sys.argv[3])
 else:
-	path =3D manager.SendMessage(sys.argv[1], sys.argv[2])
+	path =3D mm.SendMessage(sys.argv[1], sys.argv[2])
 =

 print path
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

--===============5624929653038865827==--

