Content-Type: multipart/mixed; boundary="===============8196992735857031337=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/4] aidapplications: new class for AID applications
Date: Wed, 08 Nov 2017 09:23:51 -0800
Message-ID: <1510161833-8867-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510161833-8867-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8196992735857031337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

New AID applications can be created using the XML
<application> tag. Inside this tag a file system
can be created which is accessable via session
based file access.
---
 src/aidapplication.cpp | 276 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/aidapplication.h   |  88 ++++++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 src/aidapplication.cpp
 create mode 100644 src/aidapplication.h

diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
new file mode 100644
index 0000000..e255145
--- /dev/null
+++ b/src/aidapplication.cpp
@@ -0,0 +1,276 @@
+#include "aidapplication.h"
+#include "simfilesystem.h"
+#include "simauth.h"
+
+#include <qatutils.h>
+#include <qsimcontrolevent.h>
+
+AidApplication::AidApplication( QObject *parent, SimXmlNode& n )
+    : QObject( parent )
+{
+    SimXmlNode *child =3D n.children;
+
+    type =3D n.getAttribute( "type" );
+    aid =3D n.getAttribute( "id" );
+
+    while (child) {
+        if ( child->tag =3D=3D "filesystem" )
+            fs =3D new SimFileSystem( (SimRules *)parent, *child, FILE_SYS=
TEM_TYPE_ISIM );
+
+        child =3D child->next;
+    }
+}
+
+AidApplication::~AidApplication()
+{
+}
+
+AidAppWrapper::AidAppWrapper( SimRules *r, QList<AidApplication *> apps, S=
imAuth *sa ) : QObject( r )
+{
+    applications =3D apps;
+    session_start =3D 257;
+    rules =3D r;
+    auth =3D sa;
+}
+
+AidAppWrapper::~AidAppWrapper()
+{
+}
+
+bool AidAppWrapper::command( const QString& cmd )
+{
+    if ( cmd.startsWith( "AT+CUAD") ) {
+        QString response( "+CUAD: " );
+
+        if ( cmd.contains("=3D?") ) {
+            rules->respond( "OK" );
+            return true;
+        }
+
+        foreach ( AidApplication* app, applications )
+        response +=3D app->getAid();
+
+        response.append( "\n\nOK" );
+
+        rules->respond( response );
+
+        return true;
+    } else if ( cmd.startsWith( "AT+CCHO" ) ) {
+        QString aid;
+        int session_id =3D -1;
+
+        if ( !cmd.contains("=3D") ) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        if ( cmd.contains("=3D?") ) {
+            rules->respond( "OK" );
+            return true;
+        }
+
+        aid =3D cmd.split('=3D')[1];
+        aid =3D aid.replace("\"", "");
+
+        foreach ( AidApplication* app, applications ) {
+            if ( app->getAid().contains( aid ) ) {
+                if ( sessions.size() >=3D MAX_LOGICAL_CHANNELS )
+                    break;
+
+                sessions.insert( session_start, app );
+                session_id =3D session_start;
+                session_start++;
+                break;
+            }
+        }
+
+        if ( session_id =3D=3D -1 ) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        rules->respond( QString( "+CCHO: %1\n\nOK" ).arg(session_id, 0, 10=
) );
+        return true;
+    } else if ( cmd.startsWith( "AT+CCHC" ) ) {
+        int session_id =3D -1;
+
+        if ( !cmd.contains("=3D") ) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        if ( cmd.contains("=3D?") ) {
+            rules->respond( "OK" );
+            return true;
+        }
+
+        session_id =3D cmd.split('=3D')[1].toInt();
+
+        sessions.remove( session_id );
+
+        rules->respond( "OK" );
+        return true;
+    } else if ( cmd.startsWith( "AT+CRLA" ) ) {
+        QString resp;
+        AidApplication *app;
+        QStringList params =3D cmd.split('=3D')[1].split(',');
+
+        int session_id =3D params[0].toInt();
+
+        if ( !sessions.contains( session_id ) ) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        app =3D sessions[session_id];
+        if (!app) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        QString file_cmd;
+        QString response =3D "+CRLA: ";
+
+        for (int i =3D 1; i < params.length(); i++) {
+            file_cmd +=3D params[i];
+
+            if (i !=3D params.length() - 1)
+                file_cmd +=3D ",";
+        }
+
+        bool ok =3D app->fs->fileAccess( file_cmd, resp );
+
+        if (!ok) {
+            rules->respond( "OK" );
+            return true;
+        }
+
+        response +=3D resp;
+
+        rules->respond( response );
+        rules->respond( "OK" );
+
+        return true;
+    } else if ( cmd.startsWith( "AT+CGLA" ) ) {
+        QString auth_data;
+        QString command;
+        QString resp;
+        AidApplication *app;
+        QStringList params =3D cmd.split('=3D')[1].split(',');
+
+        int session_id =3D params[0].toInt();
+
+        if ( !sessions.contains( session_id ) ) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        app =3D sessions[session_id];
+        if (!app) {
+            rules->respond( "ERROR" );
+            return true;
+        }
+
+        command =3D params[2].replace("\"", "");
+        auth_data =3D command.mid(10);
+
+        switch (checkCommand(app, command)) {
+        case CMD_TYPE_GSM_AUTH:
+        {
+            QString sres, kc;
+            QString rand =3D auth_data.mid(2, 32);
+            auth->gsmAuthenticate(rand, sres, kc);
+
+            resp =3D QString( "+CGLA: 32,\"04 %1 08 %2 \"" )
+                                        .arg( sres, kc );
+            resp.replace( " ", "");
+
+            rules->respond( resp );
+            rules->respond( "OK" );
+
+            return true;
+        }
+        break;
+        case CMD_TYPE_UMTS_AUTH:
+        {
+            enum UmtsStatus status;
+            QString res, ck, ik, auts;
+            QString rand =3D auth_data.mid(2, 32);
+            QString autn =3D auth_data.mid(36, 32);
+
+            status =3D auth->umtsAuthenticate( rand, autn, res, ck, ik, au=
ts );
+            resp =3D QString("+CGLA: ");
+
+            QString test;
+
+            switch (status) {
+            case UMTS_OK:
+                resp +=3D QString( "88,\"DB08 %1 10 %2 10 %3\"" )
+                .arg( res, ck, ik );
+                resp.replace( " ", "" );
+
+                break;
+            case UMTS_INVALID_MAC:
+                resp +=3D QString( "4,\"%1\"")
+                .arg( CMD_TYPE_APP_ERROR, 0, 16 );
+
+                break;
+            case UMTS_SYNC_FAILURE:
+                resp +=3D QString( "34,\"DC0E %1 \"" ).arg( auts );
+                resp.replace( " ", "" );
+
+                break;
+            case UMTS_ERROR:
+                rules->respond( "ERROR" );
+                return true;
+            }
+
+            rules->respond( resp );
+            rules->respond( "OK" );
+        }
+        break;
+        default:
+            return false;
+        }
+    }
+
+    return false;
+}
+
+enum CmdType AidAppWrapper::checkCommand( AidApplication *app, QString com=
mand)
+{
+    QString cls =3D command.mid(0, 2);
+    QString ins =3D command.mid(2, 2);
+    QString p1 =3D command.mid(4, 2);
+    QString p2 =3D command.mid(6, 2);
+    QString lc =3D command.mid(8, 2);
+
+    if ( cls !=3D "00" )
+        return CMD_TYPE_UNSUPPORTED_CLS;
+
+    if ( ins !=3D "88" )
+        return CMD_TYPE_UNSUPPORTED_INS;
+
+    if ( p1 !=3D "00" )
+        return CMD_TYPE_INCORRECT_P2_P1;
+
+    if ( p2 =3D=3D "80" ) {
+        if ( lc !=3D "11" )
+            return CMD_TYPE_WRONG_LENGTH;
+
+        if ( !(app->getType() =3D=3D "USim" || app->getType() =3D=3D "ISim=
") )
+            return CMD_TYPE_APP_ERROR;
+
+        return CMD_TYPE_GSM_AUTH;
+    } else if ( p2 =3D=3D "81" ) {
+        if ( lc !=3D "22" )
+            return CMD_TYPE_WRONG_LENGTH;
+
+        if ( app->getType() !=3D "ISim" )
+            return CMD_TYPE_APP_ERROR;
+
+        return CMD_TYPE_UMTS_AUTH;
+    } else {
+        return CMD_TYPE_UNKNOWN;
+    }
+}
diff --git a/src/aidapplication.h b/src/aidapplication.h
new file mode 100644
index 0000000..6a2f4d9
--- /dev/null
+++ b/src/aidapplication.h
@@ -0,0 +1,88 @@
+/*************************************************************************=
***
+**
+** This file is part of the Qt Extended Opensource Package.
+**
+** Copyright (C) 2017  Intel Corporation. All rights reserved.
+**
+** This file may be used under the terms of the GNU General Public License
+** version 2.0 as published by the Free Software Foundation and appearing
+** in the file LICENSE.GPL included in the packaging of this file.
+**
+** Please review the following information to ensure GNU General Public
+** Licensing requirements will be met:
+**     http://www.fsf.org/licensing/licenses/info/GPLv2.html.
+**
+**
+**************************************************************************=
**/
+
+#ifndef AIDAPPLICATION_H
+#define AIDAPPLICATION_H
+
+#include "phonesim.h"
+
+#define MAX_LOGICAL_CHANNELS    4
+
+/*
+ * Some common errors
+ */
+enum CmdType {
+    CMD_TYPE_GSM_AUTH =3D 0,
+    CMD_TYPE_UMTS_AUTH =3D 1,
+    CMD_TYPE_UNSUPPORTED_CLS =3D 0x6E00,
+    CMD_TYPE_UNSUPPORTED_INS =3D 0x6D00,
+    CMD_TYPE_INCORRECT_P2_P1 =3D 0x6A86,
+    CMD_TYPE_WRONG_LENGTH =3D 0x6700,
+    CMD_TYPE_APP_ERROR =3D 0x9862,
+    CMD_TYPE_UNKNOWN =3D 0xFFFF
+};
+
+/*
+ * Class for representing a single AID
+ */
+class AidApplication : public QObject
+{
+    Q_OBJECT
+public:
+    AidApplication( QObject *parent, SimXmlNode& n );
+    ~AidApplication();
+
+    QString getAid() { return aid; };
+    QString getType() { return type; };
+    SimFileSystem *fs;
+
+signals:
+    // Send a response to a command.
+    void send( const QString& line );
+
+private:
+    QString aid;
+    QString type;
+};
+
+/*
+ * Wrapper for containing all AIDs on the SIM
+ */
+class AidAppWrapper : public QObject
+{
+    Q_OBJECT
+public:
+    AidAppWrapper( SimRules *r, QList<AidApplication *> apps, SimAuth *aut=
h =3D NULL );
+    ~AidAppWrapper();
+
+    bool command( const QString& cmd );
+
+//signals:
+        // Send a response to a command.
+//        void send( const QString& line );
+private:
+    QList<AidApplication *> applications;
+    QMap<int, AidApplication*> sessions;
+    int session_start;
+    SimRules *rules;
+    SimAuth *auth;
+
+    enum CmdType checkCommand( AidApplication *app, QString command);
+
+};
+
+#endif
-- =

2.7.4


--===============8196992735857031337==--

