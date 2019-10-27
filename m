Content-Type: multipart/mixed; boundary="===============0584613515381154726=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 7/8] Fix Qt5 port on 64-bit platforms
Date: Sun, 27 Oct 2019 17:30:08 +0100
Message-ID: <20191027163009.13406-8-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0584613515381154726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alexander Akulich <akulichalexander@gmail.com>

---
 src/phonesim.cpp | 2 +-
 src/phonesim.h   | 2 +-
 src/server.cpp   | 2 +-
 src/server.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 0e446f6..f14281b 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -516,7 +516,7 @@ static bool readXmlFile( SimXmlHandler *handler, const =
QString& filename )
     return !reader.hasError();
 }

-SimRules::SimRules( int fd, QObject *p,  const QString& filename, Hardware=
ManipulatorFactory *hmf )
+SimRules::SimRules(qintptr fd, QObject *p,  const QString& filename, Hardw=
areManipulatorFactory *hmf )
     : QTcpSocket(p)
 {
     setSocketDescriptor(fd);
diff --git a/src/phonesim.h b/src/phonesim.h
index c8bcaad..466f88d 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -247,7 +247,7 @@ class SimRules : public QTcpSocket
 {
     Q_OBJECT
 public:
-    SimRules(int fd, QObject *parent, const QString& filename, HardwareMan=
ipulatorFactory *hmf );
+    SimRules(qintptr fd, QObject *parent, const QString& filename, Hardwar=
eManipulatorFactory *hmf );
     ~SimRules() {}

     // get the variable value for.
diff --git a/src/server.cpp b/src/server.cpp
index cd68969..62487ee 100644
--- a/src/server.cpp
+++ b/src/server.cpp
@@ -44,7 +44,7 @@ void PhoneSimServer::setHardwareManipulator(HardwareManip=
ulatorFactory *f)
         f->setRuleFile(filename);
 }

-void PhoneSimServer::incomingConnection(int s)
+void PhoneSimServer::incomingConnection(qintptr s)
 {
   SimRules *sr =3D new SimRules(s, this, filename, fact);
     sr->setPhoneNumber(QString::number(phonenumber));
diff --git a/src/server.h b/src/server.h
index 5915cc1..3342a90 100644
--- a/src/server.h
+++ b/src/server.h
@@ -40,7 +40,7 @@ public:
     SimRules *rules() const { return currentRules; }

 protected:
-    void incomingConnection(int s);
+    void incomingConnection(qintptr s);

 private:
     QString filename;
--
2.23.0

--===============0584613515381154726==--

