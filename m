Content-Type: multipart/mixed; boundary="===============5308391986827048025=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 4/5] control: handle call management buttons
Date: Wed, 11 May 2011 13:46:46 +0200
Message-ID: <1305114407-23796-5-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5308391986827048025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |   12 ++++++++++++
 src/control.h   |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index de141c3..4fdba27 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -88,6 +88,8 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->pbSendGNSSData, SIGNAL(clicked()), this, SLOT(sendGNSSData=
()));
     connect(ui->pbGNSSDefault, SIGNAL(clicked()), this, SLOT(setDefaultGNS=
SData()));
     connect(ui->pbSendNotif, SIGNAL(clicked()), this, SLOT(sendCSSN()));
+    connect(ui->pbAlerting, SIGNAL(clicked()), this, SLOT(setStateAlerting=
()));
+    connect(ui->pbActive, SIGNAL(clicked()), this, SLOT(setStateConnected(=
)));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -168,6 +170,16 @@ void Control::callManagement( QList<CallInfo> *list )
     widget->setCssuEnabled( enableCSSU );
 }
 =

+void ControlWidget::setStateConnected()
+{
+    emit p->stateChangedToConnected();
+}
+
+void ControlWidget::setStateAlerting()
+{
+    emit p->stateChangedToAlerting();
+}
+
 void ControlWidget::setCssiEnabled( bool enableCSSI )
 {
     ui->cbCSSI->setEnabled( enableCSSI );
diff --git a/src/control.h b/src/control.h
index ac39eb3..1d8f06f 100644
--- a/src/control.h
+++ b/src/control.h
@@ -104,6 +104,8 @@ private slots:
     void sendGNSSData();
     void setDefaultGNSSData();
     void sendCSSN();
+    void setStateAlerting();
+    void setStateConnected();
 =

 signals:
     void unsolicitedCommand(const QString &);
-- =

1.7.1


--===============5308391986827048025==--

