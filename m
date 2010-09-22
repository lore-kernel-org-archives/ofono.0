Content-Type: multipart/mixed; boundary="===============5864236912383980659=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Fix test-sms.
Date: Wed, 22 Sep 2010 22:08:38 +0300
Message-ID: <1285182518-15932-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5864236912383980659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow user to set SRR and SMSC.
---
 test/send-sms |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/test/send-sms b/test/send-sms
index bd1fae5..19d0e35 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -14,11 +14,22 @@ path =3D modems[0][0]
 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.MessageManager')
 =

+smsc =3D None
+
+if sys.argv[1] =3D=3D "--smsc":
+	smsc =3D sys.argv[2]
+	del sys.argv[1:2]
+
+if sys.argv[1].startswith("--smsc=3D"):
+	smsc =3D sys.argv[1].split("=3D", 2)[1]
+	del sys.argv[1]
+
+if smsc:
+	manager.SetProperty("ServiceCenterAddress", dbus.String(smsc))
+
 if len(sys.argv) =3D=3D 4:
-	manager.SetProperty("UseDeliveryReports",
-					dbus.Boolean(int(sys.argv[1])))
-	path =3D manager.SendMessage(sys.argv[1], sys.argv[2])
-else:
-	path =3D manager.SendMessage(sys.argv[1], sys.argv[2])
+ 	manager.SetProperty("UseDeliveryReports",
+ 					dbus.Boolean(int(sys.argv[1])))
+	del sys.argv[1]
 =

-print path
+print manager.SendMessage(sys.argv[1], sys.argv[2])
-- =

1.7.0.4


--===============5864236912383980659==--

