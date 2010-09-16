Content-Type: multipart/mixed; boundary="===============5517880017110498801=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: simulate language notification in sim app
Date: Thu, 16 Sep 2010 11:39:27 -0700
Message-ID: <1284662367-7004-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C911649.6070505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5517880017110498801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp    |   38 ++++++++++++++++++++++++
 src/qsimcommand.h      |    3 ++
 src/simapplication.cpp |   76 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 4 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 9a9a169..df2422c 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -94,6 +94,7 @@ public:
         defaultItem =3D other->defaultItem;
         menuItems =3D other->menuItems;
         url =3D other->url;
+        language =3D other->language;
         iconId =3D other->iconId;
         otherIconId =3D other->otherIconId;
         device =3D other->device;
@@ -155,6 +156,7 @@ public:
     uint defaultItem;
     QList<QSimMenuItem> menuItems;
     QString url;
+    QString language;
     uint iconId;
     uint otherIconId;
     int device;
@@ -1980,6 +1982,32 @@ void QSimCommand::setUrl( const QString& value )
 }
 =

 /*!
+    Returns the language that will be used for any text string within
+    proactive commands or envelope command responses.
+
+    Applies to: \c LanguageNotification.
+
+    \sa setLanguage()
+*/
+QString QSimCommand::language() const
+{
+    return d->language;
+}
+
+/*!
+    Sets the language that will be used for any text string within
+    proactive commands or envelope command responses to \a value.
+
+    Applies to: \c LanguageNotification.
+
+    \sa language()
+*/
+void QSimCommand::setLanguage( const QString& value )
+{
+    dwrite()->language =3D value;
+}
+
+/*!
     Returns the icon identifier associated with this command.
     Returns zero if there is no icon.
 =

@@ -3280,6 +3308,16 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpt=
ions options ) const
         }
         break;
 =

+        case LanguageNotification:
+        {
+            if ( !language().isEmpty() && language().length() =3D=3D 2 ) {
+                data +=3D (char)0xAD;
+                data +=3D (char)0x02;
+                data +=3D language();
+            }
+        }
+        break;
+
         default: break;
     }
 =

diff --git a/src/qsimcommand.h b/src/qsimcommand.h
index ff99cc7..d2183b1 100644
--- a/src/qsimcommand.h
+++ b/src/qsimcommand.h
@@ -338,6 +338,9 @@ public:
     QString url() const;
     void setUrl( const QString& value );
 =

+    QString language() const;
+    void setLanguage( const QString& value );
+
     uint iconId() const;
     void setIconId( uint value );
 =

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 4af510b..cc2094d 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -281,6 +281,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Browser    9
 #define MainMenu_DTMF       10
 #define MainMenu_SendSS     11
+#define MainMenu_Language   12
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -329,6 +330,10 @@ const QString DemoSimApplication::getName()
 #define CoLRMenu_Interrogation    2
 #define CoLRMenu_Deactivation     3
 =

+#define Language_Specific       1
+#define Language_Non_Specific   2
+#define Language_Main           3
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -381,6 +386,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Send SS" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Language );
+    item.setLabel( "Language Notification" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -481,6 +490,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Language:
+        {
+            sendLanguageMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1642,3 +1657,64 @@ void DemoSimApplication::CoLRMenu( const QSimTermina=
lResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendLanguageMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Language Notification" );
+
+    item.setIdentifier( Language_Specific );
+    item.setLabel( "Specific Language" );
+    items +=3D item;
+
+    item.setIdentifier( Language_Non_Specific );
+    item.setLabel( "Non-Specific Language" );
+    items +=3D item;
+
+    item.setIdentifier( Language_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(languageMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::languageMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+
+        // Item selected.
+        switch ( resp.menuItem() ) {
+            case Language_Specific:
+            {
+                cmd.setType( QSimCommand::LanguageNotification );
+                cmd.setQualifier( 1 );
+                cmd.setLanguage( "se" );
+                command( cmd, this, SLOT(sendLanguageMenu()) );
+            }
+            break;
+
+            case Language_Non_Specific:
+            {
+                cmd.setType( QSimCommand::LanguageNotification );
+                cmd.setQualifier( 0 );
+                command( cmd, this, SLOT(sendLanguageMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else {
+        // Unknown response - just go back to the main menu.
+        endSession();
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 0f67317..fc57423 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -109,6 +109,8 @@ protected slots:
     void CoLPMenu( const QSimTerminalResponse& resp );
     void sendCoLRMenu();
     void CoLRMenu( const QSimTerminalResponse& resp );
+    void sendLanguageMenu();
+    void languageMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============5517880017110498801==--

