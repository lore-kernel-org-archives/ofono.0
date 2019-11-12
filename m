Content-Type: multipart/mixed; boundary="===============1395207324806524612=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 12/13] Annotate overriding functions with override
Date: Tue, 12 Nov 2019 22:37:18 +0100
Message-ID: <20191112213719.9309-13-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1395207324806524612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Allows us to notice when a function becomes source incompatible in a Qt m=
ajor release,
  and our implementation stops overriding.
---
 src/aidapplication.cpp      |  3 ++-
 src/aidapplication.h        |  4 ++--
 src/callmanager.h           |  2 +-
 src/control.h               | 18 +++++++--------
 src/hardwaremanipulator.cpp |  1 +
 src/phonesim.h              | 16 +++++++-------
 src/qatutils.cpp            | 44 ++++++++++++++++++-------------------
 src/qgsmcodec.h             | 10 ++++-----
 src/qwsppdu.cpp             |  6 ++---
 src/qwsppdu.h               |  4 ++--
 src/simapplication.h        | 20 ++++++++---------
 src/simauth.h               |  2 +-
 src/simfilesystem.h         |  4 ++--
 13 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
index 807d7f9..395fe99 100644
--- a/src/aidapplication.cpp
+++ b/src/aidapplication.cpp
@@ -190,7 +190,8 @@ bool AidAppWrapper::command( const QString& cmd )

             return true;
         }
-        break;
+        // if CMD_TYPE_GSM_AUTH is the case, we already returned
+        // and can't fallthrough, so no break here
         case CMD_TYPE_UMTS_AUTH:
         {
             enum UmtsStatus status;
diff --git a/src/aidapplication.h b/src/aidapplication.h
index d8b1b93..9126412 100644
--- a/src/aidapplication.h
+++ b/src/aidapplication.h
@@ -44,7 +44,7 @@ class AidApplication : public QObject
     Q_OBJECT
 public:
     AidApplication( QObject *parent, SimXmlNode& n );
-    ~AidApplication();
+    ~AidApplication() override;

     QString getAid() { return aid; };
     QString getType() { return type; };
@@ -67,7 +67,7 @@ class AidAppWrapper : public QObject
     Q_OBJECT
 public:
     AidAppWrapper( SimRules *r, QList<AidApplication *> apps, SimAuth *aut=
h =3D nullptr );
-    ~AidAppWrapper();
+    ~AidAppWrapper() override;

     bool command( const QString& cmd );

diff --git a/src/callmanager.h b/src/callmanager.h
index 9b1eef0..a39f484 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -52,7 +52,7 @@ class CallManager : public QObject
     Q_OBJECT
 public:
     CallManager( QObject *parent =3D nullptr );
-    ~CallManager();
+    ~CallManager() override;

     // Process an AT command.  Returns false if not a call-related command.
     bool command( const QString& cmd );
diff --git a/src/control.h b/src/control.h
index a7c0ff3..79cd417 100644
--- a/src/control.h
+++ b/src/control.h
@@ -119,7 +119,7 @@ signals:
     void stateChangedToHangup( int callId );

 protected:
-    void closeEvent(QCloseEvent *event);
+    void closeEvent(QCloseEvent *event) override;

 private:
     Ui_ControlBase *ui;
@@ -150,17 +150,17 @@ Q_OBJECT

 public:
     Control(const QString& ruleFile, SimRules *sr, QObject *parent=3Dnullp=
tr);
-    virtual ~Control();
+    ~Control() override;

 public slots:
-    void handleFromData( const QString& );
-    void handleToData( const QString& );
-    void setPhoneNumber( const QString& );
-    void handleNewApp();
-    void callManagement( QList<CallInfo> *info );
+    void handleFromData( const QString& ) override;
+    void handleToData( const QString& ) override;
+    void setPhoneNumber( const QString& ) override;
+    void handleNewApp() override;
+    void callManagement( QList<CallInfo> *info ) override;

 protected:
-    virtual void warning( const QString&, const QString& );
+    void warning( const QString&, const QString& ) override;

 private:
     ControlWidget *widget;
@@ -170,7 +170,7 @@ private:
 class ControlFactory : public HardwareManipulatorFactory
 {
 public:
-    inline virtual HardwareManipulator *create(SimRules *sr, QObject *pare=
nt)
+    inline HardwareManipulator *create(SimRules *sr, QObject *parent) over=
ride
         { return new Control(ruleFile(), sr, parent); }
 };

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index ea895e7..63c498a 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -363,4 +363,5 @@ void HardwareManipulator::simAppAbort()

 void HardwareManipulator::callManagement( QList<CallInfo> *info )
 {
+    Q_UNUSED(info)
 }
diff --git a/src/phonesim.h b/src/phonesim.h
index ac5084d..362a6a8 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -128,7 +128,7 @@ class SimItem : public QObject
     Q_OBJECT
 public:
     SimItem( SimState *state ) { _state =3D state; }
-    virtual ~SimItem() {}
+    ~SimItem() override {}

     // Get the state that contains this item.
     SimState *state() { return _state; }
@@ -153,9 +153,9 @@ class SimChat : public SimItem
     Q_OBJECT
 public:
     SimChat( SimState *state, SimXmlNode& e );
-    ~SimChat() {}
+    ~SimChat() override {}

-    virtual bool command( const QString& cmd );
+    bool command( const QString& cmd ) override;

 private:
     QString _command;
@@ -180,10 +180,10 @@ class SimUnsolicited : public SimItem
     Q_OBJECT
 public:
     SimUnsolicited( SimState *state, SimXmlNode& e );
-    ~SimUnsolicited() {}
+    ~SimUnsolicited() override {}

-    virtual void enter();
-    virtual void leave();
+    void enter() override;
+    void leave() override;

 private:
     QString response;
@@ -204,7 +204,7 @@ class SimPhoneBook : public QObject
     Q_OBJECT
 public:
     SimPhoneBook( int size, QObject *parent );
-    ~SimPhoneBook();
+    ~SimPhoneBook() override;

     int size() const { return numbers.size(); }
     int used() const;
@@ -248,7 +248,7 @@ class SimRules : public QTcpSocket
     Q_OBJECT
 public:
     SimRules(qintptr fd, QObject *parent, const QString& filename, Hardwar=
eManipulatorFactory *hmf );
-    ~SimRules() {}
+    ~SimRules() override {}

     // get the variable value for.
     QString variable(const QString &name);
diff --git a/src/qatutils.cpp b/src/qatutils.cpp
index c6cc013..253a932 100644
--- a/src/qatutils.cpp
+++ b/src/qatutils.cpp
@@ -325,14 +325,14 @@ class QGsmHexCodec : public QTextCodec
 {
 public:
     QGsmHexCodec();
-    ~QGsmHexCodec();
+    ~QGsmHexCodec() override;

-    QByteArray name() const;
-    int mibEnum() const;
+    QByteArray name() const override;
+    int mibEnum() const override;

 protected:
-    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const;
-    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const;
+    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const override;
+    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const override;
 };

 QGsmHexCodec::QGsmHexCodec()
@@ -411,14 +411,14 @@ class QUcs2HexCodec : public QTextCodec
 {
 public:
     QUcs2HexCodec();
-    ~QUcs2HexCodec();
+    ~QUcs2HexCodec() override;

-    QByteArray name() const;
-    int mibEnum() const;
+    QByteArray name() const override;
+    int mibEnum() const override;

 protected:
-    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const;
-    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const;
+    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const override;
+    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const override;
 };

 QUcs2HexCodec::QUcs2HexCodec()
@@ -484,15 +484,15 @@ class QCodePage437Codec : public QTextCodec
 {
 public:
     QCodePage437Codec();
-    ~QCodePage437Codec();
+    ~QCodePage437Codec() override;

-    QByteArray name() const;
-    QList<QByteArray> aliases() const;
-    int mibEnum() const;
+    QByteArray name() const override;
+    QList<QByteArray> aliases() const override;
+    int mibEnum() const override;

 protected:
-    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const;
-    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const;
+    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const override;
+    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const override;
 };

 // Convert IBM437 character codes 0x00 - 0xFF into Unicode.
@@ -685,15 +685,15 @@ class QCodePage850Codec : public QTextCodec
 {
 public:
     QCodePage850Codec();
-    ~QCodePage850Codec();
+    ~QCodePage850Codec() override;

-    QByteArray name() const;
-    QList<QByteArray> aliases() const;
-    int mibEnum() const;
+    QByteArray name() const override;
+    QList<QByteArray> aliases() const override;
+    int mibEnum() const override;

 protected:
-    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const;
-    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const;
+    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const override;
+    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const override;
 };

 // Convert IBM850 character codes 0x00 - 0xFF into Unicode.
diff --git a/src/qgsmcodec.h b/src/qgsmcodec.h
index 8ecb6f9..b2347d5 100644
--- a/src/qgsmcodec.h
+++ b/src/qgsmcodec.h
@@ -27,10 +27,10 @@ class QGsmCodec : public QTextCodec
 {
 public:
     explicit QGsmCodec( bool noLoss=3Dfalse );
-    ~QGsmCodec();
+    ~QGsmCodec() override;

-    QByteArray name() const;
-    int mibEnum() const;
+    QByteArray name() const override;
+    int mibEnum() const override;

     static char singleFromUnicode(QChar ch);
     static QChar singleToUnicode(char ch);
@@ -39,8 +39,8 @@ public:
     static QChar twoByteToUnicode(unsigned short ch);

 protected:
-    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const;
-    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const;
+    QString convertToUnicode(const char *in, int length, ConverterState *s=
tate) const override;
+    QByteArray convertFromUnicode(const QChar *in, int length, ConverterSt=
ate *state) const override;

 private:
     bool noLoss;
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index ccb6869..f830a94 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -164,9 +164,9 @@ public:
                 EncodingVersion
     };

-    virtual QWspField decode(QWspPduDecoder &);
-    virtual bool encode(QWspPduEncoder&, const QWspField&);
-    virtual quint8 codePage() const { return 1; }
+    QWspField decode(QWspPduDecoder &) override;
+    bool encode(QWspPduEncoder&, const QWspField&) override;
+    quint8 codePage() const override { return 1; }

 private:
     int fieldFromNumber(quint8 id);
diff --git a/src/qwsppdu.h b/src/qwsppdu.h
index 91b3880..fac0176 100644
--- a/src/qwsppdu.h
+++ b/src/qwsppdu.h
@@ -129,7 +129,7 @@ class QWspPduDecoder : public QObject
     Q_OBJECT
 public:
     explicit QWspPduDecoder(QIODevice *);
-    ~QWspPduDecoder();
+    ~QWspPduDecoder() override;

     quint8 peekOctet();
     quint8 decodeOctet();
@@ -184,7 +184,7 @@ class QWspPduEncoder : public QObject
     Q_OBJECT
 public:
     explicit QWspPduEncoder(QIODevice *);
-    ~QWspPduEncoder();
+    ~QWspPduEncoder() override;

     void encodeOctet(quint8);
     void encodeUInt8(quint8);
diff --git a/src/simapplication.h b/src/simapplication.h
index c5c6501..5f427ed 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -33,7 +33,7 @@ class SimApplication : public QObject
     Q_OBJECT
 public:
     SimApplication( SimRules *rules, QObject *parent =3D nullptr );
-    ~SimApplication();
+    ~SimApplication() override;

     virtual bool envelope( const QSimEnvelope& env );
     virtual bool response( const QSimTerminalResponse& resp );
@@ -68,15 +68,15 @@ class DemoSimApplication : public SimApplication
     Q_OBJECT
 public:
     DemoSimApplication( SimRules *rules, QObject *parent =3D nullptr );
-    ~DemoSimApplication();
+    ~DemoSimApplication() override;

-    const QString getName();
+    const QString getName() override;

-    bool envelope( const QSimEnvelope& env );
+    bool envelope( const QSimEnvelope& env ) override;

 protected slots:
-    void mainMenu();
-    void mainMenuSelection( int id );
+    void mainMenu() override;
+    void mainMenuSelection( int id ) override;
     void sendSportsMenu();
     void sportsMenu( const QSimTerminalResponse& resp );
     void sendCallsMenu();
@@ -149,13 +149,13 @@ class ConformanceSimApplication : public SimApplicati=
on
     Q_OBJECT
 public:
     ConformanceSimApplication( SimRules *rules, QObject *parent =3D nullpt=
r );
-    ~ConformanceSimApplication();
+    ~ConformanceSimApplication() override;

-    const QString getName();
+    const QString getName() override;

 protected slots:
-    void mainMenu();
-    void mainMenuSelection( int id );
+    void mainMenu() override;
+    void mainMenuSelection( int id ) override;
     void sendDisplayTextMenu();
     void DisplayTextMenu( const QSimTerminalResponse& resp );
     void DisplayTextNormalMenu( const QSimTerminalResponse& resp );
diff --git a/src/simauth.h b/src/simauth.h
index fb66593..5a4996d 100644
--- a/src/simauth.h
+++ b/src/simauth.h
@@ -34,7 +34,7 @@ class SimAuth : public QObject
     Q_OBJECT
 public:
     SimAuth( QObject *parent, SimXmlNode& n );
-    ~SimAuth();
+    ~SimAuth() override;

     void gsmAuthenticate( QString rand, QString &sres, QString &kc );
     enum UmtsStatus umtsAuthenticate( QString rand, QString autn,
diff --git a/src/simfilesystem.h b/src/simfilesystem.h
index 477c6c7..9988c82 100644
--- a/src/simfilesystem.h
+++ b/src/simfilesystem.h
@@ -58,7 +58,7 @@ class SimFileSystem : public QObject
     Q_OBJECT
 public:
     SimFileSystem( SimRules *rules, SimXmlNode& e, enum file_system_type t=
ype =3D FILE_SYSTEM_TYPE_DEFAULT );
-    ~SimFileSystem();
+    ~SimFileSystem() override;

     // Execute an AT+CRSM command against the filesystem.
     void crsm( const QString& args );
@@ -98,7 +98,7 @@ class SimFileItem : public QObject
 public:
     SimFileItem( const QString& fileid, SimFileItem *parentDir,
                  int access =3D 0, enum file_type type =3D FILE_TYPE_INVAL=
ID);
-    ~SimFileItem();
+    ~SimFileItem() override;

     QString fileid() const { return _fileid; }
     SimFileItem *parentDir() const { return _parentDir; }
--
2.24.0

--===============1395207324806524612==--

