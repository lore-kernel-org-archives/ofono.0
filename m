Content-Type: multipart/mixed; boundary="===============3796483463124936108=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/2] phonesim: Add CSSU/CSSI notification support
Date: Tue, 29 Mar 2011 17:16:36 +0200
Message-ID: <1301411796-18027-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1301411796-18027-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3796483463124936108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |   30 +++++++++++++++++++++++++++++-
 src/control.h   |    2 ++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 279bade..645219c 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -87,6 +87,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(modemSilentReset())=
);
     connect(ui->pbSendGNSSData, SIGNAL(clicked()), this, SLOT(sendGNSSData=
()));
     connect(ui->pbGNSSDefault, SIGNAL(clicked()), this, SLOT(setDefaultGNS=
SData()));
+    connect(ui->pbSendNotif, SIGNAL(clicked()), this, SLOT(sendCSSN()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -94,6 +95,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     ui->twMessageList->verticalHeader()->hide();
 =

     handleNewApp();
+    handleCSSNNotif();
 =

     show();
 }
@@ -142,13 +144,39 @@ void Control::warning( const QString &title, const QS=
tring &message )
     QMessageBox::warning(widget, title, message, "OK");
 }
 =

+void ControlWidget::handleCSSNNotif()
+{
+    ui->cbCSSU->insertItem(0, "");
+    ui->cbCSSU->insertItem(1, "0 - forwarded", 0);
+    ui->cbCSSU->insertItem(3, "2 - on hold", 2);
+    ui->cbCSSU->insertItem(4, "3 - retrieved", 3);
+    ui->cbCSSU->insertItem(5, "4 - multiparty", 4);
+
+    ui->cbCSSI->insertItem(0, "");
+    ui->cbCSSI->insertItem(3, "2 - forwarded", 2);
+    ui->cbCSSI->insertItem(6, "5 - outgoing barred", 5);
+    ui->cbCSSI->insertItem(7, "6 - incomming barred", 6);
+}
+
+void ControlWidget::sendCSSN()
+{
+    QVariant v =3D ui->cbCSSU->itemData(ui->cbCSSU->currentIndex());
+
+    if (v.canConvert<int>())
+        emit unsolicitedCommand("+CSSU: "+QString::number(v.toInt()));
+
+    v =3D ui->cbCSSI->itemData(ui->cbCSSI->currentIndex());
+
+    if (v.canConvert<int>())
+        emit unsolicitedCommand("+CSSI: "+QString::number(v.toInt()));
+}
+
 void ControlWidget::sendSQ()
 {
     emit variableChanged("SQ",QString::number(ui->hsSignalQuality->value()=
)+",99");
     emit unsolicitedCommand("+CSQ: "+QString::number(ui->hsSignalQuality->=
value())+",99");
 }
 =

-
 void ControlWidget::sendBC()
 {
     bool charging =3D ui->hsBatteryCharging->checkState() =3D=3D Qt::Check=
ed;
diff --git a/src/control.h b/src/control.h
index eac4288..c17146a 100644
--- a/src/control.h
+++ b/src/control.h
@@ -70,6 +70,7 @@ public:
     void handleFromData( const QString& );
     void handleToData( const QString& );
     void handleNewApp();
+    void handleCSSNNotif();
 =

 private slots:
     void sendSQ();
@@ -97,6 +98,7 @@ private slots:
     void modemSilentReset();
     void sendGNSSData();
     void setDefaultGNSSData();
+    void sendCSSN();
 =

 signals:
     void unsolicitedCommand(const QString &);
-- =

1.7.1


--===============3796483463124936108==--

