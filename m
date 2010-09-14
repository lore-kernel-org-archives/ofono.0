Content-Type: multipart/mixed; boundary="===============7090640893769034605=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: Fix multiple proactive command ind issue
Date: Tue, 14 Sep 2010 09:22:19 -0700
Message-ID: <1284481339-10274-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284481339-10274-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7090640893769034605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 8210f51..89089b2 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -1013,11 +1013,13 @@ bool SimRules::simCommand( const QString& cmd )
         QSimTerminalResponse resp =3D
             QSimTerminalResponse::fromPdu( param.mid(5) );
 =

-        if ( toolkitApp->response( resp ) )
-            return simCsimOk( QByteArray() );
+        /* Incase of successful case, response is sent inside
+         * the SimApplication::response function. response function
+         * also handles the notification of new command
+         */
+        if ( !toolkitApp->response( resp ) )
+            respond( "+CSIM: 4,6F00\\n\\nOK" );
 =

-        /* Response to the wrong type of command. */
-        respond( "+CSIM: 4,6F00\\n\\nOK" );
         return true;
     } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0x2c &&
                     param[4] =3D=3D (char)0x10 && param.size() >=3D 21 ) {
-- =

1.7.0.4


--===============7090640893769034605==--

