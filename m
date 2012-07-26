Content-Type: multipart/mixed; boundary="===============5442067355078760192=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] monitor-ofono: Fix to print non-English characters
Date: Thu, 26 Jul 2012 17:57:53 +0200
Message-ID: <1343318274-19845-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5442067355078760192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default encoding for a Python bytestring is ASCII. But the
SMS/USSD text is encoded in UTF-8.
This is why trying to convert non-English characters (Unicode
characters beyond 128) produces the error
"UnicodeEncodeError: 'ascii' codec can't encode character".
---
 test/monitor-ofono |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index 8570c34..dcc5ff5 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -69,11 +69,11 @@ def event(member, path, interface):
 def message(msg, args, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
 	print "{%s} [%s] %s %s (%s)" % (iface, path, member,
-					str(msg), pretty(args))
+					msg, pretty(args))
 =

 def ussd(msg, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
+	print "{%s} [%s] %s %s" % (iface, path, member, msg)
 =

 def value(value, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-- =

1.7.9.5


--===============5442067355078760192==--

