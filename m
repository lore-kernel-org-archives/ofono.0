Content-Type: multipart/mixed; boundary="===============8830727585250072776=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 7/7] Fix handling of incoming connections
Date: Sun, 27 Oct 2019 02:04:25 +0200
Message-ID: <20191027000425.14022-8-jbb.prv@gmx.de>
In-Reply-To: <20191027000425.14022-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8830727585250072776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function has changed from: void incomingConnection(int s)
to: void incomingConnection(qintptr s) in Qt5

See https://doc.qt.io/qt-5/sourcebreaks.html#changes-to-qt-network

This caused our implementation of incomingConnection() of QTcpServer not
to be called anymore.
---
 src/server.cpp | 2 +-
 src/server.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 5915cc1..8fc5cfc 100644
--- a/src/server.h
+++ b/src/server.h
@@ -40,7 +40,7 @@ public:
     SimRules *rules() const { return currentRules; }

 protected:
-    void incomingConnection(int s);
+    void incomingConnection(qintptr s) override;

 private:
     QString filename;
--
2.23.0

--===============8830727585250072776==--

