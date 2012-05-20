Content-Type: multipart/mixed; boundary="===============8839407040703420906=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 01/12] Constify GDBus method tables
Date: Sun, 20 May 2012 02:07:25 -0300
Message-ID: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8839407040703420906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Henrique Dante de Almeida <hdante@profusion.mobi>

Constify method tables with the following command:

find . -name '*.[ch]' -exec \
             sed -i 's/\(GDBusMethodTable .* =3D\)/const \1/g' {} \;
---
 plugins/hfp_hf.c            |    2 +-
 plugins/push-notification.c |    2 +-
 plugins/smart-messaging.c   |    2 +-
 src/audio-settings.c        |    2 +-
 src/call-barring.c          |    2 +-
 src/call-forwarding.c       |    2 +-
 src/call-meter.c            |    2 +-
 src/call-settings.c         |    2 +-
 src/call-volume.c           |    2 +-
 src/cbs.c                   |    2 +-
 src/cdma-connman.c          |    2 +-
 src/cdma-netreg.c           |    2 +-
 src/cdma-sms.c              |    2 +-
 src/cdma-voicecall.c        |    2 +-
 src/ctm.c                   |    2 +-
 src/gnss.c                  |    2 +-
 src/gprs.c                  |    4 ++--
 src/handsfree.c             |    2 +-
 src/location-reporting.c    |    2 +-
 src/manager.c               |    2 +-
 src/message-waiting.c       |    2 +-
 src/message.c               |    2 +-
 src/modem.c                 |    2 +-
 src/network.c               |    4 ++--
 src/phonebook.c             |    2 +-
 src/radio-settings.c        |    2 +-
 src/sim.c                   |    2 +-
 src/sms.c                   |    2 +-
 src/stk.c                   |    2 +-
 src/ussd.c                  |    2 +-
 src/voicecall.c             |    4 ++--
 31 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index c11525e..19a362f 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -198,7 +198,7 @@ static DBusMessage *hfp_agent_release(DBusConnection *c=
onn,
 	return dbus_message_new_method_return(msg);
 }
 =

-static GDBusMethodTable agent_methods[] =3D {
+static const GDBusMethodTable agent_methods[] =3D {
 	{ "NewConnection", "hq", "", hfp_agent_new_connection,
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Release", "", "", hfp_agent_release },
diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index 1c19bf2..1b8f729 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -151,7 +151,7 @@ static DBusMessage *push_notification_unregister_agent(=
DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

-static GDBusMethodTable push_notification_methods[] =3D {
+static const GDBusMethodTable push_notification_methods[] =3D {
 	{ "RegisterAgent",    "o",   "",  push_notification_register_agent },
 	{ "UnregisterAgent",  "o",   "",  push_notification_unregister_agent },
 	{ }
diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index d6d77cf..6820b20 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -268,7 +268,7 @@ static DBusMessage *smart_messaging_send_vcal(DBusConne=
ction *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable smart_messaging_methods[] =3D {
+static const GDBusMethodTable smart_messaging_methods[] =3D {
 	{ "RegisterAgent",    "o",     "",  smart_messaging_register_agent },
 	{ "UnregisterAgent",  "o",     "",  smart_messaging_unregister_agent },
 	{ "SendBusinessCard", "say",   "o", smart_messaging_send_vcard,
diff --git a/src/audio-settings.c b/src/audio-settings.c
index 77930d9..6388c3e 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -117,7 +117,7 @@ static DBusMessage *audio_get_properties(DBusConnection=
 *conn,
 	return audio_get_properties_reply(msg, as);
 }
 =

-static GDBusMethodTable audio_methods[] =3D {
+static const GDBusMethodTable audio_methods[] =3D {
 	{ "GetProperties", "", "a{sv}", audio_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
diff --git a/src/call-barring.c b/src/call-barring.c
index afb3fce..952e4c2 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -966,7 +966,7 @@ static DBusMessage *cb_set_passwd(DBusConnection *conn,=
 DBusMessage *msg,
 	return NULL;
 }
 =

-static GDBusMethodTable cb_methods[] =3D {
+static const GDBusMethodTable cb_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cb_get_properties,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"svs",	"",		cb_set_property,
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index c025942..c70d140 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -881,7 +881,7 @@ static DBusMessage *cf_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	return NULL;
 }
 =

-static GDBusMethodTable cf_methods[] =3D {
+static const GDBusMethodTable cf_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cf_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		cf_set_property,
diff --git a/src/call-meter.c b/src/call-meter.c
index c3ae6f7..fd5edc2 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -646,7 +646,7 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn, =
DBusMessage *msg,
 	return NULL;
 }
 =

-static GDBusMethodTable cm_methods[] =3D {
+static const GDBusMethodTable cm_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cm_get_properties,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"svs",	"",		cm_set_property,
diff --git a/src/call-settings.c b/src/call-settings.c
index 94e606c..9d4ff7b 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1330,7 +1330,7 @@ static DBusMessage *cs_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable cs_methods[] =3D {
+static const GDBusMethodTable cs_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cs_get_properties,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		cs_set_property,
diff --git a/src/call-volume.c b/src/call-volume.c
index a1c0392..81b7564 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -301,7 +301,7 @@ static DBusMessage *cv_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable cv_methods[] =3D {
+static const GDBusMethodTable cv_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cv_get_properties },
 	{ "SetProperty",	"sv",	"",		cv_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/cbs.c b/src/cbs.c
index d898823..1c20cc6 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -540,7 +540,7 @@ static DBusMessage *cbs_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable cbs_methods[] =3D {
+static const GDBusMethodTable cbs_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cbs_get_properties },
 	{ "SetProperty",	"sv",	"",		cbs_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 0c8b061..90652e7 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -517,7 +517,7 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable cdma_connman_methods[] =3D {
+static const GDBusMethodTable cdma_connman_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",
 						cdma_connman_get_properties },
 	{ "SetProperty",	"sv",	"",	cdma_connman_set_property,
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 1a88d33..e6074a8 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -107,7 +107,7 @@ static DBusMessage *network_get_properties(DBusConnecti=
on *conn,
 	return reply;
 }
 =

-static GDBusMethodTable cdma_netreg_manager_methods[] =3D {
+static const GDBusMethodTable cdma_netreg_manager_methods[] =3D {
 	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
 	{ }
 };
diff --git a/src/cdma-sms.c b/src/cdma-sms.c
index 12ea57e..a368124 100644
--- a/src/cdma-sms.c
+++ b/src/cdma-sms.c
@@ -43,7 +43,7 @@ struct ofono_cdma_sms {
 	struct ofono_atom *atom;
 };
 =

-static GDBusMethodTable cdma_sms_manager_methods[] =3D {
+static const GDBusMethodTable cdma_sms_manager_methods[] =3D {
 	/* TODO */
 	{ }
 };
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index f7e3b67..3d0c55e 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -405,7 +405,7 @@ static DBusMessage *voicecall_manager_tone(DBusConnecti=
on *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable manager_methods[] =3D {
+static const GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",
 					voicecall_manager_get_properties },
 	{ "Dial",             "s",  "o",        voicecall_manager_dial,
diff --git a/src/ctm.c b/src/ctm.c
index 9cece8a..2ff1cca 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -202,7 +202,7 @@ static DBusMessage *ctm_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable ctm_methods[] =3D {
+static const GDBusMethodTable ctm_methods[] =3D {
 	{ "GetProperties",  "",    "a{sv}",  ctm_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",    "sv",  "",       ctm_set_property,
diff --git a/src/gnss.c b/src/gnss.c
index f4c3311..f622ed1 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -232,7 +232,7 @@ static DBusMessage *gnss_send_element(DBusConnection *c=
onn,
 	return NULL;
 }
 =

-static GDBusMethodTable gnss_methods[] =3D {
+static const GDBusMethodTable gnss_methods[] =3D {
 	{ "SendPositioningElement",		"s",	"",
 			gnss_send_element, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RegisterPositioningRequestAgent",	"o",	"",
diff --git a/src/gprs.c b/src/gprs.c
index 0d25506..887422a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1282,7 +1282,7 @@ static DBusMessage *pri_set_property(DBusConnection *=
conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable context_methods[] =3D {
+static const GDBusMethodTable context_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	pri_get_properties },
 	{ "SetProperty",	"sv",	"",		pri_set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -2062,7 +2062,7 @@ static DBusMessage *gprs_get_contexts(DBusConnection =
*conn,
 	return reply;
 }
 =

-static GDBusMethodTable manager_methods[] =3D {
+static const GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",     "",     "a{sv}",     gprs_get_properties },
 	{ "SetProperty",       "sv",   "",          gprs_set_property },
 	{ "AddContext",        "s",    "o",         gprs_add_context,
diff --git a/src/handsfree.c b/src/handsfree.c
index 66daaf1..2566dd8 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -270,7 +270,7 @@ static DBusMessage *handsfree_request_phone_number(DBus=
Connection *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable handsfree_methods[] =3D {
+static const GDBusMethodTable handsfree_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties },
 	{ "SetProperty",      "sv",  "", handsfree_set_property,
 		G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/location-reporting.c b/src/location-reporting.c
index 40aae66..d279814 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -239,7 +239,7 @@ static DBusMessage *location_reporting_release(DBusConn=
ection *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable location_reporting_methods[] =3D {
+static const GDBusMethodTable location_reporting_methods[] =3D {
 	{ "GetProperties",  "",    "a{sv}", location_reporting_get_properties },
 	{ "Request",        "",    "h",     location_reporting_request,
 						G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/manager.c b/src/manager.c
index 9614527..783ea76 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -80,7 +80,7 @@ static DBusMessage *manager_get_modems(DBusConnection *co=
nn,
 	return reply;
 }
 =

-static GDBusMethodTable manager_methods[] =3D {
+static const GDBusMethodTable manager_methods[] =3D {
 	{ "GetModems",          "",    "a(oa{sv})",  manager_get_modems },
 	{ }
 };
diff --git a/src/message-waiting.c b/src/message-waiting.c
index 328e193..7bd2576 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -368,7 +368,7 @@ static DBusMessage *mw_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable message_waiting_methods[] =3D {
+static const GDBusMethodTable message_waiting_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	mw_get_properties	},
 	{ "SetProperty",	"sv",	"",		mw_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/message.c b/src/message.c
index 7cc6538..e0e7280 100644
--- a/src/message.c
+++ b/src/message.c
@@ -103,7 +103,7 @@ static DBusMessage *message_cancel(DBusConnection *conn,
 	}
 }
 =

-static GDBusMethodTable message_methods[] =3D {
+static const GDBusMethodTable message_methods[] =3D {
 	{ "GetProperties",  "",    "a{sv}",   message_get_properties },
 	{ "Cancel",         "",    "",        message_cancel },
 	{ }
diff --git a/src/modem.c b/src/modem.c
index 43d7e9e..f9fd37a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1123,7 +1123,7 @@ static DBusMessage *modem_set_property(DBusConnection=
 *conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable modem_methods[] =3D {
+static const GDBusMethodTable modem_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	modem_get_properties },
 	{ "SetProperty",	"sv",	"",		modem_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/network.c b/src/network.c
index b8a8cfe..68749ba 100644
--- a/src/network.c
+++ b/src/network.c
@@ -623,7 +623,7 @@ static DBusMessage *network_operator_register(DBusConne=
ction *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable network_operator_methods[] =3D {
+static const GDBusMethodTable network_operator_methods[] =3D {
 	{ "GetProperties",  "",  "a{sv}",  network_operator_get_properties },
 	{ "Register",       "",  "",       network_operator_register,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -1020,7 +1020,7 @@ static DBusMessage *network_get_operators(DBusConnect=
ion *conn,
 	return reply;
 }
 =

-static GDBusMethodTable network_registration_methods[] =3D {
+static const GDBusMethodTable network_registration_methods[] =3D {
 	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
 	{ "Register",       "",  "",		network_register,
 						G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/phonebook.c b/src/phonebook.c
index 6baf7bb..3563cee 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -479,7 +479,7 @@ static DBusMessage *import_entries(DBusConnection *conn=
, DBusMessage *msg,
 	return NULL;
 }
 =

-static GDBusMethodTable phonebook_methods[] =3D {
+static const GDBusMethodTable phonebook_methods[] =3D {
 	{ "Import",	"",	"s",	import_entries,
 					G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
diff --git a/src/radio-settings.c b/src/radio-settings.c
index a8637bb..132fd4a 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -601,7 +601,7 @@ static DBusMessage *radio_set_property(DBusConnection *=
conn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

-static GDBusMethodTable radio_methods[] =3D {
+static const GDBusMethodTable radio_methods[] =3D {
 	{ "GetProperties",  "",    "a{sv}",  radio_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",    "sv",  "",       radio_set_property,
diff --git a/src/sim.c b/src/sim.c
index eb25e07..b979ddd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1067,7 +1067,7 @@ static DBusMessage *sim_reset_pin(DBusConnection *con=
n, DBusMessage *msg,
 	return NULL;
 }
 =

-static GDBusMethodTable sim_methods[] =3D {
+static const GDBusMethodTable sim_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	sim_get_properties },
 	{ "SetProperty",	"sv",	"",		sim_set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/sms.c b/src/sms.c
index 26dbd89..1f64be9 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1103,7 +1103,7 @@ int __ofono_sms_txq_cancel(struct ofono_sms *sms, con=
st struct ofono_uuid *uuid)
 	return 0;
 }
 =

-static GDBusMethodTable sms_manager_methods[] =3D {
+static const GDBusMethodTable sms_manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",        sms_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",      "sv",  "",             sms_set_property,
diff --git a/src/stk.c b/src/stk.c
index e557e90..61b29bb 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -817,7 +817,7 @@ static DBusMessage *stk_select_item(DBusConnection *con=
n,
 	return NULL;
 }
 =

-static GDBusMethodTable stk_methods[] =3D {
+static const GDBusMethodTable stk_methods[] =3D {
 	{ "GetProperties",		"",	"a{sv}",stk_get_properties },
 	{ "SelectItem",			"yo",	"",	stk_select_item,
 					G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/src/ussd.c b/src/ussd.c
index d2d3621..25ef61f 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -728,7 +728,7 @@ static DBusMessage *ussd_get_properties(DBusConnection =
*conn,
 	return reply;
 }
 =

-static GDBusMethodTable ussd_methods[] =3D {
+static const GDBusMethodTable ussd_methods[] =3D {
 	{ "Initiate",		"s",	"sv",		ussd_initiate,
 					G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Respond",		"s",	"s",		ussd_respond,
diff --git a/src/voicecall.c b/src/voicecall.c
index 104b600..73b84b9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -667,7 +667,7 @@ static DBusMessage *voicecall_answer(DBusConnection *co=
nn,
 	return NULL;
 }
 =

-static GDBusMethodTable voicecall_methods[] =3D {
+static const GDBusMethodTable voicecall_methods[] =3D {
 	{ "GetProperties",  "",    "a{sv}",   voicecall_get_properties },
 	{ "Deflect",        "s",   "",        voicecall_deflect,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -2117,7 +2117,7 @@ static DBusMessage *manager_get_calls(DBusConnection =
*conn,
 	return reply;
 }
 =

-static GDBusMethodTable manager_methods[] =3D {
+static const GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",     "",    "a{sv}",      manager_get_properties },
 	{ "Dial",              "ss",  "o",          manager_dial,
 						G_DBUS_METHOD_FLAG_ASYNC },
-- =

1.7.10.2


--===============8839407040703420906==--

