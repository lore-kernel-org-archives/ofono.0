Content-Type: multipart/mixed; boundary="===============3184452220006211494=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 5/5] phonesim: Added SimAuth to phonesim core
Date: Tue, 03 Oct 2017 09:35:16 -0700
Message-ID: <1507048516-15623-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507048516-15623-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3184452220006211494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds the SimAuth command handler to the phonesim command loop.
---
 src/default.xml  |  6 ++++++
 src/phonesim.cpp | 15 +++++++++++++++
 src/phonesim.h   |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index e0cafbb..c70b907 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -314,6 +314,12 @@
     <!-- SIM insertion state -->
     <set name=3D"SIMSTATE" value=3D"1" />
 =

+<!-- SIM Auth -->
+<simauth ki=3D"90dca4eda45b53cf0f12d7c9c3bc6a89" opc=3D"cb9cccc4b9258e6dca=
4760379fb82581">
+        <aid>61184F10A0000000871004FFFFFFFF890619000050044953494DFFFFFFFFF=
FFFFF</aid>
+        <aid>61184F10A0000000871002FFFFFFFF890619000050045553494DFFFFFFFFF=
FFFFF</aid>
+</simauth>
+
 <!-- Time -->
 <!-- Enable for testing
 <unsolicited delay=3D"3000" once=3D"true">*TTZ: 2, "11/25/2007, 12:12:12+4=
0", 0</unsolicited>
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 276ae47..cf7d5a1 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -23,6 +23,7 @@
 #include "simfilesystem.h"
 #include "simapplication.h"
 #include "callmanager.h"
+#include "simauth.h"
 #include <qatutils.h>
 =

 #include <qstring.h>
@@ -628,6 +629,12 @@ SimRules::SimRules( int fd, QObject *p,  const QString=
& filename, HardwareManipu
             // Load a phonebook definition.
             loadPhoneBook( *n );
 =

+        } else if ( n->tag =3D=3D "simauth" ) {
+            printf("\n\nPARSING SIMAUTH\n\n");
+
+            _simAuth =3D new SimAuth( this, *n );
+            connect( _simAuth, SIGNAL(send(QString)),
+                    this, SLOT(respond(QString)) );
         }
         n =3D n->next;
     }
@@ -886,6 +893,10 @@ void SimRules::destruct()
         delete defState;
     defState =3D NULL;
 =

+    if ( _simAuth )
+        delete _simAuth;
+    _simAuth =3D NULL;
+
     if ( _callManager )
         delete _callManager;
     _callManager =3D NULL;
@@ -1128,6 +1139,10 @@ void SimRules::command( const QString& cmd )
     if ( _callManager->command( cmd ) )
         return;
 =

+    // Proccess SIM auth commands
+    if ( _simAuth &&  _simAuth->command( cmd ) )
+        return;
+
     // Process SIM toolkit related commands with the current SIM applicati=
on.
     if ( simCommand( cmd ) )
         return;
diff --git a/src/phonesim.h b/src/phonesim.h
index ce69155..452dc12 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -53,6 +53,7 @@ class SimRules;
 class SimFileSystem;
 class CallManager;
 class SimApplication;
+class SimAuth;
 =

 =

 class SimXmlNode
@@ -358,6 +359,7 @@ private:
     QMap< QString, SimPhoneBook * > phoneBooks;
 =

     CallManager *_callManager;
+    SimAuth *_simAuth;
 =

     bool simCsimOk( const QByteArray& payload );
 };
-- =

2.7.4


--===============3184452220006211494==--

