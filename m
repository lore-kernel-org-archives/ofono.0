Content-Type: multipart/mixed; boundary="===============4347991267961594016=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] ste: preparation for hotswap
Date: Mon, 14 Feb 2011 10:40:53 +0200
Message-ID: <1297672853-10527-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4347991267961594016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---


Hi ,

This is a second attempt to enable hotswap support in oFono with ste modem. =


On Mon, 2011-01-31 at 11:52 +0200, Marcel Holtmann wrote: =

Hi Jussi,
> =

> > > I am a bit lost in how you fit this into the existing SIM pin check.
> > > Maybe it would be cleaner to remove that check first. And then add a
> > > patch for the SIM notification handling.
> > =

> > I don't understand this comment. Patch in original mail shows how it
> > fits to simpin_check. ( Line 91 ). =

> =

> is the simpin_check still needed after your patch?
> =

I seem to have totally missed this response. Sorry for the delay. =


Content of the method is different than it used to be. Old solution checked=
 the return value of CPIN query when new one handles the result of ESIMSR s=
etting. In other words it's not needed as it used to be. It was replaced wi=
th new method with same name. =


In this proposal I changed the name. Hopefully that clarifies the  case. =



> > > Also this seems pretty much similar to what IFX does. Can we make sure
> > > that it is handled similar as well?
> > =

> > I can't. I don't have such modem. =

> =

> You have the source code in plugins/ifx.c to look at how we did it
> there.
> =

> =

I'm little bit reluctant to say something to be "sure" without running the =
code. But it seems your "xsim_notify" has different opinions about when sim=
 is present than my "handle_sim_status". =


I changed the method to do more like ifx does

Br,
Jussi

 plugins/ste.c |  117 +++++++++++++++++++++++++++++++++++++++++------------=
---
 1 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index cf8aed8..efaa75f 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -67,15 +67,23 @@
 =

 #define NUM_CHAT	1
 =

-static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
-
 static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
 =

 struct ste_data {
 	GAtChat *chat;
-	guint cpin_poll_source;
-	guint cpin_poll_count;
 	gboolean have_sim;
+	struct ofono_sim *sim;
+};
+
+enum ste_sim_state {
+	SIM_STATE_NULL =3D 0,
+	SIM_STATE_AWAITING_APP,
+	SIM_STATE_BLOCKED,
+	SIM_STATE_BLOCKED_FOREVER,
+	SIM_STATE_WAIT_FOR_PIN,
+	SIM_STATE_ACTIVE,
+	SIM_STATE_TERMINATING,
+	SIM_STATE_POWER_OFF
 };
 =

 static int ste_probe(struct ofono_modem *modem)
@@ -103,9 +111,6 @@ static void ste_remove(struct ofono_modem *modem)
 =

 	g_at_chat_unref(data->chat);
 =

-	if (data->cpin_poll_source > 0)
-		g_source_remove(data->cpin_poll_source);
-
 	g_free(data);
 }
 =

@@ -116,39 +121,70 @@ static void ste_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static gboolean init_simpin_check(gpointer user_data);
+static void handle_sim_status(int status, struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	DBG("SIM status:%d\n", status);
+
+	switch (status) {
+	case SIM_STATE_WAIT_FOR_PIN:
+	case SIM_STATE_ACTIVE:
+	case SIM_STATE_NULL:
+	case SIM_STATE_AWAITING_APP:
+	case SIM_STATE_BLOCKED:
+	case SIM_STATE_BLOCKED_FOREVER:
+	case SIM_STATE_TERMINATING:
+		if (data->have_sim =3D=3D FALSE) {
+			if (data->sim)
+				ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+		break;
+	case SIM_STATE_POWER_OFF:
+		if (data->have_sim =3D=3D TRUE) {
+			if (data->sim)
+				ofono_sim_inserted_notify(data->sim, FALSE);
+			data->have_sim =3D FALSE;
+		}
+		break;
+	}
+}
 =

-static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void handle_sim_state(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int simnr, status;
+	GAtResultIter iter;
 =

-	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
-	if (!ok && result->final_or_pdu &&
-			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
-			data->cpin_poll_count++ < 5) {
-		data->cpin_poll_source =3D
-			g_timeout_add_seconds(1, init_simpin_check, modem);
-		return;
-	}
+	DBG("ok:%d", ok);
 =

-	data->cpin_poll_count =3D 0;
+	if (!ok)
+		return;
 =

-	/* Modem returns ERROR if there is no SIM in slot. */
-	data->have_sim =3D ok;
+	g_at_result_iter_init(&iter, result);
 =

 	ofono_modem_set_powered(modem, TRUE);
+
+	if (!g_at_result_iter_next(&iter, "*ESIMSR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &simnr))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	handle_sim_status(status, modem);
 }
 =

-static gboolean init_simpin_check(gpointer user_data)
+static gboolean init_sim_reporting(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ste_data *data =3D ofono_modem_get_data(modem);
 =

-	data->cpin_poll_source =3D 0;
-
-	g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
-			simpin_check, modem, NULL);
+	g_at_chat_send(data->chat, "AT*ESIMSR=3D1;*ESIMSR?", NULL,
+			handle_sim_state,
+			modem, NULL);
 =

 	return FALSE;
 }
@@ -164,7 +200,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	init_simpin_check(modem);
+	init_sim_reporting(modem);
 }
 =

 static GIOChannel *ste_create_channel(struct ofono_modem *modem)
@@ -235,6 +271,23 @@ static GIOChannel *ste_create_channel(struct ofono_mod=
em *modem)
 	return channel;
 }
 =

+static void esimsr_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+	DBG("");
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "*ESIMSR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	handle_sim_status(status, modem);
+}
+
 static int ste_enable(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
@@ -266,6 +319,9 @@ static int ste_enable(struct ofono_modem *modem)
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NULL);
 =

+	g_at_chat_register(data->chat, "*ESIMSR:", esimsr_notify,
+			FALSE, modem, NULL);
+
 	return -EINPROGRESS;
 }
 =

@@ -332,16 +388,13 @@ static void ste_set_online(struct ofono_modem *modem,=
 ofono_bool_t online,
 static void ste_pre_sim(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem",
+			data->chat);
 	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
-
-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
-- =

1.7.1


--===============4347991267961594016==--

