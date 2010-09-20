Content-Type: multipart/mixed; boundary="===============8328022145530784540=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 2/2] huawei: fix online logic
Date: Mon, 20 Sep 2010 15:40:33 +0300
Message-ID: <20100920124033.12498.3545.stgit@potku.valot.fi>
In-Reply-To: <20100920123957.12498.61806.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8328022145530784540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The recently introduced online support to huawei didn't work with my
Huawei E1552. The problem was that with command AT+CFUN=3D1;+CFUN=3D5
the modem didn't initialise the sim state properly.

To fix this I changed the logic so that CFUN=3D5 is called only after the s=
im
state has switched to a valid state. Now my Huawei E1552 works with connman
again.

PIN locked SIMs still won't work. The problem is that it takes some time for
the sim state to go to a valid state:

Sep 20 15:01:57 dell-m520 ofonod[12451]: Pcui:< \r\n+CPIN: READY\r\n\r\nOK\=
r\n
[...]
Sep 20 15:02:00 dell-m520 ofonod[12451]: huawei: invalid sim state in post =
online (0)
[...]
Sep 20 15:02:01 dell-m520 ofonod[12451]: Pcui:< \r\n^SIMST:1\r\n

I don't know why it takes so long to get a valid state.

There is also another issue, in "cold start" case the phonebook
initialisation fails:

Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:> AT+CPBS=3D?\r
Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:< \r\n+CME ERROR: SIM busy\r\n

But in "warm start" it seems to work:

Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:> AT+CPBS=3D?\r
Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:< \r\n+CPBS: ("SM","EN","ON")=
\r\n\r\nOK\r\n

I consider this as a minor issue and didn't investigate it@all.
---
 plugins/huawei.c |   77 +++++++++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 2f605ee..27473a8 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -163,6 +163,22 @@ static void ussdmode_support_cb(gboolean ok, GAtResult=
 *result,
 					ussdmode_query_cb, data, NULL);
 }
 =

+static void cfun_offline(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	if (data->sim =3D=3D NULL)
+		return;
+
+	ofono_sim_inserted_notify(data->sim, TRUE);
+}
+
 static gboolean notify_sim_state(struct ofono_modem *modem,
 				enum huawei_sim_state sim_state)
 {
@@ -170,17 +186,33 @@ static gboolean notify_sim_state(struct ofono_modem *=
modem,
 =

 	DBG("%d", sim_state);
 =

-	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT) {
-		ofono_sim_inserted_notify(data->sim, FALSE);
+	data->sim_state =3D sim_state;
 =

+	switch (sim_state) {
+	case HUAWEI_SIM_STATE_NOT_EXISTENT:
 		/* SIM is not ready, try again a bit later */
 		return TRUE;
+	case HUAWEI_SIM_STATE_INVALID_OR_LOCKED:
+		ofono_modem_set_powered(modem, TRUE);
+
+		return FALSE;
+	case HUAWEI_SIM_STATE_VALID:
+	case HUAWEI_SIM_STATE_INVALID_CS:
+	case HUAWEI_SIM_STATE_INVALID_PS:
+	case HUAWEI_SIM_STATE_INVALID_PS_AND_CS:
+		/*
+		 * In the "warm start" case the modem skips
+		 * HUAWEI_SIM_STATE_INVALID_OR_LOCKED altogether, so need
+		 * to set power also here
+		 */
+		ofono_modem_set_powered(modem, TRUE);
+
+		g_at_chat_send(data->pcui, "AT+CFUN=3D5", none_prefix,
+				cfun_offline, modem, NULL);
+
+		return FALSE;
 	}
 =

-	ofono_sim_inserted_notify(data->sim, TRUE);
-
-	data->sim_state =3D sim_state;
-
 	return FALSE;
 }
 =

@@ -347,24 +379,24 @@ static void cvoice_query_cb(gboolean ok, GAtResult *r=
esult,
 	gint mode, rate, bits, period;
 =

 	if (!ok)
-		goto done;
+		return;
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "^CVOICE:"))
-		goto done;
+		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &mode))
-		goto done;
+		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &rate))
-		goto done;
+		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &bits))
-		goto done;
+		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &period))
-		goto done;
+		return;
 =

 	data->voice =3D TRUE;
 =

@@ -383,9 +415,6 @@ static void cvoice_query_cb(gboolean ok, GAtResult *res=
ult,
 	/* check available voice ports */
 	g_at_chat_send(data->pcui, "AT^DDSETEX=3D?", none_prefix,
 						NULL, NULL, NULL);
-
-done:
-	ofono_modem_set_powered(modem, TRUE);
 }
 =

 static void cvoice_support_cb(gboolean ok, GAtResult *result,
@@ -396,21 +425,16 @@ static void cvoice_support_cb(gboolean ok, GAtResult =
*result,
 	GAtResultIter iter;
 =

 	if (!ok)
-		goto done;
+		return;
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "^CVOICE:"))
-		goto done;
+		return;
 =

 	/* query current voice setting */
 	g_at_chat_send(data->pcui, "AT^CVOICE?", cvoice_prefix,
 					cvoice_query_cb, modem, NULL);
-
-	return;
-
-done:
-	ofono_modem_set_powered(modem, TRUE);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
@@ -550,7 +574,7 @@ static int huawei_enable(struct ofono_modem *modem)
 =

 	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->pcui, "AT+CFUN=3D1;+CFUN=3D5", none_prefix,
+	g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	query_sim_state(modem);
@@ -667,8 +691,13 @@ static void huawei_post_online(struct ofono_modem *mod=
em)
 	struct ofono_netreg *netreg;
 	struct ofono_message_waiting *mw;
 =

-	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS)
+	if (data->sim_state !=3D HUAWEI_SIM_STATE_VALID &&
+	    data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_CS &&
+	    data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_PS) {
+		ofono_info("huawei: invalid sim state in post online (%d)",
+				data->sim_state);
 		return;
+	}
 =

 	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 								data->pcui);


--===============8328022145530784540==--

