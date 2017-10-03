Content-Type: multipart/mixed; boundary="===============7160344286442116945=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/5] simauth: Added SimAuth class for GSM/UMTS auth
Date: Tue, 03 Oct 2017 09:35:14 -0700
Message-ID: <1507048516-15623-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507048516-15623-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7160344286442116945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SimAuth class is used to parse/respond to several AT commands. In
order to simulate running a SIMs GSM/UMTS authentication algorithms.

The class is initialized if the XML contains a "simauth" tag, which should
contain the secret key "ki" value, "opc" and a list of "aid" tags.

Implemented AT commands:

AT+CUAD: List available SIM applications (USIM or ISIM)
AT+CCHO: Open logical channel
AT+CGLA: Run either GSM/UMTS algorithm
AT+CCHC: Close logical channel

The GSM algorithm uses COMP128v1 (src/comp128.c), which generates
SRES and KC.

The UMTS algorithm uses the "Milenage" algorithm which generates
RES, CK and IK, or AUTS in case of sync failure.
---
 src/simauth.cpp | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simauth.h   | 105 ++++++++++++++
 2 files changed, 519 insertions(+)
 create mode 100644 src/simauth.cpp
 create mode 100644 src/simauth.h

diff --git a/src/simauth.cpp b/src/simauth.cpp
new file mode 100644
index 0000000..ce8263d
--- /dev/null
+++ b/src/simauth.cpp
@@ -0,0 +1,414 @@
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
+#include "simauth.h"
+#include <qatutils.h>
+#include <qsimcontrolevent.h>
+
+extern "C" {
+#include "comp128.h"
+#include "aes.h"
+}
+
+#define QSTRING_TO_BUF(s) \
+    (uint8_t *)QByteArray::fromHex( s.toUtf8().data() ).data()
+
+SimAuth::SimAuth( QObject *parent, SimXmlNode& n )
+    : QObject( parent )
+{
+    SimXmlNode *child =3D n.children;
+
+    _ki =3D n.getAttribute( "ki" );
+    _opc =3D n.getAttribute( "opc" );
+    _session_start =3D 257;
+
+    _aid_list =3D QStringList();
+
+    // parse list of <aid> </aid>
+    while (child) {
+        if ( child->tag =3D=3D "aid" )
+            _aid_list +=3D QStringList( child->contents );
+
+        child =3D child->next;
+    }
+}
+
+SimAuth::~SimAuth()
+{
+}
+
+bool SimAuth::command( const QString& cmd )
+{
+    if ( cmd.startsWith( "AT+CUAD") ) {
+        QString response( "+CUAD: " );
+
+        if ( cmd.contains("=3D?") ) {
+            emit send( "OK" );
+            return true;
+        }
+
+        foreach ( const QString &str, _aid_list )
+            response +=3D str;
+
+        response.append( "\n\nOK" );
+
+        emit send( response );
+    } else if ( cmd.startsWith( "AT+CCHO" ) ) {
+        QString aid;
+        int session_id =3D -1;
+
+        if ( !cmd.contains("=3D") ) {
+            emit send( "ERROR" );
+            return true;
+        }
+
+        if ( cmd.contains("=3D?") ) {
+            emit send( "OK" );
+            return true;
+        }
+
+        aid =3D cmd.split('=3D')[1];
+        aid =3D aid.replace("\"", "");
+
+        foreach ( const QString &str, _aid_list ) {
+            if ( str.contains( aid ) ) {
+                session_id =3D openChannel( aid );
+                break;
+            }
+        }
+
+        if ( session_id =3D=3D -1 ) {
+            emit send( "ERROR" );
+            return true;
+        }
+
+        emit send( QString( "+CCHO: %1\n\nOK" ).arg(session_id, 0, 10) );
+    } else if ( cmd.startsWith( "AT+CGLA" ) ) {
+        QString aid;
+        QString data;
+        QString command;
+        QString parameters;
+        QString response;
+        enum CmdType type;
+        int session_id =3D -1;
+
+        if ( !cmd.contains("=3D") ) {
+            emit send( "ERROR" );
+            return true;
+        }
+
+        if ( cmd.contains("=3D?") ) {
+            emit send( "OK" );
+            return true;
+        }
+
+        data =3D cmd.split('=3D')[1];
+        session_id =3D data.split(',')[0].toInt();
+
+        if (!getAidFromSession( session_id, aid )) {
+            emit send( "ERROR" );
+            return true;
+        }
+
+        data =3D data.split(',')[2].replace("\"", "");
+        parameters =3D data.mid(10);
+
+        type =3D checkCommand( data, aid );
+
+        if (type =3D=3D CMD_TYPE_GSM_AUTH) {
+            QString sres, kc;
+            QString rand =3D parameters.mid(2, 32);
+
+            gsmAuthenticate( rand, sres, kc );
+
+            response =3D QString( "+CGLA: 32,\"04 %1 08 %2 \"\n\nOK" )
+                    .arg( sres, kc );
+            response.replace( " ", "");
+
+        } else if (type =3D=3D CMD_TYPE_UMTS_AUTH) {
+            enum UmtsStatus status;
+            QString res, ck, ik, auts;
+            QString rand =3D parameters.mid(2, 32);
+            QString autn =3D parameters.mid(36, 32);
+
+            status =3D umtsAuthenticate( rand, autn, res, ck, ik, auts );
+
+            response =3D QString("+CGLA: ");
+
+            QString test;
+
+            switch (status) {
+            case UMTS_OK:
+                response +=3D QString( "88,\"DB08 %1 10 %2 10 %3\"\n\nOK" )
+                        .arg( res, ck, ik );
+                response.replace( " ", "" );
+
+                break;
+            case UMTS_INVALID_MAC:
+                response +=3D QString( "4,\"%1\"\n\nOK")
+                        .arg( CMD_TYPE_APP_ERROR, 0, 16 );
+
+                break;
+            case UMTS_SYNC_FAILURE:
+                response =3D=3D QString( "34,\"DC10 %1 \"\n\nOK" ).arg( au=
ts );
+                response.replace( " ", "" );
+
+                break;
+            case UMTS_ERROR:
+                response =3D QString( "ERROR" );
+
+                break;
+            }
+        } else {
+            response =3D QString("+CGLA: 4,\"%1\"\n\nOK").arg(type, 0, 16);
+        }
+
+        emit send( response );
+    } else if ( cmd.startsWith( "AT+CCHC" ) ) {
+        int session_id =3D -1;
+
+        if ( !cmd.contains("=3D") ) {
+            emit send( "ERROR" );
+            return true;
+        }
+
+        if ( cmd.contains("=3D?") ) {
+            emit send( "OK" );
+            return true;
+        }
+
+        session_id =3D cmd.split('=3D')[1].toInt();
+
+        closeChannel(session_id);
+
+        emit send( "OK" );
+    } else {
+        return false;
+    }
+
+    return true;
+}
+
+int SimAuth::openChannel( QString aid )
+{
+    if ( _logical_channels.size() >=3D MAX_LOGICAL_CHANNELS )
+        return -1;
+
+    _logical_channels.insert( _session_start, aid );
+
+    return _session_start++;
+}
+
+void SimAuth::closeChannel( int session_id )
+{
+    _logical_channels.remove( session_id );
+}
+
+bool SimAuth::getAidFromSession( int session_id, QString& aid )
+{
+    if ( _logical_channels.contains( session_id ) ) {
+        aid =3D _logical_channels[session_id];
+        return true;
+    }
+
+    return false;
+}
+
+enum AidType SimAuth::getAidType( QString aid )
+{
+    if ( aid.mid(10, 4) =3D=3D "1004" )
+        return AID_TYPE_ISIM;
+    else if ( aid.mid(10, 4) =3D=3D "1002")
+        return AID_TYPE_USIM;
+
+    return AID_TYPE_UNKNOWN;
+}
+
+
+enum CmdType SimAuth::checkCommand( QString command, QString aid )
+{
+    QString cls =3D command.mid(0, 2);
+    QString ins =3D command.mid(2, 2);
+    QString p1 =3D command.mid(4, 2);
+    QString p2 =3D command.mid(6, 2);
+    QString lc =3D command.mid(8, 2);
+    AidType type =3D getAidType( aid );
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
+        if ( !(type =3D=3D AID_TYPE_USIM || type =3D=3D AID_TYPE_ISIM) )
+            return CMD_TYPE_APP_ERROR;
+
+        return CMD_TYPE_GSM_AUTH;
+    } else if ( p2 =3D=3D "81" ) {
+        if ( lc !=3D "22" )
+            return CMD_TYPE_WRONG_LENGTH;
+
+        if ( type !=3D AID_TYPE_ISIM )
+            return CMD_TYPE_APP_ERROR;
+
+        return CMD_TYPE_UMTS_AUTH;
+    } else {
+        return CMD_TYPE_UNKNOWN;
+    }
+}
+
+void SimAuth::gsmAuthenticate( QString rand, QString &sres,
+        QString &kc )
+{
+    uint8_t *ki =3D QSTRING_TO_BUF( _ki );
+    uint8_t *_rand =3D QSTRING_TO_BUF( rand );
+    uint8_t _sres[4];
+    uint8_t _kc[8];
+
+    comp128( ki, _rand, _sres, _kc );
+
+    sres =3D QByteArray( (const char *)_sres, 4 ).toHex();
+    kc =3D QByteArray( (const char *)_kc, 8 ).toHex();
+}
+
+/*
+ * Helper to XOR an array
+ * to - result of XOR array
+ * a - array 1
+ * b - array 2
+ * len - size of aray
+ */
+#define XOR(to, a, b, len) \
+    for (i =3D 0; i < len; i++) { \
+        to[i] =3D a[i] ^ b[i]; \
+    }
+
+enum UmtsStatus SimAuth::umtsAuthenticate( QString rand, QString autn,
+        QString &res, QString &ck, QString &ik, QString &auts )
+{
+    int i;
+
+    uint8_t *ki =3D QSTRING_TO_BUF( _ki );
+    uint8_t *_rand =3D QSTRING_TO_BUF( rand );
+    uint8_t *_autn =3D QSTRING_TO_BUF( autn );
+    uint8_t *opc =3D QSTRING_TO_BUF( _opc );
+
+    uint8_t ak[6];
+    uint8_t sqn[6];
+    uint8_t amf[2];
+    uint8_t mac[8];
+    uint8_t _res[8];
+    uint8_t _ck[16];
+    uint8_t _ik[16];
+
+    uint8_t temp[16];
+    uint8_t out1[16];
+    uint8_t out2[16];
+    uint8_t in1[16];
+    uint8_t tmp1[16];
+    uint8_t tmp2[16];
+
+    // copy out AMF/MAC from AUTN
+    memcpy(amf, _autn + 6, 2);
+    memcpy(mac, _autn + 8, 8);
+
+    // TEMP =3D AES[RAND ^ OPc]
+    XOR(temp, _rand, opc, 16);
+    aes_encrypt(ki, 16, temp, temp, 16);
+
+    // f2 algorithm
+    // OUT2 =3D=3D AES[(TEMP ^ OPc) ^ c2] ^ OPc]
+    XOR(tmp1, temp, opc, 16);
+    tmp1[15] ^=3D 1;
+    aes_encrypt(ki, 16, tmp1, tmp1, 16);
+    XOR(out2, tmp1, opc, 16);
+
+    // AK is first 6 bytes of OUT2
+    memcpy(ak, out2, 6);
+    // RES is last 8 bytes of OUT2
+    memcpy(_res, out2 + 8, 8);
+
+    // get SQN, first 6 bytes of AUTN are SQN^AK, so (SQN^AK)^AK =3D SQN
+    XOR(sqn, _autn, ak, 6);
+
+    // f1 algorithm
+    // setup IN1
+    memcpy(in1, sqn, 6);
+    memcpy(in1 + 6, amf, 2);
+    memcpy(in1 + 8, sqn, 6);
+    memcpy(in1 + 14, amf, 2);
+
+    for (i =3D 0; i < 16; i++)
+        tmp1[(i + 8) % 16] =3D in1[i] ^ opc[i];
+
+    /* tmp2 =3D TEMP ^ tmp1 */
+    XOR(tmp2, temp, tmp1, 16);
+    /* tmp2 =3D E[tmp2]k */
+    aes_encrypt(ki, 16, tmp2, tmp1, 16);
+    /* out1 =3D OUT1 =3D tmp1 ^ opc */
+    XOR(out1, tmp1, opc, 16);
+
+    if (memcmp(_autn + 8, out1, 8)) {
+        // f5* algorithm
+        // rot(TEMP ^ OPC, r5)
+        for (i =3D 0; i < 16; i++)
+            tmp1[(i + 4) % 16] =3D temp[i] ^ opc[i];
+
+        // XOR with c5
+        tmp1[15] ^=3D 1 << 3;
+        aes_encrypt(ki, 16, tmp1, tmp1, 16);
+        // XOR with OPc
+        XOR(tmp1, opc, tmp1, 16);
+
+        auts =3D QByteArray( (const char *)tmp1, 16 ).toHex();
+
+        return UMTS_INVALID_MAC;
+    }
+
+    // f3 algorithm
+    for (i =3D 0; i < 16; i++)
+        tmp1[(i + 12) % 16] =3D temp[i] ^ opc[i];
+
+    /* tmp1 ^ c3. c3 at bit 126 =3D=3D 1 */
+    tmp1[15] ^=3D 1 << 1;
+    aes_encrypt(ki, 16, tmp1, _ck, 16);
+    /* ck ^ opc */
+    XOR(_ck, _ck, opc, 16);
+
+    // f4 algorithm
+    for (i =3D 0; i < 16; i++)
+        tmp1[(i + 8) % 16] =3D temp[i] ^ opc[i];
+
+    /* tmp1 ^ c4. c4@bit 125 =3D=3D 1 */
+    tmp1[15] ^=3D 1 << 2;
+    aes_encrypt(ki, 16, tmp1, _ik, 16);
+    /* ik ^ opc */
+    XOR(_ik, _ik, opc, 16);
+
+    res =3D QByteArray( (const char *)_res, 8 ).toHex();
+    ck =3D QByteArray( (const char *)_ck, 16 ).toHex();
+    ik =3D QByteArray( (const char *)_ik, 16 ).toHex();
+
+    return UMTS_OK;
+}
diff --git a/src/simauth.h b/src/simauth.h
new file mode 100644
index 0000000..eb733f6
--- /dev/null
+++ b/src/simauth.h
@@ -0,0 +1,105 @@
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
+#ifndef SIMAUTH_H
+#define SIMAUTH_H
+
+#include "phonesim.h"
+
+#define MAX_LOGICAL_CHANNELS    4
+
+enum AidType {
+    AID_TYPE_USIM,
+    AID_TYPE_ISIM,
+    AID_TYPE_UNKNOWN
+};
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
+enum UmtsStatus {
+    UMTS_OK,            // Success
+    UMTS_INVALID_MAC,   // MAC did not match AUTN parameter
+    UMTS_SYNC_FAILURE,  // SQN did not match
+    UMTS_ERROR          // Any other error
+};
+
+class SimAuth : public QObject
+{
+    Q_OBJECT
+public:
+    SimAuth( QObject *parent, SimXmlNode& n );
+    ~SimAuth();
+
+    // Process an AT command.  Returns false if not a call-related command.
+    bool command( const QString& cmd );
+
+signals:
+    // Send a response to a command.
+    void send( const QString& line );
+
+private:
+    // secret key, set during initialization (from XML)
+    QString _ki;
+
+    // operator variant algorithm configuration field
+    QString _opc;
+
+    // arbitrary session ID starting number
+    int _session_start;
+
+    // parsed list of AID's
+    QStringList _aid_list;
+
+    // map of logical channel integers to AID's
+    QMap<int, QString> _logical_channels;
+
+    // run COMP128v1 algorithm against 'rand' and 'ki'
+    void gsmAuthenticate( QString rand, QString &sres, QString &kc );
+
+    // run Milenage algorithm with ki, rand, and autn
+    enum UmtsStatus umtsAuthenticate( QString rand, QString autn,
+            QString &res, QString &ck, QString &ik, QString &auts);
+
+    // open an AID logical channel
+    int openChannel( QString aid );
+
+    // close an AID logical channel
+    void closeChannel( int session_id );
+
+    // find the AID from a given session ID
+    bool getAidFromSession( int session_id, QString& aid );
+
+    // checks that the AID supports the given command
+    enum CmdType checkCommand( QString command, QString aid );
+
+    // returns the type of AID (USIM/ISIM/UNKNOWN)
+    enum AidType getAidType( QString aid );
+};
+
+#endif
-- =

2.7.4


--===============7160344286442116945==--

