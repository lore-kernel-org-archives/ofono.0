Content-Type: multipart/mixed; boundary="===============0295061914427426936=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] phonesim: Add title to the SETUP menu (this AID TLV object is
 mandatory)
Date: Fri, 06 May 2011 10:07:17 +0200
Message-ID: <1304669237-12189-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0295061914427426936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp |    3 ++-
 src/simapplication.cpp            |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index 5eb9d07..baf3538 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -107,6 +107,7 @@ void ConformanceSimApplication::mainMenu()
     QList<QSimMenuItem> items;
 =

     cmd.setType( QSimCommand::SetupMenu );
+    cmd.setTitle( "Conformance menu" );
 =

     item.setIdentifier( ConformanceMenu_DisplayText );
     item.setLabel( "Display Text" );
@@ -1729,4 +1730,4 @@ void ConformanceSimApplication::GetInputIconMenu( con=
st QSimTerminalResponse& re
             endSession();
         break;
     }
-}
\ No newline at end of file
+}
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 68ec1cd..119d7b2 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -382,6 +382,7 @@ void DemoSimApplication::mainMenu()
     QList<QSimMenuItem> items;
 =

     cmd.setType( QSimCommand::SetupMenu );
+    cmd.setTitle( "Phonesim services" );
 =

     item.setIdentifier( MainMenu_News );
     item.setLabel( "News" );
-- =

1.7.1


--===============0295061914427426936==--

