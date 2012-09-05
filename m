Content-Type: multipart/mixed; boundary="===============7459838333521197267=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/3] phonesim: Add text for PlayTone and Send SS
Date: Wed, 05 Sep 2012 19:21:06 +0200
Message-ID: <1346865667-24888-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865667-24888-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7459838333521197267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index bede410..d79e8ca 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -956,6 +956,7 @@ void DemoSimApplication::toneMenu( const QSimTerminalRe=
sponse& resp )
     if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
         // Item selected.
         cmd.setType( QSimCommand::PlayTone );
+        cmd.setText( "Play a standard supervisory tone" );
         cmd.setDestinationDevice( QSimCommand::Earpiece );
         cmd.setTone( (QSimCommand::Tone)( resp.menuItem() ) );
         if ( cmd.tone() =3D=3D QSimCommand::ToneDial )
@@ -1406,6 +1407,7 @@ void DemoSimApplication::CFMenu( const QSimTerminalRe=
sponse& resp )
                 cmd.setType( QSimCommand::SendSS );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setNumber( "**62*+155543*11#" );
+                cmd.setText( "Sending SS Registration" );
                 command( cmd, this, SLOT(sendCFMenu()) );
             }
             break;
@@ -1415,6 +1417,7 @@ void DemoSimApplication::CFMenu( const QSimTerminalRe=
sponse& resp )
                 cmd.setType( QSimCommand::SendSS );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setNumber( "*62#" );
+                cmd.setText( "Sending SS Activation" );
                 command( cmd, this, SLOT(sendCFMenu()) );
             }
             break;
@@ -1424,6 +1427,7 @@ void DemoSimApplication::CFMenu( const QSimTerminalRe=
sponse& resp )
                 cmd.setType( QSimCommand::SendSS );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setNumber( "*#62**11#" );
+                cmd.setText( "Sending SS Interrogation class voice" );
                 command( cmd, this, SLOT(sendCFMenu()) );
             }
             break;
@@ -1433,6 +1437,7 @@ void DemoSimApplication::CFMenu( const QSimTerminalRe=
sponse& resp )
                 cmd.setType( QSimCommand::SendSS );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setNumber( "#62#" );
+                cmd.setText( "Sending SS Deactivation" );
                 command( cmd, this, SLOT(sendCFMenu()) );
             }
             break;
@@ -1442,6 +1447,7 @@ void DemoSimApplication::CFMenu( const QSimTerminalRe=
sponse& resp )
                 cmd.setType( QSimCommand::SendSS );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setNumber( "##62#" );
+                cmd.setText( "Sending SS Erasure" );
                 command( cmd, this, SLOT(sendCFMenu()) );
             }
             break;
-- =

1.7.9.5


--===============7459838333521197267==--

