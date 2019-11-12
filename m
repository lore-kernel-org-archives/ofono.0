Content-Type: multipart/mixed; boundary="===============2421168041776205761=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 05/13] Port away from some deprecated Qt apis
Date: Tue, 12 Nov 2019 22:37:11 +0100
Message-ID: <20191112213719.9309-6-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2421168041776205761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp    | 4 ++++
 src/qsmsmessage.cpp    | 4 ++++
 src/qwsppdu.cpp        | 4 ++--
 src/simapplication.cpp | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 672ffb9..6642035 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3764,7 +3764,11 @@ void QSimCommand::addExtensionField( int tag, const =
QByteArray& value )
 QSimCommandPrivate *QSimCommand::dwrite()
 {
     // If we are the only user of the private object, return it as-is.
+#if (QT_VERSION >=3D QT_VERSION_CHECK(5, 14, 0))
+    if ( d->ref.loadRelaxed() =3D=3D 1 )
+#else
     if ( d->ref.load() =3D=3D 1 )
+#endif
         return d;

     // Create a new private object and copy the current contents into it.
diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index 518e542..e4e41b9 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -365,7 +365,11 @@ QSMSMessage::~QSMSMessage()
 QSMSMessagePrivate *QSMSMessage::dwrite()
 {
     // If we are the only user of the private object, return it as-is.
+#if (QT_VERSION >=3D QT_VERSION_CHECK(5, 14, 0))
+    if ( d->ref.loadRelaxed() =3D=3D 1 )
+#else
     if ( d->ref.load() =3D=3D 1 )
+#endif
         return d;

     // Create a new private object and copy the current contents into it.
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index def5675..26f450d 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -292,7 +292,7 @@ static QString secsToUTC(int seconds)

     int h =3D seconds / 3600;
     int m =3D ( abs(seconds) - abs(h * 3600) ) / 60;
-    str.sprintf("%+.2d%.2d", h, m );
+    str.asprintf("%+.2d%.2d", h, m );

     return str;
 }
@@ -413,7 +413,7 @@ QString QWspDateTime::dateString(QDateTime d)
     QByteArray dayName =3D date.shortDayName(date.dayOfWeek()).toUtf8();
     QByteArray monthName =3D date.shortMonthName(date.month()).toUtf8();
     QByteArray utcOffs =3D secsToUTC(timeZoneDiff()).toUtf8();
-    str.sprintf("%s, %.2d %s %d %.2d:%.2d:%.2d %s",
+    str.asprintf("%s, %.2d %s %d %.2d:%.2d:%.2d %s",
             dayName.constData(),
             date.day(),
             monthName.constData(),
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index f9169f2..84058af 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -2227,7 +2227,7 @@ void DemoSimApplication::timersCmdResp( const QSimTer=
minalResponse& resp )
     if ( resp.command().qualifier() =3D=3D 2 ) {
         if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
             QString status;
-            status.sprintf( "Timer %i expires in %i:%02i:%02i.\n",
+            status.asprintf( "Timer %i expires in %i:%02i:%02i.\n",
                     resp.timerId(), resp.duration() / 3600000,
                     (resp.duration() / 60000) % 60,
                     (resp.duration() / 1000) % 60 );
--
2.24.0

--===============2421168041776205761==--

