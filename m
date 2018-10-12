Content-Type: multipart/mixed; boundary="===============2288958001930301893=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] test: add support for new languages
Date: Fri, 12 Oct 2018 13:42:43 +0530
Message-ID: <1539331963-3573-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2288958001930301893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding new language support to set "alphabet" parameter.
---
 test/set-sms-alphabet | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/test/set-sms-alphabet b/test/set-sms-alphabet
index 5573891..ca099fc 100644
--- a/test/set-sms-alphabet
+++ b/test/set-sms-alphabet
@@ -15,7 +15,9 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	alphabet =3D sys.argv[1]
 else:
-	print("%s [PATH] turkish|spanish|portuguese|bengali|gujarati" % (sys.argv=
[0]))
+	print("%s [PATH] turkish|spanish|portuguese|bengali|gujarati|hindi \
+		      |kannada|malayalam|oriya|punjabi|tamil|telugu|urdu" %
+			(sys.argv[0]))
 	sys.exit(1)
 =

 print("Setting alphabet for modem %s..." % path)
-- =

2.7.4


--===============2288958001930301893==--

