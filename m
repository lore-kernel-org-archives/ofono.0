Content-Type: multipart/mixed; boundary="===============1292340535657534729=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] phonesim: Free some resources after client disconnects.
Date: Tue, 20 Apr 2010 06:44:08 +0200
Message-ID: <1271738648-21745-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1292340535657534729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also zero SimRules::toolkitApp to avoid segfaults before the field
is initialised.

Note there may be more places leaking resources.
---
 src/phonesim.cpp |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index d363c29..d5d7d87 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -501,6 +501,7 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
 {
     setSocketDescriptor(fd);
     machine =3D 0;
+    toolkitApp =3D 0;
 =

     if (hmf)
         machine =3D hmf->create(this, 0);
@@ -554,6 +555,7 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     SimXmlHandler *handler =3D new SimXmlHandler();
     if ( !readXmlFile( handler, filename ) ) {
         qWarning() << filename << ": could not parse simulator rule file";
+        delete handler;
         return;
     }
 =

@@ -837,6 +839,26 @@ void SimRules::tryReadCommand()
 =

 void SimRules::destruct()
 {
+    if ( toolkitApp !=3D defaultToolkitApp )
+        delete toolkitApp;
+    delete defaultToolkitApp;
+    toolkitApp =3D NULL;
+
+    if ( getMachine() )
+        getMachine()->handleNewApp();
+
+    if ( defState )
+        delete defState;
+    defState =3D NULL;
+
+    if ( _callManager )
+        delete _callManager;
+    _callManager =3D NULL;
+
+    if ( fileSystem )
+        delete fileSystem;
+    fileSystem =3D NULL;
+
     if (machine) machine->deleteLater();
     deleteLater();
 }
-- =

1.6.1


--===============1292340535657534729==--

