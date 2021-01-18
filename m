Content-Type: multipart/mixed; boundary="===============6792287825893187456=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 7/7] Replace uneccessary uses of QTextCodec to
 convert to unicode
Date: Mon, 18 Jan 2021 17:46:21 +0100
Message-ID: <20210118164621.52831-8-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6792287825893187456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp | 17 ++++++-----------
 src/simapplication.cpp            |  3 +--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index ae2f1a9..8b3c466 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -434,8 +434,7 @@ void ConformanceSimApplication::DisplayTextMenu( const =
QSimTerminalResponse& res
             cmd.setType( QSimCommand::DisplayText );
             cmd.setDestinationDevice( QSimCommand::Display );
             cmd.setClearAfterDelay( false );
-            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-            cmd.setText( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" ) );
+            cmd.setText( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95") );
             command( cmd, this, SLOT(sendDisplayTextMenu()),
                     QSimCommand::UCS2Strings );
         }
@@ -875,8 +874,7 @@ void ConformanceSimApplication::GetInkeyMenu( const QSi=
mTerminalResponse& resp )
             cmd.setType( QSimCommand::GetInkey );
             cmd.setDestinationDevice( QSimCommand::ME );
             cmd.setWantDigits(true);
-            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-            cmd.setText( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" ) );
+            cmd.setText( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" ));
             command( cmd, this, SLOT(sendGetInkeyMenu()),
                     QSimCommand::UCS2Strings );
         }
@@ -887,8 +885,7 @@ void ConformanceSimApplication::GetInkeyMenu( const QSi=
mTerminalResponse& resp )
             cmd.setType( QSimCommand::GetInkey );
             cmd.setDestinationDevice( QSimCommand::ME );
             cmd.setWantDigits(true);
-            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-            cmd.setText( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
+            cmd.setText( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=
=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
                                 "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99=D0=A2=D0=95"
                                 "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99" ) );
             command( cmd, this, SLOT(sendGetInkeyMenu()),
@@ -1364,8 +1361,7 @@ void ConformanceSimApplication::GetInputMenu( const Q=
SimTerminalResponse& resp )
             cmd.setDestinationDevice( QSimCommand::ME );
             cmd.setEcho( true );
             cmd.setWantDigits( false );
-            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-            cmd.setText( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" ) );
+            cmd.setText( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95") );
             cmd.setMinimumLength( 5 );
             cmd.setMaximumLength( 5 );
             command( cmd, this, SLOT(sendGetInputMenu()),
@@ -1379,10 +1375,9 @@ void ConformanceSimApplication::GetInputMenu( const =
QSimTerminalResponse& resp )
             cmd.setDestinationDevice( QSimCommand::ME );
             cmd.setEcho( true );
             cmd.setWantDigits( false );
-            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-            cmd.setText( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=D0=92=
=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
+            cmd.setText( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=
=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=
=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
                                 "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99=D0=A2=D0=95"
-                                "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99" ) );
+                                "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=
=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=
=D0=92=D0=A3=D0=99") );
             cmd.setMinimumLength( 5 );
             cmd.setMaximumLength( 5 );
             command( cmd, this, SLOT(sendGetInputMenu()),
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index da0385d..f21fa4e 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -1916,8 +1916,7 @@ void DemoSimApplication::USSDMenu( const QSimTerminal=
Response& resp )
                 cmd.setType( QSimCommand::SendUSSD );
                 cmd.setDestinationDevice( QSimCommand::Network );
                 cmd.setText( "UCS2 USSD" );
-                QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
-                cmd.setNumber( codec->toUnicode( "=D0=97=D0=94=D0=A0=D0=90=
=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95" ) );
+                cmd.setNumber( QStringLiteral("=D0=97=D0=94=D0=A0=D0=90=D0=
=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95") );
                 command( cmd, this, SLOT(sendUSSDMenu()),
                          QSimCommand::UCS2Strings );
             }
--
2.29.2

--===============6792287825893187456==--

