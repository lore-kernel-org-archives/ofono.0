Content-Type: multipart/mixed; boundary="===============5039684847740802027=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Force requirement for filename option in cmd line
Date: Tue, 09 Nov 2010 16:45:20 -0200
Message-ID: <1289328320-10160-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5039684847740802027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.cpp |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/main.cpp b/src/main.cpp
index d601ac2..d4327b1 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -35,7 +35,7 @@ static void usage()
 int main(int argc, char **argv)
 {
     QApplication app(argc, argv);
-    QString filename;
+    QString filename =3D NULL;
     int port =3D 12345;
     int index;
     bool with_gui =3D false;
@@ -71,6 +71,11 @@ int main(int argc, char **argv)
 =

     }
 =

+    if (filename =3D=3D NULL) {
+        qWarning() << "ERROR: filename must be the last argument";
+        usage();
+    }
+
     PhoneSimServer *pss =3D new PhoneSimServer(filename, port, 0);
 =

     if (with_gui)
-- =

1.7.3.1


--===============5039684847740802027==--

