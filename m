Content-Type: multipart/mixed; boundary="===============3181186871363626767=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] phonesim: Add Timer Management commands to sim app menu.
Date: Tue, 23 Nov 2010 14:34:45 +0100
Message-ID: <1290519286-25046-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3181186871363626767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I changed uint8_t to unsigned char here, but strangely the old version
still compiles for me.
---
 src/qsimcommand.cpp          |   83 ++++++++++++++++++++
 src/qsimcommand.h            |    3 +
 src/qsimterminalresponse.cpp |   59 ++++++++++++++
 src/qsimterminalresponse.h   |    3 +
 src/simapplication.cpp       |  171 ++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h         |    6 ++
 6 files changed, 325 insertions(+), 0 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 44bdd9a..9d9e689 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -66,6 +66,7 @@ public:
         defaultItem =3D 0;
         iconId =3D 0;
         otherIconId =3D 0;
+        timerId =3D 0;
         device =3D -1;
         qualifier =3D 0;
     }
@@ -97,6 +98,7 @@ public:
         language =3D other->language;
         iconId =3D other->iconId;
         otherIconId =3D other->otherIconId;
+        timerId =3D other->timerId;
         device =3D other->device;
         qualifier =3D other->qualifier;
         extensionData =3D other->extensionData;
@@ -159,6 +161,7 @@ public:
     QString language;
     uint iconId;
     uint otherIconId;
+    uint timerId;
     int device;
     int qualifier;
     QByteArray extensionData;
@@ -2173,6 +2176,33 @@ void QSimCommand::setSmsPacking( bool value )
 }
 =

 /*!
+    Returns the number of the timer to which a Timer Management command is
+    addressed.
+
+    Applies to: \c TimerManagement
+
+    \sa setTimerId()
+*/
+int QSimCommand::timerId() const
+{
+    return d->timerId;
+}
+
+/*!
+    Sets the identifier of the timer to which the Timer Management command
+    is being sent.  \a id should be between 1 and 8 to address one of the
+    eight timers available.
+
+    Applies to: \c TimerManagement
+
+    \sa timerId()
+*/
+void QSimCommand::setTimerId( int id )
+{
+    dwrite()->timerId =3D id;
+}
+
+/*!
     Copy the QSimCommand object \a value.
 */
 QSimCommand& QSimCommand::operator=3D( const QSimCommand & value )
@@ -2669,6 +2699,27 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& =
pdu )
             }
             break;
 =

+            case 0x24:
+            {
+                // Timer identifier.
+                sc.setTimerId( pdu[posn] );
+            }
+            break;
+
+            case 0x25:
+            {
+                // Timer value.
+                int secs =3D 0;
+                secs +=3D ((unsigned char) pdu[posn + 0] >> 4) * 3600;
+                secs +=3D ((unsigned char) pdu[posn + 0] & 15) * 36000;
+                secs +=3D ((unsigned char) pdu[posn + 1] >> 4) * 60;
+                secs +=3D ((unsigned char) pdu[posn + 1] & 15) * 600;
+                secs +=3D ((unsigned char) pdu[posn + 2] >> 4) * 1;
+                secs +=3D ((unsigned char) pdu[posn + 2] & 15) * 10;
+                sc.setDuration( secs * 1000 );
+            }
+            break;
+
             case 0x2B:
             {
                 // Immediate response block.
@@ -2963,6 +3014,31 @@ static void writeTextAttribute( QByteArray& data, co=
nst QByteArray& attr )
     }
 }
 =

+// Write a Timer Id field.
+void _qtopiaphone_writeTimerId( QByteArray& data, uint timerId )
+{
+    data +=3D 0xa4;
+    data +=3D 0x01;
+    data +=3D (char) timerId;
+}
+#define writeTimerId _qtopiaphone_writeTimerId
+
+// Write a Timer Value field.
+void _qtopiaphone_writeTimerValue( QByteArray& data, uint value )
+{
+    if (!value)
+        return;
+
+    data +=3D 0xa5;
+    data +=3D 0x03;
+#define TO_BCD(bin) (char) ((((bin) / 10) & 0xf) | (((bin) % 10) << 4))
+    data +=3D TO_BCD(value / 3600);
+    data +=3D TO_BCD((value / 60) % 60);
+    data +=3D TO_BCD(value % 60);
+#undef TO_BCD
+}
+#define writeTimerValue _qtopiaphone_writeTimerValue
+
 /*!
     \enum QSimCommand::ToPduOptions
     This enum defines additional options to use when encoding SIM commands=
 with QSimCommand::toPdu().
@@ -3189,6 +3265,13 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpt=
ions options ) const
         }
         break;
 =

+        case TimerManagement:
+        {
+            writeTimerId( data, timerId() );
+            writeTimerValue( data, duration() / 1000 );
+        }
+        break;
+
         case SetupIdleModeText:
         {
             writeTextString( data, text(), options );
diff --git a/src/qsimcommand.h b/src/qsimcommand.h
index d2183b1..eadd768 100644
--- a/src/qsimcommand.h
+++ b/src/qsimcommand.h
@@ -356,6 +356,9 @@ public:
     bool smsPacking() const;
     void setSmsPacking( bool value );
 =

+    int timerId() const;
+    void setTimerId( int id );
+
     int qualifier() const;
     void setQualifier( int value );
 =

diff --git a/src/qsimterminalresponse.cpp b/src/qsimterminalresponse.cpp
index db156aa..3e11915 100644
--- a/src/qsimterminalresponse.cpp
+++ b/src/qsimterminalresponse.cpp
@@ -142,6 +142,7 @@ public:
         duration =3D other->duration;
         menuItem =3D other->menuItem;
         dataCodingScheme =3D other->dataCodingScheme;
+        timerId =3D other->timerId;
         extensionData =3D other->extensionData;
     }
 =

@@ -155,6 +156,7 @@ public:
     uint duration;
     uint menuItem;
     int dataCodingScheme;
+    uint timerId;
     QByteArray extensionData;
 };
 =

@@ -449,6 +451,31 @@ void QSimTerminalResponse::setDataCodingScheme( int va=
lue )
 }
 =

 /*!
+    Returns the number of the timer to which a Timer Management command was
+    addressed.
+
+    Applies to: \c TimerManagement
+
+    \sa setTimerId()
+*/
+int QSimTerminalResponse::timerId() const
+{
+    return d->timerId;
+}
+
+/*!
+    Sets the identifier of the timer to which the Timer Management response
+    applies.  \a id should be between 1 and 8 to address one of the
+    eight timers available.
+
+    \sa timerId()
+*/
+void QSimTerminalResponse::setTimerId( int id )
+{
+    d->timerId =3D id;
+}
+
+/*!
     Returns the extension data for this terminal response.  The extension =
data is
     appended after all other fields, and consists of zero or more BER tag-=
length-value
     field specifications.
@@ -479,11 +506,15 @@ void _qtopiaphone_writeTextString( QByteArray& binary=
, const QString& str,
 QString _qtopiaphone_decodeCodedString( const QByteArray& binary, uint pos=
n, uint length );
 void _qtopiaphone_writeDuration( QByteArray& data, uint time );
 void _qtopiaphone_writeBerLength( QByteArray& binary, int length );
+void _qtopiaphone_writeTimerId( QByteArray& data, uint id );
+void _qtopiaphone_writeTimerValue( QByteArray& data, uint value );
 #define readBer _qtopiaphone_readBer
 #define writeTextString _qtopiaphone_writeTextString
 #define decodeCodedString _qtopiaphone_decodeCodedString
 #define writeDuration _qtopiaphone_writeDuration
 #define writeBerLength _qtopiaphone_writeBerLength
+#define writeTimerId _qtopiaphone_writeTimerId
+#define writeTimerValue _qtopiaphone_writeTimerValue
 =

 /*!
     Returns the contents of an extension field.  The \a tag is an 8-bit va=
lue,
@@ -621,6 +652,27 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( co=
nst QByteArray& pdu )
             }
             break;
 =

+            case 0x24:
+            {
+                // Timer identifier.
+                resp.setTimerId( pdu[posn] );
+            }
+            break;
+
+            case 0x25:
+            {
+                // Timer value.
+                int secs =3D 0;
+                secs +=3D ((unsigned char) pdu[posn + 0] >> 4) * 3600;
+                secs +=3D ((unsigned char) pdu[posn + 0] & 15) * 36000;
+                secs +=3D ((unsigned char) pdu[posn + 1] >> 4) * 60;
+                secs +=3D ((unsigned char) pdu[posn + 1] & 15) * 600;
+                secs +=3D ((unsigned char) pdu[posn + 2] >> 4) * 1;
+                secs +=3D ((unsigned char) pdu[posn + 2] & 15) * 10;
+                resp.setDuration( secs * 1000 );
+            }
+            break;
+
             default:
             {
                 // Don't know what this is, so add it as an extension fiel=
d.
@@ -785,6 +837,13 @@ QByteArray QSimTerminalResponse::toPdu() const
         }
         break;
 =

+        case QSimCommand::TimerManagement:
+        {
+            writeTimerId( data, timerId() );
+            writeTimerValue( data, duration() / 1000 );
+        }
+        break;
+
         default: break;
     }
 =

diff --git a/src/qsimterminalresponse.h b/src/qsimterminalresponse.h
index 86a4bf0..24427f2 100644
--- a/src/qsimterminalresponse.h
+++ b/src/qsimterminalresponse.h
@@ -145,6 +145,9 @@ public:
     int dataCodingScheme() const;
     void setDataCodingScheme( int value );
 =

+    int timerId() const;
+    void setTimerId( int id );
+
     QByteArray extensionData() const;
     void setExtensionData( QByteArray value );
 =

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 290ec2a..d9e3b77 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -288,6 +288,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_SendUSSD   13
 #define MainMenu_SendSMS    14
 #define MainMenu_Polling    15
+#define MainMenu_Timers     16
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -358,6 +359,13 @@ enum PollingMenuItems {
 	Polling_30s,
 };
 =

+enum TimersMenuItems {
+	Timers_Start =3D 1,
+	Timers_Stop,
+	Timers_Sleep,
+	Timers_Query,
+};
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -426,6 +434,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "SIM Polling" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Timers );
+    item.setLabel( "Timers" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -550,6 +562,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Timers:
+        {
+            sendTimersMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -2044,3 +2062,156 @@ void DemoSimApplication::pollingMenuResp( const QSi=
mTerminalResponse& resp )
         break;
     }
 }
+
+void DemoSimApplication::sendTimersMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Timer ops" );
+
+    item.setIdentifier( Timers_Start );
+    item.setLabel( "Reset timer 1 to 1h" );
+    items +=3D item;
+
+    item.setIdentifier( Timers_Stop );
+    item.setLabel( "Stop all timers" );
+    items +=3D item;
+
+    item.setIdentifier( Timers_Sleep );
+    item.setLabel( "Sleep for 10s using timer 2" );
+    items +=3D item;
+
+    item.setIdentifier( Timers_Query );
+    item.setLabel( "Show statuses" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(timersMenuResp(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::timersMenuResp( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() !=3D QSimTerminalResponse::Success ) {
+        /* Unknown response - just go back to the main menu. */
+        endSession();
+
+        return;
+    }
+
+    /* Item selected. */
+    switch ( resp.menuItem() ) {
+    case Timers_Start:
+        cmd.setQualifier( 0 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( 1 );
+        cmd.setDuration( 3600000 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(endSession()) );
+        break;
+
+    case Timers_Stop:
+        cmd.setQualifier( 1 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( 1 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(timersCmdResp(QSimTerminalResponse)) );
+        break;
+
+    case Timers_Sleep:
+        cmd.setQualifier( 0 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( 2 );
+        cmd.setDuration( 10000 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, NULL, NULL );
+        break;
+
+    case Timers_Query:
+        cmd.setQualifier( 2 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( 1 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(timersCmdResp(QSimTerminalResponse)) );
+	timerStatus =3D "";
+        break;
+    }
+}
+
+void DemoSimApplication::timersCmdResp( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.command().qualifier() =3D=3D 1 ) {
+        if ( resp.command().timerId() < 1 ) {
+            endSession();
+            return;
+        }
+
+        /* Stop the next timer */
+        cmd.setQualifier( 1 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( resp.timerId() + 1 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+
+        if ( cmd.timerId() >=3D 8 )
+            command( cmd, this, SLOT(endSession()) );
+        else
+            command( cmd, this, SLOT(timersCmdResp(QSimTerminalResponse)) =
);
+
+        return;
+    }
+
+    if ( resp.command().qualifier() =3D=3D 2 ) {
+        if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+            QString status;
+            status.sprintf( "Timer %i expires in %i:%02i:%02i.\n",
+                    resp.timerId(), resp.duration() / 3600000,
+                    (resp.duration() / 60000) % 60,
+                    (resp.duration() / 1000) % 60 );
+
+            timerStatus +=3D status;
+        }
+
+        if ( resp.timerId() =3D=3D 8 || resp.timerId() < 1 ) {
+            /* All timers done */
+            if ( timerStatus.length() =3D=3D 0 )
+                timerStatus =3D "All timers are stopped.";
+
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setText( timerStatus.left(220) );
+            command( cmd, this, SLOT(endSession()) );
+            return;
+        }
+
+        /* Interrogate the next timer */
+        cmd.setQualifier( 2 );
+        cmd.setType( QSimCommand::TimerManagement );
+        cmd.setTimerId( resp.timerId() + 1 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(timersCmdResp(QSimTerminalResponse)) );
+
+        return;
+    }
+}
+
+bool DemoSimApplication::envelope( const QSimEnvelope& env )
+{
+    if ( env.type() !=3D QSimEnvelope::TimerExpiration )
+        return SimApplication::envelope( env );
+
+    QSimCommand cmd;
+
+    cmd.setType( QSimCommand::DisplayText );
+    cmd.setDestinationDevice( QSimCommand::Display );
+    cmd.setText( "Timer expired." );
+    command( cmd, this, SLOT(endSession()) );
+
+    return true;
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 1d6293f..dbf061d 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -70,6 +70,8 @@ public:
 =

     const QString getName();
 =

+    bool envelope( const QSimEnvelope& env );
+
 protected slots:
     void mainMenu();
     void mainMenuSelection( int id );
@@ -119,11 +121,15 @@ protected slots:
     void smsSetTextResp( const QSimTerminalResponse& resp );
     void sendPollingMenu();
     void pollingMenuResp( const QSimTerminalResponse& resp );
+    void sendTimersMenu();
+    void timersMenuResp( const QSimTerminalResponse& resp );
+    void timersCmdResp( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
     bool immediateResponse;
     QString smsDestNumber, smsText;
+    QString timerStatus;
 };
 =

 #endif
-- =

1.7.1.86.g0e460.dirty


--===============3181186871363626767==--

