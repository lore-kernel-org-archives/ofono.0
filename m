Content-Type: multipart/mixed; boundary="===============8086180428134854746=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] test: show CalledLinePresentation property
Date: Wed, 12 Jan 2011 23:00:01 -0200
Message-ID: <1294880401-3398-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8086180428134854746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-call-settings |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/test/test-call-settings b/test/test-call-settings
index 3258da7..f49ad0b 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -48,6 +48,8 @@ if __name__ =3D=3D "__main__":
 		(properties['CallingLineRestriction'])
 	print "Network Status of Calling Line Presentation: %s" %\
 		(properties['CallingLinePresentation'])
+	print "Network Status of Called Line Presentation: %s" %\
+		(properties['CalledLinePresentation'])
 	print "Network Status of Connected Line Presentation: %s" %\
 		(properties['ConnectedLinePresentation'])
 	print "Hide my Caller Id: %s" % (properties['HideCallerId'])
-- =

1.7.3.5


--===============8086180428134854746==--

