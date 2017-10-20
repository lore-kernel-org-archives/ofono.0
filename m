Content-Type: multipart/mixed; boundary="===============0643846303475698203=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simauth: Update simauth to handle AUTS parameter
Date: Fri, 20 Oct 2017 11:20:19 -0700
Message-ID: <1508523619-4435-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0643846303475698203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The support for an invalid SQN number was incomplete in the
simauth module. The SIM should have an internal SQN stored
(default.xml now) and verify that the SQN in AUTN matches.
If not, then generate AUTS and send that back.
---
 src/default.xml |  2 +-
 src/simauth.cpp | 78 ++++++++++++++++++++++++++++++++++++++++++-----------=
----
 src/simauth.h   |  3 +++
 3 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index c70b907..39b0216 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -315,7 +315,7 @@
     <set name=3D"SIMSTATE" value=3D"1" />
 =

 <!-- SIM Auth -->
-<simauth ki=3D"90dca4eda45b53cf0f12d7c9c3bc6a89" opc=3D"cb9cccc4b9258e6dca=
4760379fb82581">
+<simauth ki=3D"90dca4eda45b53cf0f12d7c9c3bc6a89" opc=3D"cb9cccc4b9258e6dca=
4760379fb82581" sqn=3D"000000000021">
         <aid>61184F10A0000000871004FFFFFFFF890619000050044953494DFFFFFFFFF=
FFFFF</aid>
         <aid>61184F10A0000000871002FFFFFFFF890619000050045553494DFFFFFFFFF=
FFFFF</aid>
 </simauth>
diff --git a/src/simauth.cpp b/src/simauth.cpp
index ce8263d..20e011c 100644
--- a/src/simauth.cpp
+++ b/src/simauth.cpp
@@ -34,6 +34,7 @@ SimAuth::SimAuth( QObject *parent, SimXmlNode& n )
 =

     _ki =3D n.getAttribute( "ki" );
     _opc =3D n.getAttribute( "opc" );
+    _sqn =3D n.getAttribute( "sqn" );
     _session_start =3D 257;
 =

     _aid_list =3D QStringList();
@@ -164,7 +165,7 @@ bool SimAuth::command( const QString& cmd )
 =

                 break;
             case UMTS_SYNC_FAILURE:
-                response =3D=3D QString( "34,\"DC10 %1 \"\n\nOK" ).arg( au=
ts );
+                response +=3D QString( "34,\"DC0E %1 \"\n\nOK" ).arg( auts=
 );
                 response.replace( " ", "" );
 =

                 break;
@@ -309,10 +310,11 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString ra=
nd, QString autn,
 {
     int i;
 =

-    uint8_t *ki =3D QSTRING_TO_BUF( _ki );
-    uint8_t *_rand =3D QSTRING_TO_BUF( rand );
-    uint8_t *_autn =3D QSTRING_TO_BUF( autn );
-    uint8_t *opc =3D QSTRING_TO_BUF( _opc );
+    uint8_t ki[16];
+    uint8_t _rand[16];
+    uint8_t _autn[16];
+    uint8_t opc[16];
+    uint8_t sqn_stored[6];
 =

     uint8_t ak[6];
     uint8_t sqn[6];
@@ -321,14 +323,22 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString ra=
nd, QString autn,
     uint8_t _res[8];
     uint8_t _ck[16];
     uint8_t _ik[16];
+    uint8_t _auts[14];
 =

     uint8_t temp[16];
     uint8_t out1[16];
     uint8_t out2[16];
+    uint8_t out5[16];
     uint8_t in1[16];
     uint8_t tmp1[16];
     uint8_t tmp2[16];
 =

+    memcpy(ki, QSTRING_TO_BUF( _ki ), 16);
+    memcpy(_rand, QSTRING_TO_BUF( rand ), 16);
+    memcpy(_autn, QSTRING_TO_BUF( autn ), 16);
+    memcpy(opc, QSTRING_TO_BUF( _opc ), 16);
+    memcpy(sqn_stored, QSTRING_TO_BUF( _sqn ), 6);
+
     // copy out AMF/MAC from AUTN
     memcpy(amf, _autn + 6, 2);
     memcpy(mac, _autn + 8, 8);
@@ -359,6 +369,47 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString ran=
d, QString autn,
     memcpy(in1 + 8, sqn, 6);
     memcpy(in1 + 14, amf, 2);
 =

+    // check if SQNs match
+    if (memcmp(sqn, sqn_stored, 6)) {
+        uint8_t ak_star[16];
+        /*
+         * f5* outputs AK' (OUT5)
+         */
+        for (i =3D 0; i < 16; i++)
+            tmp1[(i + 4) % 16] =3D temp[i] ^ opc[i];
+
+        /* tmp1 ^ c5. c5@bit 124 =3D=3D 1 */
+        tmp1[15] ^=3D 1 << 3;
+        aes_encrypt(ki, 16, tmp1, out5, 16);
+        /* out5 ^ opc */
+        XOR(out5, out5, opc, 16);
+
+        XOR(_auts, sqn_stored, out5, 6);
+
+        /* run f1 with zero'd AMF to finish AUTS */
+        in1[6] =3D 0x00;
+        in1[7] =3D 0x00;
+        in1[14] =3D 0x00;
+        in1[15] =3D 0x00;
+
+        for (i =3D 0; i < 16; i++)
+            tmp1[(i + 8) % 16] =3D in1[i] ^ opc[i];
+
+        /* tmp2 =3D TEMP ^ tmp1 */
+        XOR(tmp2, temp, tmp1, 16);
+        /* tmp2 =3D E[tmp2]k */
+        aes_encrypt(ki, 16, tmp2, tmp1, 16);
+
+        /* out1 =3D OUT1 =3D tmp1 ^ opc */
+        XOR(out1, tmp1, opc, 16);
+
+        memcpy(_auts + 6, out1 + 8, 8);
+
+        auts =3D QByteArray( (const char *)_auts, 14 ).toHex();
+
+        return UMTS_SYNC_FAILURE;
+    }
+
     for (i =3D 0; i < 16; i++)
         tmp1[(i + 8) % 16] =3D in1[i] ^ opc[i];
 =

@@ -369,22 +420,9 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString ran=
d, QString autn,
     /* out1 =3D OUT1 =3D tmp1 ^ opc */
     XOR(out1, tmp1, opc, 16);
 =

-    if (memcmp(_autn + 8, out1, 8)) {
-        // f5* algorithm
-        // rot(TEMP ^ OPC, r5)
-        for (i =3D 0; i < 16; i++)
-            tmp1[(i + 4) % 16] =3D temp[i] ^ opc[i];
-
-        // XOR with c5
-        tmp1[15] ^=3D 1 << 3;
-        aes_encrypt(ki, 16, tmp1, tmp1, 16);
-        // XOR with OPc
-        XOR(tmp1, opc, tmp1, 16);
-
-        auts =3D QByteArray( (const char *)tmp1, 16 ).toHex();
-
+    // verify MAC-A matches AUTN
+    if (memcmp(_autn + 8, out1, 8))
         return UMTS_INVALID_MAC;
-    }
 =

     // f3 algorithm
     for (i =3D 0; i < 16; i++)
diff --git a/src/simauth.h b/src/simauth.h
index eb733f6..a66ea52 100644
--- a/src/simauth.h
+++ b/src/simauth.h
@@ -70,6 +70,9 @@ private:
     // operator variant algorithm configuration field
     QString _opc;
 =

+    // Sequence number stored on SIM
+    QString _sqn;
+
     // arbitrary session ID starting number
     int _session_start;
 =

-- =

2.7.4


--===============0643846303475698203==--

