Content-Type: multipart/mixed; boundary="===============1586271557267317518=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 3/6] hardwaremanipulator: add callmanagement method
Date: Thu, 28 Apr 2011 11:49:36 +0200
Message-ID: <1303984179-8333-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1303984179-8333-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1586271557267317518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.cpp |    4 ++++
 src/hardwaremanipulator.h   |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index c7bbe6a..909ce2a 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -337,3 +337,7 @@ void HardwareManipulator::simAppAbort()
     if (app)
         return app->abort();
 }
+
+void HardwareManipulator::callManagement( QList<CallInfo> *info )
+{
+}
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index df8f65e..ae8e716 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -27,6 +27,7 @@
 class QSMSMessage;
 class QVMMessage;
 class SimRules;
+struct CallInfo;
 class HardwareManipulator : public QObject
 {
 Q_OBJECT
@@ -49,6 +50,7 @@ public slots:
     virtual void simAppStart( int appIndex );
     virtual void simAppAbort();
     virtual void handleNewApp();
+    virtual void callManagement( QList<CallInfo> *info );
 =

 signals:
     void unsolicitedCommand(const QString &cmd);
-- =

1.7.1


--===============1586271557267317518==--

