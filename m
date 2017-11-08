Content-Type: multipart/mixed; boundary="===============5445785265704995010=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 4/4] phonesim/simauth: removed session code from simauth
Date: Wed, 08 Nov 2017 09:23:53 -0800
Message-ID: <1510161833-8867-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510161833-8867-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5445785265704995010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AID application class handles session managment
so it was removed from simauth. Now, simauth only
implements the authentication algorithms.

Added AID application init code to phonesim and added
a two sample AID applications to default.xml (ISIM/USIM)
---
 src/default.xml  |  14 +++-
 src/phonesim.cpp |  14 +++-
 src/phonesim.h   |   5 ++
 src/simauth.cpp  | 240 ---------------------------------------------------=
----
 src/simauth.h    |  60 +-------------
 5 files changed, 30 insertions(+), 303 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index 39b0216..b32a488 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -316,8 +316,6 @@
 =

 <!-- SIM Auth -->
 <simauth ki=3D"90dca4eda45b53cf0f12d7c9c3bc6a89" opc=3D"cb9cccc4b9258e6dca=
4760379fb82581" sqn=3D"000000000021">
-        <aid>61184F10A0000000871004FFFFFFFF890619000050044953494DFFFFFFFFF=
FFFFF</aid>
-        <aid>61184F10A0000000871002FFFFFFFF890619000050045553494DFFFFFFFFF=
FFFFF</aid>
 </simauth>
 =

 <!-- Time -->
@@ -3680,4 +3678,16 @@ OK</response>
 =

 </filesystem>
 =

+<application type=3D"ISim" id=3D"61184F10A0000000871004FFFFFFFF89061900005=
0044953494DFFFFFFFFFFFFFF">
+    <filesystem>
+        <file name=3D"EFimpi">
+            <!-- 123456789@phonesim.org -->
+            80 15 31 32 33 34 35 36 37 38 40 70 68 6f 6e 65 73 69 6d 2e 6f=
 72 67
+        </file>
+    </filesystem>
+</application>
+
+<application type=3D"USim" id=3D"61184F10A0000000871002FFFFFFFF89061900005=
0045553494DFFFFFFFFFFFFFF">
+</application>
+
 </simulator>
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index ec3900a..0e446f6 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -24,6 +24,7 @@
 #include "simapplication.h"
 #include "callmanager.h"
 #include "simauth.h"
+#include "aidapplication.h"
 #include <qatutils.h>
 =

 #include <qstring.h>
@@ -630,13 +631,19 @@ SimRules::SimRules( int fd, QObject *p,  const QStrin=
g& filename, HardwareManipu
             loadPhoneBook( *n );
 =

         } else if ( n->tag =3D=3D "simauth" ) {
+
             _simAuth =3D new SimAuth( this, *n );
-            connect( _simAuth, SIGNAL(send(QString)),
-                    this, SLOT(respond(QString)) );
+
+        } else if ( n->tag =3D=3D "application" ) {
+            AidApplication *app =3D new AidApplication( this, *n );
+            _applications.append(app);
         }
         n =3D n->next;
     }
 =

+    if ( _applications.length() > 0 )
+        _app_wrapper =3D new AidAppWrapper( this, _applications, _simAuth =
);
+
     // Clean up the XML reader objects.
     delete handler;
 =

@@ -1137,8 +1144,7 @@ void SimRules::command( const QString& cmd )
     if ( _callManager->command( cmd ) )
         return;
 =

-    // Proccess SIM auth commands
-    if ( _simAuth &&  _simAuth->command( cmd ) )
+    if (_app_wrapper && _app_wrapper->command( cmd ))
         return;
 =

     // Process SIM toolkit related commands with the current SIM applicati=
on.
diff --git a/src/phonesim.h b/src/phonesim.h
index 452dc12..c8bcaad 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -45,6 +45,7 @@
 #include <arpa/inet.h>
 #include <netinet/in.h>
 =

+
 class SimState;
 class SimItem;
 class SimChat;
@@ -54,6 +55,8 @@ class SimFileSystem;
 class CallManager;
 class SimApplication;
 class SimAuth;
+class AidApplication;
+class AidAppWrapper;
 =

 =

 class SimXmlNode
@@ -360,6 +363,8 @@ private:
 =

     CallManager *_callManager;
     SimAuth *_simAuth;
+    QList<AidApplication *> _applications;
+    AidAppWrapper *_app_wrapper;
 =

     bool simCsimOk( const QByteArray& payload );
 };
diff --git a/src/simauth.cpp b/src/simauth.cpp
index 54184b6..24b2d17 100644
--- a/src/simauth.cpp
+++ b/src/simauth.cpp
@@ -30,255 +30,15 @@ extern "C" {
 SimAuth::SimAuth( QObject *parent, SimXmlNode& n )
     : QObject( parent )
 {
-    SimXmlNode *child =3D n.children;
-
     _ki =3D n.getAttribute( "ki" );
     _opc =3D n.getAttribute( "opc" );
     _sqn =3D n.getAttribute( "sqn" );
-    _session_start =3D 257;
-
-    _aid_list =3D QStringList();
-
-    // parse list of <aid> </aid>
-    while (child) {
-        if ( child->tag =3D=3D "aid" )
-            _aid_list +=3D QStringList( child->contents );
-
-        child =3D child->next;
-    }
 }
 =

 SimAuth::~SimAuth()
 {
 }
 =

-bool SimAuth::command( const QString& cmd )
-{
-    if ( cmd.startsWith( "AT+CUAD") ) {
-        QString response( "+CUAD: " );
-
-        if ( cmd.contains("=3D?") ) {
-            emit send( "OK" );
-            return true;
-        }
-
-        foreach ( const QString &str, _aid_list )
-            response +=3D str;
-
-        response.append( "\n\nOK" );
-
-        emit send( response );
-    } else if ( cmd.startsWith( "AT+CCHO" ) ) {
-        QString aid;
-        int session_id =3D -1;
-
-        if ( !cmd.contains("=3D") ) {
-            emit send( "ERROR" );
-            return true;
-        }
-
-        if ( cmd.contains("=3D?") ) {
-            emit send( "OK" );
-            return true;
-        }
-
-        aid =3D cmd.split('=3D')[1];
-        aid =3D aid.replace("\"", "");
-
-        foreach ( const QString &str, _aid_list ) {
-            if ( str.contains( aid ) ) {
-                session_id =3D openChannel( aid );
-                break;
-            }
-        }
-
-        if ( session_id =3D=3D -1 ) {
-            emit send( "ERROR" );
-            return true;
-        }
-
-        emit send( QString( "+CCHO: %1\n\nOK" ).arg(session_id, 0, 10) );
-    } else if ( cmd.startsWith( "AT+CGLA" ) ) {
-        QString aid;
-        QString data;
-        QString command;
-        QString parameters;
-        QString response;
-        enum CmdType type;
-        int session_id =3D -1;
-
-        if ( !cmd.contains("=3D") ) {
-            emit send( "ERROR" );
-            return true;
-        }
-
-        if ( cmd.contains("=3D?") ) {
-            emit send( "OK" );
-            return true;
-        }
-
-        data =3D cmd.split('=3D')[1];
-        session_id =3D data.split(',')[0].toInt();
-
-        if (!getAidFromSession( session_id, aid )) {
-            emit send( "ERROR" );
-            return true;
-        }
-
-        data =3D data.split(',')[2].replace("\"", "");
-        parameters =3D data.mid(10);
-
-        type =3D checkCommand( data, aid );
-
-        if (type =3D=3D CMD_TYPE_GSM_AUTH) {
-            QString sres, kc;
-            QString rand =3D parameters.mid(2, 32);
-
-            gsmAuthenticate( rand, sres, kc );
-
-            response =3D QString( "+CGLA: 32,\"04 %1 08 %2 \"\n\nOK" )
-                    .arg( sres, kc );
-            response.replace( " ", "");
-
-        } else if (type =3D=3D CMD_TYPE_UMTS_AUTH) {
-            enum UmtsStatus status;
-            QString res, ck, ik, auts;
-            QString rand =3D parameters.mid(2, 32);
-            QString autn =3D parameters.mid(36, 32);
-
-            status =3D umtsAuthenticate( rand, autn, res, ck, ik, auts );
-
-            response =3D QString("+CGLA: ");
-
-            QString test;
-
-            switch (status) {
-            case UMTS_OK:
-                response +=3D QString( "88,\"DB08 %1 10 %2 10 %3\"\n\nOK" )
-                        .arg( res, ck, ik );
-                response.replace( " ", "" );
-
-                break;
-            case UMTS_INVALID_MAC:
-                response +=3D QString( "4,\"%1\"\n\nOK")
-                        .arg( CMD_TYPE_APP_ERROR, 0, 16 );
-
-                break;
-            case UMTS_SYNC_FAILURE:
-                response +=3D QString( "34,\"DC0E %1 \"\n\nOK" ).arg( auts=
 );
-                response.replace( " ", "" );
-
-                break;
-            case UMTS_ERROR:
-                response =3D QString( "ERROR" );
-
-                break;
-            }
-        } else {
-            response =3D QString("+CGLA: 4,\"%1\"\n\nOK").arg(type, 0, 16);
-        }
-
-        emit send( response );
-    } else if ( cmd.startsWith( "AT+CCHC" ) ) {
-        int session_id =3D -1;
-
-        if ( !cmd.contains("=3D") ) {
-            emit send( "ERROR" );
-            return true;
-        }
-
-        if ( cmd.contains("=3D?") ) {
-            emit send( "OK" );
-            return true;
-        }
-
-        session_id =3D cmd.split('=3D')[1].toInt();
-
-        closeChannel(session_id);
-
-        emit send( "OK" );
-    } else {
-        return false;
-    }
-
-    return true;
-}
-
-int SimAuth::openChannel( QString aid )
-{
-    if ( _logical_channels.size() >=3D MAX_LOGICAL_CHANNELS )
-        return -1;
-
-    _logical_channels.insert( _session_start, aid );
-
-    return _session_start++;
-}
-
-void SimAuth::closeChannel( int session_id )
-{
-    _logical_channels.remove( session_id );
-}
-
-bool SimAuth::getAidFromSession( int session_id, QString& aid )
-{
-    if ( _logical_channels.contains( session_id ) ) {
-        aid =3D _logical_channels[session_id];
-        return true;
-    }
-
-    return false;
-}
-
-enum AidType SimAuth::getAidType( QString aid )
-{
-    if ( aid.mid(10, 4) =3D=3D "1004" )
-        return AID_TYPE_ISIM;
-    else if ( aid.mid(10, 4) =3D=3D "1002")
-        return AID_TYPE_USIM;
-
-    return AID_TYPE_UNKNOWN;
-}
-
-
-enum CmdType SimAuth::checkCommand( QString command, QString aid )
-{
-    QString cls =3D command.mid(0, 2);
-    QString ins =3D command.mid(2, 2);
-    QString p1 =3D command.mid(4, 2);
-    QString p2 =3D command.mid(6, 2);
-    QString lc =3D command.mid(8, 2);
-    AidType type =3D getAidType( aid );
-
-    if ( cls !=3D "00" )
-        return CMD_TYPE_UNSUPPORTED_CLS;
-
-    if ( ins !=3D "88" )
-        return CMD_TYPE_UNSUPPORTED_INS;
-
-    if ( p1 !=3D "00" )
-        return CMD_TYPE_INCORRECT_P2_P1;
-
-    if ( p2 =3D=3D "80" ) {
-        if ( lc !=3D "11" )
-            return CMD_TYPE_WRONG_LENGTH;
-
-        if ( !(type =3D=3D AID_TYPE_USIM || type =3D=3D AID_TYPE_ISIM) )
-            return CMD_TYPE_APP_ERROR;
-
-        return CMD_TYPE_GSM_AUTH;
-    } else if ( p2 =3D=3D "81" ) {
-        if ( lc !=3D "22" )
-            return CMD_TYPE_WRONG_LENGTH;
-
-        if ( type !=3D AID_TYPE_ISIM )
-            return CMD_TYPE_APP_ERROR;
-
-        return CMD_TYPE_UMTS_AUTH;
-    } else {
-        return CMD_TYPE_UNKNOWN;
-    }
-}
-
 void SimAuth::gsmAuthenticate( QString rand, QString &sres,
         QString &kc )
 {
diff --git a/src/simauth.h b/src/simauth.h
index a66ea52..fb66593 100644
--- a/src/simauth.h
+++ b/src/simauth.h
@@ -22,26 +22,6 @@
 =

 #define MAX_LOGICAL_CHANNELS    4
 =

-enum AidType {
-    AID_TYPE_USIM,
-    AID_TYPE_ISIM,
-    AID_TYPE_UNKNOWN
-};
-
-/*
- * Some common errors
- */
-enum CmdType {
-    CMD_TYPE_GSM_AUTH =3D 0,
-    CMD_TYPE_UMTS_AUTH =3D 1,
-    CMD_TYPE_UNSUPPORTED_CLS =3D 0x6E00,
-    CMD_TYPE_UNSUPPORTED_INS =3D 0x6D00,
-    CMD_TYPE_INCORRECT_P2_P1 =3D 0x6A86,
-    CMD_TYPE_WRONG_LENGTH =3D 0x6700,
-    CMD_TYPE_APP_ERROR =3D 0x9862,
-    CMD_TYPE_UNKNOWN =3D 0xFFFF
-};
-
 enum UmtsStatus {
     UMTS_OK,            // Success
     UMTS_INVALID_MAC,   // MAC did not match AUTN parameter
@@ -56,12 +36,9 @@ public:
     SimAuth( QObject *parent, SimXmlNode& n );
     ~SimAuth();
 =

-    // Process an AT command.  Returns false if not a call-related command.
-    bool command( const QString& cmd );
-
-signals:
-    // Send a response to a command.
-    void send( const QString& line );
+    void gsmAuthenticate( QString rand, QString &sres, QString &kc );
+    enum UmtsStatus umtsAuthenticate( QString rand, QString autn,
+            QString &res, QString &ck, QString &ik, QString &auts );
 =

 private:
     // secret key, set during initialization (from XML)
@@ -72,37 +49,6 @@ private:
 =

     // Sequence number stored on SIM
     QString _sqn;
-
-    // arbitrary session ID starting number
-    int _session_start;
-
-    // parsed list of AID's
-    QStringList _aid_list;
-
-    // map of logical channel integers to AID's
-    QMap<int, QString> _logical_channels;
-
-    // run COMP128v1 algorithm against 'rand' and 'ki'
-    void gsmAuthenticate( QString rand, QString &sres, QString &kc );
-
-    // run Milenage algorithm with ki, rand, and autn
-    enum UmtsStatus umtsAuthenticate( QString rand, QString autn,
-            QString &res, QString &ck, QString &ik, QString &auts);
-
-    // open an AID logical channel
-    int openChannel( QString aid );
-
-    // close an AID logical channel
-    void closeChannel( int session_id );
-
-    // find the AID from a given session ID
-    bool getAidFromSession( int session_id, QString& aid );
-
-    // checks that the AID supports the given command
-    enum CmdType checkCommand( QString command, QString aid );
-
-    // returns the type of AID (USIM/ISIM/UNKNOWN)
-    enum AidType getAidType( QString aid );
 };
 =

 #endif
-- =

2.7.4


--===============5445785265704995010==--

