Content-Type: multipart/mixed; boundary="===============6211957757330138308=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: fix for sigsegv fault
Date: Thu, 13 Jan 2011 10:30:00 +0200
Message-ID: <1294907400-25120-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6211957757330138308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes the issue in List count handling which might result
in sigsegv during destruction. Also added additional check
for start button handling.
---
 src/control.cpp  |    3 ++-
 src/phonesim.cpp |   10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 2cbb91a..f2249cb 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -467,7 +467,8 @@ void Control::handleNewApp()
 =

 void ControlWidget::simAppStart()
 {
-    p->simAppStart( ui->cbSimApps->currentIndex() );
+    if ( ui->cbSimApps->currentIndex() >=3D 0 )
+        p->simAppStart( ui->cbSimApps->currentIndex() );
 }
 =

 void ControlWidget::simAppAbort()
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 47425bc..8a9c50e 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -844,13 +844,17 @@ void SimRules::tryReadCommand()
 =

 void SimRules::destruct()
 {
+    int count =3D simApps.count();
+
+    for ( int i =3D 0; i < count; i++ )
+        simApps.removeAt( 0 );
+
     delete conformanceApp;
+    conformanceApp =3D NULL;
     delete defaultToolkitApp;
+    defaultToolkitApp =3D NULL;
     toolkitApp =3D NULL;
 =

-    for ( int i =3D 0; i < simApps.count(); i++ )
-        simApps.removeAt( i );
-
     if ( getMachine() )
         getMachine()->handleNewApp();
 =

-- =

1.7.0.4


--===============6211957757330138308==--

