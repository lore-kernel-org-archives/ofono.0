Content-Type: multipart/mixed; boundary="===============1711445674162592912=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 10/13] Port from c-style casts to static_cast<>()
Date: Tue, 12 Nov 2019 22:37:16 +0100
Message-ID: <20191112213719.9309-11-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1711445674162592912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done using the google-readability-casting check of clang-tidy
---
 src/callmanager.cpp          |   6 +-
 src/hardwaremanipulator.cpp  |  12 +-
 src/phonesim.cpp             |  62 +++---
 src/qatresult.cpp            |  10 +-
 src/qatresultparser.cpp      |   6 +-
 src/qatutils.cpp             | 116 +++++------
 src/qcbsmessage.cpp          |   6 +-
 src/qgsmcodec.cpp            |  54 ++---
 src/qsimcommand.cpp          | 370 +++++++++++++++++------------------
 src/qsimcontrolevent.cpp     |  16 +-
 src/qsimenvelope.cpp         |  48 ++---
 src/qsimterminalresponse.cpp |  98 +++++-----
 src/qsmsmessage.cpp          | 208 ++++++++++----------
 src/qsmsmessage_p.h          |   4 +-
 src/qwsppdu.cpp              |  94 ++++-----
 src/simapplication.cpp       |  68 +++----
 src/simauth.cpp              |  12 +-
 src/simfilesystem.cpp        |  24 +--
 18 files changed, 605 insertions(+), 609 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 1fa13cf..5436e08 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -203,8 +203,8 @@ bool CallManager::command( const QString& cmd )
                 multiparty =3D 0;
             QString line =3D
                 "+CLCC: " + QString::number(info.id) + "," +
-                QString::number((int)(info.incoming)) + "," +
-                QString::number((int)(info.state)) + ",0," +
+                QString::number(static_cast<int>(info.incoming)) + "," +
+                QString::number(static_cast<int>(info.state)) + ",0," +
                 QString::number(multiparty);
             if ( !info.number.isEmpty() ) {
                 line +=3D ",";
@@ -904,7 +904,7 @@ void CallManager::sendState( const CallInfo& info )
         return;     // In the middle of a state swap: don't send this.
     QString line =3D
         "*ECAV: " + QString::number(info.id) + "," +
-        QString::number(stateMap[(int)(info.state)]) + ",0";
+        QString::number(stateMap[static_cast<int>(info.state)]) + ",0";
     if ( !info.number.isEmpty() ) {
         line +=3D ",,," + QAtUtils::encodeNumber(info.number);
     }
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 7a61c0e..ea895e7 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -74,7 +74,7 @@ void HardwareManipulator::constructCBMessage(const QStrin=
g &messageCode, int geo
         return;
     }

-    QCBSMessage::GeographicalScope gs =3D (QCBSMessage::GeographicalScope)=
geographicalScope;
+    QCBSMessage::GeographicalScope gs =3D static_cast<QCBSMessage::Geograp=
hicalScope>(geographicalScope);

     uint un =3D convertString(updateNumber,NIBBLE_MAX,ONE_CHAR,HEX_BASE,&o=
k);
     if ( !ok ) {
@@ -93,7 +93,7 @@ void HardwareManipulator::constructCBMessage(const QStrin=
g &messageCode, int geo
         return;
     }

-    QCBSMessage::Language lang =3D (QCBSMessage::Language)language;
+    QCBSMessage::Language lang =3D static_cast<QCBSMessage::Language>(lang=
uage);

     QCBSMessage m;
     m.setMessageCode(mc);
@@ -226,7 +226,7 @@ void HardwareManipulator::sendVMNotify( int type, int c=
ount, const QList<QVMMess
     if ( type =3D=3D 0 ) {
         mwiUdh.append( 0x01 );     // Special SMS message indication
         mwiUdh.append( 0x02 );     // IE length
-        mwiUdh.append( (char) 0 ); // Message type: Voice
+        mwiUdh.append( static_cast<char>(0) ); // Message type: Voice
         mwiUdh.append( count );    // Message count
     } else if ( type =3D=3D 1 ) {
         if ( received.size() ) {
@@ -234,7 +234,7 @@ void HardwareManipulator::sendVMNotify( int type, int c=
ount, const QList<QVMMess

             mwiUdh.append( 0x23 );     // Enhanced Voice Mail Notification
             mwiUdh.append( 0x02 );     // IE length (Filled in later)
-            mwiUdh.append( (char) 0 ); // Parameters
+            mwiUdh.append( static_cast<char>(0) ); // Parameters
             QSMSMessage::appendAddress( mwiUdh, mailbox, false );
             mwiUdh.append( count );    // Number of Voice Messages
             mwiUdh.append( received.size() ); // Number of VM Notifications
@@ -308,8 +308,8 @@ void HardwareManipulator::sendUSSD( bool cancel, bool r=
esponse,
             uint len =3D content.length();

             for ( u =3D 0; u < len; u++ ) {
-                binary +=3D (unsigned char)(content[u].unicode() >> 8);
-                binary +=3D (unsigned char)(content[u].unicode() & 0xFF);
+                binary +=3D static_cast<unsigned char>(content[u].unicode(=
) >> 8);
+                binary +=3D static_cast<unsigned char>(content[u].unicode(=
) & 0xFF);
             }
             request =3D PS_toHex( binary );
         }
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 0f72a09..f9dab52 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -299,8 +299,8 @@ QString PS_toHex( const QByteArray& binary )
     static char const hexchars[] =3D "0123456789ABCDEF";

     for ( int i =3D 0; i < binary.size(); i++ ) {
-        str +=3D (QChar)(hexchars[ (binary[i] >> 4) & 0x0F ]);
-        str +=3D (QChar)(hexchars[ binary[i] & 0x0F ]);
+        str +=3D QChar(hexchars[ (binary[i] >> 4) & 0x0F ]);
+        str +=3D QChar(hexchars[ binary[i] & 0x0F ]);
     }

     return str;
@@ -726,11 +726,11 @@ void SimRules::tryReadCommand()
         // Extract GSM 07.10 packets from the incoming buffer.
         posn =3D 0;
         while ( posn < incomingUsed ) {
-            if ( incomingBuffer[posn] =3D=3D (char)0xF9 ) {
+            if ( incomingBuffer[posn] =3D=3D static_cast<char>(0xF9) ) {

                 // Skip additional 0xF9 bytes between frames.
                 while ( ( posn + 1 ) < incomingUsed &&
-                        incomingBuffer[posn + 1] =3D=3D (char)0xF9 ) {
+                        incomingBuffer[posn + 1] =3D=3D static_cast<char>(=
0xF9) ) {
                     ++posn;
                 }

@@ -767,14 +767,14 @@ void SimRules::tryReadCommand()
                 if ( type =3D=3D 0xEF || type =3D=3D 0x03 ) {
                     if ( channel =3D=3D 0 ) {
                         if ( len =3D=3D 2 &&
-                             incomingBuffer[posn + 4] =3D=3D (char)0xC3 &&
-                             incomingBuffer[posn + 5] =3D=3D (char)0x01 ) {
+                             incomingBuffer[posn + 4] =3D=3D static_cast<c=
har>(0xC3) &&
+                             incomingBuffer[posn + 5] =3D=3D static_cast<c=
har>(0x01) ) {
                             // This is the "terminate" commmand, which
                             // indicates that we should exit GSM 07.10 mod=
e.
                             useGsm0710 =3D false;
                             posn +=3D len + 5;
                             if ( posn < incomingUsed &&
-                                 incomingBuffer[posn] =3D=3D (char)0xF9 ) {
+                                 incomingBuffer[posn] =3D=3D static_cast<c=
har>(0xF9) ) {
                                 // Skip the trailing 0xF9 on the terminate.
                                 ++posn;
                             }
@@ -849,7 +849,7 @@ void SimRules::tryReadCommand()
                     ++len;
                 }
                 lineBuffer[lineUsed] =3D '\0';
-                if ( lineBuffer[0] !=3D (char)0xF9 ) {
+                if ( lineBuffer[0] !=3D static_cast<char>(0xF9) ) {
                     command( lineBuffer );
                 }
                 lineUsed =3D 0;
@@ -861,17 +861,17 @@ void SimRules::tryReadCommand()
                     ++len;
                 }
                 lineBuffer[lineUsed] =3D '\0';
-                if ( lineBuffer[0] !=3D (char)0xF9 ) {
+                if ( lineBuffer[0] !=3D static_cast<char>(0xF9) ) {
                     command( lineBuffer );
                 }
                 lineUsed =3D 0;
             } else if ( incomingBuffer[len] =3D=3D '\n' ) {
                 lineBuffer[lineUsed] =3D '\0';
-                if ( lineBuffer[0] !=3D (char)0xF9 ) {
+                if ( lineBuffer[0] !=3D static_cast<char>(0xF9) ) {
                     command( lineBuffer );
                 }
                 lineUsed =3D 0;
-            } else if ( lineUsed < (int)( sizeof(lineBuffer) - 1 ) ) {
+            } else if ( lineUsed < static_cast<int>( sizeof(lineBuffer) - =
1 ) ) {
                 lineBuffer[lineUsed++] =3D incomingBuffer[len];
             }
             ++len;
@@ -1040,7 +1040,7 @@ bool SimRules::simCommand( const QString& cmd )
         return false;
     }

-    if ( param[0] !=3D (char)0xA0 ) {
+    if ( param[0] !=3D static_cast<char>(0xA0) ) {
         /* CLA not supported */
         respond( "+CSIM: 4,6800\\n\\nOK" );
         return false;
@@ -1049,7 +1049,7 @@ bool SimRules::simCommand( const QString& cmd )
     // Determine what kind of command we are dealing with.
     // Check for TERMINAL PROFILE, FETCH, TERMINAL RESPONSE,
     // ENVELOPE and UNBLOCK CHV packets.
-    if ( param[1] =3D=3D (char)0x10 ) {
+    if ( param[1] =3D=3D static_cast<char>(0x10) ) {
         /* Abort the SIM application and force it to return to the main me=
nu. */
         if ( toolkitApp )
             toolkitApp->abort();
@@ -1057,7 +1057,7 @@ bool SimRules::simCommand( const QString& cmd )
         /* Download of a TERMINAL PROFILE.  We respond with a simple OK,
          * on the assumption that what we were sent was valid.  */
         return simCsimOk( QByteArray() );
-    } else if ( param[1] =3D=3D (char)0x12 ) {
+    } else if ( param[1] =3D=3D static_cast<char>(0x12) ) {
         if ( !toolkitApp ) {
             respond( "+CSIM: 4,6F00\\n\\nOK" );
             return true;
@@ -1072,7 +1072,7 @@ bool SimRules::simCommand( const QString& cmd )
         }

         return simCsimOk( resp );
-    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0x14 ) {
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D static_cast<char>=
(0x14) ) {
         if ( !toolkitApp ) {
             respond( "+CSIM: 4,6F00\\n\\nOK" );
             return true;
@@ -1090,20 +1090,20 @@ bool SimRules::simCommand( const QString& cmd )
             respond( "+CSIM: 4,6F00\\n\\nOK" );

         return true;
-    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0x2c &&
-                    param[4] =3D=3D (char)0x10 && param.size() >=3D 21 ) {
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D static_cast<char>=
(0x2c) &&
+                    param[4] =3D=3D static_cast<char>(0x10) && param.size(=
) >=3D 21 ) {
         // UNBLOCK CHV command, for resetting a PIN using a PUK.
         QString pinName =3D "PINVALUE";
         QString pukName =3D "PUKVALUE";
-        if ( param[3] =3D=3D (char)0x02 ) {
+        if ( param[3] =3D=3D static_cast<char>(0x02) ) {
             pinName =3D "PIN2VALUE";
             pukName =3D "PUK2VALUE";
         }
         QByteArray pukValue =3D param.mid(5, 8);
         QByteArray pinValue =3D param.mid(13, 8);
-        while ( pukValue.size() > 0 && pukValue[pukValue.size() - 1] =3D=
=3D (char)0xFF )
+        while ( pukValue.size() > 0 && pukValue[pukValue.size() - 1] =3D=
=3D static_cast<char>(0xFF) )
             pukValue =3D pukValue.left( pukValue.size() - 1 );
-        while ( pinValue.size() > 0 && pinValue[pinValue.size() - 1] =3D=
=3D (char)0xFF )
+        while ( pinValue.size() > 0 && pinValue[pinValue.size() - 1] =3D=
=3D static_cast<char>(0xFF) )
             pinValue =3D pinValue.left( pinValue.size() - 1 );
         if ( QString::fromUtf8( pukValue ) !=3D variable( pukName ) ) {
             respond( "+CSIM: 4,9804\\n\\nOK" );
@@ -1113,7 +1113,7 @@ bool SimRules::simCommand( const QString& cmd )
         }

         return true;
-    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0xC2 ) {
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D static_cast<char>=
(0xC2) ) {
         /* ENVELOPE */
         if ( !toolkitApp ) {
             respond( "+CSIM: 4,6F00\\n\\nOK" );
@@ -1127,7 +1127,7 @@ bool SimRules::simCommand( const QString& cmd )
         /* Envelope not supported or current command doesn't allow envelop=
es. */
         respond( "+CSIM: 4,6F00\\n\\nOK" );
         return true;
-    } else if ( param[1] =3D=3D (char)0xf2 ) {
+    } else if ( param[1] =3D=3D static_cast<char>(0xf2) ) {
         /* STATUS command, for now ignore the parameters */
         return simCsimOk( QByteArray() );
     }
@@ -1485,13 +1485,13 @@ out:
         respond( "OK" );
     } else if ( cmd.startsWith( "AT+CPBW=3D" ) ) {
         uint posn =3D 8;
-        int index =3D (int)QAtUtils::parseNumber( cmd, posn );
+        int index =3D static_cast<int>(QAtUtils::parseNumber( cmd, posn ));
         if ( index < 1 || index > pb->size() ) {
             // Invalid index.
             respond( "ERROR" );
             return;
         }
-        if ( ((int)posn) >=3D cmd.length() ) {
+        if ( (static_cast<int>(posn)) >=3D cmd.length() ) {
             // Delete an entry from the phone book.
             pb->setDetails( index, QString(), QString() );
         } else {
@@ -1659,7 +1659,7 @@ void SimRules::modemHandledCommandNotify( const QByte=
Array& cmd )

 void SimRules::callControlEventNotify( const QSimControlEvent& evt )
 {
-    unsolicited( "*TCC: " + QString::number( (int) (evt.type()) ) +
+    unsolicited( "*TCC: " + QString::number( static_cast<int>(evt.type()) =
) +
               "," + QAtUtils::toHex( evt.toPdu() ) );
 }

@@ -1722,15 +1722,15 @@ void SimRules::unsolicited( const QString& resp )
 void SimRules::writeGsmFrame( int type, const char *data, uint len )
 {
     char frame[MAX_GSM0710_FRAME_SIZE + 6];
-    frame[0] =3D (char)0xF9;
-    frame[1] =3D (char)((currentChannel << 2) | 0x03);
-    frame[2] =3D (char)type;
-    frame[3] =3D (char)((len << 1) | 0x01);
+    frame[0] =3D static_cast<char>(0xF9);
+    frame[1] =3D static_cast<char>((currentChannel << 2) | 0x03);
+    frame[2] =3D static_cast<char>(type);
+    frame[3] =3D static_cast<char>((len << 1) | 0x01);
     if ( len > 0 )
         memcpy( frame + 4, data, len);
     // Note: GSM 07.10 says that the CRC is only computed over the header.
-    frame[len + 4] =3D (char)computeCrc( frame + 1, 3 );
-    frame[len + 5] =3D (char)0xF9;
+    frame[len + 4] =3D static_cast<char>(computeCrc( frame + 1, 3 ));
+    frame[len + 5] =3D static_cast<char>(0xF9);
     write( frame, len + 6 );
 }

diff --git a/src/qatresult.cpp b/src/qatresult.cpp
index 9a29503..1c7e785 100644
--- a/src/qatresult.cpp
+++ b/src/qatresult.cpp
@@ -483,7 +483,7 @@ static int numeric( const QString& value )
         return -1;
     int number =3D 0;
     while ( posn < value.length() && value[posn] >=3D '0' && value[posn] <=
=3D '9' )
-        number =3D number * 10 + (int)(value[posn++].unicode() - '0');
+        number =3D number * 10 + (value[posn++].unicode() - '0');
     return number;
 }

@@ -519,7 +519,7 @@ void QAtResult::resultToCode( const QString& value )
         val =3D value.mid( 11 ).trimmed();
         index =3D numeric( val );
         if ( index >=3D 0 ) {
-            d->resultCode =3D (QAtResult::ResultCode)index;
+            d->resultCode =3D static_cast<QAtResult::ResultCode>(index);
             d->verbose =3D false;
             return;
         }
@@ -531,7 +531,7 @@ void QAtResult::resultToCode( const QString& value )
         val =3D value.mid( 11 ).trimmed();
         index =3D numeric( val );
         if ( index >=3D 0 ) {
-            d->resultCode =3D (QAtResult::ResultCode)index;
+            d->resultCode =3D static_cast<QAtResult::ResultCode>(index);
             d->verbose =3D false;
             return;
         }
@@ -591,8 +591,8 @@ QString QAtResult::codeToResult( const QString& default=
Value ) const
         }
     }
     if ( defaultValue.isEmpty() ) {
-        if ( ((int)d->resultCode) >=3D 300 &&
-             ((int)d->resultCode) <=3D 500 ) {
+        if ( (static_cast<int>(d->resultCode)) >=3D 300 &&
+             (static_cast<int>(d->resultCode)) <=3D 500 ) {
             return "+CMS ERROR: " + QString::number( d->resultCode );
         } else {
             return "+CME ERROR: " + QString::number( d->resultCode );
diff --git a/src/qatresultparser.cpp b/src/qatresultparser.cpp
index cba41ad..7e694e2 100644
--- a/src/qatresultparser.cpp
+++ b/src/qatresultparser.cpp
@@ -174,7 +174,7 @@ uint QAtResultParser::readNumeric()
     uint value =3D 0;
     while ( d->linePosn < d->line.length() &&
             d->line[d->linePosn] >=3D '0' && d->line[d->linePosn] <=3D '9'=
 ) {
-        value =3D value * 10 + (uint)(d->line[d->linePosn].unicode() - '0'=
);
+        value =3D value * 10 + static_cast<uint>(d->line[d->linePosn].unic=
ode() - '0');
         ++(d->linePosn);
     }
     if ( d->linePosn < d->line.length() && d->line[d->linePosn] =3D=3D ','=
 ) {
@@ -188,9 +188,9 @@ uint QAtResultParser::readNumeric()

 static QString nextString( const QString& buf, int& posn )
 {
-    uint posn2 =3D (uint)posn;
+    uint posn2 =3D static_cast<uint>(posn);
     QString result =3D QAtUtils::nextString( buf, posn2 );
-    posn =3D (int)posn2;
+    posn =3D static_cast<int>(posn2);
     return result;
 }

diff --git a/src/qatutils.cpp b/src/qatutils.cpp
index 51161bb..c6cc013 100644
--- a/src/qatutils.cpp
+++ b/src/qatutils.cpp
@@ -54,11 +54,11 @@ QString QAtUtils::quote( const QString& str )
     while ( posn < str.length() ) {
         ch =3D str[posn++].unicode();
         if ( ch =3D=3D '"' || ch =3D=3D '\\' || ch =3D=3D '\r' || ch =3D=
=3D '\n' ) {
-            result +=3D (QChar)'\\';
-            result +=3D (QChar)(hexchars[(ch >> 4) & 0x0F]);
-            result +=3D (QChar)(hexchars[ch & 0x0F]);
+            result +=3D QChar('\\');
+            result +=3D QChar(hexchars[(ch >> 4) & 0x0F]);
+            result +=3D QChar(hexchars[ch & 0x0F]);
         } else {
-            result +=3D (QChar)ch;
+            result +=3D QChar(ch);
         }
     }
     return result;
@@ -75,8 +75,8 @@ QString QAtUtils::toHex( const QByteArray& binary )
     static char const hexchars[] =3D "0123456789ABCDEF";

     for ( int i =3D 0; i < binary.size(); i++ ) {
-        str +=3D (QChar)(hexchars[ (binary[i] >> 4) & 0x0F ]);
-        str +=3D (QChar)(hexchars[ binary[i] & 0x0F ]);
+        str +=3D QChar(hexchars[ (binary[i] >> 4) & 0x0F ]);
+        str +=3D QChar(hexchars[ binary[i] & 0x0F ]);
     }

     return str;
@@ -98,7 +98,7 @@ QByteArray QAtUtils::fromHex( const QString& hex )
     value =3D 0;
     size =3D 0;
     for ( posn =3D 0; posn < hex.length(); ++posn ) {
-        ch =3D (uint)( hex[posn].unicode() );
+        ch =3D static_cast<uint>( hex[posn].unicode() );
         if ( ch >=3D '0' && ch <=3D '9' ) {
             nibble =3D ch - '0';
         } else if ( ch >=3D 'A' && ch <=3D 'F' ) {
@@ -112,7 +112,7 @@ QByteArray QAtUtils::fromHex( const QString& hex )
         flag =3D !flag;
         if ( !flag ) {
             bytes.resize( size + 1 );
-            bytes[size++] =3D (char)value;
+            bytes[size++] =3D static_cast<char>(value);
             value =3D 0;
         }
     }
@@ -177,11 +177,11 @@ QString QAtUtils::encodeNumber( const QString& value,=
 bool keepPlus )
 static int FromHexDigit( uint ch )
 {
     if ( ch >=3D '0' && ch <=3D '9' ) {
-        return (int)( ch - '0' );
+        return static_cast<int>( ch - '0' );
     } else if ( ch >=3D 'A' && ch <=3D 'F' ) {
-        return (int)( ch - 'A' + 10 );
+        return static_cast<int>( ch - 'A' + 10 );
     } else if ( ch >=3D 'a' && ch <=3D 'f' ) {
-        return (int)( ch - 'a' + 10 );
+        return static_cast<int>( ch - 'a' + 10 );
     } else {
         return -1;
     }
@@ -190,7 +190,7 @@ static int FromHexDigit( uint ch )
 static int FromOctalDigit( uint ch )
 {
     if ( ch >=3D '0' && ch <=3D '7' ) {
-        return (int)( ch - '0' );
+        return static_cast<int>( ch - '0' );
     } else {
         return -1;
     }
@@ -207,66 +207,66 @@ QString QAtUtils::nextString( const QString& buf, uin=
t& posn )
     QString result =3D "";
     uint ch;
     int digit, digit2, digit3;
-    while ( posn < (uint)(buf.length()) && buf[posn] !=3D '"' ) {
+    while ( posn < static_cast<uint>(buf.length()) && buf[posn] !=3D '"' )=
 {
         ++posn;
     }
-    if ( posn >=3D (uint)(buf.length()) ) {
+    if ( posn >=3D static_cast<uint>(buf.length()) ) {
         return result;
     }
     ++posn;
-    while ( posn < (uint)(buf.length()) && ( ch =3D buf[posn].unicode() ) =
!=3D '"' ) {
+    while ( posn < static_cast<uint>(buf.length()) && ( ch =3D buf[posn].u=
nicode() ) !=3D '"' ) {
         ++posn;
         if ( ch =3D=3D '\\' ) {
             if ( !octalEscapesFlag ) {
                 // Hex-quoted character.
-                if ( posn >=3D (uint)buf.length() )
+                if ( posn >=3D static_cast<uint>(buf.length()) )
                     break;
                 digit =3D FromHexDigit( buf[posn].unicode() );
                 if ( digit =3D=3D -1 ) {
-                    result +=3D (QChar)'\\';
+                    result +=3D QChar('\\');
                     continue;
                 }
-                if ( ( posn + 1 ) >=3D (uint)buf.length() ) {
-                    ch =3D (uint)digit;
+                if ( ( posn + 1 ) >=3D static_cast<uint>(buf.length()) ) {
+                    ch =3D static_cast<uint>(digit);
                     ++posn;
                 } else {
                     digit2 =3D FromHexDigit( buf[posn + 1].unicode() );
                     if ( digit2 =3D=3D -1 ) {
-                        ch =3D (uint)digit;
+                        ch =3D static_cast<uint>(digit);
                         ++posn;
                     } else {
-                        ch =3D (uint)(digit * 16 + digit2);
+                        ch =3D static_cast<uint>(digit * 16 + digit2);
                         posn +=3D 2;
                     }
                 }
             } else {
                 // Octal-quoted character.
-                if ( posn >=3D (uint)buf.length() )
+                if ( posn >=3D static_cast<uint>(buf.length()) )
                     break;
                 digit =3D FromOctalDigit( buf[posn].unicode() );
                 if ( digit =3D=3D -1 ) {
-                    result +=3D (QChar)'\\';
+                    result +=3D QChar('\\');
                     continue;
                 }
-                if ( ( posn + 1 ) >=3D (uint)buf.length() ) {
-                    ch =3D (uint)digit;
+                if ( ( posn + 1 ) >=3D static_cast<uint>(buf.length()) ) {
+                    ch =3D static_cast<uint>(digit);
                     ++posn;
                 } else {
                     digit2 =3D FromOctalDigit( buf[posn + 1].unicode() );
                     if ( digit2 =3D=3D -1 ) {
-                        ch =3D (uint)digit;
+                        ch =3D static_cast<uint>(digit);
                         ++posn;
                     } else {
-                        if ( ( posn + 2 ) >=3D (uint)buf.length() ) {
-                            ch =3D (uint)(digit * 8 + digit2);
+                        if ( ( posn + 2 ) >=3D static_cast<uint>(buf.lengt=
h()) ) {
+                            ch =3D static_cast<uint>(digit * 8 + digit2);
                             posn +=3D 2;
                         } else {
                             digit3 =3D FromOctalDigit( buf[posn + 2].unico=
de() );
                             if ( digit3 =3D=3D -1 ) {
-                                ch =3D (uint)(digit * 8 + digit2);
+                                ch =3D static_cast<uint>(digit * 8 + digit=
2);
                                 posn +=3D 2;
                             } else {
-                                ch =3D (uint)(digit * 64 + digit2 * 8 + di=
git3);
+                                ch =3D static_cast<uint>(digit * 64 + digi=
t2 * 8 + digit3);
                                 posn +=3D 3;
                             }
                         }
@@ -274,9 +274,9 @@ QString QAtUtils::nextString( const QString& buf, uint&=
 posn )
                 }
             }
         }
-        result +=3D (QChar)ch;
+        result +=3D QChar(ch);
     }
-    if ( posn < (uint)buf.length() ) {
+    if ( posn < static_cast<uint>(buf.length()) ) {
         ++posn;
     }
     return result;
@@ -291,12 +291,12 @@ uint QAtUtils::parseNumber( const QString& str, uint&=
 posn , int invalidValue)
 {
     uint num =3D 0;
     int isValid =3D 0;
-    while ( posn < (uint)str.length() && ( str[posn] =3D=3D ' ' || str[pos=
n] =3D=3D ',' ) ) {
+    while ( posn < static_cast<uint>(str.length()) && ( str[posn] =3D=3D '=
 ' || str[posn] =3D=3D ',' ) ) {
         ++posn;
     }
-    while ( posn < (uint)str.length() && str[posn] >=3D '0' && str[posn] <=
=3D '9' ) {
+    while ( posn < static_cast<uint>(str.length()) && str[posn] >=3D '0' &=
& str[posn] <=3D '9' ) {
         isValid =3D 1;
-        num =3D num * 10 + (uint)(str[posn].unicode() - '0');
+        num =3D num * 10 + static_cast<uint>(str[posn].unicode() - '0');
         ++posn;
     }
     if (isValid)
@@ -313,10 +313,10 @@ uint QAtUtils::parseNumber( const QString& str, uint&=
 posn , int invalidValue)
 */
 void QAtUtils::skipField( const QString& str, uint& posn )
 {
-    if ( posn < (uint)str.length() && str[posn] =3D=3D ',' ) {
+    if ( posn < static_cast<uint>(str.length()) && str[posn] =3D=3D ',' ) {
         ++posn;
     }
-    while ( posn < (uint)str.length() && str[posn] !=3D ',' ) {
+    while ( posn < static_cast<uint>(str.length()) && str[posn] !=3D ',' )=
 {
         ++posn;
     }
 }
@@ -377,13 +377,13 @@ QString QGsmHexCodec::convertToUnicode(const char *in=
, int length, ConverterStat
             value +=3D digit;
             if ( !secondByte ) {
                 if ( value !=3D 0x1B ) {
-                    str +=3D QGsmCodec::twoByteToUnicode( (unsigned short)=
value );
+                    str +=3D QGsmCodec::twoByteToUnicode( static_cast<unsi=
gned short>(value) );
                 } else {
                     secondByte =3D true;
                 }
             } else {
                 value +=3D 0x1B00;
-                str +=3D QGsmCodec::twoByteToUnicode( (unsigned short)valu=
e );
+                str +=3D QGsmCodec::twoByteToUnicode( static_cast<unsigned=
 short>(value) );
                 secondByte =3D false;
             }
             nibble =3D 0;
@@ -458,7 +458,7 @@ QString QUcs2HexCodec::convertToUnicode(const char *in,=
 int length, ConverterSta
         value =3D value * 16 + digit;
         ++nibble;
         if ( nibble >=3D 4 ) {
-            str +=3D QChar( (ushort)value );
+            str +=3D QChar( static_cast<ushort>(value) );
             nibble =3D 0;
             value =3D 0;
         }
@@ -618,7 +618,7 @@ QString QCodePage437Codec::convertToUnicode(const char =
*in, int length, Converte
             value =3D value * 16 + digit;
             ++nibble;
             if ( nibble >=3D 4 ) {
-                str +=3D QChar( (ushort)value );
+                str +=3D QChar( static_cast<ushort>(value) );
                 nibble =3D 0;
                 value =3D 0;
             }
@@ -628,7 +628,7 @@ QString QCodePage437Codec::convertToUnicode(const char =
*in, int length, Converte

         // Regular 437-encoded string.
         while ( length-- > 0 )
-            str +=3D QChar((unsigned int)cp437ToUnicode[*in++ & 0xFF]);
+            str +=3D QChar(static_cast<unsigned int>(cp437ToUnicode[*in++ =
& 0xFF]));

     }
     return str;
@@ -675,7 +675,7 @@ QByteArray QCodePage437Codec::convertFromUnicode(const =
QChar *in, int length, Co
     result.resize( length );
     out =3D result.data();
     while ( length-- > 0 ) {
-        *out++ =3D (char)cp437FromUnicode[in->unicode()];
+        *out++ =3D static_cast<char>(cp437FromUnicode[in->unicode()]);
         ++in;
     }
     return result;
@@ -846,7 +846,7 @@ QString QCodePage850Codec::convertToUnicode(const char =
*in, int length, Converte
 {
     QString str;
     while ( length-- > 0 )
-        str +=3D QChar((unsigned int)cp850ToUnicode[*in++ & 0xFF]);
+        str +=3D QChar(static_cast<unsigned int>(cp850ToUnicode[*in++ & 0x=
FF]));
     return str;
 }

@@ -861,7 +861,7 @@ QByteArray QCodePage850Codec::convertFromUnicode(const =
QChar *in, int length, Co
         ch =3D in->unicode();
         ++in;
         if ( ch < 0x0100 ) {
-            *out++ =3D (char)cp850FromUnicode[ch];
+            *out++ =3D static_cast<char>(cp850FromUnicode[ch]);
         } else {
             // Perform a binary search on the sparse mapping table.
             int left =3D 0;
@@ -874,7 +874,7 @@ QByteArray QCodePage850Codec::convertFromUnicode(const =
QChar *in, int length, Co
                 } else if ( ch > cp850MappingInput[middle] ) {
                     left =3D middle + 1;
                 } else {
-                    *out++ =3D (char)cp850MappingOutput[middle];
+                    *out++ =3D static_cast<char>(cp850MappingOutput[middle=
]);
                     break;
                 }
             }
@@ -1037,11 +1037,11 @@ QString QAtUtils::quote( const QString& str, QTextC=
odec *codec )
     while ( posn < bytes.length() ) {
         ch =3D bytes[posn++] & 0xFF;
         if ( ch =3D=3D '"' || ch =3D=3D '\\' || ch =3D=3D '\r' || ch =3D=
=3D '\n' ) {
-            result +=3D (QChar)'\\';
-            result +=3D (QChar)(hexchars[(ch >> 4) & 0x0F]);
-            result +=3D (QChar)(hexchars[ch & 0x0F]);
+            result +=3D QChar('\\');
+            result +=3D QChar(hexchars[(ch >> 4) & 0x0F]);
+            result +=3D QChar(hexchars[ch & 0x0F]);
         } else {
-            result +=3D (QChar)ch;
+            result +=3D QChar(ch);
         }
     }
     return result;
@@ -1087,24 +1087,24 @@ QString QAtUtils::stripNumber( const QString& numbe=
r )
     for ( posn =3D 0; posn < number.length(); ++posn ) {
         ch =3D number[posn].unicode();
         if ( ch >=3D '0' && ch <=3D '9' ) {
-            n +=3D (QChar)ch;
+            n +=3D QChar(ch);
         } else if ( ch =3D=3D '+' || ch =3D=3D '#' || ch =3D=3D '*' ) {
-            n +=3D (QChar)ch;
+            n +=3D QChar(ch);
         } else if ( ch =3D=3D 'A' || ch =3D=3D 'B' || ch =3D=3D 'C' || ch =
=3D=3D 'D' ) {
             // ABCD can actually be digits!
-            n +=3D (QChar)ch;
+            n +=3D QChar(ch);
         } else if ( ch =3D=3D 'a' || ch =3D=3D 'b' || ch =3D=3D 'c' || ch =
=3D=3D 'd' ) {
-            n +=3D (QChar)( ch - 'a' + 'A' );
+            n +=3D QChar( ch - 'a' + 'A' );
         } else if ( ch =3D=3D ',' || ch =3D=3D 'p' || ch =3D=3D 'P' || ch =
=3D=3D 'X' || ch =3D=3D 'x' ) {
             // Comma and 'p' mean a short pause.
             // 'x' means an extension, which for now is the same as a paus=
e.
-            n +=3D (QChar)',';
+            n +=3D QChar(',');
         } else if ( ch =3D=3D 'w' || ch =3D=3D 'W' ) {
             // 'w' means wait for dial tone.
-            n +=3D (QChar)'W';
+            n +=3D QChar('W');
         } else if ( ch =3D=3D '!' || ch =3D=3D '@' ) {
             // '!' =3D hook flash, '@' =3D wait for silence.
-            n +=3D (QChar)ch;
+            n +=3D QChar(ch);
         }
     }
     return n;
@@ -1157,7 +1157,7 @@ QString QAtUtils::decodeString( const QString& value,=
 uint dcs )
     if ((dcs & 0xC0) =3D=3D 0)
         scheme =3D QSMS_DefaultAlphabet;  // Other bits indicate 7-bit GSM=
 language.
     else
-        scheme =3D (QSMSDataCodingScheme)(dcs & 0x0C);
+        scheme =3D static_cast<QSMSDataCodingScheme>(dcs & 0x0C);
     if ( scheme =3D=3D QSMS_UCS2Alphabet ) {
         // The string is hex-encoded UCS-2.
         return codec("ucs2")->toUnicode( value.toLatin1() );
diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index b56a761..17a2cd5 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -387,8 +387,8 @@ bool QCBSMessage::operator!=3D( const QCBSMessage& othe=
r ) const
 void QCBSMessage::print()
 {
     qLog(Modem) << "channel=3D" << channel()
-                  << ", scope=3D" << (int)scope()
-                  << ", messageCode=3D" << (int)messageCode()
+                  << ", scope=3D" << static_cast<int>(scope())
+                  << ", messageCode=3D" << static_cast<int>(messageCode())
                   << ", updateNumber=3D" << updateNumber()
                   << ", language=3D" << language()
                   << ", page=3D" << page()
@@ -434,7 +434,7 @@ QByteArray QCBSMessage::toPdu() const
 {
     QCBSDeliverMessage deliver;

-    deliver.pack( *this, (QSMSDataCodingScheme)bestScheme() );
+    deliver.pack( *this, static_cast<QSMSDataCodingScheme>(bestScheme()) );
     return deliver.toByteArray();
 }

diff --git a/src/qgsmcodec.cpp b/src/qgsmcodec.cpp
index 4120226..5bb12e1 100644
--- a/src/qgsmcodec.cpp
+++ b/src/qgsmcodec.cpp
@@ -283,11 +283,11 @@ char QGsmCodec::singleFromUnicode(QChar c)
 {
     unsigned int ch =3D c.unicode();
     if ( ch < 256 )
-        return (char)(latin1GSMTable[ch]);
+        return static_cast<char>(latin1GSMTable[ch]);
     else if ( ch >=3D 0x0390 && ch <=3D 0x03AF )
-        return (char)(greekGSMTable[ch - 0x0390]);
+        return static_cast<char>(greekGSMTable[ch - 0x0390]);
     else
-        return (char)GUC;
+        return static_cast<char>(GUC);
 }

 /*!
@@ -301,7 +301,7 @@ char QGsmCodec::singleFromUnicode(QChar c)
 */
 QChar QGsmCodec::singleToUnicode(char ch)
 {
-    return QChar((unsigned int)(gsmLatin1Table[((int)ch) & 0xFF]));
+    return QChar(static_cast<unsigned int>(gsmLatin1Table[(static_cast<int=
>(ch)) & 0xFF]));
 }

 /*!
@@ -319,7 +319,7 @@ unsigned short QGsmCodec::twoByteFromUnicode(QChar ch)
     else if ( c < 256 )
         return latin1GSMTable[c];
     else if ( c >=3D 0x0390 && c <=3D 0x03AF )
-        return (char)(greekGSMTable[c - 0x0390]);
+        return static_cast<char>(greekGSMTable[c - 0x0390]);
     else
         return GUC;
 }
@@ -366,18 +366,18 @@ QString QGsmCodec::convertToUnicode(const char *in, i=
nt length, ConverterState *
                     (state->invalidChars)++;
                 break;
             }
-            ch =3D extensionLatin1Table[((int)(*in)) & 0xFF];
+            ch =3D extensionLatin1Table[(static_cast<int>(*in)) & 0xFF];
             if ( ch !=3D UUC ) {
-                str +=3D QChar((unsigned int)ch);
+                str +=3D QChar(static_cast<unsigned int>(ch));
             } else {
-                str +=3D QChar(gsmLatin1Table[((int)(*in)) & 0xFF]);
+                str +=3D QChar(gsmLatin1Table[(static_cast<int>(*in)) & 0x=
FF]);
                 if ( state )
                     (state->invalidChars)++;
             }
         } else {
-            ch =3D gsmLatin1Table[((int)(*in)) & 0xFF];
+            ch =3D gsmLatin1Table[(static_cast<int>(*in)) & 0xFF];
             if ( ch !=3D UUC )
-                str +=3D QChar((unsigned int)ch);
+                str +=3D QChar(static_cast<unsigned int>(ch));
             else if ( state )
                 (state->invalidChars)++;
         }
@@ -402,25 +402,25 @@ QByteArray QGsmCodec::convertFromUnicode(const QChar =
*in, int length, ConverterS
         while ( length > 0 ) {
             unicode =3D (*in).unicode();
             if ( unicode =3D=3D 0x20AC ) {    // Euro
-                result +=3D (char)0x1B;
-                result +=3D (char)0x65;
+                result +=3D static_cast<char>(0x1B);
+                result +=3D static_cast<char>(0x65);
             } else if ( unicode < 256 ) {
                 unsigned short code =3D latin1GSMNoLossTable[unicode];
                 if ( code < 256 ) {
-                    if(((char)code =3D=3D GUC) && state)
+                    if((static_cast<char>(code) =3D=3D GUC) && state)
                         (state->invalidChars)++;
-                    result +=3D (char)code;
+                    result +=3D static_cast<char>(code);
                 } else {
-                    result +=3D (char)(code >> 8);
-                    result +=3D (char)code;
+                    result +=3D static_cast<char>(code >> 8);
+                    result +=3D static_cast<char>(code);
                 }
             } else if ( unicode >=3D 0x0390 && unicode <=3D 0x03AF ) {
-                char c =3D (char)(greekGSMTable[unicode - 0x0390]);
+                char c =3D static_cast<char>(greekGSMTable[unicode - 0x039=
0]);
                 result +=3D c;
-                if ( c =3D=3D (char)GUC && unicode !=3D 0x0394 && state )
+                if ( c =3D=3D static_cast<char>(GUC) && unicode !=3D 0x039=
4 && state )
                     (state->invalidChars)++;
             } else {
-                result +=3D (char)GUC;
+                result +=3D static_cast<char>(GUC);
                 if ( state )
                     (state->invalidChars)++;
             }
@@ -431,23 +431,23 @@ QByteArray QGsmCodec::convertFromUnicode(const QChar =
*in, int length, ConverterS
         while ( length > 0 ) {
             unicode =3D (*in).unicode();
             if ( unicode =3D=3D 0x20AC ) {    // Euro
-                result +=3D (char)0x1B;
-                result +=3D (char)0x65;
+                result +=3D static_cast<char>(0x1B);
+                result +=3D static_cast<char>(0x65);
             } else if ( unicode < 256 ) {
                 unsigned short code =3D latin1GSMTable[unicode];
                 if ( code < 256 ) {
-                    result +=3D (char)code;
+                    result +=3D static_cast<char>(code);
                 } else {
-                    result +=3D (char)(code >> 8);
-                    result +=3D (char)code;
+                    result +=3D static_cast<char>(code >> 8);
+                    result +=3D static_cast<char>(code);
                 }
             } else if ( unicode >=3D 0x0390 && unicode <=3D 0x03AF ) {
-                char c =3D (char)(greekGSMTable[unicode - 0x0390]);
+                char c =3D static_cast<char>(greekGSMTable[unicode - 0x039=
0]);
                 result +=3D c;
-                if ( c =3D=3D (char)GUC && unicode !=3D 0x0394 && state )
+                if ( c =3D=3D static_cast<char>(GUC) && unicode !=3D 0x039=
4 && state )
                     (state->invalidChars)++;
             } else {
-                result +=3D (char)GUC;
+                result +=3D static_cast<char>(GUC);
                 if ( state )
                     (state->invalidChars)++;
             }
diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index fb200ed..c7f3f85 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -1440,7 +1440,7 @@ void QSimCommand::setEcho( bool value )
 QSimCommand::Disposition QSimCommand::disposition() const
 {
     if ( d->type =3D=3D QSimCommand::SetupCall )
-        return (QSimCommand::Disposition)(d->qualifier >> 1);
+        return static_cast<QSimCommand::Disposition>(d->qualifier >> 1);
     else
         return IfNoOtherCalls;
 }
@@ -1456,7 +1456,7 @@ QSimCommand::Disposition QSimCommand::disposition() c=
onst
 void QSimCommand::setDisposition( QSimCommand::Disposition value )
 {
     if ( d->type =3D=3D QSimCommand::SetupCall )
-        dwrite()->qualifier =3D (((int)value) << 1) | (d->qualifier & 0x01=
);
+        dwrite()->qualifier =3D ((static_cast<int>(value)) << 1) | (d->qua=
lifier & 0x01);
 }


@@ -1872,7 +1872,7 @@ void QSimCommand::setMenuItems( const QList<QSimMenuI=
tem>& value )
 QSimCommand::RefreshType QSimCommand::refreshType() const
 {
     if ( d->type =3D=3D QSimCommand::Refresh )
-        return (QSimCommand::RefreshType)(d->qualifier);
+        return static_cast<QSimCommand::RefreshType>(d->qualifier);
     else
         return InitAndFullFileChange;
 }
@@ -1889,7 +1889,7 @@ QSimCommand::RefreshType QSimCommand::refreshType() c=
onst
 void QSimCommand::setRefreshType( QSimCommand::RefreshType value )
 {
     if ( d->type =3D=3D QSimCommand::Refresh )
-        setQualifier( (int)value );
+        setQualifier( static_cast<int>(value) );
 }


@@ -1913,12 +1913,12 @@ QSimCommand::Event QSimCommand::events() const
     QByteArray evdata =3D extensionField( 0x99 );
     if ( evdata.isEmpty() ) {
         return Cancel;      // Field is present, but empty, which means "C=
ancel".
-    } else if ( evdata.contains( (char)0x05 ) ) {
-        if ( evdata.contains( (char)0x04 ) )
+    } else if ( evdata.contains( static_cast<char>(0x05) ) ) {
+        if ( evdata.contains( static_cast<char>(0x04) ) )
             return Both;
         else
             return IdleScreen;
-    } else if ( evdata.contains( (char)0x04 ) ) {
+    } else if ( evdata.contains( static_cast<char>(0x04) ) ) {
         return UserActivity;
     } else {
         return NoEvent;
@@ -1947,33 +1947,33 @@ void QSimCommand::setEvents( QSimCommand::Event val=
ue )

             case IdleScreen:
             {
-                d->extensionData +=3D (char)0x99;
-                d->extensionData +=3D (char)0x01;
-                d->extensionData +=3D (char)0x05;
+                d->extensionData +=3D static_cast<char>(0x99);
+                d->extensionData +=3D static_cast<char>(0x01);
+                d->extensionData +=3D static_cast<char>(0x05);
             }
             break;

             case UserActivity:
             {
-                d->extensionData +=3D (char)0x99;
-                d->extensionData +=3D (char)0x01;
-                d->extensionData +=3D (char)0x04;
+                d->extensionData +=3D static_cast<char>(0x99);
+                d->extensionData +=3D static_cast<char>(0x01);
+                d->extensionData +=3D static_cast<char>(0x04);
             }
             break;

             case Both:
             {
-                d->extensionData +=3D (char)0x99;
-                d->extensionData +=3D (char)0x02;
-                d->extensionData +=3D (char)0x04;
-                d->extensionData +=3D (char)0x05;
+                d->extensionData +=3D static_cast<char>(0x99);
+                d->extensionData +=3D static_cast<char>(0x02);
+                d->extensionData +=3D static_cast<char>(0x04);
+                d->extensionData +=3D static_cast<char>(0x05);
             }
             break;

             case Cancel:
             {
-                d->extensionData +=3D (char)0x99;
-                d->extensionData +=3D (char)0x00;
+                d->extensionData +=3D static_cast<char>(0x99);
+                d->extensionData +=3D static_cast<char>(0x00);
             }
             break;
         }
@@ -1991,7 +1991,7 @@ void QSimCommand::setEvents( QSimCommand::Event value=
 )
 QSimCommand::BrowserLaunchMode QSimCommand::browserLaunchMode() const
 {
     if ( d->type =3D=3D QSimCommand::LaunchBrowser )
-        return (QSimCommand::BrowserLaunchMode)(d->qualifier);
+        return static_cast<QSimCommand::BrowserLaunchMode>(d->qualifier);
     else
         return IfNotAlreadyLaunched;
 }
@@ -2006,7 +2006,7 @@ QSimCommand::BrowserLaunchMode QSimCommand::browserLa=
unchMode() const
 void QSimCommand::setBrowserLaunchMode( QSimCommand::BrowserLaunchMode val=
ue )
 {
     if ( d->type =3D=3D QSimCommand::LaunchBrowser )
-        setQualifier( (int)value );
+        setQualifier( static_cast<int>(value) );
 }

 /*!
@@ -2362,32 +2362,32 @@ QSimCommand& QSimCommand::operator=3D( const QSimCo=
mmand & value )
 // We also need to export this to qsimterminalresponse.cpp and qsimenvelop=
e.cpp.
 void _qtopiaphone_readBer( const QByteArray& binary, uint& posn, uint& tag=
, uint& length )
 {
-    if ( posn < (uint)binary.size() ) {
-        tag =3D (uint)(binary[posn] & 0xFF);
+    if ( posn < static_cast<uint>(binary.size()) ) {
+        tag =3D static_cast<uint>(binary[posn] & 0xFF);
         ++posn;
     } else {
-        tag =3D (uint)(-1);
+        tag =3D static_cast<uint>(-1);
     }
-    if ( posn < (uint)binary.size() ) {
-        length =3D (uint)(binary[posn] & 0xFF);
+    if ( posn < static_cast<uint>(binary.size()) ) {
+        length =3D static_cast<uint>(binary[posn] & 0xFF);
         ++posn;
         if ( length =3D=3D 0x81 ) {
             // Two-byte length value.
-            if ( posn < (uint)binary.size() ) {
-                length =3D (uint)(binary[posn] & 0xFF);
+            if ( posn < static_cast<uint>(binary.size()) ) {
+                length =3D static_cast<uint>(binary[posn] & 0xFF);
                 ++posn;
             } else {
                 length =3D 0;
             }
         } else if ( length =3D=3D 0x82 ) {
             // Three-byte length value.
-            if ( ( posn + 1 ) < (uint)binary.size() ) {
-                length =3D (((uint)(binary[posn] & 0xFF)) << 8) |
-                         (uint)(binary[posn + 1] & 0xFF);
+            if ( ( posn + 1 ) < static_cast<uint>(binary.size()) ) {
+                length =3D ((static_cast<uint>(binary[posn] & 0xFF)) << 8)=
 |
+                         static_cast<uint>(binary[posn + 1] & 0xFF);
                 posn +=3D 2;
             } else {
                 length =3D 0;
-                posn =3D (uint)binary.size();
+                posn =3D static_cast<uint>(binary.size());
             }
         }
     } else {
@@ -2405,50 +2405,50 @@ QString _qtopiaphone_decodeEFADN( const QByteArray&=
 binary, uint posn, uint leng
     QTextCodec *codec =3D QAtUtils::codec( "gsm" );
     if ( length =3D=3D 0 )
         return QString("");
-    else if ( binary[posn] =3D=3D (char)0x80 ) {
+    else if ( binary[posn] =3D=3D static_cast<char>(0x80) ) {
         // UCS-2 coding.
         ++posn;
         --length;
         while ( length >=3D 2 ) {
-            ch =3D (((uint)((binary[posn]) & 0xFF)) << 8) |
-                  ((uint)(binary[posn + 1] & 0xFF));
+            ch =3D ((static_cast<uint>((binary[posn]) & 0xFF)) << 8) |
+                  (static_cast<uint>(binary[posn + 1] & 0xFF));
             if ( ch !=3D 0xFFFF )
-                temp +=3D (QChar)ch;
+                temp +=3D QChar(ch);
             posn +=3D 2;
             length -=3D 2;
         }
         return temp;
-    } else if ( binary[posn] =3D=3D (char)0x81 ) {
+    } else if ( binary[posn] =3D=3D static_cast<char>(0x81) ) {
         // 8-bit half page index coding.
         if ( length < 3 )
             return QString("");
-        num =3D ((uint)(binary[posn + 1] & 0xFF));
-        page =3D ((uint)(binary[posn + 2] & 0xFF)) << 7;
+        num =3D (static_cast<uint>(binary[posn + 1] & 0xFF));
+        page =3D (static_cast<uint>(binary[posn + 2] & 0xFF)) << 7;
         posn +=3D 3;
         length -=3D 3;
-    } else if ( binary[posn] =3D=3D (char)0x82 ) {
+    } else if ( binary[posn] =3D=3D static_cast<char>(0x82) ) {
         // 16-bit half page index coding.
         if ( length < 4 )
             return QString("");
-        num =3D ((uint)(binary[posn + 1] & 0xFF));
-        page =3D (((uint)(binary[posn + 2] & 0xFF)) << 8) |
-                ((uint)(binary[posn + 3] & 0xFF));
+        num =3D (static_cast<uint>(binary[posn + 1] & 0xFF));
+        page =3D ((static_cast<uint>(binary[posn + 2] & 0xFF)) << 8) |
+                (static_cast<uint>(binary[posn + 3] & 0xFF));
         posn +=3D 4;
         length -=3D 4;
     } else {
         // 7-bit GSM default alphabet coding.
-        while ( length > 0 && binary[posn + length - 1] =3D=3D (char)0xFF =
) {
+        while ( length > 0 && binary[posn + length - 1] =3D=3D static_cast=
<char>(0xFF) ) {
             // Strip 0xFF bytes from the end of the string first.
             --length;
         }
-        return codec->toUnicode( binary.data() + posn, (int)length );
+        return codec->toUnicode( binary.data() + posn, static_cast<int>(le=
ngth) );
     }
     while ( num > 0 && length > 0 ) {
-        ch =3D ((uint)(binary[posn] & 0xFF));
+        ch =3D (static_cast<uint>(binary[posn] & 0xFF));
         if ( ch < 0x80 ) {
-            temp +=3D QGsmCodec::singleToUnicode( (char)ch );
+            temp +=3D QGsmCodec::singleToUnicode( static_cast<char>(ch) );
         } else {
-            temp +=3D (QChar)( page + (ch & 0x7F) );
+            temp +=3D QChar( page + (ch & 0x7F) );
         }
         ++posn;
         --length;
@@ -2466,13 +2466,13 @@ static QString decodeEFADNNumber( const QByteArray&=
 binary,
     QString temp;
     uint ch;
     while ( length > 0 ) {
-        ch =3D ((uint)(binary[posn] & 0xFF));
+        ch =3D (static_cast<uint>(binary[posn] & 0xFF));
         if ( ( ch & 0x0F ) =3D=3D 0x0F )
             break;
-        temp +=3D (QChar)( digits[ch & 0x0F] );
+        temp +=3D QChar( digits[ch & 0x0F] );
         if ( ( ch & 0xF0 ) =3D=3D 0xF0 )
             break;
-        temp +=3D (QChar)( digits[(ch >> 4) & 0x0F] );
+        temp +=3D QChar( digits[(ch >> 4) & 0x0F] );
         ++posn;
         --length;
     }
@@ -2486,17 +2486,17 @@ static void writeEFADNNumber( QByteArray& data, con=
st QString& number, int tag =3D
     QString num =3D QAtUtils::stripNumber( number );
     if ( tag =3D=3D 0xAC ) {
         // DTMF strings don't have a type prefix.
-        data +=3D (char)tag;
-        data +=3D (char)((num.length() + 1) / 2);
+        data +=3D static_cast<char>(tag);
+        data +=3D static_cast<char>((num.length() + 1) / 2);
     } else if ( num.startsWith( QChar('+') ) ) {
         num =3D num.mid(1);
-        data +=3D (char)tag;
-        data +=3D (char)(1 + ((num.length() + 1) / 2));
-        data +=3D (char)145;
+        data +=3D static_cast<char>(tag);
+        data +=3D static_cast<char>(1 + ((num.length() + 1) / 2));
+        data +=3D static_cast<char>(145);
     } else {
-        data +=3D (char)tag;
-        data +=3D (char)(1 + ((num.length() + 1) / 2));
-        data +=3D (char)localTag;
+        data +=3D static_cast<char>(tag);
+        data +=3D static_cast<char>(1 + ((num.length() + 1) / 2));
+        data +=3D static_cast<char>(localTag);
     }
     int byte =3D 0;
     int nibble =3D 0;
@@ -2516,7 +2516,7 @@ static void writeEFADNNumber( QByteArray& data, const=
 QString& number, int tag =3D
             default:            ch =3D 10; break;
         }
         if ( nibble ) {
-            data +=3D (char)(byte | (ch << 4));
+            data +=3D static_cast<char>(byte | (ch << 4));
             nibble =3D 0;
         } else {
             byte =3D ch;
@@ -2524,7 +2524,7 @@ static void writeEFADNNumber( QByteArray& data, const=
 QString& number, int tag =3D
         }
     }
     if ( nibble ) {
-        data +=3D (char)(byte | 0xF0);
+        data +=3D static_cast<char>(byte | 0xF0);
     }
 }

@@ -2535,7 +2535,7 @@ QString _qtopiaphone_decodeCodedString( const QByteAr=
ray& binary, uint posn, uin
     uint ch, byte, bitCount;
     if ( length =3D=3D 0 )
         return QString("");
-    ch =3D (uint)(binary[posn++] & 0x0C);
+    ch =3D static_cast<uint>(binary[posn++] & 0x0C);
     --length;
     if ( ch =3D=3D QSMS_DefaultAlphabet ) {
         ch =3D 0;
@@ -2550,22 +2550,22 @@ QString _qtopiaphone_decodeCodedString( const QByte=
Array& binary, uint posn, uin
                 bitCount++;
                 if ( bitCount =3D=3D 7 ) {
                     bitCount =3D 0;
-                    temp +=3D QGsmCodec::singleToUnicode( (char)ch );
+                    temp +=3D QGsmCodec::singleToUnicode( static_cast<char=
>(ch) );
                     ch =3D 0;
                 }
             }
         }
         if ( bitCount =3D=3D 0 && temp.length() > 0 &&
-             temp[temp.length() - 1] =3D=3D (char)0x0D ) {
+             temp[temp.length() - 1] =3D=3D static_cast<char>(0x0D) ) {
             // CR used as a padding character in the last byte - strip it.
             temp =3D temp.left( temp.length() - 1 );
         }
         return temp;
     } else if ( ch =3D=3D QSMS_UCS2Alphabet ) {
         while ( length >=3D 2 ) {
-            ch =3D (((uint)((binary[posn]) & 0xFF)) << 8) |
-                  ((uint)(binary[posn + 1] & 0xFF));
-            temp +=3D (QChar)ch;
+            ch =3D ((static_cast<uint>((binary[posn]) & 0xFF)) << 8) |
+                  (static_cast<uint>(binary[posn + 1] & 0xFF));
+            temp +=3D QChar(ch);
             posn +=3D 2;
             length -=3D 2;
         }
@@ -2581,7 +2581,7 @@ QString _qtopiaphone_decodeCodedString( const QByteAr=
ray& binary, uint posn, uin
 static QString decodeSubAddress( const QByteArray& pdu, uint posn, uint le=
ngth )
 {
     // Verify that this looks like a BCD-encoded IA5 NSAP subaddress.
-    if ( length < 2 || pdu[posn] !=3D (char)0x80 || pdu[posn + 1] !=3D (ch=
ar)0x50 )
+    if ( length < 2 || pdu[posn] !=3D static_cast<char>(0x80) || pdu[posn =
+ 1] !=3D static_cast<char>(0x50) )
         return QString();
     QString result;
     posn +=3D 2;
@@ -2628,7 +2628,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )

     // Process the contents of the SIM command, tag by tag.
     for (;;) {
-        if ( ( posn + length ) > (uint)pdu.size() ) {
+        if ( ( posn + length ) > static_cast<uint>(pdu.size()) ) {
             break;
         }
         newPosn =3D posn + length;
@@ -2640,7 +2640,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
                 if ( length < 3 )
                     break;
                 sc.setCommandNumber( pdu[posn] & 0xFF );
-                sc.setType( (QSimCommand::Type)(pdu[posn + 1] & 0xFF) );
+                sc.setType( static_cast<QSimCommand::Type>(pdu[posn + 1] &=
 0xFF) );
                 sc.setQualifier( pdu[posn + 2] & 0xFF );
             }
             break;
@@ -2649,8 +2649,8 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
             {
                 // Device identities, GSM 11.14, section 12.7.
                 if ( length >=3D 2 ) {
-                    sc.setSourceDevice( (QSimCommand::Device)( pdu[posn] &=
 0xFF ) );
-                    sc.setDestinationDevice( (QSimCommand::Device)( pdu[po=
sn + 1] & 0xFF ) );
+                    sc.setSourceDevice( static_cast<QSimCommand::Device>( =
pdu[posn] & 0xFF ) );
+                    sc.setDestinationDevice( static_cast<QSimCommand::Devi=
ce>( pdu[posn + 1] & 0xFF ) );
                 }
             }
             break;
@@ -2699,7 +2699,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
                 // SS string for SendSS command, GSM 11.14, section 12.14.
                 if ( length < 1 )
                     break;
-                if ( pdu[posn] =3D=3D (char)145 ) {
+                if ( pdu[posn] =3D=3D static_cast<char>(145) ) {
                     sc.setNumber
                         ( "+" + decodeEFADNNumber
                                     ( pdu, posn + 1, length - 1 ) );
@@ -2760,7 +2760,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
                 // Next action indicator list, GSM 11.14, section 12.24.
                 int index =3D 0;
                 while ( length > 0 && index < items.size() ) {
-                    uint action =3D (uint)(pdu[posn++] & 0xFF);
+                    uint action =3D static_cast<uint>(pdu[posn++] & 0xFF);
                     items[index].setNextAction( action );
                     --length;
                     ++index;
@@ -2772,7 +2772,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
             {
                 // Tone code for a PlayTone command, GSM 11.14, section 12=
.16.
                 if ( length > 0 )
-                    sc.setTone( (QSimCommand::Tone)(pdu[posn] & 0xFF) );
+                    sc.setTone( static_cast<QSimCommand::Tone>(pdu[posn] &=
 0xFF) );
             }
             break;

@@ -2783,7 +2783,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
                     break;      // Zero-length items indicate empty menu.
                 QSimMenuItem item;
                 if ( length > 0 ) {
-                    item.setIdentifier( (uint)(pdu[posn] & 0xFF) );
+                    item.setIdentifier( static_cast<uint>(pdu[posn] & 0xFF=
) );
                     ++posn;
                     --length;
                 }
@@ -2797,7 +2797,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
             {
                 // Default menu item identifier, GSM 11.14, section 12.10.
                 if ( length > 0 )
-                    sc.setDefaultItem( (uint)(pdu[posn] & 0xFF) );
+                    sc.setDefaultItem( static_cast<uint>(pdu[posn] & 0xFF)=
 );
             }
             break;

@@ -2807,10 +2807,10 @@ QSimCommand QSimCommand::fromPdu( const QByteArray&=
 pdu )
                 if ( length >=3D 2 ) {
                     if ( seenIcon ) {
                         sc.setOtherIconSelfExplanatory( (pdu[posn] & 0x01)=
 =3D=3D 0 );
-                        sc.setOtherIconId( (uint)(pdu[posn + 1] & 0xFF) );
+                        sc.setOtherIconId( static_cast<uint>(pdu[posn + 1]=
 & 0xFF) );
                     } else {
                         sc.setIconSelfExplanatory( (pdu[posn] & 0x01) =3D=
=3D 0 );
-                        sc.setIconId( (uint)(pdu[posn + 1] & 0xFF) );
+                        sc.setIconId( static_cast<uint>(pdu[posn + 1] & 0x=
FF) );
                         seenIcon =3D true;
                     }
                 }
@@ -2829,7 +2829,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
                     --length;
                 }
                 while ( length > 0 && index < items.size() ) {
-                    uint iconId =3D (uint)(pdu[posn++] & 0xFF);
+                    uint iconId =3D static_cast<uint>(pdu[posn++] & 0xFF);
                     items[index].setIconId( iconId );
                     items[index].setIconSelfExplanatory( selfExplanatory );
                     --length;
@@ -2849,12 +2849,12 @@ QSimCommand QSimCommand::fromPdu( const QByteArray&=
 pdu )
             {
                 // Timer value.
                 int secs =3D 0;
-                secs +=3D ((unsigned char) pdu[posn + 0] >> 4) * 3600;
-                secs +=3D ((unsigned char) pdu[posn + 0] & 15) * 36000;
-                secs +=3D ((unsigned char) pdu[posn + 1] >> 4) * 60;
-                secs +=3D ((unsigned char) pdu[posn + 1] & 15) * 600;
-                secs +=3D ((unsigned char) pdu[posn + 2] >> 4) * 1;
-                secs +=3D ((unsigned char) pdu[posn + 2] & 15) * 10;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 0]) >> 4)=
 * 3600;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 0]) & 15)=
 * 36000;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 1]) >> 4)=
 * 60;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 1]) & 15)=
 * 600;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 2]) >> 4)=
 * 1;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 2]) & 15)=
 * 10;
                 sc.setDuration( secs * 1000 );
             }
             break;
@@ -2915,7 +2915,7 @@ QSimCommand QSimCommand::fromPdu( const QByteArray& p=
du )
             break;
         }
         posn =3D newPosn;
-        if ( posn >=3D (uint)pdu.size() ) {
+        if ( posn >=3D static_cast<uint>(pdu.size()) ) {
             break;
         }
         readBer( pdu, posn, tag, length );
@@ -2931,16 +2931,16 @@ void _qtopiaphone_writeBerLength( QByteArray& binar=
y, int length )
     int size =3D binary.size();
     if ( length < 128 ) {
         binary.resize( size + 1 );
-        binary[size] =3D (char)length;
+        binary[size] =3D static_cast<char>(length);
     } else if ( length < 256 ) {
         binary.resize( size + 2 );
-        binary[size] =3D (char)0x81;
-        binary[size + 1] =3D (char)length;
+        binary[size] =3D static_cast<char>(0x81);
+        binary[size + 1] =3D static_cast<char>(length);
     } else {
         binary.resize( size + 3 );
-        binary[size] =3D (char)0x82;
-        binary[size + 1] =3D (char)( length >> 8 );
-        binary[size + 2] =3D (char)length;
+        binary[size] =3D static_cast<char>(0x82);
+        binary[size + 1] =3D static_cast<char>( length >> 8 );
+        binary[size + 2] =3D static_cast<char>(length);
     }
 }
 #define writeBerLength _qtopiaphone_writeBerLength
@@ -2953,15 +2953,15 @@ void _qtopiaphone_writeTextString( QByteArray& bina=
ry, const QString& str,
                                    QSimCommand::ToPduOptions options, int =
tag )
 {
     if ( str.isNull() ) {
-        binary +=3D (char)tag;
-        binary +=3D (char)0x00;
+        binary +=3D static_cast<char>(tag);
+        binary +=3D static_cast<char>(0x00);
         return;
     }
     if ( str.isEmpty() && ( options & QSimCommand::EncodeEmptyStrings ) =
=3D=3D 0 ) {
         // Special form for empty strings.
-        binary +=3D (char)tag;
-        binary +=3D (char)0x01;
-        binary +=3D (char)0x00;
+        binary +=3D static_cast<char>(tag);
+        binary +=3D static_cast<char>(0x01);
+        binary +=3D static_cast<char>(0x00);
         return;
     }
     int schemeMask =3D ((tag & 0xFF00) >> 8);     // For USSD string outpu=
t.
@@ -2980,7 +2980,7 @@ void _qtopiaphone_writeTextString( QByteArray& binary=
, const QString& str,
                         for ( int i =3D 0; i < 7; i++ ) {
                             if ( bitCount =3D=3D 8 ) {
                                 bitCount =3D 0;
-                                packed +=3D (char)bits;
+                                packed +=3D static_cast<char>(bits);
                                 bits =3D 0;
                             }
                             if ( ((1 << (i+8)) & c) !=3D 0 )
@@ -2991,7 +2991,7 @@ void _qtopiaphone_writeTextString( QByteArray& binary=
, const QString& str,
                     for ( int i =3D 0; i < 7; i++ ) {
                         if ( bitCount =3D=3D 8 ) {
                             bitCount =3D 0;
-                            packed +=3D (char)bits;
+                            packed +=3D static_cast<char>(bits);
                             bits =3D 0;
                         }
                         if ( ((1 << i) & c) !=3D 0 )
@@ -3000,18 +3000,18 @@ void _qtopiaphone_writeTextString( QByteArray& bina=
ry, const QString& str,
                     }
                 }
                 if ( bitCount !=3D 0 ) {
-                    packed +=3D (char)bits;
+                    packed +=3D static_cast<char>(bits);
                 }
-                binary +=3D (char)tag;
+                binary +=3D static_cast<char>(tag);
                 writeBerLength( binary, packed.length() + 1 );
-                binary +=3D (char)(QSMS_DefaultAlphabet | schemeMask);
+                binary +=3D static_cast<char>(QSMS_DefaultAlphabet | schem=
eMask);
                 binary +=3D packed;
             } else {
                 // Use the unpacked 8-bit GSM alphabet to encode the strin=
g.
                 QByteArray unpacked =3D gsm->fromUnicode( str );
-                binary +=3D (char)tag;
+                binary +=3D static_cast<char>(tag);
                 writeBerLength( binary, unpacked.length() + 1 );
-                binary +=3D (char)(QSMS_8BitAlphabet | schemeMask);
+                binary +=3D static_cast<char>(QSMS_8BitAlphabet | schemeMa=
sk);
                 binary +=3D unpacked;
             }
             return;
@@ -3024,12 +3024,12 @@ void _qtopiaphone_writeTextString( QByteArray& bina=
ry, const QString& str,
     int len =3D str.length();
     while ( len-- > 0 ) {
         ushort ch =3D *data++;
-        ucs2 +=3D (char)(ch >> 8);
-        ucs2 +=3D (char)ch;
+        ucs2 +=3D static_cast<char>(ch >> 8);
+        ucs2 +=3D static_cast<char>(ch);
     }
-    binary +=3D (char)tag;
+    binary +=3D static_cast<char>(tag);
     writeBerLength( binary, ucs2.length() + 1 );
-    binary +=3D (char)(QSMS_UCS2Alphabet | schemeMask);
+    binary +=3D static_cast<char>(QSMS_UCS2Alphabet | schemeMask);
     binary +=3D ucs2;
 }
 #define writeTextString _qtopiaphone_writeTextString
@@ -3047,7 +3047,7 @@ void _qtopiaphone_writeEFADN( QByteArray& binary, con=
st QString& str,
         if ( gsm->canEncode( str ) ) {
             QByteArray unpacked =3D gsm->fromUnicode( str );
             if ( tag !=3D -1 ) {
-                binary +=3D (char)tag;
+                binary +=3D static_cast<char>(tag);
                 writeBerLength( binary, unpacked.length() );
             }
             binary +=3D unpacked;
@@ -3061,14 +3061,14 @@ void _qtopiaphone_writeEFADN( QByteArray& binary, c=
onst QString& str,
     int len =3D str.length();
     while ( len-- > 0 ) {
         ushort ch =3D *data++;
-        ucs2 +=3D (char)(ch >> 8);
-        ucs2 +=3D (char)ch;
+        ucs2 +=3D static_cast<char>(ch >> 8);
+        ucs2 +=3D static_cast<char>(ch);
     }
     if ( tag !=3D -1 ) {
-        binary +=3D (char)tag;
+        binary +=3D static_cast<char>(tag);
         writeBerLength( binary, ucs2.length() + 1 );
     }
-    binary +=3D (char)0x80;
+    binary +=3D static_cast<char>(0x80);
     binary +=3D ucs2;
 }
 #define writeEFADN _qtopiaphone_writeEFADN
@@ -3077,10 +3077,10 @@ void _qtopiaphone_writeEFADN( QByteArray& binary, c=
onst QString& str,
 static void writeIcon( QByteArray& binary, uint iconId, bool selfExplanato=
ry, bool mandatory )
 {
     if ( iconId ) {
-        binary +=3D (char)( mandatory ? 0x9E : 0x1E );
-        binary +=3D (char)0x02;
-        binary +=3D (char)( selfExplanatory ? 0 : 1 );
-        binary +=3D (char)iconId;
+        binary +=3D static_cast<char>( mandatory ? 0x9E : 0x1E );
+        binary +=3D static_cast<char>(0x02);
+        binary +=3D static_cast<char>( selfExplanatory ? 0 : 1 );
+        binary +=3D static_cast<char>(iconId);
     }
 }

@@ -3088,24 +3088,24 @@ static void writeIcon( QByteArray& binary, uint ico=
nId, bool selfExplanatory, bo
 void _qtopiaphone_writeDuration( QByteArray& data, uint time )
 {
     if ( time !=3D 0 ) {
-        data +=3D (char)0x84;
-        data +=3D (char)0x02;
+        data +=3D static_cast<char>(0x84);
+        data +=3D static_cast<char>(0x02);
         if ( ( time % 1000 ) !=3D 0 && time <=3D 25500 ) {
             // Encode in tenths of a second.
-            data +=3D (char)0x02;
-            data +=3D (char)(time / 100);
+            data +=3D static_cast<char>(0x02);
+            data +=3D static_cast<char>(time / 100);
         } else if ( ( time % 60000 ) !=3D 0 && time <=3D 255000 ) {
             // Encode in seconds.
-            data +=3D (char)0x01;
-            data +=3D (char)(time / 1000);
+            data +=3D static_cast<char>(0x01);
+            data +=3D static_cast<char>(time / 1000);
         } else if ( time <=3D 255 * 6000 ) {
             // Encode in minutes.
-            data +=3D (char)0x00;
-            data +=3D (char)(time / 60000);
+            data +=3D static_cast<char>(0x00);
+            data +=3D static_cast<char>(time / 60000);
         } else {
             // Encode maximum time value.
-            data +=3D (char)0x00;
-            data +=3D (char)0xFF;
+            data +=3D static_cast<char>(0x00);
+            data +=3D static_cast<char>(0xFF);
         }
     }
 }
@@ -3115,15 +3115,15 @@ void _qtopiaphone_writeDuration( QByteArray& data, =
uint time )
 // is specified in GSM 24.008, Annex E.
 static void writeSubAddress( QByteArray& data, const QString& value )
 {
-    data +=3D (char)0x88;
+    data +=3D static_cast<char>(0x88);
     writeBerLength( data, value.length() + 2 );
-    data +=3D (char)0x80;     // NSAP address type
-    data +=3D (char)0x50;     // NSAP address is BCD-encoded IA5 characters
+    data +=3D static_cast<char>(0x80);     // NSAP address type
+    data +=3D static_cast<char>(0x50);     // NSAP address is BCD-encoded =
IA5 characters
     for ( const QChar &ch : value ) {
         int val =3D ch.unicode() - 32;
         if ( val > 127 )
             val =3D 0;
-        data +=3D (char)(((val / 10) << 4) + (val % 10));
+        data +=3D static_cast<char>(((val / 10) << 4) + (val % 10));
     }
 }

@@ -3135,10 +3135,10 @@ bool _qtopiaphone_extractAndWriteExtField( QByteArr=
ay& data, QByteArray& extData
     uint startposn;
     uint posn =3D 0;
     uint currentTag, length;
-    while ( posn < (uint)( extData.length() ) ) {
+    while ( posn < static_cast<uint>( extData.length() ) ) {
         startposn =3D posn;
         readBer( extData, posn, currentTag, length );
-        if ( ( currentTag & 0x7F ) =3D=3D (uint)( tag & 0x7F ) ) {
+        if ( ( currentTag & 0x7F ) =3D=3D static_cast<uint>( tag & 0x7F ) =
) {
             data +=3D extData.mid( startposn, (posn + length) - startposn =
);
             extData =3D extData.left( startposn ) + extData.mid( posn + le=
ngth );
             return true;
@@ -3153,7 +3153,7 @@ bool _qtopiaphone_extractAndWriteExtField( QByteArray=
& data, QByteArray& extData
 static void writeTextAttribute( QByteArray& data, const QByteArray& attr )
 {
     if ( !attr.isEmpty() ) {
-        data +=3D (char)0xD0;
+        data +=3D static_cast<char>(0xD0);
         writeBerLength( data, attr.length() );
         data +=3D attr;
     }
@@ -3164,7 +3164,7 @@ void _qtopiaphone_writeTimerId( QByteArray& data, uin=
t timerId )
 {
     data +=3D 0xa4;
     data +=3D 0x01;
-    data +=3D (char) timerId;
+    data +=3D static_cast<char>(timerId);
 }
 #define writeTimerId _qtopiaphone_writeTimerId

@@ -3188,7 +3188,7 @@ void _qtopiaphone_writeTimerValue( QByteArray& data, =
uint value )
 static void writeBearerDesc( QByteArray& data, const QByteArray& bearerDes=
c )
 {
     if ( !bearerDesc.isEmpty() ) {
-        data +=3D (char)0x35;
+        data +=3D static_cast<char>(0x35);
         writeBerLength( data, bearerDesc.length() );
         data +=3D bearerDesc;
     }
@@ -3198,7 +3198,7 @@ static void writeBearerDesc( QByteArray& data, const =
QByteArray& bearerDesc )
 static void writeApn( QByteArray& data, const QByteArray& apn )
 {
     if ( !apn.isEmpty() ) {
-        data +=3D (char)0x47;
+        data +=3D static_cast<char>(0x47);
         writeBerLength( data, apn.length() );
         data +=3D apn;
     }
@@ -3210,8 +3210,8 @@ static void writeBufferSize( QByteArray& data, ushort=
 size )
     if ( size ) {
         data +=3D 0x39;
         data +=3D 0x02;
-        data +=3D (char)(size >> 8);
-        data +=3D (char)size;
+        data +=3D static_cast<char>(size >> 8);
+        data +=3D static_cast<char>(size);
     }
 }

@@ -3220,14 +3220,14 @@ static void writeDataLength( QByteArray& data, uint=
 value )
 {
     data +=3D 0x37;
     data +=3D 0x01;
-    data +=3D (char)value;
+    data +=3D static_cast<char>(value);
 }

 // Write a UICC/terminal interface transport level field
 static void writeUti( QByteArray& data, const QByteArray& uti )
 {
     if ( !uti.isEmpty() ) {
-        data +=3D (char)0x3C;
+        data +=3D static_cast<char>(0x3C);
         writeBerLength( data, uti.length() );
         data +=3D uti;
     }
@@ -3237,7 +3237,7 @@ static void writeUti( QByteArray& data, const QByteAr=
ray& uti )
 static void writeOtherAddress( QByteArray& data, const QByteArray& otherAd=
dress )
 {
     if ( !otherAddress.isEmpty() ) {
-        data +=3D (char)0x3E;
+        data +=3D static_cast<char>(0x3E);
         writeBerLength( data, otherAddress.length() );
         data +=3D otherAddress;
     }
@@ -3278,21 +3278,21 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
         // Make sure the "wantDigits" bit is unset if using Yes/No.
         qualifier &=3D ~0x01;
     }
-    data +=3D (char)0x81;
-    data +=3D (char)0x03;
-    data +=3D (char)commandNumber();
-    data +=3D (char)cmd;
-    data +=3D (char)qualifier;
+    data +=3D static_cast<char>(0x81);
+    data +=3D static_cast<char>(0x03);
+    data +=3D static_cast<char>(commandNumber());
+    data +=3D static_cast<char>(cmd);
+    data +=3D static_cast<char>(qualifier);

     // Output the device identities (SIM to Display/Keypad/Earpiece/etc).
-    data +=3D (char)0x82;
-    data +=3D (char)0x02;
-    data +=3D (char)sourceDevice();
-    data +=3D (char)destinationDevice();
+    data +=3D static_cast<char>(0x82);
+    data +=3D static_cast<char>(0x02);
+    data +=3D static_cast<char>(sourceDevice());
+    data +=3D static_cast<char>(destinationDevice());

     // If user feedback suppression is on, then encode empty strings.
     if ( suppressUserFeedback() )
-        options =3D (QSimCommand::ToPduOptions)( options | EncodeEmptyStri=
ngs );
+        options =3D static_cast<QSimCommand::ToPduOptions>( options | Enco=
deEmptyStrings );

     // Add the command parameters.
     QByteArray extData =3D extensionData();
@@ -3302,8 +3302,8 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
             writeTextString( data, text(), options );
             writeIcon( data, iconId(), iconSelfExplanatory(), true );
             if ( immediateResponse() ) {
-                data +=3D (char)0xAB;
-                data +=3D (char)0x00;
+                data +=3D static_cast<char>(0xAB);
+                data +=3D static_cast<char>(0x00);
             }
             writeTextAttribute( data, textAttribute() );
         }
@@ -3321,10 +3321,10 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
         {
             writeTextString( data, text(), options );
             if ( minimumLength() !=3D 0 || maximumLength() !=3D 255 ) {
-                data +=3D (char)0x91;
-                data +=3D (char)0x02;
-                data +=3D (char)minimumLength();
-                data +=3D (char)maximumLength();
+                data +=3D static_cast<char>(0x91);
+                data +=3D static_cast<char>(0x02);
+                data +=3D static_cast<char>(minimumLength());
+                data +=3D static_cast<char>(maximumLength());
             }
             if ( !defaultText().isEmpty() ) {
                 writeTextString( data, defaultText(), QSimCommand::NoPduOp=
tions, 0x17 );
@@ -3339,9 +3339,9 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
             if ( !text().isEmpty() )
                 writeEFADN( data, text(), options );
             if ( tone() !=3D ToneNone ) {
-                data +=3D (char)0x8E;
-                data +=3D (char)0x01;
-                data +=3D (char)tone();
+                data +=3D static_cast<char>(0x8E);
+                data +=3D static_cast<char>(0x01);
+                data +=3D static_cast<char>(tone());
             }
             writeDuration( data, duration() );
             writeIcon( data, iconId(), iconSelfExplanatory(), false );
@@ -3365,14 +3365,14 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
             bool hasNextActions =3D false;
             bool selfExplanatory =3D false;
             if ( menuItems().size() =3D=3D 0 ) {
-                data +=3D (char)0x8F;
-                data +=3D (char)0x00;
+                data +=3D static_cast<char>(0x8F);
+                data +=3D static_cast<char>(0x00);
             }
             for ( QSimMenuItem &item : menuItems() ) {
                 QByteArray contents;
-                contents +=3D (char)item.identifier();
+                contents +=3D static_cast<char>(item.identifier());
                 writeEFADN( contents, item.label(), options, -1 );
-                data +=3D (char)0x8F;
+                data +=3D static_cast<char>(0x8F);
                 writeBerLength( data, contents.size() );
                 data +=3D contents;
                 if ( item.iconId() !=3D 0 )
@@ -3384,27 +3384,27 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
                 attrLen +=3D item.labelAttribute().size();
             }
             if ( hasNextActions ) {
-                data +=3D (char)0x18;
-                data +=3D (char)menuItems().size();
+                data +=3D static_cast<char>(0x18);
+                data +=3D static_cast<char>(menuItems().size());
                 for ( const QSimMenuItem &item : menuItems() )
-                    data +=3D (char)item.nextAction();
+                    data +=3D static_cast<char>(item.nextAction());
             }
             if ( type() =3D=3D SelectItem && defaultItem() !=3D 0 ) {
-                data +=3D (char)0x90;
-                data +=3D (char)0x01;
-                data +=3D (char)defaultItem();
+                data +=3D static_cast<char>(0x90);
+                data +=3D static_cast<char>(0x01);
+                data +=3D static_cast<char>(defaultItem());
             }
             writeIcon( data, iconId(), iconSelfExplanatory(), true );
             if ( hasIcons ) {
-                data +=3D (char)0x9F;
-                data +=3D (char)(menuItems().size() + 1);
-                data +=3D (char)(selfExplanatory ? 0x00 : 0x01);
+                data +=3D static_cast<char>(0x9F);
+                data +=3D static_cast<char>(menuItems().size() + 1);
+                data +=3D static_cast<char>(selfExplanatory ? 0x00 : 0x01);
                 for ( const QSimMenuItem &item : menuItems() )
-                    data +=3D (char)item.iconId();
+                    data +=3D static_cast<char>(item.iconId());
             }
             writeTextAttribute( data, titleAttribute() );
             if ( attrLen !=3D 0 ) {
-                data +=3D (char)0xD1;
+                data +=3D static_cast<char>(0xD1);
                 writeBerLength( data, attrLen );
                 for ( QSimMenuItem &item : menuItems() ) {
                     data +=3D item.labelAttribute();
@@ -3615,8 +3615,8 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
             extractAndWriteExtField( data, extData, 0x92 ); // MMS submiss=
ion file
             extractAndWriteExtField( data, extData, 0xEB ); // Message ide=
ntifier
             if ( immediateResponse() ) {
-                data +=3D (char)0xAB;
-                data +=3D (char)0x00;
+                data +=3D static_cast<char>(0xAB);
+                data +=3D static_cast<char>(0x00);
             }
         }
         break;
@@ -3624,8 +3624,8 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
         case LanguageNotification:
         {
             if ( !language().isEmpty() && language().length() =3D=3D 2 ) {
-                data +=3D (char)0xAD;
-                data +=3D (char)0x02;
+                data +=3D static_cast<char>(0xAD);
+                data +=3D static_cast<char>(0x02);
                 data +=3D language();
             }
         }
@@ -3640,7 +3640,7 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
     // Add the "Proactive SIM" BER command wrapper if required.
     if ( ( options & NoBerWrapper ) =3D=3D 0 ) {
         QByteArray ber;
-        ber +=3D (char)0xD0;
+        ber +=3D static_cast<char>(0xD0);
         writeBerLength( ber, data.size() );
         ber +=3D data;
         return ber;
@@ -3736,9 +3736,9 @@ QByteArray QSimCommand::extensionField( int tag ) con=
st
 {
     uint posn =3D 0;
     uint currentTag, length;
-    while ( posn < (uint)( d->extensionData.length() ) ) {
+    while ( posn < static_cast<uint>( d->extensionData.length() ) ) {
         readBer( d->extensionData, posn, currentTag, length );
-        if ( ( currentTag & 0x7F ) =3D=3D (uint)( tag & 0x7F ) )
+        if ( ( currentTag & 0x7F ) =3D=3D static_cast<uint>( tag & 0x7F ) )
             return d->extensionData.mid( posn, length );
         posn +=3D length;
     }
@@ -3755,7 +3755,7 @@ QByteArray QSimCommand::extensionField( int tag ) con=
st
 */
 void QSimCommand::addExtensionField( int tag, const QByteArray& value )
 {
-    d->extensionData +=3D (char)tag;
+    d->extensionData +=3D static_cast<char>(tag);
     writeBerLength( d->extensionData, value.size() );
     d->extensionData +=3D value;
 }
diff --git a/src/qsimcontrolevent.cpp b/src/qsimcontrolevent.cpp
index 4502d78..8b41890 100644
--- a/src/qsimcontrolevent.cpp
+++ b/src/qsimcontrolevent.cpp
@@ -226,9 +226,9 @@ QByteArray QSimControlEvent::extensionField( int tag ) =
const
 {
     uint posn =3D 0;
     uint currentTag, length;
-    while ( posn < (uint)( d->extensionData.length() ) ) {
+    while ( posn < static_cast<uint>( d->extensionData.length() ) ) {
         readBer( d->extensionData, posn, currentTag, length );
-        if ( ( currentTag & 0x7F ) =3D=3D (uint)( tag & 0x7F ) )
+        if ( ( currentTag & 0x7F ) =3D=3D static_cast<uint>( tag & 0x7F ) )
             return d->extensionData.mid( posn, length );
         posn +=3D length;
     }
@@ -243,7 +243,7 @@ QByteArray QSimControlEvent::extensionField( int tag ) =
const
 */
 void QSimControlEvent::addExtensionField( int tag, const QByteArray& value=
 )
 {
-    d->extensionData +=3D (char)tag;
+    d->extensionData +=3D static_cast<char>(tag);
     writeBerLength( d->extensionData, value.size() );
     d->extensionData +=3D value;
 }
@@ -269,14 +269,14 @@ QSimControlEvent QSimControlEvent::fromPdu
         return ev;
     }
     readBer( pdu, posn, tag, length );
-    ev.setResult( (QSimControlEvent::Result)tag );
+    ev.setResult( static_cast<QSimControlEvent::Result>(tag) );
     content =3D pdu.mid( posn, length );
     posn =3D 0;
-    if ( posn >=3D (uint)content.size() )
+    if ( posn >=3D static_cast<uint>(content.size()) )
         return ev;
     readBer( content, posn, tag, length );
     for (;;) {
-        if ( ( posn + length ) > (uint)content.size() )
+        if ( ( posn + length ) > static_cast<uint>(content.size()) )
             break;
         newPosn =3D posn + length;
         switch ( tag & 0x7F ) {
@@ -296,7 +296,7 @@ QSimControlEvent QSimControlEvent::fromPdu
             break;
         }
         posn =3D newPosn;
-        if ( posn >=3D (uint)content.size() )
+        if ( posn >=3D static_cast<uint>(content.size()) )
             break;
         readBer( content, posn, tag, length );
     }
@@ -335,7 +335,7 @@ QByteArray QSimControlEvent::toPdu() const

     // Add the outermost tag layer and return.
     QByteArray outer;
-    outer +=3D (char)result();
+    outer +=3D static_cast<char>(result());
     writeBerLength( outer, data.size() );
     outer +=3D data;
     return outer;
diff --git a/src/qsimenvelope.cpp b/src/qsimenvelope.cpp
index 3942dad..a9f6bb7 100644
--- a/src/qsimenvelope.cpp
+++ b/src/qsimenvelope.cpp
@@ -324,9 +324,9 @@ QByteArray QSimEnvelope::extensionField( int tag ) const
 {
     uint posn =3D 0;
     uint currentTag, length;
-    while ( posn < (uint)( d->extensionData.length() ) ) {
+    while ( posn < static_cast<uint>( d->extensionData.length() ) ) {
         readBer( d->extensionData, posn, currentTag, length );
-        if ( ( currentTag & 0x7F ) =3D=3D (uint)( tag & 0x7F ) )
+        if ( ( currentTag & 0x7F ) =3D=3D static_cast<uint>( tag & 0x7F ) )
             return d->extensionData.mid( posn, length );
         posn +=3D length;
     }
@@ -341,7 +341,7 @@ QByteArray QSimEnvelope::extensionField( int tag ) const
 */
 void QSimEnvelope::addExtensionField( int tag, const QByteArray& value )
 {
-    d->extensionData +=3D (char)tag;
+    d->extensionData +=3D static_cast<char>(tag);
     writeBerLength( d->extensionData, value.size() );
     d->extensionData +=3D value;
 }
@@ -364,12 +364,12 @@ QSimEnvelope QSimEnvelope::fromPdu( const QByteArray&=
 pdu )
         // Doesn't appear to be a valid ENVELOPE.
         return env;
     }
-    env.setType( (QSimEnvelope::Type)tag );
+    env.setType( static_cast<QSimEnvelope::Type>(tag) );
     content =3D pdu.mid( posn, length );
     posn =3D 0;
     readBer( content, posn, tag, length );
     for (;;) {
-        if ( ( posn + length ) > (uint)content.size() )
+        if ( ( posn + length ) > static_cast<uint>(content.size()) )
             break;
         newPosn =3D posn + length;
         switch ( tag & 0x7F ) {
@@ -379,9 +379,9 @@ QSimEnvelope QSimEnvelope::fromPdu( const QByteArray& p=
du )
                 // Device identities, GSM 11.14, section 12.7.
                 if ( length >=3D 2 ) {
                     env.setSourceDevice
-                        ( (QSimCommand::Device)( content[posn] & 0xFF ) );
+                        ( static_cast<QSimCommand::Device>( content[posn] =
& 0xFF ) );
                     env.setDestinationDevice
-                        ( (QSimCommand::Device)( content[posn + 1] & 0xFF =
) );
+                        ( static_cast<QSimCommand::Device>( content[posn +=
 1] & 0xFF ) );
                 }
             }
             break;
@@ -390,7 +390,7 @@ QSimEnvelope QSimEnvelope::fromPdu( const QByteArray& p=
du )
             {
                 // Menu item identifier, GSM 11.14, section 12.10.
                 if ( length > 0 )
-                    env.setMenuItem( (uint)(content[posn] & 0xFF) );
+                    env.setMenuItem( static_cast<uint>(content[posn] & 0xF=
F) );
             }
             break;

@@ -405,7 +405,7 @@ QSimEnvelope QSimEnvelope::fromPdu( const QByteArray& p=
du )
             {
                 // Event list, GSM 11.14, section 12.25.
                 if ( length > 0 )
-                    env.setEvent( (QSimEnvelope::Event)( content[posn] & 0=
xFF ) );
+                    env.setEvent( static_cast<QSimEnvelope::Event>( conten=
t[posn] & 0xFF ) );
             }
             break;

@@ -417,7 +417,7 @@ QSimEnvelope QSimEnvelope::fromPdu( const QByteArray& p=
du )
             break;
         }
         posn =3D newPosn;
-        if ( posn >=3D (uint)content.size() )
+        if ( posn >=3D static_cast<uint>(content.size()) )
             break;
         readBer( content, posn, tag, length );
     }
@@ -435,33 +435,33 @@ QByteArray QSimEnvelope::toPdu() const

     // Output the event list before the device identities.
     if ( d->type =3D=3D QSimEnvelope::EventDownload ) {
-        data +=3D (char)0x99;
-        data +=3D (char)0x01;
-        data +=3D (char)(d->event);
+        data +=3D static_cast<char>(0x99);
+        data +=3D static_cast<char>(0x01);
+        data +=3D static_cast<char>(d->event);
     }

     // Add the device identity section (ME/Keypad/... to SIM).
     // According to 3GPP TS 51.010-4, the tag should be 0x02 for
     // MO-SMS control by SIM.
     if ( d->type =3D=3D QSimEnvelope::MOSMSControl )
-        data +=3D (char)0x02;
+        data +=3D static_cast<char>(0x02);
     else
-        data +=3D (char)0x82;
-    data +=3D (char)0x02;
-    data +=3D (char)sourceDevice();
-    data +=3D (char)destinationDevice();
+        data +=3D static_cast<char>(0x82);
+    data +=3D static_cast<char>(0x02);
+    data +=3D static_cast<char>(sourceDevice());
+    data +=3D static_cast<char>(destinationDevice());

     // Add parameters specific to this type of envelope.
     switch ( type() ) {

         case MenuSelection:
         {
-            data +=3D (char)0x90;
-            data +=3D (char)0x01;
-            data +=3D (char)menuItem();
+            data +=3D static_cast<char>(0x90);
+            data +=3D static_cast<char>(0x01);
+            data +=3D static_cast<char>(menuItem());
             if ( requestHelp() ) {
-                data +=3D (char)0x15;
-                data +=3D (char)0x00;
+                data +=3D static_cast<char>(0x15);
+                data +=3D static_cast<char>(0x00);
             }
         }
         break;
@@ -475,7 +475,7 @@ QByteArray QSimEnvelope::toPdu() const

     // Add the outermost envelope tag layer and return.
     QByteArray env;
-    env +=3D (char)type();
+    env +=3D static_cast<char>(type());
     writeBerLength( env, data.size() );
     env +=3D data;
     return env;
diff --git a/src/qsimterminalresponse.cpp b/src/qsimterminalresponse.cpp
index bd600dd..cb78bfb 100644
--- a/src/qsimterminalresponse.cpp
+++ b/src/qsimterminalresponse.cpp
@@ -316,7 +316,7 @@ QSimTerminalResponse::Cause QSimTerminalResponse::cause=
() const
     if ( d->causeData.isEmpty() )
         return NoSpecificCause;
     else
-        return (QSimTerminalResponse::Cause)(d->causeData[0] & 0xFF);
+        return static_cast<QSimTerminalResponse::Cause>(d->causeData[0] & =
0xFF);
 }

 /*!
@@ -328,7 +328,7 @@ QSimTerminalResponse::Cause QSimTerminalResponse::cause=
() const
 */
 void QSimTerminalResponse::setCause( QSimTerminalResponse::Cause value )
 {
-    d->causeData =3D QByteArray(1, (char)value);
+    d->causeData =3D QByteArray(1, static_cast<char>(value));
 }

 /*!
@@ -539,9 +539,9 @@ QByteArray QSimTerminalResponse::extensionField( int ta=
g ) const
 {
     uint posn =3D 0;
     uint currentTag, length;
-    while ( posn < (uint)( d->extensionData.length() ) ) {
+    while ( posn < static_cast<uint>( d->extensionData.length() ) ) {
         readBer( d->extensionData, posn, currentTag, length );
-        if ( ( currentTag & 0x7F ) =3D=3D (uint)( tag & 0x7F ) )
+        if ( ( currentTag & 0x7F ) =3D=3D static_cast<uint>( tag & 0x7F ) )
             return d->extensionData.mid( posn, length );
         posn +=3D length;
     }
@@ -556,7 +556,7 @@ QByteArray QSimTerminalResponse::extensionField( int ta=
g ) const
 */
 void QSimTerminalResponse::addExtensionField( int tag, const QByteArray& v=
alue )
 {
-    d->extensionData +=3D (char)tag;
+    d->extensionData +=3D static_cast<char>(tag);
     writeBerLength( d->extensionData, value.size() );
     d->extensionData +=3D value;
 }
@@ -580,7 +580,7 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( con=
st QByteArray& pdu )
         return resp;
     }
     for (;;) {
-        if ( ( posn + length ) > (uint)pdu.size() )
+        if ( ( posn + length ) > static_cast<uint>(pdu.size()) )
             break;
         newPosn =3D posn + length;
         switch ( tag & 0x7F ) {
@@ -596,8 +596,8 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( con=
st QByteArray& pdu )
             {
                 // Device identities, GSM 11.14, section 12.7.
                 if ( length >=3D 2 ) {
-                    resp.setSourceDevice( (QSimCommand::Device)( pdu[posn]=
 & 0xFF ) );
-                    resp.setDestinationDevice( (QSimCommand::Device)( pdu[=
posn + 1] & 0xFF ) );
+                    resp.setSourceDevice( static_cast<QSimCommand::Device>=
( pdu[posn] & 0xFF ) );
+                    resp.setDestinationDevice( static_cast<QSimCommand::De=
vice>( pdu[posn + 1] & 0xFF ) );
                 }
             }
             break;
@@ -607,7 +607,7 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( con=
st QByteArray& pdu )
                 // Result information.
                 if ( length < 1 )
                     break;
-                resp.setResult( (QSimTerminalResponse::Result)(pdu[posn] &=
 0xFF) );
+                resp.setResult( static_cast<QSimTerminalResponse::Result>(=
pdu[posn] & 0xFF) );
                 resp.setCauseData( pdu.mid( posn + 1, length - 1 ) );
             }
             break;
@@ -629,10 +629,10 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( c=
onst QByteArray& pdu )
             case 0x0D:
             {
                 // Text string for terminal response, GSM 11.14, section 1=
2.15.
-                if ( pdu.length() >=3D 5 && pdu[3] =3D=3D (int)QSimCommand=
::GetInkey &&
+                if ( pdu.length() >=3D 5 && pdu[3] =3D=3D static_cast<int>=
(QSimCommand::GetInkey) &&
                      (pdu[4] & 0x04) !=3D 0 ) {
                     // Processing Yes/No responses: convert 0x01/0x00 into=
 Yes/No.
-                    if ( length >=3D 2 && pdu[posn + 1] !=3D (char)0x00 )
+                    if ( length >=3D 2 && pdu[posn + 1] !=3D static_cast<c=
har>(0x00) )
                         resp.setText( "Yes" );    // No tr
                     else
                         resp.setText( "No" );     // No tr
@@ -648,7 +648,7 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( con=
st QByteArray& pdu )
             {
                 // Menu item identifier, GSM 11.14, section 12.10.
                 if ( length > 0 )
-                    resp.setMenuItem( (uint)(pdu[posn] & 0xFF) );
+                    resp.setMenuItem( static_cast<uint>(pdu[posn] & 0xFF) =
);
             }
             break;

@@ -663,12 +663,12 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( c=
onst QByteArray& pdu )
             {
                 // Timer value.
                 int secs =3D 0;
-                secs +=3D ((unsigned char) pdu[posn + 0] >> 4) * 3600;
-                secs +=3D ((unsigned char) pdu[posn + 0] & 15) * 36000;
-                secs +=3D ((unsigned char) pdu[posn + 1] >> 4) * 60;
-                secs +=3D ((unsigned char) pdu[posn + 1] & 15) * 600;
-                secs +=3D ((unsigned char) pdu[posn + 2] >> 4) * 1;
-                secs +=3D ((unsigned char) pdu[posn + 2] & 15) * 10;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 0]) >> 4)=
 * 3600;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 0]) & 15)=
 * 36000;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 1]) >> 4)=
 * 60;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 1]) & 15)=
 * 600;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 2]) >> 4)=
 * 1;
+                secs +=3D (static_cast<unsigned char>(pdu[posn + 2]) & 15)=
 * 10;
                 resp.setDuration( secs * 1000 );
             }
             break;
@@ -681,7 +681,7 @@ QSimTerminalResponse QSimTerminalResponse::fromPdu( con=
st QByteArray& pdu )
             break;
         }
         posn =3D newPosn;
-        if ( posn >=3D (uint)pdu.size() )
+        if ( posn >=3D static_cast<uint>(pdu.size()) )
             break;
         startPosn =3D newPosn;
         readBer( pdu, posn, tag, length );
@@ -722,37 +722,37 @@ QByteArray QSimTerminalResponse::toPdu() const
         }
     } else {
         // Could not find the command details, so output default details.
-        data +=3D (char)0x81;
-        data +=3D (char)0x03;
-        data +=3D (char)0x00;
-        data +=3D (char)0x00;
-        data +=3D (char)0x00;
+        data +=3D static_cast<char>(0x81);
+        data +=3D static_cast<char>(0x03);
+        data +=3D static_cast<char>(0x00);
+        data +=3D static_cast<char>(0x00);
+        data +=3D static_cast<char>(0x00);
         tag =3D 0;
         qual =3D 0;
     }

     // Add the device identity section (ME to SIM).
-    data +=3D (char)0x82;
-    data +=3D (char)0x02;
-    data +=3D (char)sourceDevice();
-    data +=3D (char)destinationDevice();
+    data +=3D static_cast<char>(0x82);
+    data +=3D static_cast<char>(0x02);
+    data +=3D static_cast<char>(sourceDevice());
+    data +=3D static_cast<char>(destinationDevice());

     // Add the result details.
-    switch ( (QSimCommand::Type)tag ) {
+    switch ( static_cast<QSimCommand::Type>(tag) ) {
         case QSimCommand::SendSS:
             if ( d->result =3D=3D DataNotUnderstood )
-                data +=3D (char)0x83;
+                data +=3D static_cast<char>(0x83);
             else
-                data +=3D (char)0x03;
+                data +=3D static_cast<char>(0x03);
             break;
-        default:                        data +=3D (char)0x83; break;
+        default:                        data +=3D static_cast<char>(0x83);=
 break;
     }
-    data +=3D (char)(d->causeData.length() + 1);
-    data +=3D (char)(d->result);
+    data +=3D static_cast<char>(d->causeData.length() + 1);
+    data +=3D static_cast<char>(d->result);
     data +=3D d->causeData;

     // Add other information for specific command response types.
-    switch ( (QSimCommand::Type)tag ) {
+    switch ( static_cast<QSimCommand::Type>(tag) ) {

         case QSimCommand::GetInkey:
         {
@@ -761,15 +761,15 @@ QByteArray QSimTerminalResponse::toPdu() const
             if ( ( qual & 0x04 ) !=3D 0 ) {
                 // Encode a Yes/No response.
                 if ( text() =3D=3D "Yes" ) {      // No tr
-                    data +=3D (char)0x8D;
-                    data +=3D (char)0x02;
-                    data +=3D (char)0x04;
-                    data +=3D (char)0x01;
+                    data +=3D static_cast<char>(0x8D);
+                    data +=3D static_cast<char>(0x02);
+                    data +=3D static_cast<char>(0x04);
+                    data +=3D static_cast<char>(0x01);
                 } else {
-                    data +=3D (char)0x8D;
-                    data +=3D (char)0x02;
-                    data +=3D (char)0x04;
-                    data +=3D (char)0x00;
+                    data +=3D static_cast<char>(0x8D);
+                    data +=3D static_cast<char>(0x02);
+                    data +=3D static_cast<char>(0x04);
+                    data +=3D static_cast<char>(0x00);
                 }
             } else if ( ( qual & 0x02 ) !=3D 0 ) {
                 // Use UCS-2 to encode the data.
@@ -787,13 +787,11 @@ QByteArray QSimTerminalResponse::toPdu() const
                 break;
             if ( ( qual & 0x02 ) !=3D 0 ) {
                 // Use UCS-2 to encode the data.
-                writeTextString( data, text(), (QSimCommand::ToPduOptions)
-                                                 (QSimCommand::UCS2Strings=
 |
+                writeTextString( data, text(), static_cast<QSimCommand::To=
PduOptions>(QSimCommand::UCS2Strings |
                                                   QSimCommand::EncodeEmpty=
Strings) );
             } else if ( ( qual & 0x08 ) !=3D 0 ) {
                 // Use the packed 7-bit GSM encoding to encode the data.
-                writeTextString( data, text(), (QSimCommand::ToPduOptions)
-                                                 (QSimCommand::PackedStrin=
gs |
+                writeTextString( data, text(), static_cast<QSimCommand::To=
PduOptions>(QSimCommand::PackedStrings |
                                                   QSimCommand::EncodeEmpty=
Strings) );
             } else {
                 // Use the unpacked 8-bit GSM encoding to encode the data.
@@ -811,9 +809,9 @@ QByteArray QSimTerminalResponse::toPdu() const
         case QSimCommand::SelectItem:
         {
             if ( menuItem() !=3D 0 ) {
-                data +=3D (char)0x90;
-                data +=3D (char)0x01;
-                data +=3D (char)menuItem();
+                data +=3D static_cast<char>(0x90);
+                data +=3D static_cast<char>(0x01);
+                data +=3D static_cast<char>(menuItem());
             }
         }
         break;
diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index e4e41b9..1d0f733 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -87,7 +87,7 @@ public:
         mMessageType =3D QSMSMessage::Normal;
         mCodec =3D nullptr;
         mForceGsm =3D false;
-        mBestScheme =3D (QSMSDataCodingScheme)(-1);
+        mBestScheme =3D static_cast<QSMSDataCodingScheme>(-1);
         mDataCodingScheme =3D -1;
         mMessageClass =3D -1;
         mProtocol =3D 0;
@@ -525,7 +525,7 @@ QSMSDataCodingScheme QSMSMessage::bestScheme() const
     bool gsmSafe;

     // Did the user provide a scheme override?
-    if ( d->mBestScheme !=3D (QSMSDataCodingScheme)(-1) )
+    if ( d->mBestScheme !=3D static_cast<QSMSDataCodingScheme>(-1) )
         return d->mBestScheme;

     // Encode zero-length bodies in the default alphabet.
@@ -847,7 +847,7 @@ void QSMSMessage::computeSize( uint& numMessages, uint&=
 spaceLeftInLast ) const
     if ( part !=3D -1 ) {
         // This is an application datagram, which has its size
         // computed using a different algorithm.
-        uint headerLen =3D 3 + d->mParts[(uint)part].data().size();
+        uint headerLen =3D 3 + d->mParts[static_cast<uint>(part)].data().s=
ize();
         uint dataLen =3D applicationData().size();
         if ( ( headerLen + dataLen ) <=3D 140 ) {
             numMessages =3D 1;
@@ -977,7 +977,7 @@ int QSMSMessage::destinationPort() const
     if ( part =3D=3D -1 )
         return -1;

-    QByteArray data =3D d->mParts[(uint)part].data();
+    QByteArray data =3D d->mParts[static_cast<uint>(part)].data();
     if ( data.size() =3D=3D 4 ) {

         return ((((int)(data[0])) & 0xFF) << 8) |
@@ -1004,17 +1004,17 @@ void QSMSMessage::setDestinationPort(int value)
     int part =3D findPart( "application/x-qtopia-wdp-ports" );
     if ( part =3D=3D -1 ) {
         data.resize(4);
-        data[0] =3D (char)(value >> 8);
-        data[1] =3D (char)value;
-        data[2] =3D (char)0;
-        data[3] =3D (char)0;
+        data[0] =3D static_cast<char>(value >> 8);
+        data[1] =3D static_cast<char>(value);
+        data[2] =3D static_cast<char>(0);
+        data[3] =3D static_cast<char>(0);
     } else {
         source =3D sourcePort();
         data.resize(4);
-        data[0] =3D (char)(value >> 8);
-        data[1] =3D (char)value;
-        data[2] =3D (char)(source >> 8);
-        data[3] =3D (char)source;
+        data[0] =3D static_cast<char>(value >> 8);
+        data[1] =3D static_cast<char>(value);
+        data[2] =3D static_cast<char>(source >> 8);
+        data[3] =3D static_cast<char>(source);
     }
     removeParts( "application/x-qtopia-wdp-ports" );
     addPart( QSMSMessagePart( "application/x-qtopia-wdp-ports", data ) );
@@ -1032,7 +1032,7 @@ int QSMSMessage::sourcePort() const
     if ( part =3D=3D -1 )
         return -1;

-    QByteArray data =3D d->mParts[(uint)part].data();
+    QByteArray data =3D d->mParts[static_cast<uint>(part)].data();
     if ( data.size() =3D=3D 4 ) {

         return ((((int)(data[2])) & 0xFF) << 8) |
@@ -1059,17 +1059,17 @@ void QSMSMessage::setSourcePort(int value)
     int part =3D findPart( "application/x-qtopia-wdp-ports" );
     if ( part =3D=3D -1 ) {
         data.resize(4);
-        data[0] =3D (char)0;
-        data[1] =3D (char)0;
-        data[2] =3D (char)(value >> 8);
-        data[3] =3D (char)value;
+        data[0] =3D static_cast<char>(0);
+        data[1] =3D static_cast<char>(0);
+        data[2] =3D static_cast<char>(value >> 8);
+        data[3] =3D static_cast<char>(value);
     } else {
         dest =3D destinationPort();
         data.resize(4);
-        data[0] =3D (char)(dest >> 8);
-        data[1] =3D (char)dest;
-        data[2] =3D (char)(value >> 8);
-        data[3] =3D (char)value;
+        data[0] =3D static_cast<char>(dest >> 8);
+        data[1] =3D static_cast<char>(dest);
+        data[2] =3D static_cast<char>(value >> 8);
+        data[3] =3D static_cast<char>(value);
     }
     removeParts( "application/x-qtopia-wdp-ports" );
     addPart( QSMSMessagePart( "application/x-qtopia-wdp-ports", data ) );
@@ -1248,7 +1248,7 @@ QList<QSMSMessage> QSMSMessage::split() const
         uint partSize =3D 134 - 6;
         while ( posn < data.size() ) {
             tmp =3D *this;
-            if ( ( posn + partSize ) <=3D (uint)data.size() ) {
+            if ( ( posn + partSize ) <=3D static_cast<uint>(data.size()) )=
 {
                 part.resize(partSize);
                 memcpy(part.data(), data.data() + posn, partSize );
             } else {
@@ -1343,9 +1343,9 @@ void QSMSMessage::setFragmentHeader( uint refNum, uin=
t part, uint numParts,
     d->mHeaders.resize( len + 5 );
     d->mHeaders[len++] =3D 0;         // Type for concatenated short messa=
ges.
     d->mHeaders[len++] =3D 3;         // Length of header information.
-    d->mHeaders[len++] =3D (char)refNum;
-    d->mHeaders[len++] =3D (char)numParts;
-    d->mHeaders[len++] =3D (char)part;
+    d->mHeaders[len++] =3D static_cast<char>(refNum);
+    d->mHeaders[len++] =3D static_cast<char>(numParts);
+    d->mHeaders[len++] =3D static_cast<char>(part);
 }


@@ -1356,12 +1356,12 @@ void QSMSMessage::unpackHeaderParts()
     uint tag, len;
     uint temp;
     QString type;
-    while ( ( posn + 2 ) <=3D (uint)(headers.size()) ) {
+    while ( ( posn + 2 ) <=3D static_cast<uint>(headers.size()) ) {
         tag =3D (unsigned char)(headers[posn]);
         len =3D (unsigned char)(headers[posn + 1]);
-        if ( ( posn + len + 2 ) > (uint)(headers.size()) )
+        if ( ( posn + len + 2 ) > static_cast<uint>(headers.size()) )
             break;
-        switch ( (SMSHeaderKind)tag ) {
+        switch ( static_cast<SMSHeaderKind>(tag) ) {

             case SMS_HK_Predefined_Sound:
             {
@@ -1412,7 +1412,7 @@ void QSMSMessage::unpackHeaderParts()
                     data[2] =3D 0x20;
                     data[3] =3D 0x20;
                     for ( temp =3D 0; temp < (len - 1); ++temp ) {
-                        data[4 + temp] =3D (char)(~(headers[posn + 3 + tem=
p]));
+                        data[4 + temp] =3D static_cast<char>(~(headers[pos=
n + 3 + temp]));
                     }
                     addPart( QSMSMessagePart
                         ( "image/vnd.wap.wbmp", data,
@@ -1432,7 +1432,7 @@ void QSMSMessage::unpackHeaderParts()
                     data[2] =3D 0x10;
                     data[3] =3D 0x10;
                     for ( temp =3D 0; temp < (len - 1); ++temp ) {
-                        data[4 + temp] =3D (char)(~(headers[posn + 3 + tem=
p]));
+                        data[4 + temp] =3D static_cast<char>(~(headers[pos=
n + 3 + temp]));
                     }
                     addPart( QSMSMessagePart
                         ( "image/vnd.wap.wbmp", data,
@@ -1451,7 +1451,7 @@ void QSMSMessage::unpackHeaderParts()
                     data[2] =3D headers[posn + 3];
                     data[3] =3D headers[posn + 4];
                     for ( temp =3D 2; temp < (len - 1); ++temp ) {
-                        data[2 + temp] =3D (char)(~(headers[posn + 3 + tem=
p]));
+                        data[2 + temp] =3D static_cast<char>(~(headers[pos=
n + 3 + temp]));
                     }
                     addPart( QSMSMessagePart
                         ( "image/vnd.wap.wbmp", data,
@@ -1521,11 +1521,11 @@ void QPDUMessage::skipOctet()
 QByteArray QPDUMessage::getOctets( uint len )
 {
     QByteArray result;
-    if ( ( mBuffer.size() - mPosn ) < (int)len ) {
+    if ( ( mBuffer.size() - mPosn ) < static_cast<int>(len) ) {
         result =3D mBuffer.mid( mPosn );
         abort();
     } else {
-        result =3D mBuffer.mid( mPosn, (int)len );
+        result =3D mBuffer.mid( mPosn, static_cast<int>(len) );
         mPosn +=3D len;
     }
     return result;
@@ -1537,15 +1537,15 @@ char QPDUMessage::mBits;
 void QPDUMessage::setBit(int b, bool on)
 {
     if ( on )
-        mBits |=3D (char)(Unit << b);
+        mBits |=3D static_cast<char>(Unit << b);
     else
-        mBits &=3D (char)(~(Unit << b));
+        mBits &=3D static_cast<char>(~(Unit << b));
 }

 void QPDUMessage::setBits(int offset, int len, int val)
 {
     uint mask =3D ((Unit << len) - 1) << offset;
-    mBits =3D (char)((mBits & ~mask) | ((val << offset) & mask));
+    mBits =3D static_cast<char>((mBits & ~mask) | ((val << offset) & mask)=
);
 }

 void QPDUMessage::commitBits()
@@ -1571,8 +1571,7 @@ bool QPDUMessage::bit(int b)
 unsigned char QPDUMessage::bits(int offset, int len)
 {
     if ( needOctets(1) )
-        return (unsigned char)
-            ((mBuffer[mPosn] >> offset) & ((Unit << len) - 1));
+        return static_cast<unsigned char>((mBuffer[mPosn] >> offset) & ((U=
nit << len) - 1));
     else
         return 0;
 }
@@ -1588,7 +1587,7 @@ unsigned char QPDUMessage::getOctet()
 unsigned char QPDUMessage::peekOctet() const
 {
     if ( needOctets(1) )
-        return (unsigned char)(mBuffer[mPosn]);
+        return static_cast<unsigned char>(mBuffer[mPosn]);
     else
         return 0;
 }
@@ -1605,14 +1604,14 @@ static QByteArray collapse7Bit( const QByteArray& i=
n )
                 byte |=3D (1 << size);
             ++size;
             if ( size >=3D 8 ) {
-                out +=3D (char)byte;
+                out +=3D static_cast<char>(byte);
                 byte =3D 0;
                 size =3D 0;
             }
         }
     }
     if ( size !=3D 0 ) {
-        out +=3D (char)byte;
+        out +=3D static_cast<char>(byte);
     }
     return out;
 }
@@ -1655,7 +1654,7 @@ void QPDUMessage::appendAddress( QByteArray &buffer, =
const QString &strin, bool

     // Bail out early if the address is zero-length.
     if ( !len ) {
-        buffer.append( (char) 0 );
+        buffer.append( static_cast<char>(0) );
         return;
     }

@@ -1755,7 +1754,7 @@ static QByteArray expand7Bit( const QByteArray& in )
                 byte |=3D (1 << size);
             ++size;
             if ( size >=3D 7 ) {
-                out +=3D (char)byte;
+                out +=3D static_cast<char>(byte);
                 byte =3D 0;
                 size =3D 0;
             }
@@ -1771,14 +1770,14 @@ QString QPDUMessage::address(bool SCAddress)
     // Get the address length and validate it.
     if ( !needOctets(1) )
         return str;
-    uint len =3D (((uint)(getOctet())) & 0xFF);
+    uint len =3D ((static_cast<uint>(getOctet())) & 0xFF);
     if ( !needOctets(len) ) {
         abort();
         return str;
     }

     if ( len ) {
-        SMSAddressType at =3D (SMSAddressType) bits(4, 3);
+        SMSAddressType at =3D static_cast<SMSAddressType>(bits(4, 3));

         if ( at =3D=3D SMS_Address_International )
             str +=3D "+";
@@ -1792,12 +1791,12 @@ QString QPDUMessage::address(bool SCAddress)

         if ( at !=3D SMS_Address_AlphaNumeric ) {
             unsigned char c;
-            for (int i =3D 0; i < (int)len; i++) {
+            for (int i =3D 0; i < static_cast<int>(len); i++) {
                 c =3D peekOctet() & 0x0F;
-                str +=3D (char) ('0' + c);
+                str +=3D static_cast<char>('0' + c);
                 c =3D (peekOctet() & 0xF0) >> 4;
                 if ( c !=3D 0xf )
-                    str +=3D (char) ('0' + c);
+                    str +=3D static_cast<char>('0' + c);
                 skipOctet();
             }
         } else {
@@ -1815,7 +1814,7 @@ QString QPDUMessage::address(bool SCAddress)
 uint QPDUMessage::addressLength() const
 {
     if( mPosn < mBuffer.size() )
-        return (((uint)peekOctet()) & 0xFF) + 1;
+        return ((static_cast<uint>(peekOctet())) & 0xFF) + 1;
     else
         return 0;
 }
@@ -1834,7 +1833,7 @@ void QPDUMessage::setTimeStamp(const QDateTime &dt)
     tArr[5] =3D t.second();

     for ( int i =3D 0; i < 6; i++) {
-        appendOctet((unsigned char) ( (((tArr[i]/10)%10) & 0x0F) | (((tArr=
[i]%10) & 0x0F)<<4) ) );
+        appendOctet(static_cast<unsigned char>( (((tArr[i]/10)%10) & 0x0F)=
 | (((tArr[i]%10) & 0x0F)<<4) ) );
     }

     appendOctet(0x04); //arbitrary random timezone
@@ -1870,7 +1869,7 @@ QDateTime QPDUMessage::timeStamp()
 static uint getEncodedLength( const QString& txt, uint size )
 {
     uint len =3D 0;
-    for ( int u =3D 0; u < (int)size; u++ ) {
+    for ( int u =3D 0; u < static_cast<int>(size); u++ ) {
         if ( QGsmCodec::twoByteFromUnicode( txt[u].unicode() ) >=3D 256 )
             len +=3D 2;
         else
@@ -1884,7 +1883,7 @@ void QPDUMessage::setUserData(const QString &txt, QSM=
SDataCodingScheme scheme, Q
     uint len =3D txt.length();
     uint u;
     uint encodedLen;
-    uint headerLen =3D (uint)(headers.size());
+    uint headerLen =3D static_cast<uint>(headers.size());
     if ( headerLen )
         ++headerLen;

@@ -1892,7 +1891,7 @@ void QPDUMessage::setUserData(const QString &txt, QSM=
SDataCodingScheme scheme, Q
     switch (scheme >> 6) {
     case 0:
     default:
-        scheme =3D (QSMSDataCodingScheme)(scheme & 0x0C);
+        scheme =3D static_cast<QSMSDataCodingScheme>(scheme & 0x0C);
         break;
     case 3:
         switch ((scheme & 0x30) >> 4) {
@@ -1982,7 +1981,7 @@ void QPDUMessage::setUserData(const QString &txt, QSM=
SDataCodingScheme scheme, Q
         }
         const char *s =3D (const char *)converted;
         for ( u =3D 0; u < len; u++ ) {
-            appendOctet( (unsigned char)(s[u]) );
+            appendOctet( static_cast<unsigned char>(s[u]) );
         }

     } else {
@@ -1999,8 +1998,8 @@ void QPDUMessage::setUserData(const QString &txt, QSM=
SDataCodingScheme scheme, Q
             }
         }
         for ( u =3D 0; u < len; u++ ) {
-            appendOctet( (unsigned char)(txt[u].unicode() >> 8) );
-            appendOctet( (unsigned char)(txt[u].unicode() & 0xFF) );
+            appendOctet( static_cast<unsigned char>(txt[u].unicode() >> 8)=
 );
+            appendOctet( static_cast<unsigned char>(txt[u].unicode() & 0xF=
F) );
         }

     }
@@ -2012,13 +2011,13 @@ static bool isSMSDatagram( const QByteArray& header=
s )
 {
     uint posn =3D 0;
     uint tag, len;
-    while ( ( posn + 2 ) <=3D (uint)(headers.size()) ) {
-        tag =3D (unsigned char)(headers[posn]);
-        len =3D (unsigned char)(headers[posn + 1]);
-        if ( ( posn + len + 2 ) > (uint)(headers.size()) )
+    while ( ( posn + 2 ) <=3D static_cast<uint>(headers.size()) ) {
+        tag =3D static_cast<unsigned char>(headers[posn]);
+        len =3D static_cast<unsigned char>(headers[posn + 1]);
+        if ( ( posn + len + 2 ) > static_cast<uint>(headers.size()) )
             break;
-        if ( tag =3D=3D (uint)SMS_HK_AppPort_8Bit ||
-             tag =3D=3D (uint)SMS_HK_AppPort_16Bit ) {
+        if ( tag =3D=3D static_cast<uint>(SMS_HK_AppPort_8Bit) ||
+             tag =3D=3D static_cast<uint>(SMS_HK_AppPort_16Bit) ) {
             return true;
         }
         posn +=3D len + 2;
@@ -2042,11 +2041,11 @@ QString QPDUMessage::userData(QSMSDataCodingScheme =
scheme, QTextCodec *codec, QB
     } else {
         if ( !needOctets(1) )
             return str;
-        len =3D (uint)getOctet();
+        len =3D static_cast<uint>(getOctet());
     }

     // Strip off everything except the alphabet bits.
-    scheme =3D (QSMSDataCodingScheme)(scheme & 0x0C);
+    scheme =3D static_cast<QSMSDataCodingScheme>(scheme & 0x0C);

     if ( scheme =3D=3D QSMS_DefaultAlphabet ) {

@@ -2092,7 +2091,7 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
                             ( QGsmCodec::twoByteToUnicode( 0x1B00 | ch ) );
                         prefixed =3D false;
                     } else {
-                        str +=3D QGsmCodec::singleToUnicode( (unsigned cha=
r)ch );
+                        str +=3D QGsmCodec::singleToUnicode( static_cast<u=
nsigned char>(ch) );
                     }
                     ch =3D 0;
                     --len;
@@ -2110,7 +2109,7 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
             return str;
         }
         if ( hasHeaders ) {
-            if ( !len || len < (uint)( (peekOctet() & 0xFF) + 1 ) ) {
+            if ( !len || len < static_cast<uint>( (peekOctet() & 0xFF) + 1=
 ) ) {
                 abort();
                 return str;
             }
@@ -2130,7 +2129,7 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
             return str;
         }
         if ( hasHeaders ) {
-            if ( !len || len < (uint)( (peekOctet() & 0xFF) + 1 ) ) {
+            if ( !len || len < static_cast<uint>( (peekOctet() & 0xFF) + 1=
 ) ) {
                 abort();
                 return str;
             }
@@ -2140,9 +2139,9 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
         }
         len /=3D 2;
         for ( u =3D 0; u < len; ++u ) {
-            ch =3D (((uint)(getOctet() & 0xFF)) << 8);
-            ch |=3D ((uint)(getOctet() & 0xFF));
-            str +=3D (QChar)ch;
+            ch =3D ((static_cast<uint>(getOctet() & 0xFF)) << 8);
+            ch |=3D (static_cast<uint>(getOctet() & 0xFF));
+            str +=3D QChar(ch);
         }

     } else {
@@ -2150,12 +2149,12 @@ QString QPDUMessage::userData(QSMSDataCodingScheme =
scheme, QTextCodec *codec, QB
         // Assume 8-bit for any other coding scheme value.

         // Process an 8-bit sequence using the default Latin1 codec.
-        if ( len > (uint)(mBuffer.size() - mPosn) ) {
+        if ( len > static_cast<uint>(mBuffer.size() - mPosn) ) {
             // The length field is invalid - use the actual size.
             len =3D mBuffer.size() - mPosn;
         }
         if ( hasHeaders ) {
-            if ( !len || len < (uint)( (peekOctet() & 0xFF) + 1 ) ) {
+            if ( !len || len < static_cast<uint>( (peekOctet() & 0xFF) + 1=
 ) ) {
                 abort();
                 return str;
             }
@@ -2166,7 +2165,7 @@ QString QPDUMessage::userData(QSMSDataCodingScheme sc=
heme, QTextCodec *codec, QB
             len -=3D headerLen + 1;
         }
         for ( u =3D 0; u < len; ++u ) {
-            str +=3D (QChar)(getOctet() & 0xFF);
+            str +=3D QChar(getOctet() & 0xFF);
         }

     }
@@ -2184,10 +2183,10 @@ SMSMessageType QPDUMessage::messageType()
         const char *ptr =3D mBuffer.constData();
         ptr +=3D (*ptr & 0xFF) + 1;
         unsigned char c =3D *ptr & 3;
-        return (SMSMessageType) c;
+        return static_cast<SMSMessageType>(c);

     }
-    return (SMSMessageType)0;
+    return static_cast<SMSMessageType>(0);
 }

 QSMSSubmitMessage::QSMSSubmitMessage(const QSMSMessage &m, bool isDeliver)
@@ -2207,30 +2206,29 @@ QSMSSubmitMessage::QSMSSubmitMessage(const QSMSMess=
age &m, bool isDeliver)
     QSMSDataCodingScheme scheme =3D m.bestScheme();
     int part =3D m.findPart( "application/x-qtopia-wdp-ports" );
     if ( part !=3D -1 ) {
-        QByteArray portData =3D m.parts()[(uint)part].data();
+        QByteArray portData =3D m.parts()[static_cast<uint>(part)].data();
         uint size =3D headers.size();
         headers.resize(size + portData.size() + 2);
         if ( portData.size() =3D=3D 4 ) {
-            headers[size++] =3D (char)SMS_HK_AppPort_16Bit;
+            headers[size++] =3D static_cast<char>(SMS_HK_AppPort_16Bit);
         } else {
-            headers[size++] =3D (char)SMS_HK_AppPort_8Bit;
+            headers[size++] =3D static_cast<char>(SMS_HK_AppPort_8Bit);
         }
-        headers[size++] =3D (char)(portData.size());
+        headers[size++] =3D static_cast<char>(portData.size());
         memcpy(headers.data() + size, portData.data(), portData.size());
         int dataScheme =3D m.dataCodingScheme(); // User-supplied override.
         if ( dataScheme =3D=3D -1 )
             dataScheme =3D 0xF5;      // Special value for datagrams.
-        scheme =3D (QSMSDataCodingScheme)dataScheme;
+        scheme =3D static_cast<QSMSDataCodingScheme>(dataScheme);
     } else if ( m.messageClass() !=3D -1 ) {
-        scheme =3D (QSMSDataCodingScheme)
-                    (scheme | QSMS_MessageClass | m.messageClass());
+        scheme =3D static_cast<QSMSDataCodingScheme>(scheme | QSMS_Message=
Class | m.messageClass());
         int dataScheme =3D m.dataCodingScheme(); // User-supplied override.
         if ( dataScheme !=3D -1 )
-            scheme =3D (QSMSDataCodingScheme)dataScheme;
+            scheme =3D static_cast<QSMSDataCodingScheme>(dataScheme);
     } else {
         int dataScheme =3D m.dataCodingScheme(); // User-supplied override.
         if ( dataScheme !=3D -1 )
-            scheme =3D (QSMSDataCodingScheme)dataScheme;
+            scheme =3D static_cast<QSMSDataCodingScheme>(dataScheme);
     }

     if ( !isDeliver )
@@ -2239,7 +2237,7 @@ QSMSSubmitMessage::QSMSSubmitMessage(const QSMSMessag=
e &m, bool isDeliver)
         setBits(0, 2, SMS_Deliver);

     setBit(2, false);                   // TP-Reject-Duplicates
-    if ( !isDeliver && m.validityPeriod() =3D=3D (uint)(-1) )
+    if ( !isDeliver && m.validityPeriod() =3D=3D static_cast<uint>(-1) )
         setBits(3, 2, SMS_VF_NoPresent);
     else
         setBits(3, 2, SMS_VF_Relative);
@@ -2273,7 +2271,7 @@ QSMSSubmitMessage::QSMSSubmitMessage(const QSMSMessag=
e &m, bool isDeliver)

     if ( !isDeliver ) {
         // TP-VP ( Validity Period )
-        if ( m.validityPeriod() !=3D (uint)(-1) )
+        if ( m.validityPeriod() !=3D static_cast<uint>(-1) )
             appendOctet(m.gsmValidityPeriod());
     }  else {
         setTimeStamp(m.timestamp());
@@ -2291,7 +2289,7 @@ QSMSSubmitMessage::QSMSSubmitMessage(const QSMSMessag=
e &m, bool isDeliver)
         appendOctet( len + headers.size() + 1 );
         appendOctet( headers.size() );
         uint u;
-        for ( u =3D 0; u < (uint)headers.size(); u++ ) {
+        for ( u =3D 0; u < static_cast<uint>(headers.size()); u++ ) {
             appendOctet( headers[u] );
         }
         for ( u =3D 0; u < len; u++ ) {
@@ -2333,8 +2331,8 @@ static void unpackSckl( QSMSMessage& m, const QString=
& text )
     m.addPart( QSMSMessagePart( "application/x-qtopia-wdp-ports", ports ) =
);
     if ( header.size() > 4 ) {
         QByteArray fragments( header.size() - 4 + 2, '\0' );
-        fragments[0] =3D (char)( SMS_HK_Concat_8Bit );
-        fragments[1] =3D (char)( header.size() - 4 );
+        fragments[0] =3D static_cast<char>( SMS_HK_Concat_8Bit );
+        fragments[1] =3D static_cast<char>( header.size() - 4 );
         memcpy( fragments.data() + 2, header.data() + 4, header.size() - 4=
 );
         m.setHeaders( fragments );
     }
@@ -2436,14 +2434,14 @@ QSMSMessage QSMSDeliverMessage::unpack(QTextCodec *=
codec)
                 return m;
             mPosn +=3D 7;
         } else {
-            m.setValidityPeriod( (uint)(-1) );
+            m.setValidityPeriod( static_cast<uint>(-1) );
         }
     }

     // Read the user data field.
     QByteArray *headers =3D nullptr;
     QString text;
-    text =3D userData( (QSMSDataCodingScheme)scheme, codec,
+    text =3D userData( static_cast<QSMSDataCodingScheme>(scheme), codec,
                      headers, userDataHeader, false );
     if ( !headers && text.startsWith( "//SCKL" ) ) {
         unpackSckl( m, text );
@@ -2584,19 +2582,19 @@ QCBSMessage QCBSDeliverMessage::unpack(QTextCodec *=
codec)

     const char *mOffset =3D mBuffer.constData() + mPosn;
     m.setMessageCode( ((mOffset[0] & 0xFC) << 2) | (mOffset[1] & 0x0F) );
-    m.setScope( (QCBSMessage::GeographicalScope)(mOffset[0] & 0x03) );
+    m.setScope( static_cast<QCBSMessage::GeographicalScope>(mOffset[0] & 0=
x03) );
     m.setUpdateNumber( (mOffset[1] >> 4) & 0x0F );
     m.setChannel( ((mOffset[2] & 0xFF) << 8) | (mOffset[3] & 0xFF) );
-    scheme =3D (unsigned char)((mOffset[4] >> 4) & 0x0F);
-    m.setLanguage( (QCBSMessage::Language)(mOffset[4] & 0x0F) );
-    m.setNumPages( (uint)((mOffset[5] >> 4) & 0x0F) );
-    m.setPage( (uint)(mOffset[5] & 0x0F) );
+    scheme =3D static_cast<unsigned char>((mOffset[4] >> 4) & 0x0F);
+    m.setLanguage( static_cast<QCBSMessage::Language>(mOffset[4] & 0x0F) );
+    m.setNumPages( static_cast<uint>((mOffset[5] >> 4) & 0x0F) );
+    m.setPage( static_cast<uint>(mOffset[5] & 0x0F) );
     mPosn +=3D 6;

     // Read the user data field and strip CR's, LF's, and NUL's from the e=
nd.
     QByteArray *headers =3D nullptr;
     QString text =3D userData
-        ( (QSMSDataCodingScheme)scheme, codec, headers, false, true );
+        ( static_cast<QSMSDataCodingScheme>(scheme), codec, headers, false=
, true );
     len =3D text.length();
     while ( len > 0 && ( text.at(len - 1) =3D=3D QChar ('\r') || text.at(l=
en - 1) =3D=3D QChar ('\n') ||
                          text.at(len - 1) =3D=3D QChar ('\0') ) ) {
@@ -2619,17 +2617,17 @@ void QCBSDeliverMessage::pack(const QCBSMessage &m,=
 QSMSDataCodingScheme scheme)
     mPosn =3D 0;
     mBits =3D 0;

-    mBuffer.append( (char) (((m.messageCode() >> 4) & 0x3F) | (m.scope() <=
< 6)) );
-    mBuffer.append( (char)(((m.messageCode() & 0xF) << 4) | (m.updateNumbe=
r() & 0xF)) );
-    mBuffer.append( (char)((m.channel() & 0x0000FF00) >> 8) );
-    mBuffer.append( (char)(m.channel() & 0x000000FF) );
+    mBuffer.append( static_cast<char>(((m.messageCode() >> 4) & 0x3F) | (m=
.scope() << 6)) );
+    mBuffer.append( static_cast<char>(((m.messageCode() & 0xF) << 4) | (m.=
updateNumber() & 0xF)) );
+    mBuffer.append( static_cast<char>((m.channel() & 0x0000FF00) >> 8) );
+    mBuffer.append( static_cast<char>(m.channel() & 0x000000FF) );

     if (scheme =3D=3D QSMS_UCS2Alphabet)
         mBuffer.append( 0x11 );
     else
-        mBuffer.append( (char)(((scheme & 0x0F)<<4) | (m.language() & 0x0F=
)) );
+        mBuffer.append( static_cast<char>(((scheme & 0x0F)<<4) | (m.langua=
ge() & 0x0F)) );

-    mBuffer.append( (char)((m.numPages() & 0x0F) | ((m.page() & 0x0F) << 4=
)) );
+    mBuffer.append( static_cast<char>((m.numPages() & 0x0F) | ((m.page() &=
 0x0F) << 4)) );

     QString paddedText =3D m.text();

@@ -2639,8 +2637,8 @@ void QCBSDeliverMessage::pack(const QCBSMessage &m, Q=
SMSDataCodingScheme scheme)

         iso639_2_from_language(m.language(), iso639);
         c =3D ((iso639[1] & 0x7F)<<7) | (iso639[0] & 0x7F);
-        mBuffer.append( (char)(c & 0xFF) );
-        mBuffer.append( (char)(c >> 8) );
+        mBuffer.append( static_cast<char>(c & 0xFF) );
+        mBuffer.append( static_cast<char>(c >> 8) );
         numPad =3D 40 - (paddedText.length());
     }
     else
diff --git a/src/qsmsmessage_p.h b/src/qsmsmessage_p.h
index 49060c7..b25056f 100644
--- a/src/qsmsmessage_p.h
+++ b/src/qsmsmessage_p.h
@@ -120,7 +120,7 @@ public:
     static void setBits(int offset, int len, int val);
     void commitBits();
     static void commitBits(QByteArray& buffer);
-    void appendOctet(uchar c) { mBuffer +=3D (char)c; }
+    void appendOctet(uchar c) { mBuffer +=3D static_cast<char>(c); }

     bool bit(int b);
     unsigned char bits(int offset, int len);
@@ -147,7 +147,7 @@ public:
     void reset() { mPosn =3D 0; }

     bool needOctets( uint num ) const
-        { return ((uint)(mBuffer.size() - mPosn) >=3D num); }
+        { return (static_cast<uint>(mBuffer.size() - mPosn) >=3D num); }

     static void appendAddress( QByteArray &buffer, const QString &strin, b=
ool SCAddress );

diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index f3a1661..ccb6869 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -346,8 +346,8 @@ QDateTime QWspDateTime::parseDate(QString in)
     QString time, timeDiff;

     for (int z =3D 0; z < in.length(); z++) {
-        if (in[(int)z] !=3D ',') {
-            org +=3D in[(int)z];
+        if (in[z] !=3D ',') {
+            org +=3D in[z];
         } else {
             org +=3D " ";
         }
@@ -357,7 +357,7 @@ QDateTime QWspDateTime::parseDate(QString in)
     org +=3D " ";

     index =3D org.indexOf(' ');
-    str =3D org.left((uint) index);
+    str =3D org.left(static_cast<uint>(index));
     while ( str !=3D QString() ) {
         len =3D str.length();
         index--;
@@ -547,9 +547,9 @@ quint8 QWspPduDecoder::peekOctet()
     char o;
     if ( dev->getChar(&o) ) {
         dev->ungetChar(o);
-        return (quint8)o;
+        return static_cast<quint8>(o);
     } else {
-        return (quint8)0;
+        return static_cast<quint8>(0);
     }
 }

@@ -561,12 +561,12 @@ quint8 QWspPduDecoder::decodeOctet()
     char o;
     if (dev->atEnd()) {
         stat =3D Eof;
-        return (quint8)0;
+        return static_cast<quint8>(0);
     } else if ( dev->getChar(&o) ) {
-        return (quint8)o;
+        return static_cast<quint8>(o);
     } else {
         stat =3D Eof;
-        return (quint8)0;
+        return static_cast<quint8>(0);
     }
 }

@@ -621,7 +621,7 @@ quint32 QWspPduDecoder::decodeUIntVar()

     quint32 v =3D 0;
     for (int i =3D 0; i < count; i++) {
-        v |=3D (quint32)d[i] << ((count-i-1)*7);
+        v |=3D static_cast<quint32>(d[i]) << ((count-i-1)*7);
     }

     return v;
@@ -648,7 +648,7 @@ quint32 QWspPduDecoder::decodeLongInteger()
     quint8 len =3D decodeUInt8();    // short length
     quint32 v =3D 0;
     for (int i =3D 0; i < len && !dev->atEnd(); i++) {
-        v |=3D (quint32)decodeOctet() << ((len-i-1)*8);
+        v |=3D static_cast<quint32>(decodeOctet()) << ((len-i-1)*8);
     }
     return v;
 }
@@ -680,7 +680,7 @@ quint32 QWspPduDecoder::decodeLength()
     quint32 len =3D 0;
     quint8 o =3D peekOctet();
     if (o < 31) {
-        len =3D (quint32)decodeOctet();
+        len =3D static_cast<quint32>(decodeOctet());
     } else if (o =3D=3D 31) {
         decodeOctet();
         len =3D decodeUIntVar();
@@ -791,7 +791,7 @@ QString QWspPduDecoder::decodeContentType()
     if (o <=3D 31) {
         // Content-general-form
         quint32 len =3D decodeLength();
-        int endByte =3D (int)(dev->pos()+len);
+        int endByte =3D static_cast<int>(dev->pos()+len);
         // decode media type
         o =3D peekOctet();
         if (o & 0x80) {
@@ -811,7 +811,7 @@ QString QWspPduDecoder::decodeContentType()
                 o =3D decodeOctet();
             }
         }
-        while (endByte > ((int)(dev->pos())) && !dev->atEnd()) {
+        while (endByte > (static_cast<int>(dev->pos())) && !dev->atEnd()) {
             // read parameters
             QString p =3D decodeParameter();
             if (!p.isEmpty())
@@ -924,12 +924,12 @@ QString QWspPduDecoder::decodeParameter()
             case 0x07:
                 p =3D "differences=3D";
                 if (octet & 0x80)
-                    p +=3D QString::number((int)decodeShortInteger());
+                    p +=3D QString::number(static_cast<int>(decodeShortInt=
eger()));
                 else
                     p +=3D '\"' + decodeTokenText() + '\"';
                 break;
             case 0x08:
-                p =3D "padding=3D" + QString::number((int)decodeShortInteg=
er());
+                p =3D "padding=3D" + QString::number(static_cast<int>(deco=
deShortInteger()));
                 break;
             case 0x09:
                 p =3D "type=3D";
@@ -1019,16 +1019,16 @@ QWspMultipart QWspPduDecoder::decodeMultipart()
 */
 void QWspPduDecoder::decodeContentTypeAndHeaders(QWspPart& part, quint32 h=
drLen)
 {
-    int curByte =3D (int)(dev->pos());
-    int afterHeader =3D curByte + (int)hdrLen;
+    int curByte =3D static_cast<int>(dev->pos());
+    int afterHeader =3D curByte + static_cast<int>(hdrLen);
     QWspField field;
     field.name =3D "Content-Type";
     field.value =3D decodeContentType();
     part.addHeader(field);
-    hdrLen -=3D ((int)(dev->pos())) - curByte;
+    hdrLen -=3D (static_cast<int>(dev->pos())) - curByte;

-    int dataByte =3D ((int)(dev->pos())) + hdrLen;
-    while (((int)(dev->pos())) < dataByte && !dev->atEnd()) {
+    int dataByte =3D (static_cast<int>(dev->pos())) + hdrLen;
+    while ((static_cast<int>(dev->pos())) < dataByte && !dev->atEnd()) {
         field =3D decodeField();
         part.addHeader(field);
     }
@@ -1065,7 +1065,7 @@ QWspPush QWspPduDecoder::decodePush()

     decodeContentTypeAndHeaders(part, hdrLen);

-    part.readData(dev, ((int)dev->size()) - ((int)(dev->pos())));
+    part.readData(dev, (static_cast<int>(dev->size())) - (static_cast<int>=
(dev->pos())));

     return part;
 }
@@ -1128,16 +1128,16 @@ QString QWspPduDecoder::decodeCharset( const QStrin=
g &encoded, quint32 mib)
     {
         for(int x =3D 1; x < encoded.length(); x+=3D2)
         {
-            bytes[x-1] =3D (char)encoded[x].unicode();
-            bytes[x] =3D (char)encoded[x-1].unicode();
+            bytes[x-1] =3D static_cast<char>(encoded[x].unicode());
+            bytes[x] =3D static_cast<char>(encoded[x-1].unicode());
         }
     }
     else
     {
-        int posn =3D (int)encoded.length();
+        int posn =3D encoded.length();
         while ( posn > 0 ) {
             --posn;
-            bytes[posn] =3D (char)( encoded[posn].unicode() );
+            bytes[posn] =3D static_cast<char>( encoded[posn].unicode() );
         }
     }

@@ -1179,7 +1179,7 @@ QWspPduEncoder::~QWspPduEncoder()
 */
 void QWspPduEncoder::encodeOctet(quint8 octet)
 {
-    dev->putChar((char)octet);
+    dev->putChar(static_cast<char>(octet));
 }

 /*!
@@ -1187,7 +1187,7 @@ void QWspPduEncoder::encodeOctet(quint8 octet)
 */
 void QWspPduEncoder::encodeUInt8(quint8 octet)
 {
-    dev->putChar((char)octet);
+    dev->putChar(static_cast<char>(octet));
 }

 /*!
@@ -1195,8 +1195,8 @@ void QWspPduEncoder::encodeUInt8(quint8 octet)
 */
 void QWspPduEncoder::encodeUInt16(quint16 d)
 {
-    dev->putChar((char)(d >> 8));
-    dev->putChar((char)(d & 0x0f));
+    dev->putChar(static_cast<char>(d >> 8));
+    dev->putChar(static_cast<char>(d & 0x0f));
 }

 /*!
@@ -1204,10 +1204,10 @@ void QWspPduEncoder::encodeUInt16(quint16 d)
 */
 void QWspPduEncoder::encodeUInt32(quint32 d)
 {
-    dev->putChar((char)((d >> 24) & 0x0f));
-    dev->putChar((char)((d >> 16) & 0x0f));
-    dev->putChar((char)((d >> 8) & 0x0f));
-    dev->putChar((char)(d & 0x0f));
+    dev->putChar(static_cast<char>((d >> 24) & 0x0f));
+    dev->putChar(static_cast<char>((d >> 16) & 0x0f));
+    dev->putChar(static_cast<char>((d >> 8) & 0x0f));
+    dev->putChar(static_cast<char>(d & 0x0f));
 }

 /*!
@@ -1228,7 +1228,7 @@ void QWspPduEncoder::encodeUIntVar(quint32 iv)
         int val =3D d[count];
         if (count)
             val |=3D 0x80;
-        dev->putChar((char)val);
+        dev->putChar(static_cast<char>(val));
     }
 }

@@ -1237,7 +1237,7 @@ void QWspPduEncoder::encodeUIntVar(quint32 iv)
 */
 void QWspPduEncoder::encodeShortInteger(quint8 d)
 {
-    dev->putChar((char)(d | 0x80));
+    dev->putChar(static_cast<char>(d | 0x80));
 }

 /*!
@@ -1255,7 +1255,7 @@ void QWspPduEncoder::encodeLongInteger(quint32 iv)
     encodeUInt8(count);
     while (count) {
         count--;
-        dev->putChar((char)(d[count]));
+        dev->putChar(static_cast<char>(d[count]));
     }
 }

@@ -1288,13 +1288,13 @@ void QWspPduEncoder::encodeLength(quint32 d)
 */
 void QWspPduEncoder::encodeTextString(const QString &str)
 {
-    if ((uchar)str[0].toLatin1() >=3D 128)
+    if (static_cast<uchar>(str[0].toLatin1()) >=3D 128)
         dev->putChar('\"');

     for (int i =3D 0; i < str.length(); i++)
-        dev->putChar((char)(str[i].toLatin1()));
+        dev->putChar((str[i].toLatin1()));

-    if ((uchar)str[0].toLatin1() >=3D 128)
+    if (static_cast<uchar>(str[0].toLatin1()) >=3D 128)
         dev->putChar('\"');

     dev->putChar(0);
@@ -1614,8 +1614,8 @@ void QWspPduEncoder::encodePush(const QWspPush &part)

     quint32 hdrLen =3D buffer.buffer().size();

-    encodeOctet((quint8)(part.identifier()));
-    encodeOctet((quint8)(part.pduType()));
+    encodeOctet(static_cast<quint8>(part.identifier()));
+    encodeOctet(static_cast<quint8>(part.pduType()));
     encodeUIntVar(hdrLen);
     buffer.close();

@@ -1630,7 +1630,7 @@ QString QWspPduEncoder::unquoteString(const QString &=
str)

     if ( tmp[0] =3D=3D '\"' )
         tmp =3D tmp.right( tmp.length() - 1 );
-    if ( tmp[(int)tmp.length() - 1] =3D=3D '\"' )
+    if ( tmp[tmp.length() - 1] =3D=3D '\"' )
         tmp =3D tmp.left( tmp.length() - 1 );

     return tmp;
@@ -1977,7 +1977,7 @@ QString QWspPush::quickContentType( const QByteArray&=
 data )
                 type =3D contentTypeAssignments[ch];
         } else {
             while ( ch !=3D 0 ) {
-                type +=3D (QChar)ch;
+                type +=3D QChar(ch);
                 ++posn;
                 if ( posn < size )
                     ch =3D data[posn] & 0xFF;
@@ -1991,7 +1991,7 @@ QString QWspPush::quickContentType( const QByteArray&=
 data )
             type =3D contentTypeAssignments[ch];
     } else {
         while ( ch !=3D 0 ) {
-            type +=3D (QChar)ch;
+            type +=3D QChar(ch);
             ++posn;
             if ( posn < size )
                 ch =3D data[posn] & 0xFF;
@@ -2004,8 +2004,8 @@ QString QWspPush::quickContentType( const QByteArray&=
 data )

     // Make sure that the content type does not contain
     // invalid characters, to protect the filesystem.
-    for ( posn =3D 0; posn < (uint)(type.length()); ++posn ) {
-        ch =3D (int)(type[posn].unicode());
+    for ( posn =3D 0; posn < static_cast<uint>(type.length()); ++posn ) {
+        ch =3D static_cast<int>(type[posn].unicode());
         if ( ch >=3D 'A' && ch <=3D 'Z' )
             continue;
         if ( ch >=3D 'a' && ch <=3D 'z' )
@@ -2017,7 +2017,7 @@ QString QWspPush::quickContentType( const QByteArray&=
 data )
         if ( ch =3D=3D '/' ) {
             // If the '/' is followed by '.', it may be an attempt
             // to do "xyz/..", which would be bad.
-            if ( (posn + 1) < (uint)(type.length()) && type[posn + 1] =3D=
=3D '.' )
+            if ( (posn + 1) < static_cast<uint>(type.length()) && type[pos=
n + 1] =3D=3D '.' )
                 return QString();

             // Cannot use '/' at the start of a MIME type.
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 84058af..5968399 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -910,43 +910,43 @@ void DemoSimApplication::sendToneMenu()
     cmd.setType( QSimCommand::SelectItem );
     cmd.setTitle( "Tones" );

-    item.setIdentifier( (uint)QSimCommand::ToneDial );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneDial) );
     item.setLabel( "Dial" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneBusy );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneBusy) );
     item.setLabel( "Busy" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneCongestion );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneCongestion) );
     item.setLabel( "Congestion" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneRadioAck );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneRadioAck) );
     item.setLabel( "Radio Ack" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneDropped );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneDropped) );
     item.setLabel( "Dropped" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneError );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneError) );
     item.setLabel( "Error" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneCallWaiting );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneCallWaiting) );
     item.setLabel( "Call Waiting" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneGeneralBeep );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneGeneralBeep) );
     item.setLabel( "General Beep" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::TonePositiveBeep );
+    item.setIdentifier( static_cast<uint>(QSimCommand::TonePositiveBeep) );
     item.setLabel( "Positive Beep" );
     items +=3D item;

-    item.setIdentifier( (uint)QSimCommand::ToneNegativeBeep );
+    item.setIdentifier( static_cast<uint>(QSimCommand::ToneNegativeBeep) );
     item.setLabel( "Negative Beep" );
     items +=3D item;

@@ -964,7 +964,7 @@ void DemoSimApplication::toneMenu( const QSimTerminalRe=
sponse& resp )
         cmd.setType( QSimCommand::PlayTone );
         cmd.setText( "Play a standard supervisory tone" );
         cmd.setDestinationDevice( QSimCommand::Earpiece );
-        cmd.setTone( (QSimCommand::Tone)( resp.menuItem() ) );
+        cmd.setTone( static_cast<QSimCommand::Tone>( resp.menuItem() ) );
         if ( cmd.tone() =3D=3D QSimCommand::ToneDial )
             cmd.setDuration( 5000 );
         else if ( cmd.tone() =3D=3D QSimCommand::ToneGeneralBeep ||
@@ -2338,28 +2338,28 @@ void DemoSimApplication::refreshMenuResp( const QSi=
mTerminalResponse& resp )
             cmd.refreshType() =3D=3D QSimCommand::InitAndFileChange ||
             cmd.refreshType() =3D=3D QSimCommand::NaaSessionReset ) {
         QByteArray files;
-        files +=3D (char) 0x03;
+        files +=3D static_cast<char>(0x03);
         /* EFmsisdn */
-        files +=3D (char) 0x3f;
-        files +=3D (char) 0x00;
-        files +=3D (char) 0x7f;
-        files +=3D (char) 0xff;
-        files +=3D (char) 0x6f;
-        files +=3D (char) 0x40;
+        files +=3D static_cast<char>(0x3f);
+        files +=3D static_cast<char>(0x00);
+        files +=3D static_cast<char>(0x7f);
+        files +=3D static_cast<char>(0xff);
+        files +=3D static_cast<char>(0x6f);
+        files +=3D static_cast<char>(0x40);
         /* EFecc */
-        files +=3D (char) 0x3f;
-        files +=3D (char) 0x00;
-        files +=3D (char) 0x7f;
-        files +=3D (char) 0xff;
-        files +=3D (char) 0x6f;
-        files +=3D (char) 0xb7;
+        files +=3D static_cast<char>(0x3f);
+        files +=3D static_cast<char>(0x00);
+        files +=3D static_cast<char>(0x7f);
+        files +=3D static_cast<char>(0xff);
+        files +=3D static_cast<char>(0x6f);
+        files +=3D static_cast<char>(0xb7);
         /* EFfdn */
-        files +=3D (char) 0x3f;
-        files +=3D (char) 0x00;
-        files +=3D (char) 0x7f;
-        files +=3D (char) 0xff;
-        files +=3D (char) 0x6f;
-        files +=3D (char) 0x3b;
+        files +=3D static_cast<char>(0x3f);
+        files +=3D static_cast<char>(0x00);
+        files +=3D static_cast<char>(0x7f);
+        files +=3D static_cast<char>(0xff);
+        files +=3D static_cast<char>(0x6f);
+        files +=3D static_cast<char>(0x3b);
         cmd.addExtensionField( 0x92, files );
     }

@@ -2451,8 +2451,8 @@ void DemoSimApplication::BIPMenu( const QSimTerminalR=
esponse& resp )

                 destAddress +=3D 0x21;
                 destAddress +=3D 0x7F; /* local host 127.0.0.1 */
-                destAddress +=3D (char) 0x00;
-                destAddress +=3D (char) 0x00;
+                destAddress +=3D static_cast<char>(0x00);
+                destAddress +=3D static_cast<char>(0x00);
                 destAddress +=3D 0x01;

                 apn +=3D 0x06;
@@ -2501,8 +2501,8 @@ void DemoSimApplication::BIPMenu( const QSimTerminalR=
esponse& resp )

                 destAddress +=3D 0x21;
                 destAddress +=3D 0x7F; /* local host 127.0.0.1 */
-                destAddress +=3D (char) 0x00;
-                destAddress +=3D (char) 0x00;
+                destAddress +=3D static_cast<char>(0x00);
+                destAddress +=3D static_cast<char>(0x00);
                 destAddress +=3D 0x01;

                 apn +=3D 0x06;
diff --git a/src/simauth.cpp b/src/simauth.cpp
index 93b8826..b5fc7b1 100644
--- a/src/simauth.cpp
+++ b/src/simauth.cpp
@@ -52,8 +52,8 @@ void SimAuth::gsmAuthenticate( QString rand, QString &sre=
s,

     comp128( ki, _rand, _sres, _kc );

-    sres =3D QByteArray( (const char *)_sres, 4 ).toHex();
-    kc =3D QByteArray( (const char *)_kc, 8 ).toHex();
+    sres =3D QByteArray( reinterpret_cast<const char *>(_sres), 4 ).toHex(=
);
+    kc =3D QByteArray( reinterpret_cast<const char *>(_kc), 8 ).toHex();
 }

 /*
@@ -167,7 +167,7 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString rand=
, QString autn,

         memcpy(_auts + 6, out1 + 8, 8);

-        auts =3D QByteArray( (const char *)_auts, 14 ).toHex();
+        auts =3D QByteArray( reinterpret_cast<const char *>(_auts), 14 ).t=
oHex();

         return UMTS_SYNC_FAILURE;
     }
@@ -206,9 +206,9 @@ enum UmtsStatus SimAuth::umtsAuthenticate( QString rand=
, QString autn,
     /* ik ^ opc */
     XOR(_ik, _ik, opc, 16);

-    res =3D QByteArray( (const char *)_res, 8 ).toHex();
-    ck =3D QByteArray( (const char *)_ck, 16 ).toHex();
-    ik =3D QByteArray( (const char *)_ik, 16 ).toHex();
+    res =3D QByteArray( reinterpret_cast<const char *>(_res), 8 ).toHex();
+    ck =3D QByteArray( reinterpret_cast<const char *>(_ck), 16 ).toHex();
+    ik =3D QByteArray( reinterpret_cast<const char *>(_ik), 16 ).toHex();

     return UMTS_OK;
 }
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index b3ea8a4..7293a2f 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -249,8 +249,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )

         case 176:       // READ BINARY
         {
-            offset =3D (int)((p1 << 8) + p2);
-            length =3D (int)p3;
+            offset =3D static_cast<int>((p1 << 8) + p2);
+            length =3D static_cast<int>(p3);
             item =3D findItem( fileid );
             if ( !item ) {
                 sw1 =3D 0x94;
@@ -283,8 +283,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )

         case 178:       // READ RECORD
         {
-            offset =3D (int)(p1 - 1);
-            length =3D (int)p3;
+            offset =3D static_cast<int>(p1 - 1);
+            length =3D static_cast<int>(p3);
             item =3D findItem( fileid );
             if ( !item ) {
                 sw1 =3D 0x94;
@@ -339,8 +339,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )
             status[0] =3D 0x00;           // RFU
             status[1] =3D 0x00;
             int size =3D currentItem->contents().size();
-            status[2] =3D (char)(size >> 8);
-            status[3] =3D (char)size;
+            status[2] =3D static_cast<char>(size >> 8);
+            status[3] =3D static_cast<char>(size);
             status[4] =3D fileid.left(2).toInt(0, 16);
             status[5] =3D fileid.right(2).toInt(0, 16);
             if ( currentItem =3D=3D rootItem ) {
@@ -365,8 +365,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )
                 status[13] =3D 0x00;
                 status[14] =3D 0x00;
             } else if ( currentItem->recordSize() > 0 ) {
-                status[13] =3D (char)(currentItem->type() );
-                status[14] =3D (char)( currentItem->recordSize() );
+                status[13] =3D static_cast<char>(currentItem->type() );
+                status[14] =3D static_cast<char>( currentItem->recordSize(=
) );
             } else {
                 status[13] =3D 0x00;
                 status[14] =3D 0x00;
@@ -379,8 +379,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )

         case 214:       // UPDATE BINARY
         {
-            offset =3D (int)((p1 << 8) + p2);
-            length =3D (int)p3;
+            offset =3D static_cast<int>((p1 << 8) + p2);
+            length =3D static_cast<int>(p3);
             item =3D findItem( fileid );
             if ( !item ) {
                 sw1 =3D 0x94;
@@ -415,8 +415,8 @@ bool SimFileSystem::fileAccess( const QString& args, QS=
tring& resp )

         case 220:       // UPDATE RECORD
         {
-            offset =3D (int)(p1 - 1);
-            length =3D (int)p3;
+            offset =3D static_cast<int>(p1 - 1);
+            length =3D static_cast<int>(p3);
             item =3D findItem( fileid );
             if ( !item ) {
                 sw1 =3D 0x94;
--
2.24.0

--===============1711445674162592912==--

