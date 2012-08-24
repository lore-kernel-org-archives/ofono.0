Content-Type: multipart/mixed; boundary="===============7251722269838402647=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 3/3] control: Link functionnality to STK command editor
Date: Fri, 24 Aug 2012 10:32:35 +0200
Message-ID: <1345797155-27517-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1345797155-27517-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7251722269838402647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |   12 ++++++++++++
 src/control.h   |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/src/control.cpp b/src/control.cpp
index 3f1dd45..f518201 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -91,6 +91,8 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->pbAlerting, SIGNAL(clicked()), this, SLOT(setStateAlerting=
()));
     connect(ui->pbActive, SIGNAL(clicked()), this, SLOT(setStateConnected(=
)));
     connect(ui->pbHangup, SIGNAL(clicked()), this, SLOT(setStateHangup()));
+    connect(ui->pbSTKCmdSend, SIGNAL(clicked()), this, SLOT(STKCmdSend()));
+    connect(ui->pbSTKClear, SIGNAL(clicked()), this, SLOT(STKClear()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -625,6 +627,16 @@ void Control::handleNewApp()
     widget->handleNewApp();
 }
 =

+void ControlWidget::STKCmdSend()
+{
+    emit unsolicitedCommand( "+CUSATP: " + ui->teSTKCmdEditor->toPlainText=
() );
+}
+
+void ControlWidget::STKClear()
+{
+    ui->teSTKCmdEditor->clear();
+}
+
 void ControlWidget::simAppStart()
 {
     if ( ui->cbSimApps->currentIndex() >=3D 0 )
diff --git a/src/control.h b/src/control.h
index fd1a4e6..c4d5244 100644
--- a/src/control.h
+++ b/src/control.h
@@ -107,6 +107,8 @@ private slots:
     void setStateAlerting();
     void setStateConnected();
     void setStateHangup();
+    void STKCmdSend();
+    void STKClear();
 =

 signals:
     void unsolicitedCommand(const QString &);
-- =

1.7.9.5


--===============7251722269838402647==--

