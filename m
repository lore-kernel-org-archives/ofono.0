Content-Type: multipart/mixed; boundary="===============6443268046643711446=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] gemalto/location-reporting: add driver properties
Date: Sun, 23 Sep 2018 08:19:22 +0200
Message-ID: <20180923061922.23288-3-gciofono@gmail.com>
In-Reply-To: <20180923061922.23288-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6443268046643711446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/gemaltomodem/location-reporting.c | 317 ++++++++++++++++++++--
 1 file changed, 291 insertions(+), 26 deletions(-)

diff --git a/drivers/gemaltomodem/location-reporting.c b/drivers/gemaltomod=
em/location-reporting.c
index bcfe00e5..375b7bfa 100644
--- a/drivers/gemaltomodem/location-reporting.c
+++ b/drivers/gemaltomodem/location-reporting.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -31,38 +32,62 @@
 #include <unistd.h>
 =

 #include <glib.h>
+#include <gdbus.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/location-reporting.h>
 =

+#include <src/storage.h>
+
 #include "gatchat.h"
 #include "gatresult.h"
 #include "gattty.h"
 =

+#include "ofono.h"
+#include "common.h"
+
 #include "gemaltomodem.h"
 =

+struct ofono_location_reporting {
+	DBusMessage *pending;
+	const struct ofono_location_reporting_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	ofono_bool_t enabled;
+	char *client_owner;
+	guint disconnect_watch;
+};
+
 static const char *sgpsc_prefix[] =3D { "^SGPSC:", NULL };
 =

+#define MAX_GNSS_PROPERTIES		(64)
+#define MAX_GNSS_STRLEN			(32)
+
+typedef struct _gnss_property {
+	uint type; // dynamic or stored, exclude, value_s or value_i
+	char name[MAX_GNSS_STRLEN];
+	union {
+		char value_s[32];
+		int value_i;
+	};
+} gnss_property;
+
 struct gps_data {
 	GAtChat *chat;
+	gnss_property properties[MAX_GNSS_PROPERTIES];
 };
 =

 static void gemalto_gps_disable_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct ofono_location_reporting *lr =3D cbd->user;
 	ofono_location_reporting_disable_cb_t cb =3D cbd->cb;
 =

-	DBG("lr=3D%p, ok=3D%d", lr, ok);
-
 	if (!ok) {
 		struct ofono_error error;
-
 		decode_at_error(&error, g_at_result_final_response(result));
 		cb(&error, cbd->data);
-
 		return;
 	}
 =

@@ -77,8 +102,6 @@ static void gemalto_location_reporting_disable(
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	DBG("lr=3D%p", lr);
-
 	cbd->user =3D lr;
 =

 	if (g_at_chat_send(gd->chat, "AT^SGPSC=3D\"Engine\",0", sgpsc_prefix,
@@ -86,36 +109,32 @@ static void gemalto_location_reporting_disable(
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-
 	g_free(cbd);
 }
 =

 static int enable_data_stream(struct ofono_location_reporting *lr)
 {
 	struct ofono_modem *modem;
-	const char *gps_dev;
+	const char *gnss_dev;
 	GHashTable *options;
 	GIOChannel *channel;
 	int fd;
 =

 	modem =3D ofono_location_reporting_get_modem(lr);
-	gps_dev =3D ofono_modem_get_string(modem, "GPS");
-
+	gnss_dev =3D ofono_modem_get_string(modem, "GNSS");
 	options =3D g_hash_table_new(g_str_hash, g_str_equal);
-	if (options =3D=3D NULL)
+
+	if (!gnss_dev || !*gnss_dev || !options)
 		return -1;
 =

 	g_hash_table_insert(options, "Baud", "115200");
-
-	channel =3D g_at_tty_open(gps_dev, options);
-
+	channel =3D g_at_tty_open(gnss_dev, options);
 	g_hash_table_destroy(options);
 =

-	if (channel =3D=3D NULL)
+	if (!channel)
 		return -1;
 =

 	fd =3D g_io_channel_unix_get_fd(channel);
-
 	g_io_channel_set_close_on_unref(channel, FALSE);
 	g_io_channel_unref(channel);
 =

@@ -131,8 +150,6 @@ static void gemalto_sgpsc_cb(gboolean ok, GAtResult *re=
sult,
 	struct ofono_error error;
 	int fd;
 =

-	DBG("lr=3D%p ok=3D%d", lr, ok);
-
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
@@ -153,15 +170,14 @@ static void gemalto_sgpsc_cb(gboolean ok, GAtResult *=
result,
 	close(fd);
 }
 =

-static void gemalto_location_reporting_enable(struct ofono_location_report=
ing *lr,
+static void gemalto_location_reporting_enable(
+					struct ofono_location_reporting *lr,
 					ofono_location_reporting_enable_cb_t cb,
 					void *data)
 {
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	DBG("lr=3D%p", lr);
-
 	cbd->user =3D lr;
 =

 	if (g_at_chat_send(gd->chat, "AT^SGPSC=3D\"Engine\",2", sgpsc_prefix,
@@ -172,6 +188,205 @@ static void gemalto_location_reporting_enable(struct =
ofono_location_reporting *l
 	g_free(cbd);
 }
 =

+static void gemalto_location_reporting_get_properties(
+			struct ofono_location_reporting *lr, void *_dict)
+{
+	DBusMessageIter *dict =3D _dict;
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	int property_pos =3D 0;
+	struct ofono_modem *modem =3D ofono_location_reporting_get_modem(lr);
+	const char *port =3D ofono_modem_get_string(modem, "GNSS");
+	const char *prop_port =3D "Port";
+
+	while(property_pos < MAX_GNSS_PROPERTIES &&
+					*gd->properties[property_pos].name) {
+		char *propval =3D gd->properties[property_pos].value_s;
+		ofono_dbus_dict_append(dict, gd->properties[property_pos].name,
+						DBUS_TYPE_STRING, &propval);
+		property_pos++;
+	}
+
+	/* add port outside of the modem property list */
+	DBG("%s=3D%s", prop_port, port);
+	if (port)
+		ofono_dbus_dict_append(dict, prop_port, DBUS_TYPE_STRING, &port);
+}
+
+static void change_property_list(GAtResult *result, gpointer user_data) {
+	struct ofono_location_reporting *lr =3D user_data;
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	GAtResultIter iter;
+	int property_pos;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(lr->atom);
+
+	g_at_result_iter_init(&iter, result);
+
+	/* supported format: ^SGPSC: "Nmea/Output","off" */
+	while (g_at_result_iter_next(&iter, "^SGPSC:")) {
+		const char *name =3D "";
+		const char *val =3D "";
+
+		if (!g_at_result_iter_next_string(&iter, &name))
+			continue;
+
+		/*
+		 * skip the "Info" property:
+		 * different line format and different usage
+		 */
+		if (g_str_equal(name,"Info"))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &val))
+			continue;
+
+		for(property_pos =3D 0; property_pos < MAX_GNSS_PROPERTIES &&
+			   *gd->properties[property_pos].name; property_pos++) {
+
+			if (!g_str_equal(gd->properties[property_pos].name,
+									name))
+				continue;
+
+			strncpy(gd->properties[property_pos].value_s,val,
+					MAX_GNSS_STRLEN);
+			ofono_dbus_signal_property_changed(conn, path,
+					OFONO_LOCATION_REPORTING_INTERFACE,
+					name, DBUS_TYPE_STRING, &val);
+		}
+	}
+}
+
+static void gemalto_location_reporting_set_property_cb(gboolean ok,
+					GAtResult *result, gpointer user_data)
+{
+	struct ofono_location_reporting *lr =3D user_data;
+
+	if (!ok || !lr)
+		return;
+
+	change_property_list(result, lr);
+}
+
+static void *gemalto_location_reporting_set_property(
+				struct ofono_location_reporting *lr, void *_msg)
+{
+	DBusMessage *msg =3D _msg;
+	struct gps_data *gd;
+	DBusMessageIter iter, var;
+	const char *name;
+	int property_pos;
+
+	DBG("");
+	if (!lr)
+		return __ofono_error_not_available(msg);
+
+	gd =3D ofono_location_reporting_get_data(lr);
+
+	if (!gd)
+		return __ofono_error_not_available(msg);
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	property_pos =3D 0;
+
+	while(property_pos < MAX_GNSS_PROPERTIES &&
+					*gd->properties[property_pos].name) {
+
+		if (g_str_equal(name, gd->properties[property_pos].name))
+		{
+			char s[128];
+			char *value;
+
+			if (dbus_message_iter_get_arg_type(&var) !=3D
+							DBUS_TYPE_STRING)
+				return __ofono_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&var, &value);
+
+			/* do not set the same value and do not notify change */
+			if (g_str_equal(value,
+					gd->properties[property_pos].value_s))
+				return __ofono_error_not_available(msg);
+
+			sprintf(s, "AT^SGPSC=3D\"%s\",\"%s\"",name, value);
+			DBG("setting %s", s);
+
+			/* TODO: report value changed */
+
+			if (g_at_chat_send(gd->chat, s, sgpsc_prefix,
+				    gemalto_location_reporting_set_property_cb,
+								lr, NULL) > 0)
+
+				return dbus_message_new_method_return(msg);
+
+			return __ofono_error_not_available(msg);
+		}
+		property_pos++;
+
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static void build_property_list(GAtResult *result, gpointer user_data) {
+	struct ofono_location_reporting *lr =3D user_data;
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	GAtResultIter iter;
+	int property_pos =3D 0;
+
+	/* skip pre-set */
+	while (property_pos < MAX_GNSS_PROPERTIES &&
+					*gd->properties[property_pos].name)
+		property_pos++;
+
+	g_at_result_iter_init(&iter, result);
+
+	/* supported format: ^SGPSC: "Nmea/Output","off" */
+	while ((property_pos < MAX_GNSS_PROPERTIES) &&
+				g_at_result_iter_next(&iter, "^SGPSC:")) {
+		const char *name =3D "";
+		const char *val =3D "";
+
+		if (!g_at_result_iter_next_string(&iter, &name))
+			continue;
+
+		/*
+		 * skip the "Info" property:
+		 * different line format and different usage
+		 */
+		if (g_str_equal(name,"Info"))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &val))
+			continue;
+
+		strncpy(gd->properties[property_pos].name, name,
+							MAX_GNSS_STRLEN);
+		strncpy(gd->properties[property_pos].value_s, val,
+							MAX_GNSS_STRLEN);
+		property_pos++;
+	}
+
+	property_pos =3D 0;
+
+	while ((property_pos < MAX_GNSS_PROPERTIES) &&
+					*gd->properties[property_pos].name) {
+		property_pos++;
+	}
+}
+
 static void gemalto_location_reporting_support_cb(gboolean ok, GAtResult *=
result,
 							gpointer user_data)
 {
@@ -179,13 +394,50 @@ static void gemalto_location_reporting_support_cb(gbo=
olean ok, GAtResult *result
 =

 	if (!ok) {
 		ofono_location_reporting_remove(lr);
-
 		return;
 	}
 =

+	build_property_list(result, user_data);
 	ofono_location_reporting_register(lr);
 }
 =

+static void gemalto_locrep_stored(struct ofono_location_reporting *lr) {
+	struct ofono_modem *modem =3D ofono_location_reporting_get_modem(lr);
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	const char *vid =3D ofono_modem_get_string(modem, "Vendor");
+	const char *pid =3D ofono_modem_get_string(modem, "Model");
+	char store[32];
+	int index;
+	char *property, *value;
+	char key[32];
+	GKeyFile *f;
+	char *command;
+
+	sprintf(store,"%s-%s/location-reporting", vid, pid);
+	f =3D storage_open(NULL, store);
+
+	if (!f)
+		return;
+
+	for (index =3D 0; ; index++) {
+		sprintf(key, "property_%d", index);
+		property =3D g_key_file_get_string(f, "Properties", key, NULL);
+
+		sprintf(key, "value_%d", index);
+		value =3D g_key_file_get_string(f, "Properties", key, NULL);
+
+		if (!property || !value)
+			break;
+
+		command =3D g_strdup_printf("AT^SGPSC=3D%s,%s", property, value);
+		DBG("setting GNSS property: %s", command);
+		g_at_chat_send(gd->chat, command, NULL, NULL, NULL, NULL);
+		free(command);
+	}
+
+	storage_close(NULL, store, f, FALSE);
+}
+
 static int gemalto_location_reporting_probe(struct ofono_location_reportin=
g *lr,
 						unsigned int vendor, void *data)
 {
@@ -193,24 +445,35 @@ static int gemalto_location_reporting_probe(struct of=
ono_location_reporting *lr,
 	struct gps_data *gd;
 =

 	gd =3D g_try_new0(struct gps_data, 1);
+
 	if (gd =3D=3D NULL)
 		return -ENOMEM;
 =

 	gd->chat =3D g_at_chat_clone(chat);
-
 	ofono_location_reporting_set_data(lr, gd);
 =

-	g_at_chat_send(gd->chat, "AT^SGPSC=3D?", sgpsc_prefix,
+	/*
+	 * Storage of parameters is read-only.
+	 * It is intended for preconfiguring the devide by tbe manufacturer.
+	 * The parameters are stored by USB VID-PID, because
+	 * they are not standardized, and each model can have its own set.
+	 */
+	gemalto_locrep_stored(lr);
+
+	g_at_chat_send(gd->chat, "AT^SGPSC?", sgpsc_prefix,
 					gemalto_location_reporting_support_cb,
 					lr, NULL);
 =

 	return 0;
 }
 =

-static void gemalto_location_reporting_remove(struct ofono_location_report=
ing *lr)
+static void gemalto_location_reporting_remove(struct ofono_location_report=
ing
+									*lr)
 {
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 =

+	/* TODO: store modified params if [Settings] sync=3D=3Dyes */
+
 	ofono_location_reporting_set_data(lr, NULL);
 =

 	g_at_chat_unref(gd->chat);
@@ -224,6 +487,8 @@ static struct ofono_location_reporting_driver driver =
=3D {
 	.remove			=3D gemalto_location_reporting_remove,
 	.enable			=3D gemalto_location_reporting_enable,
 	.disable		=3D gemalto_location_reporting_disable,
+	.get_properties		=3D gemalto_location_reporting_get_properties,
+	.set_property		=3D gemalto_location_reporting_set_property
 };
 =

 void gemalto_location_reporting_init()
-- =

2.17.1


--===============6443268046643711446==--

