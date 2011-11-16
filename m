Content-Type: multipart/mixed; boundary="===============3863149246129374729=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 3/3] huaweicdma: Add SIM creation and set_online method
 driver
Date: Wed, 16 Nov 2011 15:49:01 +0100
Message-ID: <1321454941-32022-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321454941-32022-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3863149246129374729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |  303 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 297 insertions(+), 6 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..caa9a6e 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -37,10 +37,28 @@
 #include <ofono/cdma-netreg.h>
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
+#include <ofono.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
+enum {
+	SIM_STATE_VALID =3D		1,
+	SIM_STATE_EMBEDDED =3D		240,
+	SIM_STATE_NOT_EXISTENT =3D	255,
+};
 =

 struct huaweicdma_data {
 	GAtChat *modem;
 	GAtChat *pcui;
+	gboolean have_sim;
+	int sim_state;
+	guint sysinfo_poll_source;
+	guint sysinfo_poll_count;
+	struct cb_data *online_cbd;
 };
 =

 static void huaweicdma_debug(const char *str, void *data)
@@ -79,6 +97,122 @@ static void huaweicdma_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

+static void simst_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int sim_state;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SIMST:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &sim_state))
+		return;
+
+	DBG("%d -> %d", data->sim_state, sim_state);
+
+	data->sim_state =3D sim_state;
+}
+
+static gboolean parse_sysinfo_result(GAtResult *result, int *srv_status,
+					int *srv_domain, int *sim_state)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, srv_status))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, srv_domain))
+		return FALSE;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, sim_state))
+		return FALSE;
+
+	return TRUE;
+}
+
+static void shutdown_device(struct huaweicdma_data *data)
+{
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->pcui);
+	g_at_chat_unregister_all(data->pcui);
+
+	g_at_chat_unref(data->pcui);
+	data->pcui =3D NULL;
+}
+
+static gboolean sysinfo_enable_check(gpointer user_data);
+
+static void sysinfo_enable_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+	int srv_status, srv_domain, sim_state;
+
+	if (!ok)
+		goto failure;
+
+	if (parse_sysinfo_result(result, &srv_status, &srv_domain,
+						&sim_state) =3D=3D FALSE)
+		goto failure;
+
+	DBG("%d -> %d", data->sim_state, sim_state);
+
+	data->sim_state =3D sim_state;
+
+	if (sim_state =3D=3D SIM_STATE_NOT_EXISTENT) {
+		data->sysinfo_poll_count++;
+
+		if (data->sysinfo_poll_count > 5)
+			goto failure;
+
+		data->sysinfo_poll_source =3D g_timeout_add_seconds(1,
+						sysinfo_enable_check, modem);
+		return;
+	}
+
+	data->have_sim =3D TRUE;
+	ofono_modem_set_powered(modem, TRUE);
+	return;
+
+failure:
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static gboolean sysinfo_enable_check(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	data->sysinfo_poll_source =3D 0;
+
+	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
+					sysinfo_enable_cb, modem, NULL);
+
+	return FALSE;
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -87,14 +221,18 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	DBG("");
 =

 	if (!ok) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-
-		g_at_chat_unref(data->pcui);
-		data->pcui =3D NULL;
+		shutdown_device(data);
+		ofono_modem_set_powered(modem, FALSE);
+		return;
 	}
 =

-	ofono_modem_set_powered(modem, ok);
+	/* Follow sim state changes */
+	g_at_chat_register(data->pcui, "^SIMST:", simst_notify,
+						FALSE, modem, NULL);
+
+	data->sysinfo_poll_count =3D 0;
+
+	sysinfo_enable_check(modem);
 }
 =

 static GAtChat *open_device(struct ofono_modem *modem,
@@ -150,6 +288,8 @@ static int huaweicdma_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->pcui, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

+	data->sim_state =3D SIM_STATE_NOT_EXISTENT;
+
 	g_at_chat_send(data->pcui, "AT+CFUN=3D1", NULL,
 					cfun_enable, modem, NULL);
 =

@@ -191,18 +331,168 @@ static int huaweicdma_disable(struct ofono_modem *mo=
dem)
 	return -EINPROGRESS;
 }
 =

+
+static gboolean sysinfo_online_check(gpointer user_data);
+
+static void sysinfo_online_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct huaweicdma_data *data =3D user_data;
+	ofono_modem_online_cb_t cb =3D data->online_cbd->cb;
+	int srv_status, srv_domain, sim_state;
+
+	if (!ok)
+		goto failure;
+
+	if (parse_sysinfo_result(result, &srv_status, &srv_domain,
+							&sim_state) =3D=3D FALSE)
+		goto failure;
+
+	DBG("%d -> %d", data->sim_state, sim_state);
+
+	data->sim_state =3D sim_state;
+
+	/* Valid service status and at minimum PS domain */
+	if (srv_status > 0 && srv_domain > 1) {
+		CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);
+		goto done;
+	}
+
+	switch (sim_state) {
+	case SIM_STATE_VALID:
+	case SIM_STATE_EMBEDDED:
+		CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);
+		goto done;
+	}
+
+	data->sysinfo_poll_count++;
+
+	if (data->sysinfo_poll_count > 15)
+		goto failure;
+
+	data->sysinfo_poll_source =3D g_timeout_add_seconds(2,
+						sysinfo_online_check, data);
+	return;
+
+failure:
+	CALLBACK_WITH_FAILURE(cb, data->online_cbd->data);
+
+done:
+	g_free(data->online_cbd);
+	data->online_cbd =3D NULL;
+}
+
+static gboolean sysinfo_online_check(gpointer user_data)
+{
+	struct huaweicdma_data *data =3D user_data;
+
+	data->sysinfo_poll_source =3D 0;
+
+	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
+					sysinfo_online_cb, data, NULL);
+
+	return FALSE;
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		ofono_modem_online_cb_t cb =3D data->online_cbd->cb;
+
+		CALLBACK_WITH_FAILURE(cb, data->online_cbd->data);
+
+		g_free(data->online_cbd);
+		data->online_cbd =3D NULL;
+		return;
+	}
+
+	data->sysinfo_poll_count =3D 0;
+
+	sysinfo_online_check(data);
+}
+
+static void set_offline_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void huaweicdma_set_online(struct ofono_modem *modem,
+				ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (online =3D=3D TRUE) {
+		data->online_cbd =3D cb_data_new(cb, user_data);
+
+		if (g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
+					set_online_cb, modem, NULL) > 0)
+			return;
+
+		g_free(data->online_cbd);
+		data->online_cbd =3D NULL;
+	} else {
+		struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+		if (g_at_chat_send(data->pcui, "AT+CFUN=3D4", none_prefix,
+					set_offline_cb, cbd, g_free) > 0)
+			return;
+
+		g_free(cbd);
+	}
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
 static void huaweicdma_pre_sim(struct ofono_modem *modem)
 {
 	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
+	sim =3D ofono_cdma_sim_create(modem, OFONO_VENDOR_HUAWEI,
+					"atmodem", data->pcui);
+
+	if (sim && data->have_sim =3D=3D TRUE)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void sim_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		__ofono_sim_recheck_pin(sim);
 }
 =

 static void huaweicdma_post_sim(struct ofono_modem *modem)
 {
+	struct ofono_atom *atom;
+	struct ofono_sim *sim;
+
 	DBG("%p", modem);
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	if (atom) {
+		sim =3D __ofono_atom_get_data(atom);
+		__ofono_sim_recheck_pin(sim);
+	} else
+		__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+						sim_watch, NULL, NULL);
 }
 =

 static void huaweicdma_post_online(struct ofono_modem *modem)
@@ -222,6 +512,7 @@ static struct ofono_modem_driver huaweicdma_driver =3D {
 	.remove		=3D huaweicdma_remove,
 	.enable		=3D huaweicdma_enable,
 	.disable	=3D huaweicdma_disable,
+	.set_online	=3D huaweicdma_set_online,
 	.pre_sim	=3D huaweicdma_pre_sim,
 	.post_sim	=3D huaweicdma_post_sim,
 	.post_online	=3D huaweicdma_post_online,
-- =

1.7.1


--===============3863149246129374729==--

