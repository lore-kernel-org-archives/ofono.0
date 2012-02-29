Content-Type: multipart/mixed; boundary="===============3597165199015204794=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/2] phonesim: Add timer to set the variable with the delay
Date: Wed, 29 Feb 2012 11:37:47 +0200
Message-ID: <1330508267-8656-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1330508267-8656-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3597165199015204794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to set the variable with the delay, specify the
delay in milliseconds:

<chat>
	<set name=3D"AAA" value=3D"BBB" delay=3D"30000"/>
</chat>
---
 src/phonesim.cpp |   29 +++++++++++++++++++++++++++--
 src/phonesim.h   |   14 ++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 6931317..44401fe 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -268,8 +268,12 @@ SimChat::SimChat( SimState *state, SimXmlNode& e )
         } else if ( n->tag =3D=3D "switch" ) {
             switchTo =3D n->getAttribute( "name" );
         } else if ( n->tag =3D=3D "set" ) {
-	    variables +=3D n->getAttribute( "name" );
+            QString name =3D n->getAttribute( "name" );
+	    variables +=3D name;
 	    values +=3D n->getAttribute( "value" );
+            int delay =3D n->getAttribute( "delay" ).toInt();
+            if (delay)
+                delays[name] =3D delay;
         } else if ( n->tag =3D=3D "newcall" ) {
             newCallVar =3D n->getAttribute( "name" );
         } else if ( n->tag =3D=3D "forgetcall" ) {
@@ -331,6 +335,7 @@ bool SimChat::command( const QString& cmd )
     for ( int varNum =3D 0; varNum < variables.size(); ++varNum ) {
     	QString variable =3D variables[varNum];
 	QString value =3D values[varNum];
+        int delay =3D delays.value(variable, 0);
         QString val;
 =

         if ( value =3D=3D "*" )
@@ -348,7 +353,18 @@ bool SimChat::command( const QString& cmd )
                 val =3D value;
         }
 =

-        state()->rules()->setVariable( variable, val );
+        if (delay) {
+            QVariantTimer *timer =3D new QVariantTimer(this->state()->rule=
s());
+
+            timer->param =3D QVariant::fromValue(QPairKV(variable, val));
+
+            timer->setSingleShot( true );
+
+            connect(timer, SIGNAL(timeout()), this->state()->rules(),
+                    				SLOT(delaySetVariable()));
+            timer->start( delay );
+        } else
+            state()->rules()->setVariable( variable, val );
     }
 =

     // Switch to the new state.
@@ -1637,6 +1653,15 @@ void SimRules::delayTimeout()
     timer->deleteLater();
 }
 =

+void SimRules::delaySetVariable()
+{
+    QVariantTimer *timer =3D (QVariantTimer *)sender();
+    QPairKV kv =3D timer->param.value<QPairKV>();
+
+    setVariable( kv.first, kv.second );
+
+    delete timer;
+}
 =

 void SimRules::dialCheck( const QString& number, bool& ok )
 {
diff --git a/src/phonesim.h b/src/phonesim.h
index aa693cd..ce69155 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -162,6 +162,7 @@ private:
     bool eol;
     QStringList variables;
     QStringList values;
+    QMap<QString, int> delays;
     QString newCallVar;
     QString forgetCallId;
     bool listSMS;
@@ -315,6 +316,7 @@ private slots:
     void tryReadCommand();
     void destruct();
     void delayTimeout();
+    void delaySetVariable();
     void dialCheck( const QString& number, bool& ok );
 =

 private:
@@ -373,4 +375,16 @@ public:
     int channel;
 };
 =

+class QVariantTimer : public QTimer
+{
+    Q_OBJECT
+public:
+    QVariantTimer( QObject *parent =3D 0 ) : QTimer(parent) { }
+    QVariant param;
+};
+
+typedef QPair<QString,QString> QPairKV;
+
+Q_DECLARE_METATYPE(QPairKV);
+
 #endif
-- =

1.7.5.4


--===============3597165199015204794==--

