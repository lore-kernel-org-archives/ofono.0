Content-Type: multipart/mixed; boundary="===============7722569794145653736=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/2] phonesim: Minor reflow in SimChat::command()
Date: Wed, 29 Feb 2012 11:37:46 +0200
Message-ID: <1330508267-8656-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1330508267-8656-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7722569794145653736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Preparation in order to set the variable with the delay,
call setVariable() just from one place.
---
 src/phonesim.cpp |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 09d6306..6931317 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -331,22 +331,24 @@ bool SimChat::command( const QString& cmd )
     for ( int varNum =3D 0; varNum < variables.size(); ++varNum ) {
     	QString variable =3D variables[varNum];
 	QString value =3D values[varNum];
-        if ( value !=3D "*" ) {
+        QString val;
+
+        if ( value =3D=3D "*" )
+            val =3D wild;
+        else {
             int index =3D value.indexOf( "${*}" );
-            if ( index =3D=3D -1 ) {
-                state()->rules()->setVariable( variable, value );
-            } else {
+            if ( index !=3D -1 ) {
                 if ( wild.length() > 0 && wild[wild.length() - 1] =3D=3D 0=
x1A ) {
                     // Strip the terminating ^Z from SMS PDU's.
                     wild =3D wild.left( wild.length() - 1 );
                 }
-                state()->rules()->setVariable
-                    ( variable, value.left( index ) + wild +
-                    value.mid( index + 4 ) );
-            }
-        } else {
-            state()->rules()->setVariable( variable, wild );
+
+                val =3D value.left( index ) + wild + value.mid( index + 4 =
);
+            } else
+                val =3D value;
         }
+
+        state()->rules()->setVariable( variable, val );
     }
 =

     // Switch to the new state.
-- =

1.7.5.4


--===============7722569794145653736==--

