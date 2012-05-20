Content-Type: multipart/mixed; boundary="===============3445093868443037737=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 08/12] Do not set signature and reply in GDBus tables
Date: Sun, 20 May 2012 02:07:32 -0300
Message-ID: <1337490456-10941-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3445093868443037737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use GDBUS_* macros, so signature and reply fields are not set in each
method/signal.
---
 plugins/hfp_hf.c            |    4 +--
 plugins/push-notification.c |    6 ++--
 plugins/smart-messaging.c   |   23 +++++++---------
 src/audio-settings.c        |    8 +++---
 src/call-barring.c          |   37 ++++++++++++-------------
 src/call-forwarding.c       |   12 ++++----
 src/call-meter.c            |   24 ++++++++--------
 src/call-settings.c         |   14 +++++-----
 src/call-volume.c           |   10 +++----
 src/cbs.c                   |   14 +++++-----
 src/cdma-connman.c          |   14 +++++-----
 src/cdma-netreg.c           |    6 ++--
 src/cdma-sms.c              |    2 +-
 src/cdma-voicecall.c        |   23 ++++++++--------
 src/ctm.c                   |   14 +++++-----
 src/gnss.c                  |    6 ++--
 src/gprs.c                  |   41 ++++++++++++++-------------
 src/handsfree.c             |   20 +++++++-------
 src/location-reporting.c    |   16 +++++------
 src/manager.c               |    6 ++--
 src/message-waiting.c       |   10 +++----
 src/message.c               |    6 ++--
 src/modem.c                 |   10 +++----
 src/network.c               |   20 +++++++-------
 src/phonebook.c             |    2 +-
 src/radio-settings.c        |   10 +++----
 src/sim.c                   |   22 +++++++--------
 src/sms.c                   |   18 ++++++------
 src/stk.c                   |   14 +++++-----
 src/ussd.c                  |   18 ++++++------
 src/voicecall.c             |   64 ++++++++++++++++++++-------------------=
----
 31 files changed, 240 insertions(+), 254 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 628e034..16c7d5b 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -199,10 +199,10 @@ static DBusMessage *hfp_agent_release(DBusConnection =
*conn,
 }
 =

 static const GDBusMethodTable agent_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("NewConnection", "hq", "",
+	{ GDBUS_ASYNC_METHOD("NewConnection",
 			      GDBUS_ARGS({ "fd", "h" }, { "version", "q" }),
 			      NULL, hfp_agent_new_connection) },
-	{ _GDBUS_METHOD("Release", "", "", NULL, NULL, hfp_agent_release) },
+	{ GDBUS_METHOD("Release", NULL, NULL, hfp_agent_release) },
 	{ }
 };
 =

diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index b916a6a..f6ca365 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -152,11 +152,9 @@ static DBusMessage *push_notification_unregister_agent=
(DBusConnection *conn,
 }
 =

 static const GDBusMethodTable push_notification_methods[] =3D {
-	{ _GDBUS_METHOD("RegisterAgent", "o", "",
-			GDBUS_ARGS({ "path", "o" }), NULL,
+	{ GDBUS_METHOD("RegisterAgent",	GDBUS_ARGS({ "path", "o" }), NULL,
 			push_notification_register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
-			GDBUS_ARGS({ "path", "o" }), NULL,
+	{ GDBUS_METHOD("UnregisterAgent", GDBUS_ARGS({ "path", "o" }), NULL,
 			push_notification_unregister_agent) },
 	{ }
 };
diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index a924f00..b368917 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -269,21 +269,18 @@ static DBusMessage *smart_messaging_send_vcal(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable smart_messaging_methods[] =3D {
-	{ _GDBUS_METHOD("RegisterAgent", "o", "",
-			GDBUS_ARGS({ "path", "o" }), NULL,
+	{ GDBUS_METHOD("RegisterAgent", GDBUS_ARGS({ "path", "o" }), NULL,
 			smart_messaging_register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
-			GDBUS_ARGS({ "path", "o" }), NULL,
+	{ GDBUS_METHOD("UnregisterAgent", GDBUS_ARGS({ "path", "o" }), NULL,
 			smart_messaging_unregister_agent) },
-	{ _GDBUS_ASYNC_METHOD("SendBusinessCard", "say", "o",
-			      GDBUS_ARGS({ "to", "s" }, { "card", "ay" }),
-			      GDBUS_ARGS({ "path", "o" }),
-			      smart_messaging_send_vcard) },
-	{ _GDBUS_ASYNC_METHOD("SendAppointment", "say", "o",
-			      GDBUS_ARGS({ "to", "s" },
-			                      { "appointment", "ay" }),
-			      GDBUS_ARGS({ "path", "o" }),
-			      smart_messaging_send_vcal) },
+	{ GDBUS_ASYNC_METHOD("SendBusinessCard",
+				GDBUS_ARGS({ "to", "s" }, { "card", "ay" }),
+				GDBUS_ARGS({ "path", "o" }),
+				smart_messaging_send_vcard) },
+	{ GDBUS_ASYNC_METHOD("SendAppointment",
+			GDBUS_ARGS({ "to", "s" }, { "appointment", "ay" }),
+			GDBUS_ARGS({ "path", "o" }),
+			smart_messaging_send_vcal) },
 	{ }
 };
 =

diff --git a/src/audio-settings.c b/src/audio-settings.c
index a83e9ac..aae7423 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -118,14 +118,14 @@ static DBusMessage *audio_get_properties(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable audio_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      audio_get_properties) },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				audio_get_properties) },
 	{ }
 };
 =

 static const GDBusSignalTable audio_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/call-barring.c b/src/call-barring.c
index af78564..ddf4c73 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -967,30 +967,29 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cb_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      cb_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "svs", "",
-			      GDBUS_ARGS({ "property", "s" },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				cb_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" },
 					{ "value", "v" }, { "pin2", "s" }),
-			      NULL, cb_set_property) },
-	{ _GDBUS_ASYNC_METHOD("DisableAll", "s", "",
-			      GDBUS_ARGS({ "password", "s" }), NULL,
-			      cb_disable_ab) },
-	{ _GDBUS_ASYNC_METHOD("DisableAllIncoming", "s", "",
-			      GDBUS_ARGS({ "password", "s" }), NULL,
-			      cb_disable_ac) },
-	{ _GDBUS_ASYNC_METHOD("DisableAllOutgoing", "s", "",
-			      GDBUS_ARGS({ "password", "s" }), NULL,
-			      cb_disable_ag) },
-	{ _GDBUS_ASYNC_METHOD("ChangePassword", "ss", "",
-			      GDBUS_ARGS({ "old", "s" }, { "new", "s" }),
-			      NULL, cb_set_passwd) },
+			NULL, cb_set_property) },
+	{ GDBUS_ASYNC_METHOD("DisableAll", GDBUS_ARGS({ "password", "s" }),
+			NULL, cb_disable_ab) },
+	{ GDBUS_ASYNC_METHOD("DisableAllIncoming",
+			GDBUS_ARGS({ "password", "s" }), NULL,
+			cb_disable_ac) },
+	{ GDBUS_ASYNC_METHOD("DisableAllOutgoing",
+			GDBUS_ARGS({ "password", "s" }), NULL,
+			cb_disable_ag) },
+	{ GDBUS_ASYNC_METHOD("ChangePassword",
+			GDBUS_ARGS({ "old", "s" }, { "new", "s" }),
+			NULL, cb_set_passwd) },
 	{ }
 };
 =

 static const GDBusSignalTable cb_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 171feee..3d9c5c1 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -882,20 +882,20 @@ static DBusMessage *cf_disable_all(DBusConnection *co=
nn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cf_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_ASYNC_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				cf_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, cf_set_property) },
-	{ _GDBUS_ASYNC_METHOD("DisableAll", "s", "",
-				GDBUS_ARGS({ "type", "s" }), NULL,
-				cf_disable_all) },
+	{ GDBUS_ASYNC_METHOD("DisableAll",
+			GDBUS_ARGS({ "type", "s" }), NULL,
+			cf_disable_all) },
 	{ }
 };
 =

 static const GDBusSignalTable cf_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/call-meter.c b/src/call-meter.c
index a67815d..00a0127 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -647,23 +647,23 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn=
, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cm_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      cm_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "svs", "",
-			      GDBUS_ARGS({ "property", "s" }, { "value", "v" },
-					 { "password", "s" }),
-			      NULL, cm_set_property) },
-	{ _GDBUS_ASYNC_METHOD("Reset", "s", "",
-			      GDBUS_ARGS({ "passoword", "s" }), NULL,
-			      cm_acm_reset) },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				cm_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" },
+							{ "password", "s" }),
+			NULL, cm_set_property) },
+	{ GDBUS_ASYNC_METHOD("Reset",
+				GDBUS_ARGS({ "passoword", "s" }), NULL,
+				cm_acm_reset) },
 	{ }
 };
 =

 static const GDBusSignalTable cm_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("NearMaximumWarning", "", NULL) },
+	{ GDBUS_SIGNAL("NearMaximumWarning", NULL) },
 	{ }
 };
 =

diff --git a/src/call-settings.c b/src/call-settings.c
index f0fc68d..6bc9658 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1331,17 +1331,17 @@ static DBusMessage *cs_set_property(DBusConnection =
*conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cs_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      cs_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-			      NULL, cs_set_property) },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				cs_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, cs_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cs_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/call-volume.c b/src/call-volume.c
index 22b505c..ddb8b77 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -302,17 +302,17 @@ static DBusMessage *cv_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cv_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			cv_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-			      NULL, cv_set_property) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, cv_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cv_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/cbs.c b/src/cbs.c
index 23c9497..b5f0b72 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -541,21 +541,21 @@ static DBusMessage *cbs_set_property(DBusConnection *=
conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cbs_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			cbs_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-			      NULL, cbs_set_property) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, cbs_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cbs_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("IncomingBroadcast", "sq",
+	{ GDBUS_SIGNAL("IncomingBroadcast",
 			GDBUS_ARGS({ "message", "s" }, { "channel", "q" })) },
-	{ _GDBUS_SIGNAL("EmergencyBroadcast", "sa{sv}",
+	{ GDBUS_SIGNAL("EmergencyBroadcast",
 			GDBUS_ARGS({ "message", "s" }, { "dict", "a{sv}" })) },
 	{ }
 };
diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 8064542..2f2ea54 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -518,17 +518,17 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable cdma_connman_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				cdma_connman_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-			      NULL, cdma_connman_set_property) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			cdma_connman_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, cdma_connman_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cdma_connman_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 9246f0c..ba9ee23 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -108,9 +108,9 @@ static DBusMessage *network_get_properties(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable cdma_netreg_manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      network_get_properties) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			network_get_properties) },
 	{ }
 };
 =

diff --git a/src/cdma-sms.c b/src/cdma-sms.c
index f7a09fe..108455e 100644
--- a/src/cdma-sms.c
+++ b/src/cdma-sms.c
@@ -49,7 +49,7 @@ static const GDBusMethodTable cdma_sms_manager_methods[] =
=3D {
 };
 =

 static const GDBusSignalTable cdma_sms_manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("IncomingMessage", "sa{sv}",
+	{ GDBUS_SIGNAL("IncomingMessage",
 			GDBUS_ARGS({ "message", "s"}, { "info", "a{sv}" })) },
 	/* TODO */
 	{ }
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index f7ee09a..fd38dd8 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -406,29 +406,28 @@ static DBusMessage *voicecall_manager_tone(DBusConnec=
tion *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      voicecall_manager_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Dial", "s", "",
-					GDBUS_ARGS({ "number", "s" }), NULL,
-					voicecall_manager_dial) },
-	{ _GDBUS_ASYNC_METHOD("Hangup", "", "", NULL, NULL,
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			voicecall_manager_get_properties) },
+	{ GDBUS_ASYNC_METHOD("Dial", GDBUS_ARGS({ "number", "s" }), NULL,
+						voicecall_manager_dial) },
+	{ GDBUS_ASYNC_METHOD("Hangup", NULL, NULL,
 						voicecall_manager_hangup) },
-	{ _GDBUS_ASYNC_METHOD("Answer", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("Answer", NULL, NULL,
 						voicecall_manager_answer) },
-	{ _GDBUS_ASYNC_METHOD("SendFlash", "s", "",
+	{ GDBUS_ASYNC_METHOD("SendFlash",
 				GDBUS_ARGS({ "flash_string", "s" }), NULL,
 				voicecall_manager_flash) },
-	{ _GDBUS_ASYNC_METHOD("SendTones", "s", "",
+	{ GDBUS_ASYNC_METHOD("SendTones",
 				GDBUS_ARGS({ "tones", "s" }), NULL,
 				voicecall_manager_tone) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("DisconnectReason", "s",
+	{ GDBUS_SIGNAL("DisconnectReason",
 			GDBUS_ARGS({ "reason", "s" })) },
 	{ }
 };
diff --git a/src/ctm.c b/src/ctm.c
index fd7df5e..cb8f147 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -203,17 +203,17 @@ static DBusMessage *ctm_set_property(DBusConnection *=
conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable ctm_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      ctm_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }), NULL,
-		      ctm_set_property) },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			ctm_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }), NULL,
+			ctm_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable ctm_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/gnss.c b/src/gnss.c
index 3d2d793..97d1152 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -233,13 +233,13 @@ static DBusMessage *gnss_send_element(DBusConnection =
*conn,
 }
 =

 static const GDBusMethodTable gnss_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("SendPositioningElement", "s", "",
+	{ GDBUS_ASYNC_METHOD("SendPositioningElement",
 			GDBUS_ARGS({ "xml_element" "s" }), NULL,
 			gnss_send_element) },
-	{ _GDBUS_ASYNC_METHOD("RegisterPositioningRequestAgent", "o", "",
+	{ GDBUS_ASYNC_METHOD("RegisterPositioningRequestAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			gnss_register_agent) },
-	{ _GDBUS_ASYNC_METHOD("UnregisterPositioningRequestAgent", "o", "",
+	{ GDBUS_ASYNC_METHOD("UnregisterPositioningRequestAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			gnss_unregister_agent) },
 	{ }
diff --git a/src/gprs.c b/src/gprs.c
index 9a4138e..994607d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1283,17 +1283,17 @@ static DBusMessage *pri_set_property(DBusConnection=
 *conn,
 }
 =

 static const GDBusMethodTable context_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      pri_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-		      NULL, pri_set_property) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			pri_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, pri_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable context_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
@@ -2067,34 +2067,33 @@ static DBusMessage *gprs_get_contexts(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      gprs_get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
-		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-		      NULL, gprs_set_property) },
-	{ _GDBUS_ASYNC_METHOD("AddContext", "s", "o",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			gprs_get_properties) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, gprs_set_property) },
+	{ GDBUS_ASYNC_METHOD("AddContext",
 			GDBUS_ARGS({ "type", "s" }),
 			GDBUS_ARGS({ "path", "o" }),
 			gprs_add_context) },
-	{ _GDBUS_ASYNC_METHOD("RemoveContext", "o", "",
+	{ GDBUS_ASYNC_METHOD("RemoveContext",
 			GDBUS_ARGS({ "path", "o" }), NULL,
 			gprs_remove_context) },
-	{ _GDBUS_ASYNC_METHOD("DeactivateAll", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("DeactivateAll", NULL, NULL,
 			gprs_deactivate_all) },
-	{ _GDBUS_METHOD("GetContexts", "", "a(oa{sv})",
-			NULL,
+	{ GDBUS_METHOD("GetContexts", NULL,
 			GDBUS_ARGS({ "contexts_with_properties", "a(oa{sv})" }),
 			gprs_get_contexts) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("ContextAdded", "oa{sv}",
+	{ GDBUS_SIGNAL("ContextAdded",
 			GDBUS_ARGS({ "path", "o" }, { "properties", "v" })) },
-	{ _GDBUS_SIGNAL("ContextRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
+	{ GDBUS_SIGNAL("ContextRemoved", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

diff --git a/src/handsfree.c b/src/handsfree.c
index e2d47d6..40caf93 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -271,20 +271,20 @@ static DBusMessage *handsfree_request_phone_number(DB=
usConnection *conn,
 }
 =

 static const GDBusMethodTable handsfree_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			      handsfree_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
-		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
-		      NULL, handsfree_set_property) },
-	{ _GDBUS_ASYNC_METHOD("RequestPhoneNumber", "", "s",
-				NULL, GDBUS_ARGS({ "number", "s" }),
-				handsfree_request_phone_number) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			handsfree_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, handsfree_set_property) },
+	{ GDBUS_ASYNC_METHOD("RequestPhoneNumber",
+			NULL, GDBUS_ARGS({ "number", "s" }),
+			handsfree_request_phone_number) },
 	{ }
 };
 =

 static const GDBusSignalTable handsfree_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/location-reporting.c b/src/location-reporting.c
index 9ea200c..6a3e03c 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -240,19 +240,19 @@ static DBusMessage *location_reporting_release(DBusCo=
nnection *conn,
 }
 =

 static const GDBusMethodTable location_reporting_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				location_reporting_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Request", "", "h",
-				NULL, GDBUS_ARGS({ "fd", "h" }),
-				location_reporting_request) },
-	{ _GDBUS_ASYNC_METHOD("Release", "", "", NULL, NULL,
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			location_reporting_get_properties) },
+	{ GDBUS_ASYNC_METHOD("Request",
+			NULL, GDBUS_ARGS({ "fd", "h" }),
+			location_reporting_request) },
+	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL,
 					location_reporting_release) },
 	{ }
 };
 =

 static const GDBusSignalTable location_reporting_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index 18df994..393b689 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -81,16 +81,16 @@ static DBusMessage *manager_get_modems(DBusConnection *=
conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetModems", "", "a(oa{sv})",
+	{ GDBUS_METHOD("GetModems",
 				NULL, GDBUS_ARGS({ "modems", "a(oa{sv})" }),
 				manager_get_modems) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("ModemAdded", "oa{sv}",
+	{ GDBUS_SIGNAL("ModemAdded",
 				GDBUS_ARGS({ "modems", "a(oa{sv})" })) },
-	{ _GDBUS_SIGNAL("ModemRemoved", "o",
+	{ GDBUS_SIGNAL("ModemRemoved",
 				GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
diff --git a/src/message-waiting.c b/src/message-waiting.c
index b8ced45..fc03d62 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -369,17 +369,17 @@ static DBusMessage *mw_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable message_waiting_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				mw_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			mw_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, mw_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable message_waiting_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/message.c b/src/message.c
index 7c0df3c..a6aedcb 100644
--- a/src/message.c
+++ b/src/message.c
@@ -104,15 +104,15 @@ static DBusMessage *message_cancel(DBusConnection *co=
nn,
 }
 =

 static const GDBusMethodTable message_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				message_get_properties) },
-	{ _GDBUS_METHOD("Cancel", "","", NULL, NULL, message_cancel) },
+	{ GDBUS_METHOD("Cancel", NULL, NULL, message_cancel) },
 	{ }
 };
 =

 static const GDBusSignalTable message_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/modem.c b/src/modem.c
index e5a3b68..de72d63 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1124,17 +1124,17 @@ static DBusMessage *modem_set_property(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable modem_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				modem_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			modem_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, modem_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable modem_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/network.c b/src/network.c
index ede8437..32be6fc 100644
--- a/src/network.c
+++ b/src/network.c
@@ -624,16 +624,16 @@ static DBusMessage *network_operator_register(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable network_operator_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				network_operator_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Register", "", "", NULL, NULL,
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			network_operator_get_properties) },
+	{ GDBUS_ASYNC_METHOD("Register", NULL, NULL,
 						network_operator_register) },
 	{ }
 };
 =

 static const GDBusSignalTable network_operator_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
@@ -1024,22 +1024,22 @@ static DBusMessage *network_get_operators(DBusConne=
ction *conn,
 }
 =

 static const GDBusMethodTable network_registration_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			network_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Register", "", "",
+	{ GDBUS_ASYNC_METHOD("Register",
 				NULL, NULL, network_register) },
-	{ _GDBUS_METHOD("GetOperators", "", "a(oa{sv})",
+	{ GDBUS_METHOD("GetOperators",
 		NULL, GDBUS_ARGS({ "operators_with_properties", "a(oa{sv})" }),
 		network_get_operators) },
-	{ _GDBUS_ASYNC_METHOD("Scan", "", "a(oa{sv})",
+	{ GDBUS_ASYNC_METHOD("Scan",
 		NULL, GDBUS_ARGS({ "operators_with_properties", "a(oa{sv})" }),
 		network_scan) },
 	{ }
 };
 =

 static const GDBusSignalTable network_registration_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/phonebook.c b/src/phonebook.c
index fb52c21..531b5a6 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -480,7 +480,7 @@ static DBusMessage *import_entries(DBusConnection *conn=
, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable phonebook_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("Import", "", "s",
+	{ GDBUS_ASYNC_METHOD("Import",
 			NULL, GDBUS_ARGS({ "entries", "s" }),
 			import_entries) },
 	{ }
diff --git a/src/radio-settings.c b/src/radio-settings.c
index 65c20f5..d1b1cc1 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -602,17 +602,17 @@ static DBusMessage *radio_set_property(DBusConnection=
 *conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable radio_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				radio_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			radio_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, radio_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable radio_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/sim.c b/src/sim.c
index fd8a797..d6aba84 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1068,30 +1068,30 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable sim_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				sim_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			sim_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, sim_set_property) },
-	{ _GDBUS_ASYNC_METHOD("ChangePin", "sss", "",
+	{ GDBUS_ASYNC_METHOD("ChangePin",
 			GDBUS_ARGS({ "type", "s" }, { "oldpin", "s" },
 						{ "newpin", "s" }), NULL,
 			sim_change_pin) },
-	{ _GDBUS_ASYNC_METHOD("EnterPin", "ss", "",
+	{ GDBUS_ASYNC_METHOD("EnterPin",
 			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
 			sim_enter_pin) },
-	{ _GDBUS_ASYNC_METHOD("ResetPin", "sss", "",
+	{ GDBUS_ASYNC_METHOD("ResetPin",
 			GDBUS_ARGS({ "type", "s" }, { "puk", "s" },
 						{ "newpin", "s" }), NULL,
 			sim_reset_pin) },
-	{ _GDBUS_ASYNC_METHOD("LockPin", "ss", "",
+	{ GDBUS_ASYNC_METHOD("LockPin",
 			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
 			sim_lock_pin) },
-	{ _GDBUS_ASYNC_METHOD("UnlockPin", "ss", "",
+	{ GDBUS_ASYNC_METHOD("UnlockPin",
 			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
 			sim_unlock_pin) },
-	{ _GDBUS_ASYNC_METHOD("GetIcon", "y", "ay",
+	{ GDBUS_ASYNC_METHOD("GetIcon",
 			GDBUS_ARGS({ "id", "y" }),
 			GDBUS_ARGS({ "icon", "ay" }),
 			sim_get_icon) },
@@ -1099,7 +1099,7 @@ static const GDBusMethodTable sim_methods[] =3D {
 };
 =

 static const GDBusSignalTable sim_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/sms.c b/src/sms.c
index b700513..b600088 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1104,33 +1104,33 @@ int __ofono_sms_txq_cancel(struct ofono_sms *sms, c=
onst struct ofono_uuid *uuid)
 }
 =

 static const GDBusMethodTable sms_manager_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_ASYNC_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				sms_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, sms_set_property) },
-	{ _GDBUS_ASYNC_METHOD("SendMessage", "ss", "o",
+	{ GDBUS_ASYNC_METHOD("SendMessage",
 			GDBUS_ARGS({ "to", "s" }, { "text", "s" }),
 			GDBUS_ARGS({ "path", "o" }),
 			sms_send_message) },
-	{ _GDBUS_METHOD("GetMessages", "", "a(oa{sv})",
+	{ GDBUS_METHOD("GetMessages",
 			GDBUS_ARGS({ "messages", "a(oa{sv})" }), NULL,
 			sms_get_messages) },
 	{ }
 };
 =

 static const GDBusSignalTable sms_manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("IncomingMessage", "sa{sv}",
+	{ GDBUS_SIGNAL("IncomingMessage",
 			GDBUS_ARGS({ "message", "s" }, { "info", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("ImmediateMessage", "sa{sv}",
+	{ GDBUS_SIGNAL("ImmediateMessage",
 			GDBUS_ARGS({ "message", "s" }, { "info", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("MessageAdded", "oa{sv}",
+	{ GDBUS_SIGNAL("MessageAdded",
 			GDBUS_ARGS({ "path", "o" },
 						{ "properties", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("MessageRemoved", "o",
+	{ GDBUS_SIGNAL("MessageRemoved",
 			GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
diff --git a/src/stk.c b/src/stk.c
index 46921b6..2ccb25e 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -818,23 +818,23 @@ static DBusMessage *stk_select_item(DBusConnection *c=
onn,
 }
 =

 static const GDBusMethodTable stk_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				stk_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SelectItem", "yo", "",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			stk_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SelectItem",
 			GDBUS_ARGS({ "item", "y" }, { "agent", "o" }), NULL,
 			stk_select_item) },
-	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "path", "o" }), NULL,
 			stk_register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "path", "o" }), NULL,
 			stk_unregister_agent) },
 	{ }
 };
 =

 static const GDBusSignalTable stk_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/ussd.c b/src/ussd.c
index 3a95c4e..29cf1b4 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -729,27 +729,27 @@ static DBusMessage *ussd_get_properties(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable ussd_methods[] =3D {
-	{ _GDBUS_ASYNC_METHOD("Initiate", "s", "sv",
+	{ GDBUS_ASYNC_METHOD("Initiate",
 			GDBUS_ARGS({ "command", "s" }),
 			GDBUS_ARGS({ "result_name", "s" }, { "value", "v" }),
 			ussd_initiate) },
-	{ _GDBUS_ASYNC_METHOD("Respond", "s", "s",
+	{ GDBUS_ASYNC_METHOD("Respond",
 			GDBUS_ARGS({ "reply", "s" }),
 			GDBUS_ARGS({ "result", "s" }),
 			ussd_respond) },
-	{ _GDBUS_ASYNC_METHOD("Cancel", "", "", NULL, NULL, ussd_cancel) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				ussd_get_properties) },
+	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL, ussd_cancel) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			ussd_get_properties) },
 	{ }
 };
 =

 static const GDBusSignalTable ussd_signals[] =3D {
-	{ _GDBUS_SIGNAL("NotificationReceived", "s",
+	{ GDBUS_SIGNAL("NotificationReceived",
 					GDBUS_ARGS({ "message", "s" })) },
-	{ _GDBUS_SIGNAL("RequestReceived", "s",
+	{ GDBUS_SIGNAL("RequestReceived",
 					GDBUS_ARGS({ "message", "s" })) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/src/voicecall.c b/src/voicecall.c
index bb99420..dd4a2f9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -668,23 +668,20 @@ static DBusMessage *voicecall_answer(DBusConnection *=
conn,
 }
 =

 static const GDBusMethodTable voicecall_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				voicecall_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Deflect", "s", "",
-					GDBUS_ARGS({ "number", "s" }), NULL,
-					voicecall_deflect) },
-	{ _GDBUS_ASYNC_METHOD("Hangup", "", "", NULL, NULL,
-							voicecall_hangup) },
-	{ _GDBUS_ASYNC_METHOD("Answer", "", "", NULL, NULL,
-							voicecall_answer) },
+	{ GDBUS_ASYNC_METHOD("Deflect", GDBUS_ARGS({ "number", "s" }), NULL,
+							voicecall_deflect) },
+	{ GDBUS_ASYNC_METHOD("Hangup", NULL, NULL, voicecall_hangup) },
+	{ GDBUS_ASYNC_METHOD("Answer", NULL, NULL, voicecall_answer) },
 	{ }
 };
 =

 static const GDBusSignalTable voicecall_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("DisconnectReason", "s",
+	{ GDBUS_SIGNAL("DisconnectReason",
 					GDBUS_ARGS({ "reason", "s" })) },
 	{ }
 };
@@ -2123,49 +2120,46 @@ static DBusMessage *manager_get_calls(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				manager_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Dial", "ss", "o",
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			manager_get_properties) },
+	{ GDBUS_ASYNC_METHOD("Dial",
 		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
 		GDBUS_ARGS({ "path", "o" }),
 		manager_dial) },
-	{ _GDBUS_ASYNC_METHOD("Transfer", "", "", NULL, NULL,
-							manager_transfer) },
-	{ _GDBUS_ASYNC_METHOD("SwapCalls", "", "",  NULL, NULL,
-							manager_swap_calls) },
-	{ _GDBUS_ASYNC_METHOD("ReleaseAndAnswer", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
+	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
+	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
 						manager_release_and_answer) },
-	{ _GDBUS_ASYNC_METHOD("HoldAndAnswer", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("HoldAndAnswer", NULL, NULL,
 						manager_hold_and_answer) },
-	{ _GDBUS_ASYNC_METHOD("HangupAll", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("HangupAll", NULL, NULL,
 						manager_hangup_all) },
-	{ _GDBUS_ASYNC_METHOD("PrivateChat", "o", "ao",
-						GDBUS_ARGS({ "call", "o" }),
+	{ GDBUS_ASYNC_METHOD("PrivateChat", GDBUS_ARGS({ "call", "o" }),
 						GDBUS_ARGS({ "calls", "ao" }),
 						multiparty_private_chat) },
-	{ _GDBUS_ASYNC_METHOD("CreateMultiparty", "", "ao",
+	{ GDBUS_ASYNC_METHOD("CreateMultiparty",
 					NULL, GDBUS_ARGS({ "calls", "o" }),
 					multiparty_create) },
-	{ _GDBUS_ASYNC_METHOD("HangupMultiparty", "", "", NULL, NULL,
-					multiparty_hangup) },
-	{ _GDBUS_ASYNC_METHOD("SendTones", "s", "",
-					GDBUS_ARGS({ "SendTones", "s" }), NULL,
-					manager_tone) },
-	{ _GDBUS_METHOD("GetCalls", "", "a(oa{sv})",
+	{ GDBUS_ASYNC_METHOD("HangupMultiparty", NULL, NULL,
+							multiparty_hangup) },
+	{ GDBUS_ASYNC_METHOD("SendTones",
+				GDBUS_ARGS({ "SendTones", "s" }), NULL,
+				manager_tone) },
+	{ GDBUS_METHOD("GetCalls",
 		NULL, GDBUS_ARGS({ "calls_with_properties", "a(oa{sv})" }),
 		manager_get_calls) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("Forwarded", "s", GDBUS_ARGS({ "type", "s" })) },
-	{ _GDBUS_SIGNAL("BarringActive", "s", GDBUS_ARGS({ "type", "s" })) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("Forwarded", GDBUS_ARGS({ "type", "s" })) },
+	{ GDBUS_SIGNAL("BarringActive", GDBUS_ARGS({ "type", "s" })) },
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("CallAdded", "oa{sv}",
+	{ GDBUS_SIGNAL("CallAdded",
 		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("CallRemoved", "o", GDBUS_ARGS({ "path", "o"})) },
+	{ GDBUS_SIGNAL("CallRemoved", GDBUS_ARGS({ "path", "o"})) },
 	{ }
 };
 =

-- =

1.7.10.2


--===============3445093868443037737==--

