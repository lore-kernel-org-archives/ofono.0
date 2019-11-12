Content-Type: multipart/mixed; boundary="===============6794626523197484663=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 01/13] Use nullptrs
Date: Tue, 12 Nov 2019 22:37:07 +0100
Message-ID: <20191112213719.9309-2-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794626523197484663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done using the modernize-use-nullptr check of clang-tidy
---
 src/aidapplication.h              |  2 +-
 src/callmanager.h                 |  2 +-
 src/conformancesimapplication.cpp |  2 +-
 src/control.cpp                   |  2 +-
 src/control.h                     |  2 +-
 src/gsmspec.cpp                   | 20 ++++++------
 src/hardwaremanipulator.h         |  2 +-
 src/main.cpp                      |  6 ++--
 src/phonesim.cpp                  | 54 +++++++++++++++----------------
 src/phonesim.h                    |  2 +-
 src/qatresult.cpp                 |  2 +-
 src/qatresultparser.cpp           |  8 ++---
 src/qatutils.cpp                  | 12 +++----
 src/qcbsmessage.cpp               |  2 +-
 src/qsmsmessage.cpp               |  8 ++---
 src/qsmsmessage_p.h               |  4 +--
 src/qwsppdu.cpp                   |  4 +--
 src/server.cpp                    |  4 +--
 src/simapplication.cpp            | 22 ++++++-------
 src/simapplication.h              |  6 ++--
 20 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/src/aidapplication.h b/src/aidapplication.h
index 6a2f4d9..d8b1b93 100644
--- a/src/aidapplication.h
+++ b/src/aidapplication.h
@@ -66,7 +66,7 @@ class AidAppWrapper : public QObject
 {
     Q_OBJECT
 public:
-    AidAppWrapper( SimRules *r, QList<AidApplication *> apps, SimAuth *aut=
h =3D NULL );
+    AidAppWrapper( SimRules *r, QList<AidApplication *> apps, SimAuth *aut=
h =3D nullptr );
     ~AidAppWrapper();

     bool command( const QString& cmd );
diff --git a/src/callmanager.h b/src/callmanager.h
index c34e7fd..9b1eef0 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -51,7 +51,7 @@ class CallManager : public QObject
 {
     Q_OBJECT
 public:
-    CallManager( QObject *parent =3D 0 );
+    CallManager( QObject *parent =3D nullptr );
     ~CallManager();

     // Process an AT command.  Returns false if not a call-related command.
diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index 108b060..2817b0c 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -147,7 +147,7 @@ void ConformanceSimApplication::mainMenu()

     cmd.setMenuItems( items );

-    command( cmd, 0, 0 );
+    command( cmd, nullptr, nullptr );
 }

 void ConformanceSimApplication::mainMenuSelection( int id )
diff --git a/src/control.cpp b/src/control.cpp
index 5eb82f1..1ea5294 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -503,7 +503,7 @@ void ControlWidget::resetTranslator()
 {
     QString fileName =3D QFileDialog::getOpenFileName(this,
      tr("Open Specification File"), QDir::homePath(), tr("Specification fi=
les (*.xml)"));
-    if(fileName !=3D 0)
+    if(fileName !=3D nullptr)
         translator->resetSpecification(fileName);
 }

diff --git a/src/control.h b/src/control.h
index fd1a4e6..6514bf4 100644
--- a/src/control.h
+++ b/src/control.h
@@ -149,7 +149,7 @@ class Control: public HardwareManipulator
 Q_OBJECT

 public:
-    Control(const QString& ruleFile, SimRules *sr, QObject *parent=3D0);
+    Control(const QString& ruleFile, SimRules *sr, QObject *parent=3Dnullp=
tr);
     virtual ~Control();

 public slots:
diff --git a/src/gsmspec.cpp b/src/gsmspec.cpp
index 013ef62..fbb7e2a 100644
--- a/src/gsmspec.cpp
+++ b/src/gsmspec.cpp
@@ -137,11 +137,11 @@ void GSMSpec::setupDictionary(const QString& filePath)
     GsmXmlNode *specNode =3D handler->documentElement()->children;
     QString command, profile, format, response, description;

-    while ( specNode !=3D 0 ) {
+    while ( specNode !=3D nullptr ) {
         if ( specNode->tag =3D=3D "spec" ) {

             GsmXmlNode *specData =3D specNode->children;
-            while ( specData !=3D 0 ) {
+            while ( specData !=3D nullptr ) {

                 if( specData->tag =3D=3D "command" ) {
                     command =3D specData->contents;
@@ -171,10 +171,10 @@ void GSMSpec::setupDictionary(const QString& filePath)

 GsmXmlNode::GsmXmlNode( const QString& _tag )
 {
-    parent =3D 0;
-    next =3D 0;
-    children =3D 0;
-    attributes =3D 0;
+    parent =3D nullptr;
+    next =3D nullptr;
+    children =3D nullptr;
+    attributes =3D nullptr;
     tag =3D _tag;
 }

@@ -200,7 +200,7 @@ GsmXmlNode::~GsmXmlNode()
 void GsmXmlNode::addChild( GsmXmlNode *child )
 {
     GsmXmlNode *current =3D children;
-    GsmXmlNode *prev =3D 0;
+    GsmXmlNode *prev =3D nullptr;
     while ( current ) {
         prev =3D current;
         current =3D current->next;
@@ -210,7 +210,7 @@ void GsmXmlNode::addChild( GsmXmlNode *child )
     } else {
         children =3D child;
     }
-    child->next =3D 0;
+    child->next =3D nullptr;
     child->parent =3D this;
 }

@@ -218,7 +218,7 @@ void GsmXmlNode::addChild( GsmXmlNode *child )
 void GsmXmlNode::addAttribute( GsmXmlNode *child )
 {
     GsmXmlNode *current =3D attributes;
-    GsmXmlNode *prev =3D 0;
+    GsmXmlNode *prev =3D nullptr;
     while ( current ) {
         prev =3D current;
         current =3D current->next;
@@ -228,7 +228,7 @@ void GsmXmlNode::addAttribute( GsmXmlNode *child )
     } else {
         attributes =3D child;
     }
-    child->next =3D 0;
+    child->next =3D nullptr;
     child->parent =3D this;
 }

diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index 87a8c6e..ae071e5 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -34,7 +34,7 @@ class HardwareManipulator : public QObject
 Q_OBJECT

 public:
-    HardwareManipulator(SimRules *sr, QObject *parent=3D0);
+    HardwareManipulator(SimRules *sr, QObject *parent=3Dnullptr);
     QSMSMessageList & getSMSList();
     bool getSimPresent();
     QStringList getSimAppsNameList();
diff --git a/src/main.cpp b/src/main.cpp
index 684a9b7..b320140 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -34,7 +34,7 @@ static void usage()

 int main(int argc, char **argv)
 {
-    QString filename =3D NULL;
+    QString filename =3D nullptr;
     QCoreApplication *app;
     int port =3D 12345;
     int index;
@@ -72,7 +72,7 @@ int main(int argc, char **argv)

     }

-    if (filename =3D=3D NULL) {
+    if (filename =3D=3D nullptr) {
         qWarning() << "ERROR: filename must be the last argument";
         usage();
     }
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
     } else
         app =3D new QCoreApplication(argc, argv);

-    PhoneSimServer *pss =3D new PhoneSimServer(filename, port, 0);
+    PhoneSimServer *pss =3D new PhoneSimServer(filename, port, nullptr);

     if (with_gui)
         pss->setHardwareManipulator(new ControlFactory);
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index f14281b..ba99fd0 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -44,10 +44,10 @@

 SimXmlNode::SimXmlNode( const QString& _tag )
 {
-    parent =3D 0;
-    next =3D 0;
-    children =3D 0;
-    attributes =3D 0;
+    parent =3D nullptr;
+    next =3D nullptr;
+    children =3D nullptr;
+    attributes =3D nullptr;
     tag =3D _tag;
 }

@@ -72,7 +72,7 @@ SimXmlNode::~SimXmlNode()
 void SimXmlNode::addChild( SimXmlNode *child )
 {
     SimXmlNode *current =3D children;
-    SimXmlNode *prev =3D 0;
+    SimXmlNode *prev =3D nullptr;
     while ( current ) {
         prev =3D current;
         current =3D current->next;
@@ -82,7 +82,7 @@ void SimXmlNode::addChild( SimXmlNode *child )
     } else {
         children =3D child;
     }
-    child->next =3D 0;
+    child->next =3D nullptr;
     child->parent =3D this;
 }

@@ -90,7 +90,7 @@ void SimXmlNode::addChild( SimXmlNode *child )
 void SimXmlNode::addAttribute( SimXmlNode *child )
 {
     SimXmlNode *current =3D attributes;
-    SimXmlNode *prev =3D 0;
+    SimXmlNode *prev =3D nullptr;
     while ( current ) {
         prev =3D current;
         current =3D current->next;
@@ -100,7 +100,7 @@ void SimXmlNode::addAttribute( SimXmlNode *child )
     } else {
         attributes =3D child;
     }
-    child->next =3D 0;
+    child->next =3D nullptr;
     child->parent =3D this;
 }

@@ -177,7 +177,7 @@ SimState::SimState( SimRules *rules, SimXmlNode& e )
         _name =3D e.getAttribute( "name" );
     }
     SimXmlNode *n =3D e.children;
-    while ( n !=3D 0 ) {
+    while ( n !=3D nullptr ) {
         if ( n->tag =3D=3D "chat" ) {

             // Load a chat response definition.
@@ -244,7 +244,7 @@ SimChat::SimChat( SimState *state, SimXmlNode& e )
     deleteSMS =3D false;
     readSMS =3D false;

-    while ( n !=3D 0 ) {
+    while ( n !=3D nullptr ) {
         if ( n->tag =3D=3D "command" ) {
             _command =3D n->contents;
             int w=3D_command.indexOf(QChar('*'));
@@ -520,11 +520,11 @@ SimRules::SimRules(qintptr fd, QObject *p,  const QSt=
ring& filename, HardwareMan
     : QTcpSocket(p)
 {
     setSocketDescriptor(fd);
-    machine =3D 0;
-    toolkitApp =3D 0;
+    machine =3D nullptr;
+    toolkitApp =3D nullptr;

     if (hmf)
-        machine =3D hmf->create(this, 0);
+        machine =3D hmf->create(this, nullptr);

     if (machine) {
         connect(machine, SIGNAL(unsolicitedCommand(QString)),
@@ -563,10 +563,10 @@ SimRules::SimRules(qintptr fd, QObject *p,  const QSt=
ring& filename, HardwareMan
     connect(this,SIGNAL(disconnected()),
         this,SLOT(destruct()));
     // Initialize the local state.
-    currentState =3D 0;
-    defState =3D 0;
+    currentState =3D nullptr;
+    defState =3D nullptr;
     usedCallIds =3D 0;
-    fileSystem =3D 0;
+    fileSystem =3D nullptr;
     useGsm0710 =3D false;
     currentChannel =3D 1;
     incomingUsed =3D 0;
@@ -599,7 +599,7 @@ SimRules::SimRules(qintptr fd, QObject *p,  const QStri=
ng& filename, HardwareMan
     // Load the other states, and the start state's name (if specified).
     SimXmlNode *n =3D handler->documentElement()->children;
     QString start =3D QString();
-    while ( n !=3D 0 ) {
+    while ( n !=3D nullptr ) {
         if ( n->tag =3D=3D "state" ) {

             // Load a new state definition.
@@ -886,29 +886,29 @@ void SimRules::destruct()
         simApps.removeAt( 0 );

     delete conformanceApp;
-    conformanceApp =3D NULL;
+    conformanceApp =3D nullptr;
     delete defaultToolkitApp;
-    defaultToolkitApp =3D NULL;
-    toolkitApp =3D NULL;
+    defaultToolkitApp =3D nullptr;
+    toolkitApp =3D nullptr;

     if ( getMachine() )
         getMachine()->handleNewApp();

     if ( defState )
         delete defState;
-    defState =3D NULL;
+    defState =3D nullptr;

     if ( _simAuth )
         delete _simAuth;
-    _simAuth =3D NULL;
+    _simAuth =3D nullptr;

     if ( _callManager )
         delete _callManager;
-    _callManager =3D NULL;
+    _callManager =3D nullptr;

     if ( fileSystem )
         delete fileSystem;
-    fileSystem =3D NULL;
+    fileSystem =3D nullptr;

     if (machine) machine->deleteLater();
     deleteLater();
@@ -968,7 +968,7 @@ SimState *SimRules::state( const QString& name ) const

     }
     qWarning() << "Warning: no state called \"" << name << "\" has been de=
fined";
-    return 0;
+    return nullptr;
 }

 bool SimRules::simCsimOk( const QByteArray& payload )
@@ -1319,7 +1319,7 @@ void SimRules::loadPhoneBook( SimXmlNode& node )
     }
     SimPhoneBook *pb =3D phoneBooks[name];
     SimXmlNode *n =3D node.children;
-    while ( n !=3D 0 ) {
+    while ( n !=3D nullptr ) {
         if ( n->tag =3D=3D "entry" ) {
             // Load a phone book entry.
             int index =3D n->getAttribute( "index" ).toInt();
@@ -1553,7 +1553,7 @@ SimPhoneBook *SimRules::currentPB() const
     if ( phoneBooks.contains( currentPhoneBook ) )
         return phoneBooks[currentPhoneBook];
     else
-        return 0;
+        return nullptr;
 }

 int SimRules::newCall()
diff --git a/src/phonesim.h b/src/phonesim.h
index 466f88d..fef97d4 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -386,7 +386,7 @@ class QVariantTimer : public QTimer
 {
     Q_OBJECT
 public:
-    QVariantTimer( QObject *parent =3D 0 ) : QTimer(parent) { }
+    QVariantTimer( QObject *parent =3D nullptr ) : QTimer(parent) { }
     QVariant param;
 };

diff --git a/src/qatresult.cpp b/src/qatresult.cpp
index d4b8cab..9a29503 100644
--- a/src/qatresult.cpp
+++ b/src/qatresult.cpp
@@ -45,7 +45,7 @@ public:
         result =3D "OK";
         resultCode =3D QAtResult::OK;
         verbose =3D true;
-        userData =3D 0;
+        userData =3D nullptr;
     }
     ~QAtResultPrivate()
     {
diff --git a/src/qatresultparser.cpp b/src/qatresultparser.cpp
index 0cc0b24..cba41ad 100644
--- a/src/qatresultparser.cpp
+++ b/src/qatresultparser.cpp
@@ -328,7 +328,7 @@ QAtResultParser::Node::Node( uint number )
 {
     _kind =3D Number;
     _number =3D number;
-    _list =3D 0;
+    _list =3D nullptr;
 }

 QAtResultParser::Node::Node( uint first, uint last )
@@ -336,14 +336,14 @@ QAtResultParser::Node::Node( uint first, uint last )
     _kind =3D Range;
     _number =3D first;
     _last =3D last;
-    _list =3D 0;
+    _list =3D nullptr;
 }

 QAtResultParser::Node::Node( const QString& str )
 {
     _kind =3D String;
     _str =3D str;
-    _list =3D 0;
+    _list =3D nullptr;
 }

 QAtResultParser::Node::Node( QList<Node> *list )
@@ -361,7 +361,7 @@ QAtResultParser::Node::Node( const Node& other )
     _number =3D other._number;
     _last =3D other._last;
     _str =3D other._str;
-    _list =3D ( other._list ? new QList<Node>( *other._list ) : 0 );
+    _list =3D ( other._list ? new QList<Node>( *other._list ) : nullptr );
 }

 /*!
diff --git a/src/qatutils.cpp b/src/qatutils.cpp
index 6fa191f..51161bb 100644
--- a/src/qatutils.cpp
+++ b/src/qatutils.cpp
@@ -923,18 +923,18 @@ QByteArray QCodePage850Codec::convertFromUnicode(cons=
t QChar *in, int length, Co
 QTextCodec *QAtUtils::codec( const QString& gsmCharset )
 {
     QString cs =3D gsmCharset.toLower();
-    QTextCodec *codec =3D 0;
+    QTextCodec *codec =3D nullptr;

     // Convert the name into an appropriate codec.
     if ( cs =3D=3D "gsm" ) {
         // 7-bit GSM character set.
-        static QTextCodec *gsm =3D 0;
+        static QTextCodec *gsm =3D nullptr;
         if ( !gsm )
             gsm =3D new QGsmCodec();
         codec =3D gsm;
     } else if ( cs =3D=3D "gsm-noloss" ) {
         // 7-bit GSM character set, with no loss of quality.
-        static QTextCodec *gsmNoLoss =3D 0;
+        static QTextCodec *gsmNoLoss =3D nullptr;
         if ( !gsmNoLoss )
             gsmNoLoss =3D new QGsmCodec( true );
         codec =3D gsmNoLoss;
@@ -943,13 +943,13 @@ QTextCodec *QAtUtils::codec( const QString& gsmCharse=
t )
         // be anything according to the specification, but we need to pick
         // something.  We assume that it is 7-bit GSM, as that is the most
         // likely value.
-        static QTextCodec *hex =3D 0;
+        static QTextCodec *hex =3D nullptr;
         if ( !hex )
             hex =3D new QGsmHexCodec();
         codec =3D hex;
     } else if ( cs =3D=3D "ucs2" ) {
         // Hex-encoded UCS2 character set.
-        static QTextCodec *ucs2 =3D 0;
+        static QTextCodec *ucs2 =3D nullptr;
         if ( !ucs2 )
             ucs2 =3D new QUcs2HexCodec();
         codec =3D ucs2;
@@ -964,7 +964,7 @@ QTextCodec *QAtUtils::codec( const QString& gsmCharset )
         // to handle embedded UCS-2 character strings.  A hex UCS-2 string
         // will start with "80" and end with "FFFF".  If the string does
         // not have this format, it is interpreted as code page 437.
-        static QTextCodec *cp437 =3D 0;
+        static QTextCodec *cp437 =3D nullptr;
         if ( !cp437 )
             cp437 =3D new QCodePage437Codec();
         codec =3D cp437;
diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index a1c0913..b56a761 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -135,7 +135,7 @@ QCBSMessage::QCBSMessage()
 */
 QCBSMessage::QCBSMessage(const QCBSMessage &msg)
 {
-    d =3D 0;
+    d =3D nullptr;
     *this =3D msg;
 }

diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index 63d6952..ec158ef 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -85,7 +85,7 @@ public:
         mReplyRequest =3D false;
         mStatusReportRequested =3D false;
         mMessageType =3D QSMSMessage::Normal;
-        mCodec =3D 0;
+        mCodec =3D nullptr;
         mForceGsm =3D false;
         mBestScheme =3D (QSMSDataCodingScheme)(-1);
         mDataCodingScheme =3D -1;
@@ -2030,7 +2030,7 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
     uint ch;

     // Reset the header return.
-    headers =3D 0;
+    headers =3D nullptr;

     // Get the length of the user data payload.
     if ( implicitLength ) {
@@ -2437,7 +2437,7 @@ QSMSMessage QSMSDeliverMessage::unpack(QTextCodec *co=
dec)
     }

     // Read the user data field.
-    QByteArray *headers =3D 0;
+    QByteArray *headers =3D nullptr;
     QString text;
     text =3D userData( (QSMSDataCodingScheme)scheme, codec,
                      headers, userDataHeader, false );
@@ -2590,7 +2590,7 @@ QCBSMessage QCBSDeliverMessage::unpack(QTextCodec *co=
dec)
     mPosn +=3D 6;

     // Read the user data field and strip CR's, LF's, and NUL's from the e=
nd.
-    QByteArray *headers =3D 0;
+    QByteArray *headers =3D nullptr;
     QString text =3D userData
         ( (QSMSDataCodingScheme)scheme, codec, headers, false, true );
     len =3D text.length();
diff --git a/src/qsmsmessage_p.h b/src/qsmsmessage_p.h
index f26d066..49060c7 100644
--- a/src/qsmsmessage_p.h
+++ b/src/qsmsmessage_p.h
@@ -169,7 +169,7 @@ class QSMSDeliverMessage: public QPDUMessage
 public:
     explicit QSMSDeliverMessage(const QByteArray &pdu);

-    QSMSMessage unpack(QTextCodec *codec=3D0);
+    QSMSMessage unpack(QTextCodec *codec=3Dnullptr);
 };

 class QCBSDeliverMessage: public QPDUMessage
@@ -178,7 +178,7 @@ public:
     QCBSDeliverMessage();
     explicit QCBSDeliverMessage(const QByteArray &pdu);

-    QCBSMessage unpack(QTextCodec *codec=3D0);
+    QCBSMessage unpack(QTextCodec *codec=3Dnullptr);
     void pack(const QCBSMessage &m, QSMSDataCodingScheme scheme);
 };

diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index 49b9405..f487a35 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -108,7 +108,7 @@ static const char * const contentTypeAssignments[] =3D {
     "application/vnd.oma.drm.content",
     "application/vnd.oma.drm.rights+xml",
     "application/vnd.oma.drm.rights+wbxml",
-    0
+    nullptr
 };
 #define numContentTypes (int)((sizeof(contentTypeAssignments) / \
                                sizeof(char *)) - 1)
@@ -1731,7 +1731,7 @@ const QWspField *QWspPart::header(const QString &name=
) const
             return &(*it);
     }

-    return 0;
+    return nullptr;
 }

 /*!
diff --git a/src/server.cpp b/src/server.cpp
index 62487ee..3ff7def 100644
--- a/src/server.cpp
+++ b/src/server.cpp
@@ -25,7 +25,7 @@
 static int phonenumber =3D 555000;

 PhoneSimServer::PhoneSimServer(const QString &f, quint16 port, QObject *pa=
rent)
-    : QTcpServer(parent), fact(0), currentRules(0)
+    : QTcpServer(parent), fact(nullptr), currentRules(nullptr)
 {
     listen( QHostAddress::Any, port );
     filename =3D f;
@@ -33,7 +33,7 @@ PhoneSimServer::PhoneSimServer(const QString &f, quint16 =
port, QObject *parent)

 PhoneSimServer::~PhoneSimServer()
 {
-    setHardwareManipulator(0);
+    setHardwareManipulator(nullptr);
 }

 void PhoneSimServer::setHardwareManipulator(HardwareManipulatorFactory *f)
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index c491674..f9169f2 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -30,8 +30,8 @@ public:
     {
         expectedType =3D QSimCommand::NoCommand;
         modemHandled =3D false;
-        target =3D 0;
-        slot =3D 0;
+        target =3D nullptr;
+        slot =3D nullptr;
         inResponse =3D false;
     }

@@ -136,8 +136,8 @@ void SimApplication::abort()
     d->expectedType =3D QSimCommand::NoCommand;
     d->modemHandled =3D false;
     d->currentCommand =3D QByteArray();
-    d->target =3D 0;
-    d->slot =3D 0;
+    d->target =3D nullptr;
+    d->slot =3D nullptr;
     endSession();
 }

@@ -196,8 +196,8 @@ bool SimApplication::envelope( const QSimEnvelope& env )

     d->expectedType =3D QSimCommand::NoCommand;
     d->currentCommand =3D QByteArray();
-    d->target =3D 0;
-    d->slot =3D 0;
+    d->target =3D nullptr;
+    d->slot =3D nullptr;
     if ( env.requestHelp() )
         mainMenuHelpRequest( env.menuItem() );
     else
@@ -235,8 +235,8 @@ bool SimApplication::response( const QSimTerminalRespon=
se& resp )
         d->modemHandled =3D false;
         d->currentCommand =3D QByteArray();
     }
-    d->target =3D 0;
-    d->slot =3D 0;
+    d->target =3D nullptr;
+    d->slot =3D nullptr;

     // Process the response.
     d->inResponse =3D true;
@@ -247,7 +247,7 @@ bool SimApplication::response( const QSimTerminalRespon=
se& resp )
         int index =3D target->metaObject()->indexOfMethod( name.constData(=
) );
         if ( index !=3D -1 ) {
             void *args[2];
-            args[0] =3D 0;
+            args[0] =3D nullptr;
             args[1] =3D (void *)&resp;
             target->qt_metacall
                 ( QMetaObject::InvokeMetaMethod, index, args );
@@ -500,7 +500,7 @@ void DemoSimApplication::mainMenu()

     cmd.setMenuItems( items );

-    command( cmd, 0, 0 );
+    command( cmd, nullptr, nullptr );
 }

 void DemoSimApplication::sendDisplayText()
@@ -2186,7 +2186,7 @@ void DemoSimApplication::timersMenuResp( const QSimTe=
rminalResponse& resp )
         cmd.setTimerId( 2 );
         cmd.setDuration( 10000 );
         cmd.setDestinationDevice( QSimCommand::ME );
-        command( cmd, NULL, NULL );
+        command( cmd, nullptr, nullptr );
         break;

     case Timers_Query:
diff --git a/src/simapplication.h b/src/simapplication.h
index d80d0e6..c5c6501 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -32,7 +32,7 @@ class SimApplication : public QObject
 {
     Q_OBJECT
 public:
-    SimApplication( SimRules *rules, QObject *parent =3D 0 );
+    SimApplication( SimRules *rules, QObject *parent =3D nullptr );
     ~SimApplication();

     virtual bool envelope( const QSimEnvelope& env );
@@ -67,7 +67,7 @@ class DemoSimApplication : public SimApplication
 {
     Q_OBJECT
 public:
-    DemoSimApplication( SimRules *rules, QObject *parent =3D 0 );
+    DemoSimApplication( SimRules *rules, QObject *parent =3D nullptr );
     ~DemoSimApplication();

     const QString getName();
@@ -148,7 +148,7 @@ class ConformanceSimApplication : public SimApplication
 {
     Q_OBJECT
 public:
-    ConformanceSimApplication( SimRules *rules, QObject *parent =3D 0 );
+    ConformanceSimApplication( SimRules *rules, QObject *parent =3D nullpt=
r );
     ~ConformanceSimApplication();

     const QString getName();
--
2.24.0

--===============6794626523197484663==--

