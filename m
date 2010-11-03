Content-Type: multipart/mixed; boundary="===============2316759813986184718=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2] Add option to support version
Date: Wed, 03 Nov 2010 18:16:13 +0800
Message-ID: <1288779373-29307-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2316759813986184718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.cpp |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/main.cpp b/src/main.cpp
index d7de416..d601ac2 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -28,7 +28,7 @@ static void usage()
 {
     qWarning() << "Usage:"
                << QFileInfo(QCoreApplication::instance()->applicationFileP=
ath()).fileName().toLocal8Bit().constData()
-               << "[-p port] [-gui] filename";
+               << "[-v] [-p port] [-gui] filename";
     exit(-1);
 }
 =

@@ -43,7 +43,10 @@ int main(int argc, char **argv)
     // Parse the command-line.
     index =3D 1;
     for (index =3D 1; index < argc; index++) {
-        if (strcmp(argv[index],"-p") =3D=3D 0) {
+        if (strcmp(argv[index],"-v") =3D=3D 0) {
+            qWarning() << VERSION;
+            exit(0);
+        } else if (strcmp(argv[index],"-p") =3D=3D 0) {
             index++;
             if (index >=3D argc) {
                 qWarning() << "ERROR: Got -p but missing port number";
-- =

1.7.2.3


--===============2316759813986184718==--

