Content-Type: multipart/mixed; boundary="===============1522493313634529884=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] test: Find the active call and do hangup on that.
Date: Thu, 03 Feb 2011 14:14:08 +0100
Message-ID: <1296738848-23648-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1522493313634529884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 test/hangup-active |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/test/hangup-active b/test/hangup-active
index 52dd2c6..6444b23 100755
--- a/test/hangup-active
+++ b/test/hangup-active
@@ -15,9 +15,15 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', p=
ath),
 						'org.ofono.VoiceCallManager')
 =

 calls =3D manager.GetCalls()
-path =3D calls[0][0]
 =

-call =3D dbus.Interface(bus.get_object('org.ofono', path),
+for path, properties in calls:
+		state =3D properties["State"]
+		print "[ %s ] %s" % (path, state)
+
+		if state !=3D "active":
+			continue
+
+		call =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.VoiceCall')
 =

-call.Hangup()
+		call.Hangup()
-- =

1.7.1


--===============1522493313634529884==--

