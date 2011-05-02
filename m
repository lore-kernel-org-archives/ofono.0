Content-Type: multipart/mixed; boundary="===============2457736808825172040=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 3/6] hardwaremanipulator: add callmanagement method
Date: Mon, 02 May 2011 11:17:15 +0200
Message-ID: <1304327838-11164-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2457736808825172040==
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


--===============2457736808825172040==--

