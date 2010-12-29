Content-Type: multipart/mixed; boundary="===============4788267564733826508=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/4] test: use new names for CalledLine* properties
Date: Wed, 29 Dec 2010 00:41:02 -0200
Message-ID: <1293590462-3516-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1293590462-3516-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4788267564733826508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-call-settings |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/test-call-settings b/test/test-call-settings
index 60fe3ba..3258da7 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -42,14 +42,14 @@ if __name__ =3D=3D "__main__":
 	print "Current Property values:"
 	print "Network Status of Call Waiting - Voice: %s" %\
 		(properties['VoiceCallWaiting'])
-	print "Network Status of Called Line Restriction: %s" %\
-		(properties['CalledLineRestriction'])
+	print "Network Status of Connected Line Restriction: %s" %\
+		(properties['ConnectedLineRestriction'])
 	print "Network Status of Calling Line Restriction: %s" %\
 		(properties['CallingLineRestriction'])
 	print "Network Status of Calling Line Presentation: %s" %\
 		(properties['CallingLinePresentation'])
-	print "Network Status of Called Line Presentation: %s" %\
-		(properties['CalledLinePresentation'])
+	print "Network Status of Connected Line Presentation: %s" %\
+		(properties['ConnectedLinePresentation'])
 	print "Hide my Caller Id: %s" % (properties['HideCallerId'])
 =

 	try:
-- =

1.7.3.4


--===============4788267564733826508==--

