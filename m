Content-Type: multipart/mixed; boundary="===============4761541314422230752=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 4/5] control: Handle hangup call
Date: Wed, 18 May 2011 15:33:29 +0200
Message-ID: <1305725610-32602-5-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4761541314422230752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |   24 +++++++++++++++++++++++-
 src/control.h   |    2 ++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 60f23f2..7c52564 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -90,6 +90,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->pbSendNotif, SIGNAL(clicked()), this, SLOT(sendCSSN()));
     connect(ui->pbAlerting, SIGNAL(clicked()), this, SLOT(setStateAlerting=
()));
     connect(ui->pbActive, SIGNAL(clicked()), this, SLOT(setStateConnected(=
)));
+    connect(ui->pbHangup, SIGNAL(clicked()), this, SLOT(setStateHangup()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -127,7 +128,8 @@ Control::Control(const QString& ruleFile, SimRules *sr,=
 QObject *parent)
         << SIGNAL(switchTo(QString))
         << SIGNAL(startIncomingCall(QString, QString, QString))
         << SIGNAL(stateChangedToAlerting())
-        << SIGNAL(stateChangedToConnected());
+        << SIGNAL(stateChangedToConnected())
+        << SIGNAL(stateChangedToHangup(int));
 =

     foreach (QByteArray sig, proxySignals)
         connect(widget, sig, this, sig);
@@ -182,6 +184,26 @@ void ControlWidget::setStateAlerting()
     emit stateChangedToAlerting();
 }
 =

+void ControlWidget::setStateHangup()
+{
+    QList <QTableWidgetItem *> items =3D ui->twCallMgt->selectedItems();
+
+    foreach ( QTableWidgetItem *item, items )
+    {
+        int row =3D item->row();
+        if ( row >=3D 0 )
+        {
+            QTableWidgetItem *itemCallId =3D ui->twCallMgt->item( row, 0 );
+            if ( itemCallId !=3D 0 )
+            {
+                QString strid =3D itemCallId->text();
+                int id =3D strid.toInt();
+                emit p->stateChangedToHangup( id );
+            }
+        }
+    }
+}
+
 void ControlWidget::setCssiEnabled( bool enableCSSI )
 {
     ui->cbCSSI->setEnabled( enableCSSI );
diff --git a/src/control.h b/src/control.h
index 3b8ff64..fd1a4e6 100644
--- a/src/control.h
+++ b/src/control.h
@@ -106,6 +106,7 @@ private slots:
     void sendCSSN();
     void setStateAlerting();
     void setStateConnected();
+    void setStateHangup();
 =

 signals:
     void unsolicitedCommand(const QString &);
@@ -115,6 +116,7 @@ signals:
     void startIncomingCall(const QString &, const QString &, const QString=
 &);
     void stateChangedToAlerting();
     void stateChangedToConnected();
+    void stateChangedToHangup( int callId );
 =

 protected:
     void closeEvent(QCloseEvent *event);
-- =

1.7.1


--===============4761541314422230752==--

