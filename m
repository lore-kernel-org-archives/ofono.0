Content-Type: multipart/mixed; boundary="===============1498292458227938422=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 02/11] atmodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:35 -0800
Message-ID: <1296308084-3726-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1498292458227938422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/call-barring.c         |    6 ++--
 drivers/atmodem/call-forwarding.c      |    8 -----
 drivers/atmodem/call-meter.c           |   28 -------------------
 drivers/atmodem/call-settings.c        |   36 -------------------------
 drivers/atmodem/call-volume.c          |    8 -----
 drivers/atmodem/cbs.c                  |    8 -----
 drivers/atmodem/devinfo.c              |   16 -----------
 drivers/atmodem/gprs.c                 |    8 -----
 drivers/atmodem/network-registration.c |   24 ----------------
 drivers/atmodem/phonebook.c            |    4 ---
 drivers/atmodem/sim-auth.c             |    2 +-
 drivers/atmodem/sim.c                  |   46 ++--------------------------=
---
 drivers/atmodem/sms.c                  |   20 --------------
 drivers/atmodem/stk.c                  |    4 +-
 drivers/atmodem/ussd.c                 |    7 -----
 drivers/atmodem/voicecall.c            |    7 -----
 16 files changed, 9 insertions(+), 223 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index 516b470..73820d2 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -86,7 +86,7 @@ static void at_call_barring_query(struct ofono_call_barri=
ng *cb,
 	struct cb_data *cbd =3D cb_data_new(callback, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL || strlen(lock) !=3D 2)
+	if (strlen(lock) !=3D 2)
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2", lock);
@@ -121,7 +121,7 @@ static void at_call_barring_set(struct ofono_call_barri=
ng *cb, const char *lock,
 	char buf[64];
 	int len;
 =

-	if (cbd =3D=3D NULL || strlen(lock) !=3D 2 || (cls && passwd =3D=3D NULL))
+	if (strlen(lock) !=3D 2 || (cls && passwd =3D=3D NULL))
 		goto error;
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i", lock, enable);
@@ -164,7 +164,7 @@ static void at_call_barring_set_passwd(struct ofono_cal=
l_barring *cb,
 	struct cb_data *cbd =3D cb_data_new(callback, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL || strlen(lock) !=3D 2)
+	if (strlen(lock) !=3D 2)
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index f11a68e..a5cbd59 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -128,9 +128,6 @@ static void at_ccfc_query(struct ofono_call_forwarding =
*cf, int type, int cls,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D GINT_TO_POINTER(cls);
 =

 	if (cls =3D=3D 7)
@@ -142,7 +139,6 @@ static void at_ccfc_query(struct ofono_call_forwarding =
*cf, int type, int cls,
 				ccfc_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
@@ -165,14 +161,10 @@ static void at_ccfc_set(struct ofono_call_forwarding =
*cf, const char *buf,
 	GAtChat *chat =3D ofono_call_forwarding_get_data(cf);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, buf, none_prefix,
 				ccfc_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 3ab4706..2b91848 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -116,15 +116,11 @@ static void at_caoc_query(struct ofono_call_meter *cm,
 	GAtChat *chat =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CAOC:";
 	if (g_at_chat_send(chat, "AT+CAOC=3D0", caoc_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -137,15 +133,11 @@ static void at_cacm_query(struct ofono_call_meter *cm,
 	GAtChat *chat =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CACM:";
 	if (g_at_chat_send(chat, "AT+CACM?", cacm_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -169,16 +161,12 @@ static void at_cacm_set(struct ofono_call_meter *cm, =
const char *passwd,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CACM=3D\"%s\"", passwd);
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -191,15 +179,11 @@ static void at_camm_query(struct ofono_call_meter *cm,
 	GAtChat *chat =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CAMM:";
 	if (g_at_chat_send(chat, "AT+CAMM?", camm_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -213,16 +197,12 @@ static void at_camm_set(struct ofono_call_meter *cm,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CAMM=3D\"%06X\",\"%s\"", accmax, passwd);
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -274,15 +254,11 @@ static void at_cpuc_query(struct ofono_call_meter *cm,
 	GAtChat *chat =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CPUC:";
 	if (g_at_chat_send(chat, "AT+CPUC?", cpuc_prefix,
 				cpuc_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, 0, 0, data);
@@ -296,9 +272,6 @@ static void at_cpuc_set(struct ofono_call_meter *cm, co=
nst char *currency,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CPUC=3D\"%s\",\"%f\",\"%s\"",
 			currency, ppu, passwd);
 =

@@ -306,7 +279,6 @@ static void at_cpuc_set(struct ofono_call_meter *cm, co=
nst char *currency,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 5cea233..7e4d92a 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -86,9 +86,6 @@ static void at_ccwa_query(struct ofono_call_settings *cs,=
 int cls,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D GINT_TO_POINTER(cls);
 =

 	if (cls =3D=3D 7)
@@ -100,7 +97,6 @@ static void at_ccwa_query(struct ofono_call_settings *cs=
, int cls,
 				ccwa_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, 0, data);
@@ -124,16 +120,12 @@ static void at_ccwa_set(struct ofono_call_settings *c=
s, int mode, int cls,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CCWA=3D1,%d,%d", mode, cls);
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				ccwa_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -187,14 +179,10 @@ static void at_clip_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+CLIP?", clip_prefix,
 				clip_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -211,14 +199,10 @@ static void at_cdip_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+CDIP?", cdip_prefix,
 				cdip_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -235,14 +219,10 @@ static void at_cnap_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+CNAP?", cnap_prefix,
 				cnap_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -259,14 +239,10 @@ static void at_colp_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+COLP?", colp_prefix,
 				colp_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -308,14 +284,10 @@ static void at_clir_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+CLIR?", clir_prefix,
 				clir_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
@@ -339,16 +311,12 @@ static void at_clir_set(struct ofono_call_settings *c=
s, int mode,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CLIR=3D%d", mode);
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				clir_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -392,14 +360,10 @@ static void at_colr_query(struct ofono_call_settings =
*cs,
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+COLR", colr_prefix,
 				colr_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index d3910d4..6d87276 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -138,9 +138,6 @@ static void at_call_volume_speaker_volume(struct ofono_=
call_volume *cv,
 	char buf[64];
 	int level;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	level =3D ((cvd->clvl_max - cvd->clvl_min) *
 			percent) / 100 + cvd->clvl_min;
 =

@@ -150,7 +147,6 @@ static void at_call_volume_speaker_volume(struct ofono_=
call_volume *cv,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -163,16 +159,12 @@ static void at_call_volume_mute(struct ofono_call_vol=
ume *cv, int muted,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CMUT=3D%d", muted);
 =

 	if (g_at_chat_send(cvd->chat, buf, none_prefix,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 9b5ae6c..8cc3ef0 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -115,9 +115,6 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	/* For the Qualcomm based devices it is required to clear
 	 * the list of topics first.  Otherwise setting the new
 	 * topic ranges will fail.
@@ -145,7 +142,6 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 	if (id > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
@@ -160,9 +156,6 @@ static void at_cbs_clear_topics(struct ofono_cbs *cbs,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (data->cscb_mode_1)
 		snprintf(buf, sizeof(buf), "AT+CSCB=3D1,\"0-65535\"");
 	else
@@ -172,7 +165,6 @@ static void at_cbs_clear_topics(struct ofono_cbs *cbs,
 				at_cscb_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
diff --git a/drivers/atmodem/devinfo.c b/drivers/atmodem/devinfo.c
index 8d0830b..4c802f1 100644
--- a/drivers/atmodem/devinfo.c
+++ b/drivers/atmodem/devinfo.c
@@ -64,15 +64,11 @@ static void at_query_manufacturer(struct ofono_devinfo =
*info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CGMI:";
 =

 	if (g_at_chat_send(chat, "AT+CGMI", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -84,15 +80,11 @@ static void at_query_model(struct ofono_devinfo *info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CGMM:";
 =

 	if (g_at_chat_send(chat, "AT+CGMM", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -104,15 +96,11 @@ static void at_query_revision(struct ofono_devinfo *in=
fo,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CGMR:";
 =

 	if (g_at_chat_send(chat, "AT+CGMR", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -124,15 +112,11 @@ static void at_query_serial(struct ofono_devinfo *inf=
o,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "+CGSN:";
 =

 	if (g_at_chat_send(chat, "AT+CGSN", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 0127a3a..6e01994 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -69,16 +69,12 @@ static void at_gprs_set_attached(struct ofono_gprs *gpr=
s, int attached,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
 =

 	if (g_at_chat_send(gd->chat, buf, none_prefix,
 				at_cgatt_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -115,9 +111,6 @@ static void at_gprs_registration_status(struct ofono_gp=
rs *gprs,
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D gd;
 =

 	switch (gd->vendor) {
@@ -143,7 +136,6 @@ static void at_gprs_registration_status(struct ofono_gp=
rs *gprs,
 				at_cgreg_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 7b04f19..4913611 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -186,9 +186,6 @@ static void at_registration_status(struct ofono_netreg =
*netreg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D nd;
 =

 	switch (nd->vendor) {
@@ -232,7 +229,6 @@ static void at_registration_status(struct ofono_netreg =
*netreg,
 				at_creg_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, data);
@@ -361,9 +357,6 @@ static void at_current_operator(struct ofono_netreg *ne=
treg,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	gboolean ok;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D netreg;
 =

 	/* Nokia modems have a broken return value for the string
@@ -388,7 +381,6 @@ static void at_current_operator(struct ofono_netreg *ne=
treg,
 	if (ok)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -503,14 +495,10 @@ static void at_list_operators(struct ofono_netreg *ne=
treg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(nd->chat, "AT+COPS=3D?", cops_prefix,
 				cops_list_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
@@ -533,14 +521,10 @@ static void at_register_auto(struct ofono_netreg *net=
reg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(nd->chat, "AT+COPS=3D0", none_prefix,
 				register_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -554,16 +538,12 @@ static void at_register_manual(struct ofono_netreg *n=
etreg,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+COPS=3D1,2,\"%s%s\"", mcc, mnc);
 =

 	if (g_at_chat_send(nd->chat, buf, none_prefix,
 				register_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -858,9 +838,6 @@ static void at_signal_strength(struct ofono_netreg *net=
reg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D nd;
 =

 	/*
@@ -877,7 +854,6 @@ static void at_signal_strength(struct ofono_netreg *net=
reg,
 			return;
 	}
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 64aa05e..97213db 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -368,9 +368,6 @@ static void at_export_entries(struct ofono_phonebook *p=
b, const char *storage,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[32];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D pb;
 =

 	snprintf(buf, sizeof(buf), "AT+CPBS=3D\"%s\"", storage);
@@ -378,7 +375,6 @@ static void at_export_entries(struct ofono_phonebook *p=
b, const char *storage,
 				at_select_storage_cb, cbd, NULL) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
index 3b636bd..9ce810f 100644
--- a/drivers/atmodem/sim-auth.c
+++ b/drivers/atmodem/sim-auth.c
@@ -101,7 +101,7 @@ static void at_discover_apps(struct ofono_sim_auth *sa,
 	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd && g_at_chat_send(sad->chat, "AT+CUAD", cuad_prefix,
+	if (g_at_chat_send(sad->chat, "AT+CUAD", cuad_prefix,
 					at_discover_apps_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 548a95c..819864f 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -142,8 +142,6 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	}
 =

 	cbd =3D cb_data_new(cb, data);
-	if (cbd =3D=3D NULL)
-		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CRSM=3D192,%i", fileid);
 =

@@ -159,7 +157,6 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 				at_crsm_info_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
 				EF_STATUS_INVALIDATED, data);
 }
@@ -220,9 +217,6 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,%i,%i,%i", fileid,
 			start >> 8, start & 0xff, length);
 =

@@ -230,7 +224,6 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
@@ -244,9 +237,6 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
 			record, length);
 =

@@ -254,7 +244,6 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
@@ -309,7 +298,7 @@ static void at_sim_update_binary(struct ofono_sim *sim,=
 int fileid,
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
@@ -342,7 +331,7 @@ static void at_sim_update_record(struct ofono_sim *sim,=
 int fileid,
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
@@ -374,7 +363,7 @@ static void at_sim_update_cyclic(struct ofono_sim *sim,=
 int fileid,
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
@@ -430,14 +419,10 @@ static void at_read_imsi(struct ofono_sim *sim, ofono=
_sim_imsi_cb_t cb,
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(sd->chat, "AT+CIMI", NULL,
 				at_cimi_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -576,9 +561,6 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	switch (sd->vendor) {
 	case OFONO_VENDOR_IFX:
 		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
@@ -596,7 +578,6 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 		break;
 	}
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -663,16 +644,12 @@ static void at_pin_query(struct ofono_sim *sim, ofono=
_sim_passwd_cb_t cb,
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D sim;
 =

 	if (g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix,
 				at_cpin_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -772,9 +749,6 @@ static void at_pin_send(struct ofono_sim *sim, const ch=
ar *passwd,
 	char buf[64];
 	int ret;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D sd;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
@@ -787,7 +761,6 @@ static void at_pin_send(struct ofono_sim *sim, const ch=
ar *passwd,
 	if (ret > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -802,9 +775,6 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 	char buf[64];
 	int ret;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D sd;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
@@ -817,7 +787,6 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 	if (ret > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -857,9 +826,6 @@ static void at_pin_enable(struct ofono_sim *sim,
 	int ret;
 	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
 		goto error;
 =

@@ -891,9 +857,6 @@ static void at_change_passwd(struct ofono_sim *sim,
 	int ret;
 	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (passwd_type >=3D len ||
 			at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
 		goto error;
@@ -954,9 +917,6 @@ static void at_pin_query_enabled(struct ofono_sim *sim,
 	char buf[64];
 	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
 		goto error;
 =

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 83006eb..9385fbb 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -106,16 +106,12 @@ static void at_csca_set(struct ofono_sms *sms,
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
 =

 	if (g_at_chat_send(data->chat, buf, csca_prefix,
 				at_csca_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
@@ -173,14 +169,10 @@ static void at_csca_query(struct ofono_sms *sms, ofon=
o_sms_sca_query_cb_t cb,
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(data->chat, "AT+CSCA?", csca_prefix,
 				at_csca_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, user_data);
@@ -227,9 +219,6 @@ static void at_cmgs(struct ofono_sms *sms, unsigned cha=
r *pdu, int pdu_len,
 	char buf[512];
 	int len;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (mms) {
 		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
 		g_at_chat_send(data->chat, buf, none_prefix,
@@ -243,7 +232,6 @@ static void at_cmgs(struct ofono_sms *sms, unsigned cha=
r *pdu, int pdu_len,
 				at_cmgs_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, user_data);
@@ -267,16 +255,12 @@ static void at_cgsms_set(struct ofono_sms *sms, int b=
earer,
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+CGSMS=3D%d", bearer);
 =

 	if (g_at_chat_send(data->chat, buf, none_prefix,
 				at_cgsms_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
@@ -319,14 +303,10 @@ static void at_cgsms_query(struct ofono_sms *sms,
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(data->chat, "AT+CGSMS?", cgsms_prefix,
 				at_cgsms_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, user_data);
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 4de3042..a3b7526 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -153,7 +153,7 @@ static void at_stk_envelope(struct ofono_stk *stk, int =
length,
 	char *buf =3D g_try_new(char, 64 + length * 2);
 	int len, ret;
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
@@ -236,7 +236,7 @@ static void at_stk_terminal_response(struct ofono_stk *=
stk, int length,
 	char *buf =3D g_try_new(char, 64 + length * 2);
 	int len, ret;
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 8b42926..f8cde2d 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -187,9 +187,6 @@ static void at_ussd_request(struct ofono_ussd *ussd, in=
t dcs,
 	char buf[512];
 	enum sms_charset charset;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D ussd;
 =

 	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
@@ -273,16 +270,12 @@ static void at_ussd_cancel(struct ofono_ussd *ussd,
 	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D data;
 =

 	if (g_at_chat_send(data->chat, "AT+CUSD=3D2", none_prefix,
 				cusd_cancel_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 10cac42..a64269d 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -374,9 +374,6 @@ static void at_dial(struct ofono_voicecall *vc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[256];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vc;
 =

 	if (ph->type =3D=3D 145)
@@ -401,7 +398,6 @@ static void at_dial(struct ofono_voicecall *vc,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -598,9 +594,6 @@ static void at_send_dtmf(struct ofono_voicecall *vc, co=
nst char *dtmf,
 	int i;
 	char *buf;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vd;
 =

 	/* strlen("+VTS=3DT;") =3D 7 + initial AT + null */
-- =

1.7.0.4


--===============1498292458227938422==--

