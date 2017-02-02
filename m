Content-Type: multipart/mixed; boundary="===============6524143685774871795=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 1/2] plugins: rename xe910 to telit
Date: Thu, 02 Feb 2017 15:09:26 +0100
Message-ID: <20170202140927.8152-2-gluedig@gmail.com>
In-Reply-To: <20170202140927.8152-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6524143685774871795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unify old telit and xe910 plugins.
Dropping support for Bluetooth SAP.
Add support for UC864 family.
---
 Makefile.am     |   7 +-
 plugins/telit.c | 550 +++++++++++++++++++++-------------------------------=
----
 plugins/xe910.c | 546 ----------------------------------------------------=
---
 3 files changed, 207 insertions(+), 896 deletions(-)
 delete mode 100644 plugins/xe910.c

diff --git a/Makefile.am b/Makefile.am
index 560fc1cb..5968d8a8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -492,8 +492,8 @@ builtin_sources +=3D plugins/sim900.c
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

-builtin_modules +=3D xe910
-builtin_sources +=3D plugins/xe910.c
+builtin_modules +=3D telit
+builtin_sources +=3D plugins/telit.c
 =

 builtin_modules +=3D quectel
 builtin_sources +=3D plugins/quectel.c
@@ -503,9 +503,6 @@ builtin_sources +=3D plugins/ublox.c
 =

 if BLUETOOTH
 if BLUEZ4
-builtin_modules +=3D telit
-builtin_sources +=3D plugins/telit.c plugins/bluez4.h
-
 builtin_modules +=3D sap
 builtin_sources +=3D plugins/sap.c plugins/bluez4.h
 =

diff --git a/plugins/telit.c b/plugins/telit.c
index 392283aa..742e06c0 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2008-2014  Intel Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -46,6 +46,7 @@
 #include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
 #include <ofono/message-waiting.h>
+#include <ofono/location-reporting.h>
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
@@ -58,10 +59,39 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

-#include "bluez4.h"
-
 static const char *none_prefix[] =3D { NULL };
-static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
+static const char *qss_prefix[] =3D { "#QSS:", NULL };
+
+enum modem_model {
+	HE910 =3D 1,
+	UE910,
+	LE910,
+	UC864,
+};
+
+static struct {
+	enum modem_model model;
+	const char *variant;
+	gboolean has_voice;
+	gboolean has_gps;
+} variants_list[] =3D {
+	{ HE910,	NULL,	FALSE,	FALSE },
+	{ HE910,	"G",	TRUE,	TRUE },
+	{ HE910,	"GL",	TRUE,	FALSE },
+	{ HE910,	"EUR",	TRUE,	FALSE },
+	{ HE910,	"NAR",	TRUE,	FALSE },
+	{ HE910,	"DG",	FALSE,	TRUE },
+	{ HE910,	"EUG",	FALSE,	TRUE },
+	{ HE910,	"NAG",	FALSE,	TRUE },
+	{ UE910,	NULL,	FALSE,	FALSE },
+	{ UE910,	"EUR",	TRUE,	FALSE },
+	{ UE910,	"NAR",	TRUE,	FALSE },
+	{ LE910,	NULL,	FALSE,	FALSE },
+	{ UC864,	NULL,	TRUE,	FALSE },
+	{ UC864,	"G",	TRUE,	TRUE },
+	{ UC864,	"WD",	FALSE,	FALSE },
+	{ }
+};
 =

 struct telit_data {
 	GAtChat *chat;		/* AT chat */
@@ -69,11 +99,9 @@ struct telit_data {
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
 	ofono_bool_t sms_phonebook_added;
-	struct ofono_modem *sap_modem;
-	GIOChannel *bt_io;
-	GIOChannel *hw_io;
-	guint bt_watch;
-	guint hw_watch;
+	enum modem_model model;
+	gboolean has_voice;
+	gboolean has_gps;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -83,102 +111,6 @@ static void telit_debug(const char *str, void *user_da=
ta)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static void sap_close_io(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	if (data->bt_io !=3D NULL) {
-		int sk =3D g_io_channel_unix_get_fd(data->bt_io);
-		shutdown(sk, SHUT_RDWR);
-
-		g_io_channel_unref(data->bt_io);
-		data->bt_io =3D NULL;
-	}
-
-	if (data->bt_watch > 0)
-		g_source_remove(data->bt_watch);
-
-	g_io_channel_unref(data->hw_io);
-	data->hw_io =3D NULL;
-
-	if (data->hw_watch > 0)
-		g_source_remove(data->hw_watch);
-}
-
-static void bt_watch_remove(gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	ofono_modem_set_powered(modem, FALSE);
-
-	data->bt_watch =3D 0;
-}
-
-static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondition condition,
-							gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	if (condition & G_IO_IN) {
-		GIOStatus status;
-		gsize bytes_read, bytes_written;
-		gchar buf[300];
-
-		status =3D g_io_channel_read_chars(bt_io, buf, 300,
-							&bytes_read, NULL);
-
-		if (bytes_read > 0)
-			g_io_channel_write_chars(data->hw_io, buf,
-					bytes_read, &bytes_written, NULL);
-
-		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
-			return FALSE;
-
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
-static void hw_watch_remove(gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	ofono_modem_set_powered(modem, FALSE);
-
-	data->hw_watch =3D 0;
-}
-
-static gboolean hw_event_cb(GIOChannel *hw_io, GIOCondition condition,
-							gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	if (condition & G_IO_IN) {
-		GIOStatus status;
-		gsize bytes_read, bytes_written;
-		gchar buf[300];
-
-		status =3D g_io_channel_read_chars(hw_io, buf, 300,
-							&bytes_read, NULL);
-
-		if (bytes_read > 0)
-			g_io_channel_write_chars(data->bt_io, buf,
-					bytes_read, &bytes_written, NULL);
-
-		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
-			return FALSE;
-
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
@@ -199,15 +131,13 @@ static GAtChat *open_device(struct ofono_modem *modem,
 		return NULL;
 =

 	g_hash_table_insert(options, "Baud", "115200");
-
 	channel =3D g_at_tty_open(device, options);
-
 	g_hash_table_destroy(options);
 =

 	if (channel =3D=3D NULL)
 		return NULL;
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
@@ -273,19 +203,46 @@ static void telit_qss_notify(GAtResult *result, gpoin=
ter user_data)
 	switch_sim_state_status(modem, status);
 }
 =

+static void qss_query_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status, mode;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &mode))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	switch_sim_state_status(modem, status);
+}
+
 static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_modem *m =3D data->sap_modem ? : modem;
 =

 	DBG("%p", modem);
 =

 	if (!ok) {
 		g_at_chat_unref(data->chat);
 		data->chat =3D NULL;
-		ofono_modem_set_powered(m, FALSE);
-		sap_close_io(modem);
+
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
 =

@@ -299,7 +256,7 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	data->have_sim =3D FALSE;
 	data->sms_phonebook_added =3D FALSE;
 =

-	ofono_modem_set_powered(m, TRUE);
+	ofono_modem_set_powered(modem, TRUE);
 =

 	/*
 	 * Tell the modem not to automatically initiate auto-attach
@@ -314,6 +271,103 @@ static void cfun_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	/* Enable sim state notification */
 	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
+
+	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
+			qss_query_cb, modem, NULL);
+}
+
+static gboolean find_model_variant(struct ofono_modem *modem,
+						const char * model_variant)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	char model[32];
+	char variant[32];
+	gchar **tokens;
+	int i;
+
+	if (!model_variant || model_variant[0] =3D=3D '\0')
+		return FALSE;
+
+	DBG("%s", model_variant);
+
+	tokens =3D g_strsplit(model_variant, "-", 2);
+
+	if (!tokens || !tokens[0] || !tokens[1])
+		return FALSE;
+
+	g_strlcpy(model, tokens[0], sizeof(model));
+	g_strlcpy(variant, tokens[1], sizeof(variant));
+	g_strfreev(tokens);
+
+	if (g_str_equal(model, "HE910"))
+		data->model =3D HE910;
+	else if (g_str_equal(model, "UE910"))
+		data->model =3D UE910;
+	else if (g_str_equal(model, "LE910"))
+		data->model =3D LE910;
+	else if (g_str_equal(model, "UC864"))
+		data->model =3D UC864;
+	else
+		return FALSE;
+
+	DBG("Model: %s", model);
+
+	for (i =3D 0; variants_list[i].model; i++) {
+		if (variants_list[i].model !=3D data->model)
+			continue;
+
+		/* Set model defaults */
+		if (variants_list[i].variant =3D=3D NULL) {
+			data->has_voice =3D variants_list[i].has_voice;
+			data->has_gps =3D variants_list[i].has_gps;
+			continue;
+		}
+
+		/* Specific variant match */
+		if (g_str_equal(variant, variants_list[i].variant)) {
+			DBG("Variant: %s", variant);
+			data->has_voice =3D variants_list[i].has_voice;
+			data->has_gps =3D variants_list[i].has_gps;
+		}
+	}
+
+	return TRUE;
+}
+
+static void cfun_gmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	const char * model_variant;
+
+	DBG("%p", modem);
+
+	if (!ok)
+		goto error;
+
+	/* Get +GMM response */
+	if (!at_util_parse_attr(result, "", &model_variant))
+		goto error;
+
+	/* Try to find modem model and variant */
+	if (!find_model_variant(modem, model_variant)) {
+		ofono_info("Unknown xE910 model/variant %s", model_variant);
+		goto error;
+	}
+
+	/* Set phone functionality */
+	if (g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+				cfun_enable_cb, modem, NULL) > 0)
+		return;
+
+error:
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static int telit_enable(struct ofono_modem *modem)
@@ -341,57 +395,16 @@ static int telit_enable(struct ofono_modem *modem)
 	 */
 	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
 				NULL, NULL, NULL);
+	g_at_chat_send(data->modem, "ATE0", none_prefix,
+				NULL, NULL, NULL);
 =

-	/*
-	 * Disable sim state notification so that we sure get a notification
-	 * when we enable it again later and don't have to query it.
-	 */
-	g_at_chat_send(data->chat, "AT#QSS=3D0", none_prefix, NULL, NULL, NULL);
-
-	/* Set phone functionality */
-	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
-				cfun_enable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
-static void telit_rsen_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	int status;
-	GAtResultIter iter;
-
-	DBG("%p", modem);
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "#RSEN:"))
-		return;
-
-	g_at_result_iter_next_number(&iter, &status);
-
-	if (status =3D=3D 0) {
-		ofono_modem_set_powered(data->sap_modem, FALSE);
-		sap_close_io(modem);
-		return;
-	}
-
-	telit_enable(modem);
-}
 =

-static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
+	/* Get modem model and variant */
+	g_at_chat_send(data->chat, "AT+GMM", NULL,
+				cfun_gmm_cb, modem, NULL);
 =

-	DBG("%p", modem);
 =

-	if (!ok) {
-		ofono_modem_set_powered(data->sap_modem, FALSE);
-		sap_close_io(modem);
-		return;
-	}
+	return -EINPROGRESS;
 }
 =

 static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -399,9 +412,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 =

-	if(data->sap_modem)
-		modem =3D data->sap_modem;
-
 	DBG("%p", modem);
 =

 	g_at_chat_unref(data->chat);
@@ -409,13 +419,12 @@ static void cfun_disable_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
-
-	data->sap_modem =3D NULL;
 }
 =

 static int telit_disable(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
 =

 	g_at_chat_cancel_all(data->modem);
@@ -427,211 +436,66 @@ static int telit_disable(struct ofono_modem *modem)
 	g_at_chat_unregister_all(data->chat);
 =

 	/* Power down modem */
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
 				cfun_disable_cb, modem, NULL);
 =

 	return -EINPROGRESS;
 }
 =

-static void rsen_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
-{
-	struct ofono_modem *modem =3D user_data;
-
-	DBG("%p", modem);
-
-	sap_close_io(modem);
-
-	telit_disable(modem);
-}
-
-static int telit_sap_open(void)
-{
-	const char *device =3D "/dev/ttyUSB4";
-	struct termios ti;
-	int fd;
-
-	DBG("%s", device);
-
-	fd =3D open(device, O_RDWR | O_NOCTTY | O_NONBLOCK);
-	if (fd < 0)
-		return -EINVAL;
-
-	/* Switch TTY to raw mode */
-	memset(&ti, 0, sizeof(ti));
-	cfmakeraw(&ti);
-
-	ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
-
-	tcflush(fd, TCIOFLUSH);
-	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
-		close(fd);
-		return -EBADF;
-	}
-
-	return fd;
-}
-
-static int telit_sap_enable(struct ofono_modem *modem,
-					struct ofono_modem *sap_modem,
-					int bt_fd)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	int fd;
-
-	DBG("%p", modem);
-
-	fd =3D telit_sap_open();
-	if (fd < 0)
-		goto error;
-
-	data->hw_io =3D g_io_channel_unix_new(fd);
-	if (data->hw_io =3D=3D NULL) {
-		close(fd);
-		goto error;
-	}
-
-	g_io_channel_set_encoding(data->hw_io, NULL, NULL);
-	g_io_channel_set_buffered(data->hw_io, FALSE);
-	g_io_channel_set_close_on_unref(data->hw_io, TRUE);
-
-	data->bt_io =3D g_io_channel_unix_new(bt_fd);
-	if (data->bt_io =3D=3D NULL)
-		goto error;
-
-	g_io_channel_set_encoding(data->bt_io, NULL, NULL);
-	g_io_channel_set_buffered(data->bt_io, FALSE);
-	g_io_channel_set_close_on_unref(data->bt_io, TRUE);
-
-	data->hw_watch =3D g_io_add_watch_full(data->hw_io, G_PRIORITY_DEFAULT,
-				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
-				hw_event_cb, modem, hw_watch_remove);
-
-	data->bt_watch =3D g_io_add_watch_full(data->bt_io, G_PRIORITY_DEFAULT,
-				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
-				bt_event_cb, modem, bt_watch_remove);
-
-	data->sap_modem =3D sap_modem;
-
-	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
-				FALSE, modem, NULL);
-
-	g_at_chat_send(data->chat, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
-
-	/* Set SAP functionality */
-	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
-				rsen_enable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-
-error:
-	shutdown(bt_fd, SHUT_RDWR);
-	close(bt_fd);
-
-	sap_close_io(modem);
-	return -EINVAL;
-}
-
-static int telit_sap_disable(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_send(data->chat, "AT#RSEN=3D0", rsen_prefix,
-				rsen_disable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
 static void telit_pre_sim(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 =

-	if (data->sap_modem)
-		modem =3D data->sap_modem;
-
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
-	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (data->has_gps)
+		ofono_location_reporting_create(modem, 0, "telitmodem",
+								data->chat);
 }
 =

-static void telit_post_sim(struct ofono_modem *modem)
+static void telit_post_online(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

-	if (data->sap_modem)
-		modem =3D data->sap_modem;
-
 	DBG("%p", modem);
 =

-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
-					data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-}
-
-static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
-}
-
-static void telit_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
-				ofono_modem_online_cb_t cb, void *user_data)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
+	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
 =

-	DBG("modem %p %s", modem, online ? "online" : "offline");
+	if (data->has_voice) {
+		struct ofono_message_waiting *mw;
 =

-	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
-						cbd, g_free);
-}
+		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+		ofono_ussd_create(modem, 0, "atmodem", data->chat);
+		ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+		ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+		ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+		ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 =

-static void telit_post_online(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
+		mw =3D ofono_message_waiting_create(modem);
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
 =

-	if(data->sap_modem)
-		modem =3D data->sap_modem;
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
+					data->chat);
 =

-	DBG("%p", modem);
+	if (data->model =3D=3D LE910)
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_TELIT,
+						"telitncmmodem", data->modem);
+	else
+		gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+						data->modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
-	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-
-	mw =3D ofono_message_waiting_create(modem);
-	if (mw)
-		ofono_message_waiting_register(mw);
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

-static struct bluetooth_sap_driver sap_driver =3D {
-	.name =3D "telit",
-	.enable =3D telit_sap_enable,
-	.pre_sim =3D telit_pre_sim,
-	.post_sim =3D telit_post_sim,
-	.set_online =3D telit_set_online,
-	.post_online =3D telit_post_online,
-	.disable =3D telit_sap_disable,
-};
-
 static int telit_probe(struct ofono_modem *modem)
 {
 	struct telit_data *data;
@@ -644,8 +508,6 @@ static int telit_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

-	bluetooth_sap_client_register(&sap_driver, modem);
-
 	return 0;
 }
 =

@@ -655,8 +517,6 @@ static void telit_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	bluetooth_sap_client_unregister(modem);
-
 	ofono_modem_set_data(modem, NULL);
 =

 	/* Cleanup after hot-unplug */
@@ -672,14 +532,14 @@ static struct ofono_modem_driver telit_driver =3D {
 	.remove		=3D telit_remove,
 	.enable		=3D telit_enable,
 	.disable	=3D telit_disable,
-	.set_online	=3D telit_set_online,
 	.pre_sim	=3D telit_pre_sim,
-	.post_sim	=3D telit_post_sim,
 	.post_online	=3D telit_post_online,
 };
 =

 static int telit_init(void)
 {
+	DBG("");
+
 	return ofono_modem_driver_register(&telit_driver);
 }
 =

@@ -688,5 +548,5 @@ static void telit_exit(void)
 	ofono_modem_driver_unregister(&telit_driver);
 }
 =

-OFONO_PLUGIN_DEFINE(telit, "telit driver", VERSION,
+OFONO_PLUGIN_DEFINE(telit, "Telit driver", VERSION,
 		OFONO_PLUGIN_PRIORITY_DEFAULT, telit_init, telit_exit)
diff --git a/plugins/xe910.c b/plugins/xe910.c
deleted file mode 100644
index bf40a3de..00000000
--- a/plugins/xe910.c
+++ /dev/null
@@ -1,546 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2014  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <termios.h>
-#include <string.h>
-#include <sys/socket.h>
-
-#include <glib.h>
-#include <gatchat.h>
-#include <gattty.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/call-barring.h>
-#include <ofono/call-forwarding.h>
-#include <ofono/call-meter.h>
-#include <ofono/call-settings.h>
-#include <ofono/devinfo.h>
-#include <ofono/message-waiting.h>
-#include <ofono/location-reporting.h>
-#include <ofono/netreg.h>
-#include <ofono/phonebook.h>
-#include <ofono/sim.h>
-#include <ofono/gprs.h>
-#include <ofono/gprs-context.h>
-#include <ofono/sms.h>
-#include <ofono/ussd.h>
-#include <ofono/voicecall.h>
-
-#include <drivers/atmodem/atutil.h>
-#include <drivers/atmodem/vendor.h>
-
-static const char *none_prefix[] =3D { NULL };
-static const char *qss_prefix[] =3D { "#QSS:", NULL };
-
-enum modem_model {
-	HE910 =3D 1,
-	UE910,
-	LE910
-};
-
-static struct {
-	enum modem_model model;
-	const char *variant;
-	gboolean has_voice;
-	gboolean has_gps;
-} variants_list[] =3D {
-	{ HE910,	NULL,	FALSE,	FALSE },
-	{ HE910,	"G",	TRUE,	TRUE },
-	{ HE910,	"GL",	TRUE,	FALSE },
-	{ HE910,	"EUR",	TRUE,	FALSE },
-	{ HE910,	"NAR",	TRUE,	FALSE },
-	{ HE910,	"DG",	FALSE,	TRUE },
-	{ HE910,	"EUG",	FALSE,	TRUE },
-	{ HE910,	"NAG",	FALSE,	TRUE },
-	{ UE910,	NULL,	FALSE,	FALSE },
-	{ UE910,	"EUR",	TRUE,	FALSE },
-	{ UE910,	"NAR",	TRUE,	FALSE },
-	{ LE910,	NULL,	FALSE,	FALSE },
-	{ }
-};
-
-struct xe910_data {
-	GAtChat *chat;		/* AT chat */
-	GAtChat *modem;		/* Data port */
-	struct ofono_sim *sim;
-	ofono_bool_t have_sim;
-	ofono_bool_t sms_phonebook_added;
-	enum modem_model model;
-	gboolean has_voice;
-	gboolean has_gps;
-};
-
-static void xe910_debug(const char *str, void *user_data)
-{
-	const char *prefix =3D user_data;
-
-	ofono_info("%s%s", prefix, str);
-}
-
-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
-{
-	const char *device;
-	GAtSyntax *syntax;
-	GIOChannel *channel;
-	GAtChat *chat;
-	GHashTable *options;
-
-	device =3D ofono_modem_get_string(modem, key);
-	if (device =3D=3D NULL)
-		return NULL;
-
-	DBG("%s %s", key, device);
-
-	options =3D g_hash_table_new(g_str_hash, g_str_equal);
-	if (options =3D=3D NULL)
-		return NULL;
-
-	g_hash_table_insert(options, "Baud", "115200");
-	channel =3D g_at_tty_open(device, options);
-	g_hash_table_destroy(options);
-
-	if (channel =3D=3D NULL)
-		return NULL;
-
-	syntax =3D g_at_syntax_new_gsm_permissive();
-	chat =3D g_at_chat_new(channel, syntax);
-	g_at_syntax_unref(syntax);
-	g_io_channel_unref(channel);
-
-	if (chat =3D=3D NULL)
-		return NULL;
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, xe910_debug, debug);
-
-	return chat;
-}
-
-static void switch_sim_state_status(struct ofono_modem *modem, int status)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p, SIM status: %d", modem, status);
-
-	switch (status) {
-	case 0:	/* SIM not inserted */
-		if (data->have_sim =3D=3D TRUE) {
-			ofono_sim_inserted_notify(data->sim, FALSE);
-			data->have_sim =3D FALSE;
-			data->sms_phonebook_added =3D FALSE;
-		}
-		break;
-	case 1:	/* SIM inserted */
-	case 2:	/* SIM inserted and PIN unlocked */
-		if (data->have_sim =3D=3D FALSE) {
-			ofono_sim_inserted_notify(data->sim, TRUE);
-			data->have_sim =3D TRUE;
-		}
-		break;
-	case 3:	/* SIM inserted, SMS and phonebook ready */
-		if (data->sms_phonebook_added =3D=3D FALSE) {
-			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
-			ofono_sms_create(modem, 0, "atmodem", data->chat);
-			data->sms_phonebook_added =3D TRUE;
-		}
-		break;
-	default:
-		ofono_warn("Unknown SIM state %d received", status);
-		break;
-	}
-}
-
-static void xe910_qss_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	int status;
-	GAtResultIter iter;
-
-	DBG("%p", modem);
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "#QSS:"))
-		return;
-
-	g_at_result_iter_next_number(&iter, &status);
-
-	switch_sim_state_status(modem, status);
-}
-
-static void qss_query_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-{
-	struct ofono_modem *modem =3D user_data;
-	int status, mode;
-	GAtResultIter iter;
-
-	DBG("%p", modem);
-
-	if (!ok)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "#QSS:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &mode))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &status))
-		return;
-
-	switch_sim_state_status(modem, status);
-}
-
-static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
-
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-
-		ofono_modem_set_powered(modem, FALSE);
-		return;
-	}
-
-	/*
-	 * Switch data carrier detect signal off.
-	 * When the DCD is disabled the modem does not hangup anymore
-	 * after the data connection.
-	 */
-	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
-
-	data->have_sim =3D FALSE;
-	data->sms_phonebook_added =3D FALSE;
-
-	ofono_modem_set_powered(modem, TRUE);
-
-	/*
-	 * Tell the modem not to automatically initiate auto-attach
-	 * proceedures on its own.
-	 */
-	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
-				NULL, NULL, NULL);
-
-	/* Follow sim state */
-	g_at_chat_register(data->chat, "#QSS:", xe910_qss_notify,
-				FALSE, modem, NULL);
-
-	/* Enable sim state notification */
-	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
-
-	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
-			qss_query_cb, modem, NULL);
-}
-
-static gboolean find_model_variant(struct ofono_modem *modem,
-						const char * model_variant)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-	char model[32];
-	char variant[32];
-	gchar **tokens;
-	int i;
-
-	if (!model_variant || model_variant[0] =3D=3D '\0')
-		return FALSE;
-
-	DBG("%s", model_variant);
-
-	tokens =3D g_strsplit(model_variant, "-", 2);
-
-	if (!tokens || !tokens[0] || !tokens[1])
-		return FALSE;
-
-	g_strlcpy(model, tokens[0], sizeof(model));
-	g_strlcpy(variant, tokens[1], sizeof(variant));
-	g_strfreev(tokens);
-
-	if (g_str_equal(model, "HE910"))
-		data->model =3D HE910;
-	else if (g_str_equal(model, "UE910"))
-		data->model =3D UE910;
-	else if (g_str_equal(model, "LE910"))
-		data->model =3D LE910;
-	else
-		return FALSE;
-
-	DBG("Model: %s", model);
-
-	for (i =3D 0; variants_list[i].model; i++) {
-		if (variants_list[i].model !=3D data->model)
-			continue;
-
-		/* Set model defaults */
-		if (variants_list[i].variant =3D=3D NULL) {
-			data->has_voice =3D variants_list[i].has_voice;
-			data->has_gps =3D variants_list[i].has_gps;
-			continue;
-		}
-
-		/* Specific variant match */
-		if (g_str_equal(variant, variants_list[i].variant)) {
-			DBG("Variant: %s", variant);
-			data->has_voice =3D variants_list[i].has_voice;
-			data->has_gps =3D variants_list[i].has_gps;
-		}
-	}
-
-	return TRUE;
-}
-
-static void cfun_gmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-	const char * model_variant;
-
-	DBG("%p", modem);
-
-	if (!ok)
-		goto error;
-
-	/* Get +GMM response */
-	if (!at_util_parse_attr(result, "", &model_variant))
-		goto error;
-
-	/* Try to find modem model and variant */
-	if (!find_model_variant(modem, model_variant)) {
-		ofono_info("Unknown xE910 model/variant %s", model_variant);
-		goto error;
-	}
-
-	/* Set phone functionality */
-	if (g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
-				cfun_enable_cb, modem, NULL) > 0)
-		return;
-
-error:
-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
-
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-
-	ofono_modem_set_powered(modem, FALSE);
-}
-
-static int xe910_enable(struct ofono_modem *modem)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
-		return -EINVAL;
-
-	data->chat =3D open_device(modem, "Aux", "Aux: ");
-	if (data->chat =3D=3D NULL) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-		return -EIO;
-	}
-
-	g_at_chat_set_slave(data->modem, data->chat);
-
-	/*
-	 * Disable command echo and
-	 * enable the Extended Error Result Codes
-	 */
-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
-				NULL, NULL, NULL);
-	g_at_chat_send(data->modem, "ATE0", none_prefix,
-				NULL, NULL, NULL);
-
-
-	/* Get modem model and variant */
-	g_at_chat_send(data->chat, "AT+GMM", NULL,
-				cfun_gmm_cb, modem, NULL);
-
-
-	return -EINPROGRESS;
-}
-
-static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
-
-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
-}
-
-static int xe910_disable(struct ofono_modem *modem)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_cancel_all(data->modem);
-	g_at_chat_unregister_all(data->modem);
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-
-	g_at_chat_cancel_all(data->chat);
-	g_at_chat_unregister_all(data->chat);
-
-	/* Power down modem */
-	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
-				cfun_disable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
-static void xe910_pre_sim(struct ofono_modem *modem)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
-					data->chat);
-
-	if (data->has_gps)
-		ofono_location_reporting_create(modem, 0, "telitmodem",
-								data->chat);
-}
-
-static void xe910_post_online(struct ofono_modem *modem)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
-
-	DBG("%p", modem);
-
-	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
-
-	if (data->has_voice) {
-		struct ofono_message_waiting *mw;
-
-		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
-		ofono_ussd_create(modem, 0, "atmodem", data->chat);
-		ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
-		ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-		ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-		ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-
-		mw =3D ofono_message_waiting_create(modem);
-		if (mw)
-			ofono_message_waiting_register(mw);
-	}
-
-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
-					data->chat);
-
-	if (data->model =3D=3D LE910)
-		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_TELIT,
-						"telitncmmodem", data->modem);
-	else
-		gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
-						data->modem);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-}
-
-static int xe910_probe(struct ofono_modem *modem)
-{
-	struct xe910_data *data;
-
-	DBG("%p", modem);
-
-	data =3D g_try_new0(struct xe910_data, 1);
-	if (data =3D=3D NULL)
-		return -ENOMEM;
-
-	ofono_modem_set_data(modem, data);
-
-	return 0;
-}
-
-static void xe910_remove(struct ofono_modem *modem)
-{
-	struct xe910_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_modem_set_data(modem, NULL);
-
-	/* Cleanup after hot-unplug */
-	g_at_chat_unref(data->chat);
-	g_at_chat_unref(data->modem);
-
-	g_free(data);
-}
-
-static struct ofono_modem_driver xe910_driver =3D {
-	.name		=3D "xe910",
-	.probe		=3D xe910_probe,
-	.remove		=3D xe910_remove,
-	.enable		=3D xe910_enable,
-	.disable	=3D xe910_disable,
-	.pre_sim	=3D xe910_pre_sim,
-	.post_online	=3D xe910_post_online,
-};
-
-static int xe910_init(void)
-{
-	DBG("");
-
-	return ofono_modem_driver_register(&xe910_driver);
-}
-
-static void xe910_exit(void)
-{
-	ofono_modem_driver_unregister(&xe910_driver);
-}
-
-OFONO_PLUGIN_DEFINE(xe910, "Telit HE910 driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, xe910_init, xe910_exit)
-- =

2.11.0


--===============6524143685774871795==--

