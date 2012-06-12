Content-Type: multipart/mixed; boundary="===============7583492270072333214=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 6/6] test: Support delivery_report in Send-Message script
Date: Tue, 12 Jun 2012 16:04:15 +0200
Message-ID: <1339509855-7467-7-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7583492270072333214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-message |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/test/send-message b/test/send-message
index 558fdaa..8522375 100755
--- a/test/send-message
+++ b/test/send-message
@@ -4,20 +4,23 @@ import sys
 import dbus
 import csv
 =

-if (len(sys.argv) < 4):
+if (len(sys.argv) < 5):
 	print "Usage: %s"\
 		" <recipient>,..."\
+		"<delivery-report>"\
 		" <smil-file-path>"\
 		" <<content-id>,<content-type>,<file-path>>,..."\
 		% (sys.argv[0])
 	print "Sample(Related): %s"\
 		" \"+33611111111,+33622222222\""\
+		" \"TRUE\""\
 		" \"smil.txt\""\
 		" \"cid-1,text/plain,text.txt\""\
 		" \"cid-2,image/jpeg,image.jpg\""\
 		% (sys.argv[0])
 	print "Sample(Mixed): %s"\
 		" \"+33611111111,+33622222222\""\
+		" \"FALSE\""\
 		" \"\""\
 		" \"cid-1,text/plain,text.txt\""\
 		" \"cid-2,image/jpeg,image.jpg\""\
@@ -42,18 +45,22 @@ for r in reader:
 	for i in r:
 		recipients.append(dbus.String(i))
 =

+if sys.argv[2].capitalize() =3D=3D 'True':
+	delivery =3D True
+else:
+	delivery =3D False
 =

-if sys.argv[2] =3D=3D "":
+if sys.argv[3] =3D=3D "":
 	print "Send MMS as Mixed"
 	smil =3D ""
 else:
 	print "Send MMS as Related"
-	print "Smil path: %s" % (sys.argv[2])
-	file =3D open(sys.argv[2],"r")
+	print "Smil path: %s" % (sys.argv[3])
+	file =3D open(sys.argv[3],"r")
 	smil =3D dbus.String(file.read())
 =

 attachments =3D dbus.Array([],signature=3Ddbus.Signature('(sss)'))
-for a in sys.argv[3:]:
+for a in sys.argv[4:]:
 	print "Attachment: (%s)" % a
 	reader =3D csv.reader([a])
 	for r in reader:
@@ -62,6 +69,6 @@ for a in sys.argv[3:]:
 						dbus.String(r[2])
 						), signature=3DNone))
 =

-path =3D service.SendMessage(recipients, smil, attachments)
+path =3D service.SendMessage(recipients, delivery, smil, attachments)
 =

 print path
-- =

1.7.4.1


--===============7583492270072333214==--

