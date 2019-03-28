Content-Type: multipart/mixed; boundary="===============5899825869862368563=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 4/5] xmm7modem: handling of dual sim single active feature
Date: Thu, 28 Mar 2019 17:36:39 +0530
Message-ID: <1553774799-18614-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5899825869862368563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled DSSA use case for xmm7modem. Added driver function
to switch between available card slots for SIM.

Only one SIM will be active at a given time. On calling this
function the active SIM will be removed and the card slot made
inactive and SIM in the other card slot will be made active.

Use case is similar to a SIM swap/change where one SIM is replaced
another SIM in the same slot.
---
 drivers/atmodem/sim.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 5f66a09..5fdfe30 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -75,6 +75,7 @@ static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
 static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
 static const char *crla_prefix[] =3D { "+CRLA:", NULL };
 static const char *cgla_prefix[] =3D { "+CGLA:", NULL };
+static const char *xcmscsc_prefix[] =3D { "+XCMSCSC:", NULL};
 static const char *none_prefix[] =3D { NULL };
 =

 static void append_file_path(char *buf, const unsigned char *path,
@@ -1160,6 +1161,7 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 	DBG("");
 =

 	switch (sd->vendor) {
+	case OFONO_VENDOR_XMM:
 	case OFONO_VENDOR_IFX:
 		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
 					xpincnt_cb, cbd, g_free) > 0)
@@ -1920,6 +1922,76 @@ static void at_logical_access(struct ofono_sim *sim,=
 int session_id,
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 }
 =

+static void xcmscsc_query_cb(gboolean ok, GAtResult *result, gpointer user)
+{
+	struct ofono_sim *sim =3D user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	GAtResultIter iter;
+	int active_slot;
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XCMSCSC:"))
+		goto done;
+
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &active_slot);
+
+	/* set active SIM slot */
+	ofono_sim_set_active_card_slot(sim, active_slot+1);
+
+done:
+	/* Query supported <fac>s */
+	g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
+				at_clck_query_cb, sim, NULL);
+}
+
+static void at_xcmscsc_test_cb(gboolean ok, GAtResult *result, gpointer us=
er)
+{
+	struct ofono_sim *sim =3D user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	GAtResultIter iter;
+	int card_slot_count;
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XCMSCSC:"))
+		goto done;
+
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto done;
+
+	g_at_result_iter_skip_next(&iter);
+
+	if (!g_at_result_iter_next_number(&iter, &card_slot_count))
+		goto done;
+
+	/* Set num slots */
+	ofono_sim_set_card_slot_count(sim, card_slot_count+1);
+
+done:
+	/* enable reporting of MSIM remap status information
+	   and enable automatic acceptance of MSIM Remap
+	   acknowledgement. */
+	g_at_chat_send(sd->chat, "AT+XCMSRS=3D2", none_prefix,
+					NULL, NULL, NULL);
+
+	/* Query active card slot */
+	g_at_chat_send(sd->chat, "AT+XCMSCSC?", xcmscsc_prefix,
+				xcmscsc_query_cb, sim, NULL);
+}
+
 static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
 				void *data)
 {
@@ -1938,6 +2010,14 @@ static int at_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 		if (at_clck_cpwd_fac[i])
 			sd->passwd_type_mask |=3D (1 << i);
 =

+	/* set default values */
+	ofono_sim_set_card_slot_count(sim, 1);
+	ofono_sim_set_active_card_slot(sim, 1);
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_XMM)
+		return g_at_chat_send(sd->chat, "AT+XCMSCSC=3D?", xcmscsc_prefix,
+			at_xcmscsc_test_cb, sim, NULL) ? 0 : -1;
+
 	/* Query supported <fac>s */
 	return g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
 				at_clck_query_cb, sim, NULL) ? 0 : -1;
@@ -1957,6 +2037,38 @@ static void at_sim_remove(struct ofono_sim *sim)
 	g_free(sd);
 }
 =

+static void xcmscsc_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_set_active_card_slot_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (cb)
+		cb(&error, cbd->data);
+}
+
+static void at_set_active_card_slot(struct ofono_sim *sim, unsigned int in=
dex,
+			ofono_sim_set_active_card_slot_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[43];
+
+	/* Enable single SIM mode for indicated card slot id */
+	snprintf(cmd, sizeof(cmd), "AT+XCMSCSC=3D1,0,%u,1", index);
+
+	if (g_at_chat_send(sd->chat, cmd, none_prefix, xcmscsc_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static const struct ofono_sim_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_sim_probe,
@@ -1982,7 +2094,8 @@ static const struct ofono_sim_driver driver =3D {
 	.session_read_binary	=3D at_session_read_binary,
 	.session_read_record	=3D at_session_read_record,
 	.session_read_info	=3D at_session_read_info,
-	.logical_access		=3D at_logical_access
+	.logical_access		=3D at_logical_access,
+	.set_active_card_slot	=3D at_set_active_card_slot
 };
 =

 static const struct ofono_sim_driver driver_noef =3D {
-- =

1.9.1


--===============5899825869862368563==--

