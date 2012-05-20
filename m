Content-Type: multipart/mixed; boundary="===============9065921939519883616=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 05/12] Convert GDBus methods to use macro helpers
Date: Sun, 20 May 2012 02:07:29 -0300
Message-ID: <1337490456-10941-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9065921939519883616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With these macro helpers we can separate in/out arguments and use their
own vector.
---
 plugins/hfp_hf.c            |    9 +++--
 plugins/push-notification.c |    8 +++-
 plugins/smart-messaging.c   |   21 +++++++---
 src/audio-settings.c        |    8 ++--
 src/call-barring.c          |   34 ++++++++++-------
 src/call-forwarding.c       |   18 +++++----
 src/call-meter.c            |   21 ++++++----
 src/call-settings.c         |   13 ++++---
 src/call-volume.c           |   12 ++++--
 src/cbs.c                   |   18 ++++++---
 src/cdma-connman.c          |   13 ++++---
 src/cdma-netreg.c           |    4 +-
 src/cdma-sms.c              |    3 +-
 src/cdma-voicecall.c        |   34 ++++++++++-------
 src/ctm.c                   |   13 ++++---
 src/gnss.c                  |   15 +++++---
 src/gprs.c                  |   48 +++++++++++++++--------
 src/handsfree.c             |   19 +++++----
 src/location-reporting.c    |   16 +++++---
 src/manager.c               |   10 +++--
 src/message-waiting.c       |   12 ++++--
 src/message.c               |    9 +++--
 src/modem.c                 |   12 ++++--
 src/network.c               |   31 +++++++++------
 src/phonebook.c             |    5 ++-
 src/radio-settings.c        |   13 ++++---
 src/sim.c                   |   45 ++++++++++++++--------
 src/sms.c                   |   36 +++++++++++------
 src/stk.c                   |   22 +++++++----
 src/ussd.c                  |   29 ++++++++------
 src/voicecall.c             |   89 ++++++++++++++++++++++++++-------------=
----
 31 files changed, 406 insertions(+), 234 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 19a362f..628e034 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -199,10 +199,11 @@ static DBusMessage *hfp_agent_release(DBusConnection =
*conn,
 }
 =

 static const GDBusMethodTable agent_methods[] =3D {
-	{ "NewConnection", "hq", "", hfp_agent_new_connection,
-		G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Release", "", "", hfp_agent_release },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("NewConnection", "hq", "",
+			      GDBUS_ARGS({ "fd", "h" }, { "version", "q" }),
+			      NULL, hfp_agent_new_connection) },
+	{ _GDBUS_METHOD("Release", "", "", NULL, NULL, hfp_agent_release) },
+	{ }
 };
 =

 static int hfp_hf_probe(const char *device, const char *dev_addr,
diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index 1b8f729..b916a6a 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -152,8 +152,12 @@ static DBusMessage *push_notification_unregister_agent=
(DBusConnection *conn,
 }
 =

 static const GDBusMethodTable push_notification_methods[] =3D {
-	{ "RegisterAgent",    "o",   "",  push_notification_register_agent },
-	{ "UnregisterAgent",  "o",   "",  push_notification_unregister_agent },
+	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			push_notification_register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			push_notification_unregister_agent) },
 	{ }
 };
 =

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index 6820b20..a924f00 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -269,12 +269,21 @@ static DBusMessage *smart_messaging_send_vcal(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable smart_messaging_methods[] =3D {
-	{ "RegisterAgent",    "o",     "",  smart_messaging_register_agent },
-	{ "UnregisterAgent",  "o",     "",  smart_messaging_unregister_agent },
-	{ "SendBusinessCard", "say",   "o", smart_messaging_send_vcard,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendAppointment",  "say",   "o", smart_messaging_send_vcal,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			smart_messaging_register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			smart_messaging_unregister_agent) },
+	{ _GDBUS_ASYNC_METHOD("SendBusinessCard", "say", "o",
+			      GDBUS_ARGS({ "to", "s" }, { "card", "ay" }),
+			      GDBUS_ARGS({ "path", "o" }),
+			      smart_messaging_send_vcard) },
+	{ _GDBUS_ASYNC_METHOD("SendAppointment", "say", "o",
+			      GDBUS_ARGS({ "to", "s" },
+			                      { "appointment", "ay" }),
+			      GDBUS_ARGS({ "path", "o" }),
+			      smart_messaging_send_vcal) },
 	{ }
 };
 =

diff --git a/src/audio-settings.c b/src/audio-settings.c
index 0e52761..a83e9ac 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -118,13 +118,15 @@ static DBusMessage *audio_get_properties(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable audio_methods[] =3D {
-	{ "GetProperties", "", "a{sv}", audio_get_properties,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      audio_get_properties) },
 	{ }
 };
 =

 static const GDBusSignalTable audio_signals[] =3D {
-	{ "PropertyChanged", "sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/call-barring.c b/src/call-barring.c
index 6b9bf6e..af78564 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -967,23 +967,31 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cb_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cb_get_properties,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",	"svs",	"",		cb_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "DisableAll",		"s",	"",		cb_disable_ab,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "DisableAllIncoming",	"s",	"",		cb_disable_ac,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "DisableAllOutgoing",	"s",	"",		cb_disable_ag,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ChangePassword",	"ss",	"",		cb_set_passwd,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      cb_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "svs", "",
+			      GDBUS_ARGS({ "property", "s" },
+					{ "value", "v" }, { "pin2", "s" }),
+			      NULL, cb_set_property) },
+	{ _GDBUS_ASYNC_METHOD("DisableAll", "s", "",
+			      GDBUS_ARGS({ "password", "s" }), NULL,
+			      cb_disable_ab) },
+	{ _GDBUS_ASYNC_METHOD("DisableAllIncoming", "s", "",
+			      GDBUS_ARGS({ "password", "s" }), NULL,
+			      cb_disable_ac) },
+	{ _GDBUS_ASYNC_METHOD("DisableAllOutgoing", "s", "",
+			      GDBUS_ARGS({ "password", "s" }), NULL,
+			      cb_disable_ag) },
+	{ _GDBUS_ASYNC_METHOD("ChangePassword", "ss", "",
+			      GDBUS_ARGS({ "old", "s" }, { "new", "s" }),
+			      NULL, cb_set_passwd) },
 	{ }
 };
 =

 static const GDBusSignalTable cb_signals[] =3D {
-	{ "PropertyChanged",		"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 7a73ff1..171feee 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -882,17 +882,21 @@ static DBusMessage *cf_disable_all(DBusConnection *co=
nn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cf_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cf_get_properties,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",	"sv",	"",		cf_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "DisableAll",		"s",	"",		cf_disable_all,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				cf_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, cf_set_property) },
+	{ _GDBUS_ASYNC_METHOD("DisableAll", "s", "",
+				GDBUS_ARGS({ "type", "s" }), NULL,
+				cf_disable_all) },
 	{ }
 };
 =

 static const GDBusSignalTable cf_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/call-meter.c b/src/call-meter.c
index 67965a4..a67815d 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -647,18 +647,23 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn=
, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cm_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cm_get_properties,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",	"svs",	"",		cm_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Reset", 		"s",	"",		cm_acm_reset,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      cm_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "svs", "",
+			      GDBUS_ARGS({ "property", "s" }, { "value", "v" },
+					 { "password", "s" }),
+			      NULL, cm_set_property) },
+	{ _GDBUS_ASYNC_METHOD("Reset", "s", "",
+			      GDBUS_ARGS({ "passoword", "s" }), NULL,
+			      cm_acm_reset) },
 	{ }
 };
 =

 static const GDBusSignalTable cm_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ "NearMaximumWarning",	"" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("NearMaximumWarning", "", NULL) },
 	{ }
 };
 =

diff --git a/src/call-settings.c b/src/call-settings.c
index 014deb8..f0fc68d 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1331,15 +1331,18 @@ static DBusMessage *cs_set_property(DBusConnection =
*conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cs_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cs_get_properties,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",	"sv",	"",		cs_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      cs_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			      NULL, cs_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cs_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/call-volume.c b/src/call-volume.c
index 528e39c..22b505c 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -302,14 +302,18 @@ static DBusMessage *cv_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cv_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cv_get_properties },
-	{ "SetProperty",	"sv",	"",		cv_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			cv_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			      NULL, cv_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cv_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/cbs.c b/src/cbs.c
index f81cfb7..23c9497 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -541,16 +541,22 @@ static DBusMessage *cbs_set_property(DBusConnection *=
conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable cbs_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	cbs_get_properties },
-	{ "SetProperty",	"sv",	"",		cbs_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			cbs_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			      NULL, cbs_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cbs_signals[] =3D {
-	{ "PropertyChanged",	"sv"		},
-	{ "IncomingBroadcast",	"sq"		},
-	{ "EmergencyBroadcast", "sa{sv}"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("IncomingBroadcast", "sq",
+			GDBUS_ARGS({ "message", "s" }, { "channel", "q" })) },
+	{ _GDBUS_SIGNAL("EmergencyBroadcast", "sa{sv}",
+			GDBUS_ARGS({ "message", "s" }, { "dict", "a{sv}" })) },
 	{ }
 };
 =

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 92866ba..8064542 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -518,15 +518,18 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable cdma_connman_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",
-						cdma_connman_get_properties },
-	{ "SetProperty",	"sv",	"",	cdma_connman_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				cdma_connman_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			      NULL, cdma_connman_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable cdma_connman_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 7b63cd7..9246f0c 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -108,7 +108,9 @@ static DBusMessage *network_get_properties(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable cdma_netreg_manager_methods[] =3D {
-	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      network_get_properties) },
 	{ }
 };
 =

diff --git a/src/cdma-sms.c b/src/cdma-sms.c
index bef214c..f7a09fe 100644
--- a/src/cdma-sms.c
+++ b/src/cdma-sms.c
@@ -49,7 +49,8 @@ static const GDBusMethodTable cdma_sms_manager_methods[] =
=3D {
 };
 =

 static const GDBusSignalTable cdma_sms_manager_signals[] =3D {
-	{ "IncomingMessage",	"sa{sv}"	},
+	{ _GDBUS_SIGNAL("IncomingMessage", "sa{sv}",
+			GDBUS_ARGS({ "message", "s"}, { "info", "a{sv}" })) },
 	/* TODO */
 	{ }
 };
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index 3ff128c..f7ee09a 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -406,24 +406,30 @@ static DBusMessage *voicecall_manager_tone(DBusConnec=
tion *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ "GetProperties",    "",    "a{sv}",
-					voicecall_manager_get_properties },
-	{ "Dial",             "s",  "o",        voicecall_manager_dial,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Hangup",           "",    "",         voicecall_manager_hangup,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Answer",           "",    "",         voicecall_manager_answer,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendFlash",      "s",    "",         voicecall_manager_flash,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendTones",     "s",    "",        voicecall_manager_tone,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      voicecall_manager_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Dial", "s", "",
+					GDBUS_ARGS({ "number", "s" }), NULL,
+					voicecall_manager_dial) },
+	{ _GDBUS_ASYNC_METHOD("Hangup", "", "", NULL, NULL,
+						voicecall_manager_hangup) },
+	{ _GDBUS_ASYNC_METHOD("Answer", "", "", NULL, NULL,
+						voicecall_manager_answer) },
+	{ _GDBUS_ASYNC_METHOD("SendFlash", "s", "",
+				GDBUS_ARGS({ "flash_string", "s" }), NULL,
+				voicecall_manager_flash) },
+	{ _GDBUS_ASYNC_METHOD("SendTones", "s", "",
+				GDBUS_ARGS({ "tones", "s" }), NULL,
+				voicecall_manager_tone) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ "DisconnectReason",	"s" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("DisconnectReason", "s",
+			GDBUS_ARGS({ "reason", "s" })) },
 	{ }
 };
 =

diff --git a/src/ctm.c b/src/ctm.c
index 88ff141..fd7df5e 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -203,15 +203,18 @@ static DBusMessage *ctm_set_property(DBusConnection *=
conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable ctm_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}",  ctm_get_properties,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",    "sv",  "",       ctm_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      ctm_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }), NULL,
+		      ctm_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable ctm_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/gnss.c b/src/gnss.c
index f622ed1..3d2d793 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -233,12 +233,15 @@ static DBusMessage *gnss_send_element(DBusConnection =
*conn,
 }
 =

 static const GDBusMethodTable gnss_methods[] =3D {
-	{ "SendPositioningElement",		"s",	"",
-			gnss_send_element, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RegisterPositioningRequestAgent",	"o",	"",
-			gnss_register_agent, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "UnregisterPositioningRequestAgent",	"o",	"",
-			gnss_unregister_agent, G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("SendPositioningElement", "s", "",
+			GDBUS_ARGS({ "xml_element" "s" }), NULL,
+			gnss_send_element) },
+	{ _GDBUS_ASYNC_METHOD("RegisterPositioningRequestAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			gnss_register_agent) },
+	{ _GDBUS_ASYNC_METHOD("UnregisterPositioningRequestAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			gnss_unregister_agent) },
 	{ }
 };
 =

diff --git a/src/gprs.c b/src/gprs.c
index 83995f3..9a4138e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1283,14 +1283,18 @@ static DBusMessage *pri_set_property(DBusConnection=
 *conn,
 }
 =

 static const GDBusMethodTable context_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	pri_get_properties },
-	{ "SetProperty",	"sv",	"",		pri_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      pri_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+		      NULL, pri_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable context_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

@@ -2063,22 +2067,34 @@ static DBusMessage *gprs_get_contexts(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ "GetProperties",     "",     "a{sv}",     gprs_get_properties },
-	{ "SetProperty",       "sv",   "",          gprs_set_property },
-	{ "AddContext",        "s",    "o",         gprs_add_context,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RemoveContext",     "o",    "",          gprs_remove_context,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "DeactivateAll",     "",     "",          gprs_deactivate_all,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetContexts",       "",     "a(oa{sv})", gprs_get_contexts },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      gprs_get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+		      NULL, gprs_set_property) },
+	{ _GDBUS_ASYNC_METHOD("AddContext", "s", "o",
+			GDBUS_ARGS({ "type", "s" }),
+			GDBUS_ARGS({ "path", "o" }),
+			gprs_add_context) },
+	{ _GDBUS_ASYNC_METHOD("RemoveContext", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			gprs_remove_context) },
+	{ _GDBUS_ASYNC_METHOD("DeactivateAll", "", "", NULL, NULL,
+			gprs_deactivate_all) },
+	{ _GDBUS_METHOD("GetContexts", "", "a(oa{sv})",
+			NULL,
+			GDBUS_ARGS({ "contexts_with_properties", "a(oa{sv})" }),
+			gprs_get_contexts) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ "ContextAdded",	"oa{sv}" },
-	{ "ContextRemoved",     "o" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("ContextAdded", "oa{sv}",
+			GDBUS_ARGS({ "path", "o" }, { "properties", "v" })) },
+	{ _GDBUS_SIGNAL("ContextRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

diff --git a/src/handsfree.c b/src/handsfree.c
index a838952..e2d47d6 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -271,16 +271,21 @@ static DBusMessage *handsfree_request_phone_number(DB=
usConnection *conn,
 }
 =

 static const GDBusMethodTable handsfree_methods[] =3D {
-	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties },
-	{ "SetProperty",      "sv",  "", handsfree_set_property,
-		G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RequestPhoneNumber", "", "s", handsfree_request_phone_number,
-		G_DBUS_METHOD_FLAG_ASYNC },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			      NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			      handsfree_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+		      GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+		      NULL, handsfree_set_property) },
+	{ _GDBUS_ASYNC_METHOD("RequestPhoneNumber", "", "s",
+				NULL, GDBUS_ARGS({ "number", "s" }),
+				handsfree_request_phone_number) },
+	{ }
 };
 =

 static const GDBusSignalTable handsfree_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/location-reporting.c b/src/location-reporting.c
index 6417330..9ea200c 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -240,16 +240,20 @@ static DBusMessage *location_reporting_release(DBusCo=
nnection *conn,
 }
 =

 static const GDBusMethodTable location_reporting_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}", location_reporting_get_properties },
-	{ "Request",        "",    "h",     location_reporting_request,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Release",        "",    "",      location_reporting_release,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				location_reporting_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Request", "", "h",
+				NULL, GDBUS_ARGS({ "fd", "h" }),
+				location_reporting_request) },
+	{ _GDBUS_ASYNC_METHOD("Release", "", "", NULL, NULL,
+					location_reporting_release) },
 	{ }
 };
 =

 static const GDBusSignalTable location_reporting_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/manager.c b/src/manager.c
index ac729dc..18df994 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -81,13 +81,17 @@ static DBusMessage *manager_get_modems(DBusConnection *=
conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ "GetModems",          "",    "a(oa{sv})",  manager_get_modems },
+	{ _GDBUS_METHOD("GetModems", "", "a(oa{sv})",
+				NULL, GDBUS_ARGS({ "modems", "a(oa{sv})" }),
+				manager_get_modems) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ "ModemAdded",        "oa{sv}" },
-	{ "ModemRemoved",      "o" },
+	{ _GDBUS_SIGNAL("ModemAdded", "oa{sv}",
+				GDBUS_ARGS({ "modems", "a(oa{sv})" })) },
+	{ _GDBUS_SIGNAL("ModemRemoved", "o",
+				GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 19b995d..b8ced45 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -369,14 +369,18 @@ static DBusMessage *mw_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable message_waiting_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	mw_get_properties	},
-	{ "SetProperty",	"sv",	"",		mw_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				mw_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, mw_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable message_waiting_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/message.c b/src/message.c
index a8be570..7c0df3c 100644
--- a/src/message.c
+++ b/src/message.c
@@ -104,13 +104,16 @@ static DBusMessage *message_cancel(DBusConnection *co=
nn,
 }
 =

 static const GDBusMethodTable message_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}",   message_get_properties },
-	{ "Cancel",         "",    "",        message_cancel },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				message_get_properties) },
+	{ _GDBUS_METHOD("Cancel", "","", NULL, NULL, message_cancel) },
 	{ }
 };
 =

 static const GDBusSignalTable message_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/modem.c b/src/modem.c
index f4278e9..e5a3b68 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1124,14 +1124,18 @@ static DBusMessage *modem_set_property(DBusConnecti=
on *conn,
 }
 =

 static const GDBusMethodTable modem_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	modem_get_properties },
-	{ "SetProperty",	"sv",	"",		modem_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				modem_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, modem_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable modem_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/network.c b/src/network.c
index 7d28762..ede8437 100644
--- a/src/network.c
+++ b/src/network.c
@@ -624,14 +624,17 @@ static DBusMessage *network_operator_register(DBusCon=
nection *conn,
 }
 =

 static const GDBusMethodTable network_operator_methods[] =3D {
-	{ "GetProperties",  "",  "a{sv}",  network_operator_get_properties },
-	{ "Register",       "",  "",       network_operator_register,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				network_operator_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Register", "", "", NULL, NULL,
+						network_operator_register) },
 	{ }
 };
 =

 static const GDBusSignalTable network_operator_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

@@ -1021,17 +1024,23 @@ static DBusMessage *network_get_operators(DBusConne=
ction *conn,
 }
 =

 static const GDBusMethodTable network_registration_methods[] =3D {
-	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
-	{ "Register",       "",  "",		network_register,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetOperators",   "",  "a(oa{sv})",	network_get_operators },
-	{ "Scan",           "",  "a(oa{sv})",	network_scan,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			network_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Register", "", "",
+				NULL, NULL, network_register) },
+	{ _GDBUS_METHOD("GetOperators", "", "a(oa{sv})",
+		NULL, GDBUS_ARGS({ "operators_with_properties", "a(oa{sv})" }),
+		network_get_operators) },
+	{ _GDBUS_ASYNC_METHOD("Scan", "", "a(oa{sv})",
+		NULL, GDBUS_ARGS({ "operators_with_properties", "a(oa{sv})" }),
+		network_scan) },
 	{ }
 };
 =

 static const GDBusSignalTable network_registration_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "a{sv}",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/phonebook.c b/src/phonebook.c
index 16f1fb9..fb52c21 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -480,8 +480,9 @@ static DBusMessage *import_entries(DBusConnection *conn=
, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable phonebook_methods[] =3D {
-	{ "Import",	"",	"s",	import_entries,
-					G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("Import", "", "s",
+			NULL, GDBUS_ARGS({ "entries", "s" }),
+			import_entries) },
 	{ }
 };
 =

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 4777b18..65c20f5 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -602,15 +602,18 @@ static DBusMessage *radio_set_property(DBusConnection=
 *conn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable radio_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}",  radio_get_properties,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",    "sv",  "",       radio_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				radio_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, radio_set_property) },
 	{ }
 };
 =

 static const GDBusSignalTable radio_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/sim.c b/src/sim.c
index 6207607..fd8a797 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1068,26 +1068,39 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

 static const GDBusMethodTable sim_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	sim_get_properties },
-	{ "SetProperty",	"sv",	"",		sim_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ChangePin",		"sss",	"",		sim_change_pin,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "EnterPin",		"ss",	"",		sim_enter_pin,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ResetPin",		"sss",	"",		sim_reset_pin,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "LockPin",		"ss",	"",		sim_lock_pin,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetIcon",		"y",	"ay",		sim_get_icon,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				sim_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, sim_set_property) },
+	{ _GDBUS_ASYNC_METHOD("ChangePin", "sss", "",
+			GDBUS_ARGS({ "type", "s" }, { "oldpin", "s" },
+						{ "newpin", "s" }), NULL,
+			sim_change_pin) },
+	{ _GDBUS_ASYNC_METHOD("EnterPin", "ss", "",
+			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
+			sim_enter_pin) },
+	{ _GDBUS_ASYNC_METHOD("ResetPin", "sss", "",
+			GDBUS_ARGS({ "type", "s" }, { "puk", "s" },
+						{ "newpin", "s" }), NULL,
+			sim_reset_pin) },
+	{ _GDBUS_ASYNC_METHOD("LockPin", "ss", "",
+			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
+			sim_lock_pin) },
+	{ _GDBUS_ASYNC_METHOD("UnlockPin", "ss", "",
+			GDBUS_ARGS({ "type", "s" }, { "pin", "s" }), NULL,
+			sim_unlock_pin) },
+	{ _GDBUS_ASYNC_METHOD("GetIcon", "y", "ay",
+			GDBUS_ARGS({ "id", "y" }),
+			GDBUS_ARGS({ "icon", "ay" }),
+			sim_get_icon) },
 	{ }
 };
 =

 static const GDBusSignalTable sim_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/sms.c b/src/sms.c
index 428eb52..b700513 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1104,22 +1104,34 @@ int __ofono_sms_txq_cancel(struct ofono_sms *sms, c=
onst struct ofono_uuid *uuid)
 }
 =

 static const GDBusMethodTable sms_manager_methods[] =3D {
-	{ "GetProperties",    "",    "a{sv}",        sms_get_properties,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",      "sv",  "",             sms_set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",      "ss",  "o",             sms_send_message,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetMessages",       "",    "a(oa{sv})",    sms_get_messages },
+	{ _GDBUS_ASYNC_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				sms_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, sms_set_property) },
+	{ _GDBUS_ASYNC_METHOD("SendMessage", "ss", "o",
+			GDBUS_ARGS({ "to", "s" }, { "text", "s" }),
+			GDBUS_ARGS({ "path", "o" }),
+			sms_send_message) },
+	{ _GDBUS_METHOD("GetMessages", "", "a(oa{sv})",
+			GDBUS_ARGS({ "messages", "a(oa{sv})" }), NULL,
+			sms_get_messages) },
 	{ }
 };
 =

 static const GDBusSignalTable sms_manager_signals[] =3D {
-	{ "PropertyChanged",	"sv"		},
-	{ "IncomingMessage",	"sa{sv}"	},
-	{ "ImmediateMessage",	"sa{sv}"	},
-	{ "MessageAdded",	"oa{sv}"	},
-	{ "MessageRemoved",	"o"		},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("IncomingMessage", "sa{sv}",
+			GDBUS_ARGS({ "message", "s" }, { "info", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("ImmediateMessage", "sa{sv}",
+			GDBUS_ARGS({ "message", "s" }, { "info", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("MessageAdded", "oa{sv}",
+			GDBUS_ARGS({ "path", "o" },
+						{ "properties", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("MessageRemoved", "o",
+			GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

diff --git a/src/stk.c b/src/stk.c
index f111f0d..46921b6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -818,18 +818,24 @@ static DBusMessage *stk_select_item(DBusConnection *c=
onn,
 }
 =

 static const GDBusMethodTable stk_methods[] =3D {
-	{ "GetProperties",		"",	"a{sv}",stk_get_properties },
-	{ "SelectItem",			"yo",	"",	stk_select_item,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RegisterAgent",		"o",	"",	stk_register_agent },
-	{ "UnregisterAgent",		"o",	"",	stk_unregister_agent },
-
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				stk_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SelectItem", "yo", "",
+			GDBUS_ARGS({ "item", "y" }, { "agent", "o" }), NULL,
+			stk_select_item) },
+	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			stk_register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			stk_unregister_agent) },
 	{ }
 };
 =

 static const GDBusSignalTable stk_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/ussd.c b/src/ussd.c
index 92a7949..3a95c4e 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -729,21 +729,28 @@ static DBusMessage *ussd_get_properties(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable ussd_methods[] =3D {
-	{ "Initiate",		"s",	"sv",		ussd_initiate,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Respond",		"s",	"s",		ussd_respond,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Cancel",		"",	"",		ussd_cancel,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties",	"",	"a{sv}",	ussd_get_properties,
-					0 },
+	{ _GDBUS_ASYNC_METHOD("Initiate", "s", "sv",
+			GDBUS_ARGS({ "command", "s" }),
+			GDBUS_ARGS({ "result_name", "s" }, { "value", "v" }),
+			ussd_initiate) },
+	{ _GDBUS_ASYNC_METHOD("Respond", "s", "s",
+			GDBUS_ARGS({ "reply", "s" }),
+			GDBUS_ARGS({ "result", "s" }),
+			ussd_respond) },
+	{ _GDBUS_ASYNC_METHOD("Cancel", "", "", NULL, NULL, ussd_cancel) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				ussd_get_properties) },
 	{ }
 };
 =

 static const GDBusSignalTable ussd_signals[] =3D {
-	{ "NotificationReceived",	"s" },
-	{ "RequestReceived",		"s" },
-	{ "PropertyChanged",		"sv" },
+	{ _GDBUS_SIGNAL("NotificationReceived", "s",
+					GDBUS_ARGS({ "message", "s" })) },
+	{ _GDBUS_SIGNAL("RequestReceived", "s",
+					GDBUS_ARGS({ "message", "s" })) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

diff --git a/src/voicecall.c b/src/voicecall.c
index 36a795d..bb99420 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -668,19 +668,24 @@ static DBusMessage *voicecall_answer(DBusConnection *=
conn,
 }
 =

 static const GDBusMethodTable voicecall_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}",   voicecall_get_properties },
-	{ "Deflect",        "s",   "",        voicecall_deflect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Hangup",         "",    "",        voicecall_hangup,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Answer",         "",    "",        voicecall_answer,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				voicecall_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Deflect", "s", "",
+					GDBUS_ARGS({ "number", "s" }), NULL,
+					voicecall_deflect) },
+	{ _GDBUS_ASYNC_METHOD("Hangup", "", "", NULL, NULL,
+							voicecall_hangup) },
+	{ _GDBUS_ASYNC_METHOD("Answer", "", "", NULL, NULL,
+							voicecall_answer) },
 	{ }
 };
 =

 static const GDBusSignalTable voicecall_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ "DisconnectReason",	"s" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("DisconnectReason", "s",
+					GDBUS_ARGS({ "reason", "s" })) },
 	{ }
 };
 =

@@ -2118,37 +2123,49 @@ static DBusMessage *manager_get_calls(DBusConnectio=
n *conn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ "GetProperties",     "",    "a{sv}",      manager_get_properties },
-	{ "Dial",              "ss",  "o",          manager_dial,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Transfer",          "",    "",           manager_transfer,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SwapCalls",         "",    "",           manager_swap_calls,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ReleaseAndAnswer",  "",    "",           manager_release_and_answer,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "HoldAndAnswer",     "",    "",           manager_hold_and_answer,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "HangupAll",         "",    "",           manager_hangup_all,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PrivateChat",       "o",   "ao",         multiparty_private_chat,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "CreateMultiparty",  "",    "ao",         multiparty_create,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "HangupMultiparty",  "",    "",           multiparty_hangup,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendTones",         "s",   "",           manager_tone,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetCalls",          "",    "a(oa{sv})",  manager_get_calls },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				manager_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Dial", "ss", "o",
+		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
+		GDBUS_ARGS({ "path", "o" }),
+		manager_dial) },
+	{ _GDBUS_ASYNC_METHOD("Transfer", "", "", NULL, NULL,
+							manager_transfer) },
+	{ _GDBUS_ASYNC_METHOD("SwapCalls", "", "",  NULL, NULL,
+							manager_swap_calls) },
+	{ _GDBUS_ASYNC_METHOD("ReleaseAndAnswer", "", "", NULL, NULL,
+						manager_release_and_answer) },
+	{ _GDBUS_ASYNC_METHOD("HoldAndAnswer", "", "", NULL, NULL,
+						manager_hold_and_answer) },
+	{ _GDBUS_ASYNC_METHOD("HangupAll", "", "", NULL, NULL,
+						manager_hangup_all) },
+	{ _GDBUS_ASYNC_METHOD("PrivateChat", "o", "ao",
+						GDBUS_ARGS({ "call", "o" }),
+						GDBUS_ARGS({ "calls", "ao" }),
+						multiparty_private_chat) },
+	{ _GDBUS_ASYNC_METHOD("CreateMultiparty", "", "ao",
+					NULL, GDBUS_ARGS({ "calls", "o" }),
+					multiparty_create) },
+	{ _GDBUS_ASYNC_METHOD("HangupMultiparty", "", "", NULL, NULL,
+					multiparty_hangup) },
+	{ _GDBUS_ASYNC_METHOD("SendTones", "s", "",
+					GDBUS_ARGS({ "SendTones", "s" }), NULL,
+					manager_tone) },
+	{ _GDBUS_METHOD("GetCalls", "", "a(oa{sv})",
+		NULL, GDBUS_ARGS({ "calls_with_properties", "a(oa{sv})" }),
+		manager_get_calls) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ "Forwarded",		"s" },
-	{ "BarringActive",	"s" },
-	{ "PropertyChanged",	"sv" },
-	{ "CallAdded",		"oa{sv}" },
-	{ "CallRemoved",	"o" },
+	{ _GDBUS_SIGNAL("Forwarded", "s", GDBUS_ARGS({ "type", "s" })) },
+	{ _GDBUS_SIGNAL("BarringActive", "s", GDBUS_ARGS({ "type", "s" })) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("CallAdded", "oa{sv}",
+		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("CallRemoved", "o", GDBUS_ARGS({ "path", "o"})) },
 	{ }
 };
 =

-- =

1.7.10.2


--===============9065921939519883616==--

