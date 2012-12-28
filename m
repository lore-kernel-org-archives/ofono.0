Content-Type: multipart/mixed; boundary="===============5040190239410342152=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 7/8] sierra: Support CDMA modems
Date: Fri, 28 Dec 2012 14:36:13 -0500
Message-ID: <20121228193613.GM18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5040190239410342152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 plugins/sierra.c |  104 ++++++++++++++++++++++++++++++++++++++++++++------=
---
 1 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index a458e38..1beb59a 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -39,15 +40,20 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/phonebook.h>
+#include <ofono/cdma-netreg.h>
+#include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
 =

 struct sierra_data {
 	GAtChat *modem;
+	ofono_bool_t have_gsm;
+	ofono_bool_t have_cdma;
 };
 =

 static void sierra_debug(const char *str, void *user_data)
@@ -119,7 +125,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void enable_result(ofono_bool_t ok, GAtResult *result, gpointer use=
r_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
@@ -134,6 +140,40 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	ofono_modem_set_powered(modem, ok);
 }
 =

+static void gcap_support(ofono_bool_t ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sierra_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *gcap;
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+GCAP:"))
+		goto done;
+
+	while (g_at_result_iter_next_unquoted_string(&iter, &gcap)) {
+		if (*gcap =3D=3D '\0')
+			break;
+
+		if (!strcmp(gcap, "+CGSM"))
+			data->have_gsm =3D TRUE;
+		else if (!strcmp(gcap, "+CIS707-A"))
+			data->have_cdma =3D TRUE;
+	}
+
+done:
+	if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE)
+		g_at_chat_send(data->modem, "AT!PCSTATE=3D1", none_prefix,
+						enable_result, modem, NULL);
+	else
+		g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
+						enable_result, modem, NULL);
+}
+
 static int sierra_enable(struct ofono_modem *modem)
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
@@ -148,13 +188,14 @@ static int sierra_enable(struct ofono_modem *modem)
 	/* This is separate because it is not supported by all modems. */
 	g_at_chat_send(data->modem, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
+	/* Check for GSM capabilities */
+	g_at_chat_send(data->modem, "ATI", gcap_prefix,
+					gcap_support, modem, NULL);
 =

 	return -EINPROGRESS;
 }
 =

-static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void disable_result(ofono_bool_t ok, GAtResult *result, gpointer us=
er_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
@@ -171,19 +212,25 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 static int sierra_disable(struct ofono_modem *modem)
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
+	const char *command;
 =

 	DBG("%p", modem);
 =

 	g_at_chat_cancel_all(data->modem);
 	g_at_chat_unregister_all(data->modem);
 =

-	g_at_chat_send(data->modem, "AT+CFUN=3D0", none_prefix,
-					cfun_disable, modem, NULL);
+	if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE)
+		command =3D "AT!PCSTATE=3D0";
+	else
+		command =3D "AT+CFUN=3D0";
+
+	g_at_chat_send(data->modem, command, none_prefix,
+				disable_result, modem, NULL);
 =

 	return -EINPROGRESS;
 }
 =

-static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+static void set_online_cb(ofono_bool_t ok, GAtResult *result, gpointer use=
r_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_modem_online_cb_t cb =3D cbd->cb;
@@ -198,10 +245,15 @@ static void sierra_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+	char const *command;
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

+	if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE)
+		command =3D online ? "AT!PCSTATE=3D1" : "AT!PCSTATE=3D0";
+	else
+		command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
 	if (g_at_chat_send(data->modem, command, none_prefix,
 					set_online_cb, cbd, g_free) > 0)
 		return;
@@ -214,13 +266,17 @@ static void sierra_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 static void sierra_pre_sim(struct ofono_modem *modem)
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
+	struct ofono_sim *sim =3D NULL;
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->modem);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIERRA,
-					"atmodem", data->modem);
+	if (data->have_gsm =3D=3D TRUE) {
+		ofono_devinfo_create(modem, 0, "atmodem", data->modem);
+		sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIERRA,
+						"atmodem", data->modem);
+	} else if (data->have_cdma =3D=3D TRUE) {
+		ofono_devinfo_create(modem, 0, "cdmamodem", data->modem);
+	}
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
@@ -234,13 +290,15 @@ static void sierra_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
+	if (data->have_gsm =3D=3D TRUE) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->modem);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
-	gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
+		gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
+		gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+	}
 }
 =

 static void sierra_post_online(struct ofono_modem *modem)
@@ -249,7 +307,17 @@ static void sierra_post_online(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, 0, "atmodem", data->modem);
+	if (data->have_gsm =3D=3D TRUE) {
+		ofono_netreg_create(modem, 0, "atmodem", data->modem);
+	} else if (data->have_cdma =3D=3D TRUE) {
+		/*
+		 * Once we have CnS protocol support, we should be able to do
+		 * netreg that way instead of using the same port for both.
+		 */
+		ofono_cdma_netreg_create(modem, 0, "sierramodem", data->modem);
+		ofono_cdma_connman_create(modem, OFONO_VENDOR_SIERRA,
+						"cdmamodem", data->modem);
+	}
 }
 =

 static struct ofono_modem_driver sierra_driver =3D {
-- =

1.7.0.4

--===============5040190239410342152==--

