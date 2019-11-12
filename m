Content-Type: multipart/mixed; boundary="===============6297660672877637811=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 11/13] Use dynamic_cast where appropriate
Date: Tue, 12 Nov 2019 22:37:17 +0100
Message-ID: <20191112213719.9309-12-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6297660672877637811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done using the cppcoreguidelines-pro-type-cstyle-cast check of clang-tidy
---
 src/aidapplication.cpp | 2 +-
 src/phonesim.cpp       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
index 16fef0c..807d7f9 100644
--- a/src/aidapplication.cpp
+++ b/src/aidapplication.cpp
@@ -15,7 +15,7 @@ AidApplication::AidApplication( QObject *parent, SimXmlNo=
de& n )

     while (child) {
         if ( child->tag =3D=3D "filesystem" )
-            fs =3D new SimFileSystem( (SimRules *)parent, *child, FILE_SYS=
TEM_TYPE_ISIM );
+            fs =3D new SimFileSystem( dynamic_cast<SimRules *>(parent), *c=
hild, FILE_SYSTEM_TYPE_ISIM );

         child =3D child->next;
     }
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index f9dab52..9acd39e 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -1665,7 +1665,7 @@ void SimRules::callControlEventNotify( const QSimCont=
rolEvent& evt )

 void SimRules::delayTimeout()
 {
-    SimDelayTimer *timer =3D (SimDelayTimer *)sender();
+    SimDelayTimer *timer =3D dynamic_cast<SimDelayTimer *>(sender());
     int save =3D currentChannel;
     currentChannel =3D timer->channel;
     writeChatData(timer->response.toLatin1().data(), timer->response.lengt=
h());
@@ -1676,7 +1676,7 @@ void SimRules::delayTimeout()

 void SimRules::delaySetVariable()
 {
-    QVariantTimer *timer =3D (QVariantTimer *)sender();
+    QVariantTimer *timer =3D dynamic_cast<QVariantTimer *>(sender());
     QPairKV kv =3D timer->param.value<QPairKV>();

     setVariable( kv.first, kv.second );
--
2.24.0

--===============6297660672877637811==--

