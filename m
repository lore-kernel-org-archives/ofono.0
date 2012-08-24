Content-Type: multipart/mixed; boundary="===============6965505136531956227=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/3] phonesim: accept STK command without application
Date: Fri, 24 Aug 2012 10:32:33 +0200
Message-ID: <1345797155-27517-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1345797155-27517-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6965505136531956227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the STK command is rightly formated, send OK even if
the sim application does not handle it. it's needed to
be able to manualy send STK command.
---
 src/phonesim.cpp |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 276ae47..aa4f8a2 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -985,8 +985,10 @@ bool SimRules::simCommand( const QString& cmd )
         QByteArray response =3D QAtUtils::fromHex( cmd.mid(start) );
         QSimTerminalResponse resp =3D QSimTerminalResponse::fromPdu( respo=
nse );
 =

-        if ( !toolkitApp || !toolkitApp->response( resp ) )
+        if ( ( resp.command().type() =3D=3D QSimCommand::NoCommand ) || !t=
oolkitApp )
             respond( "ERROR" );
+        else if ( !toolkitApp->response( resp ) )
+            respond( "OK" );
 =

         return true;
     }
@@ -997,8 +999,10 @@ bool SimRules::simCommand( const QString& cmd )
         QByteArray envelope =3D QAtUtils::fromHex( cmd.mid(start) );
         QSimEnvelope env =3D QSimEnvelope::fromPdu( envelope );
 =

-        if (!toolkitApp || !toolkitApp->envelope( env ) )
+        if ( ( env.type() =3D=3D QSimEnvelope::NoEnvelope ) || !toolkitApp=
 )
             respond( "ERROR" );
+        else if ( !toolkitApp->envelope( env ) )
+            respond( "OK" );
 =

         return true;
     }
-- =

1.7.9.5


--===============6965505136531956227==--

