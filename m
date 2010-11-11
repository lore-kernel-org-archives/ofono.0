Content-Type: multipart/mixed; boundary="===============6543504823186986619=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] test/answer-calls: answer waiting calls, too
Date: Thu, 11 Nov 2010 14:54:31 +0200
Message-ID: <1289480071-30423-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6543504823186986619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/answer-calls |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/test/answer-calls b/test/answer-calls
index 0deb832..1218c66 100755
--- a/test/answer-calls
+++ b/test/answer-calls
@@ -4,8 +4,11 @@ import dbus
 =

 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
+def oface(path, name):
+	obj =3D bus.get_object('org.ofono', path)
+	return dbus.Interface(obj, name)
+
+manager =3D oface('/', 'org.ofono.Manager')
 =

 modems =3D manager.GetModems()
 =

@@ -15,8 +18,7 @@ for path, properties in modems:
 	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
 		continue
 =

-	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.VoiceCallManager')
+	mgr =3D oface(path, 'org.ofono.VoiceCallManager')
 =

 	calls =3D mgr.GetCalls()
 =

@@ -24,10 +26,8 @@ for path, properties in modems:
 		state =3D properties["State"]
 		print "[ %s ] %s" % (path, state)
 =

-		if state !=3D "incoming":
-			continue
-
-		call =3D dbus.Interface(bus.get_object('org.ofono', path),
-						'org.ofono.VoiceCall')
+		if state =3D=3D "incoming":
+			oface(path, 'org.ofono.VoiceCall').Answer()
+		elif state =3D=3D "waiting":
+			mgr.HoldAndAnswer()
 =

-		call.Answer()
-- =

1.7.1


--===============6543504823186986619==--

