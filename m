Content-Type: multipart/mixed; boundary="===============3018806887166435134=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH v2 2/3] Some instances in ControlWidget need to be deleted
Date: Fri, 01 Oct 2010 01:52:25 +0800
Message-ID: <1285869146-30183-3-git-send-email-gyagp0@gmail.com>
In-Reply-To: <1285869146-30183-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3018806887166435134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |    6 ++++++
 src/control.h   |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 458ee43..9e2c1f0 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -89,6 +89,12 @@ void ControlWidget::closeEvent(QCloseEvent *event)
     hide();
 }
 =

+ControlWidget::~ControlWidget()
+{
+    delete ui;
+    delete translator;
+}
+
 Control::Control(const QString& ruleFile, SimRules *sr, QObject *parent)
         : HardwareManipulator(sr, parent),
         widget(new ControlWidget(ruleFile, this))
diff --git a/src/control.h b/src/control.h
index 3577e8d..95536dc 100644
--- a/src/control.h
+++ b/src/control.h
@@ -31,6 +31,7 @@ class ControlWidget : public QWidget
 Q_OBJECT
 public:
     ControlWidget( const QString&, Control*);
+    ~ControlWidget();
 =

     void handleFromData( const QString& );
     void handleToData( const QString& );
-- =

1.7.0.4


--===============3018806887166435134==--

