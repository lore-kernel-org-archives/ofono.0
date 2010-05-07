Content-Type: multipart/mixed; boundary="===============0132518431753199621=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH v2 2/6] gatchat: Add g_at_chat_send_full.
Date: Fri, 07 May 2010 02:27:11 +0200
Message-ID: <1273192031-11189-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0132518431753199621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

g_at_chat_send_full takes two additional parameters compared to
g_at_chat_send.  The destroy notification is removed from
g_at_chat_send and users updated.
---
 drivers/atmodem/call-barring.c          |    6 +-
 drivers/atmodem/call-forwarding.c       |    4 +-
 drivers/atmodem/call-meter.c            |   19 ++++----
 drivers/atmodem/call-settings.c         |   12 +++---
 drivers/atmodem/call-volume.c           |   13 ++----
 drivers/atmodem/cbs.c                   |    8 ++--
 drivers/atmodem/devinfo.c               |    8 ++--
 drivers/atmodem/gprs-context.c          |    6 +-
 drivers/atmodem/gprs.c                  |   16 ++++----
 drivers/atmodem/network-registration.c  |   70 +++++++++++++--------------=
---
 drivers/atmodem/phonebook.c             |   16 ++++----
 drivers/atmodem/sim-poll.c              |    5 +-
 drivers/atmodem/sim.c                   |   26 ++++++------
 drivers/atmodem/sms.c                   |   52 ++++++++++-------------
 drivers/atmodem/ssn.c                   |    2 +-
 drivers/atmodem/stk.c                   |    9 ++--
 drivers/atmodem/ussd.c                  |    6 +-
 drivers/atmodem/voicecall.c             |   35 +++++++---------
 drivers/calypsomodem/voicecall.c        |    7 +--
 drivers/hfpmodem/call-volume.c          |    4 +-
 drivers/hfpmodem/network-registration.c |   13 +++---
 drivers/hfpmodem/voicecall.c            |   27 ++++++------
 drivers/hsomodem/gprs-context.c         |   11 ++---
 drivers/mbmmodem/gprs-context.c         |   20 ++++----
 drivers/stemodem/gprs-context.c         |   10 ++--
 drivers/stemodem/voicecall.c            |   10 ++--
 gatchat/gatchat.c                       |   45 ++++++++++++++------
 gatchat/gatchat.h                       |   23 +++++++++-
 gatchat/gatmux.c                        |    4 +-
 gatchat/gsmdial.c                       |   31 ++++++--------
 plugins/calypso.c                       |   17 +++----
 plugins/em770.c                         |    8 +--
 plugins/g1.c                            |    6 +-
 plugins/hfp.c                           |   14 +++----
 plugins/hso.c                           |    8 ++--
 plugins/huawei.c                        |    8 +--
 plugins/mbm.c                           |   12 +++---
 plugins/novatel.c                       |    6 +--
 plugins/palmpre.c                       |    8 +--
 plugins/phonesim.c                      |   10 ++---
 plugins/ste.c                           |    7 +--
 unit/test-caif.c                        |    2 +-
 unit/test-mux.c                         |   18 ++++----
 43 files changed, 313 insertions(+), 329 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index b1d2900..7312d91 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -91,7 +91,7 @@ static void at_call_barring_query(struct ofono_call_barri=
ng *cb,
 =

 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2", lock);
 =

-	if (g_at_chat_send(chat, buf, clck_prefix,
+	if (g_at_chat_send_full(chat, buf, clck_prefix, NULL,
 				clck_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -134,7 +134,7 @@ static void at_call_barring_set(struct ofono_call_barri=
ng *cb, const char *lock,
 			snprintf(buf + len, sizeof(buf) - len, ",%i", cls);
 	}
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				clck_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -172,7 +172,7 @@ static void at_call_barring_set_passwd(struct ofono_cal=
l_barring *cb,
 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
 			lock, old_passwd, new_passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				cpwd_set_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index 72a0188..defa300 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -138,7 +138,7 @@ static void at_ccfc_query(struct ofono_call_forwarding =
*cf, int type, int cls,
 	else
 		snprintf(buf, sizeof(buf), "AT+CCFC=3D%d,2,,,%d", type, cls);
 =

-	if (g_at_chat_send(chat, buf, ccfc_prefix,
+	if (g_at_chat_send_full(chat, buf, ccfc_prefix, NULL,
 				ccfc_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -169,7 +169,7 @@ static void at_ccfc_set(struct ofono_call_forwarding *c=
f, const char *buf,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				ccfc_set_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 0553d78..3a6b128 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -114,7 +114,7 @@ static void at_caoc_query(struct ofono_call_meter *cm,
 		goto error;
 =

 	cbd->user =3D "+CAOC:";
-	if (g_at_chat_send(chat, "AT+CAOC=3D0", caoc_prefix,
+	if (g_at_chat_send_full(chat, "AT+CAOC=3D0", caoc_prefix, NULL,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -136,7 +136,7 @@ static void at_cacm_query(struct ofono_call_meter *cm,
 		goto error;
 =

 	cbd->user =3D "+CACM:";
-	if (g_at_chat_send(chat, "AT+CACM?", cacm_prefix,
+	if (g_at_chat_send_full(chat, "AT+CACM?", cacm_prefix, NULL,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -170,7 +170,7 @@ static void at_cacm_set(struct ofono_call_meter *cm, co=
nst char *passwd,
 =

 	snprintf(buf, sizeof(buf), "AT+CACM=3D\"%s\"", passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -192,7 +192,7 @@ static void at_camm_query(struct ofono_call_meter *cm,
 		goto error;
 =

 	cbd->user =3D "+CAMM:";
-	if (g_at_chat_send(chat, "AT+CAMM?", camm_prefix,
+	if (g_at_chat_send_full(chat, "AT+CAMM?", camm_prefix, NULL,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -216,7 +216,7 @@ static void at_camm_set(struct ofono_call_meter *cm,
 =

 	snprintf(buf, sizeof(buf), "AT+CAMM=3D\"%06X\",\"%s\"", accmax, passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -271,7 +271,7 @@ static void at_cpuc_query(struct ofono_call_meter *cm,
 		goto error;
 =

 	cbd->user =3D "+CPUC:";
-	if (g_at_chat_send(chat, "AT+CPUC?", cpuc_prefix,
+	if (g_at_chat_send_full(chat, "AT+CPUC?", cpuc_prefix, NULL,
 				cpuc_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -296,7 +296,7 @@ static void at_cpuc_set(struct ofono_call_meter *cm, co=
nst char *currency,
 	snprintf(buf, sizeof(buf), "AT+CPUC=3D\"%s\",\"%f\",\"%s\"",
 			currency, ppu, passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -338,9 +338,8 @@ static int at_caoc_probe(struct ofono_call_meter *cm, u=
nsigned int vendor,
 =

 	ofono_call_meter_set_data(cm, chat);
 =

-	g_at_chat_send(chat, "AT+CAOC=3D2", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CCWE=3D1", NULL,
-			at_call_meter_initialized, cm, NULL);
+	g_at_chat_send(chat, "AT+CAOC=3D2", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CCWE=3D1", NULL, at_call_meter_initialized, cm);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 2a3ec42..c54b068 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -93,7 +93,7 @@ static void at_ccwa_query(struct ofono_call_settings *cs,=
 int cls,
 	else
 		snprintf(buf, sizeof(buf), "AT+CCWA=3D1,2,%d", cls);
 =

-	if (g_at_chat_send(chat, buf, ccwa_prefix,
+	if (g_at_chat_send_full(chat, buf, ccwa_prefix, NULL,
 				ccwa_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -127,7 +127,7 @@ static void at_ccwa_set(struct ofono_call_settings *cs,=
 int mode, int cls,
 =

 	snprintf(buf, sizeof(buf), "AT+CCWA=3D1,%d,%d", mode, cls);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				ccwa_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -179,7 +179,7 @@ static void at_clip_query(struct ofono_call_settings *c=
s,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CLIP?", clip_prefix,
+	if (g_at_chat_send_full(chat, "AT+CLIP?", clip_prefix, NULL,
 				clip_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -230,7 +230,7 @@ static void at_colp_query(struct ofono_call_settings *c=
s,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+COLP?", colp_prefix,
+	if (g_at_chat_send_full(chat, "AT+COLP?", colp_prefix, NULL,
 				colp_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -280,7 +280,7 @@ static void at_clir_query(struct ofono_call_settings *c=
s,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CLIR?", clir_prefix,
+	if (g_at_chat_send_full(chat, "AT+CLIR?", clir_prefix, NULL,
 				clir_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -314,7 +314,7 @@ static void at_clir_set(struct ofono_call_settings *cs,=
 int mode,
 =

 	snprintf(buf, sizeof(buf), "AT+CLIR=3D%d", mode);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send_full(chat, buf, none_prefix, NULL,
 				clir_set_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index d44789b..fb317ff 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -146,7 +146,7 @@ static void at_call_volume_speaker_volume(struct ofono_=
call_volume *cv,
 =

 	snprintf(buf, sizeof(buf), "AT+CLVL=3D%d", level);
 =

-	if (g_at_chat_send(cvd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(cvd->chat, buf, none_prefix, NULL,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -169,7 +169,7 @@ static void at_call_volume_mute(struct ofono_call_volum=
e *cv, int muted,
 =

 	snprintf(buf, sizeof(buf), "AT+CMUT=3D%d", muted);
 =

-	if (g_at_chat_send(cvd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(cvd->chat, buf, none_prefix, NULL,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -193,12 +193,9 @@ static int at_call_volume_probe(struct ofono_call_volu=
me *cv,
 =

 	ofono_call_volume_set_data(cv, cvd);
 =

-	g_at_chat_send(chat, "AT+CMUT?", cmut_prefix,
-			cmut_query, cv, NULL);
-	g_at_chat_send(chat, "AT+CLVL=3D?", clvl_prefix,
-			clvl_range_query, cv, NULL);
-	g_at_chat_send(chat, "AT+CLVL?", clvl_prefix,
-			clvl_query, cv, NULL);
+	g_at_chat_send(chat, "AT+CMUT?", cmut_prefix, cmut_query, cv);
+	g_at_chat_send(chat, "AT+CLVL=3D?", clvl_prefix, clvl_range_query, cv);
+	g_at_chat_send(chat, "AT+CLVL?", clvl_prefix, clvl_query, cv);
 =

 	/* Generic driver does not support microphone level */
 	ofono_call_volume_set_microphone_volume(cv, 100);
diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index eb46d30..663ca42 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -115,7 +115,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 =

 	buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
 =

-	id =3D g_at_chat_send(data->chat, buf, none_prefix,
+	id =3D g_at_chat_send_full(data->chat, buf, none_prefix, NULL,
 				at_cscb_set_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -145,7 +145,7 @@ static void at_cbs_clear_topics(struct ofono_cbs *cbs,
 	else
 		snprintf(buf, sizeof(buf), "AT+CSCB=3D0,\"\"");
 =

-	if (g_at_chat_send(data->chat, buf, none_prefix,
+	if (g_at_chat_send_full(data->chat, buf, none_prefix, NULL,
 				at_cscb_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -209,7 +209,7 @@ static void at_cscb_support_cb(gboolean ok, GAtResult *=
result, gpointer user)
 		snprintf(buf, sizeof(buf), "AT+CSCB=3D0,\"\"");
 =

 	if (g_at_chat_send(data->chat, buf, none_prefix,
-				at_cbs_register, cbs, NULL) > 0)
+				at_cbs_register, cbs) > 0)
 		return;
 =

 error:
@@ -229,7 +229,7 @@ static int at_cbs_probe(struct ofono_cbs *cbs, unsigned=
 int vendor,
 	ofono_cbs_set_data(cbs, data);
 =

 	g_at_chat_send(chat, "AT+CSCB=3D?", cscb_prefix,
-			at_cscb_support_cb, cbs, NULL);
+			at_cscb_support_cb, cbs);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/devinfo.c b/drivers/atmodem/devinfo.c
index e4b070b..df06bff 100644
--- a/drivers/atmodem/devinfo.c
+++ b/drivers/atmodem/devinfo.c
@@ -97,7 +97,7 @@ static void at_query_manufacturer(struct ofono_devinfo *i=
nfo,
 =

 	cbd->user =3D "+CGMI:";
 =

-	if (g_at_chat_send(chat, "AT+CGMI", NULL,
+	if (g_at_chat_send_full(chat, "AT+CGMI", NULL, NULL,
 				attr_cb, cbd, g_free) > 0)
 		return;
 =

@@ -119,7 +119,7 @@ static void at_query_model(struct ofono_devinfo *info,
 =

 	cbd->user =3D "+CGMM:";
 =

-	if (g_at_chat_send(chat, "AT+CGMM", NULL,
+	if (g_at_chat_send_full(chat, "AT+CGMM", NULL, NULL,
 				attr_cb, cbd, g_free) > 0)
 		return;
 =

@@ -141,7 +141,7 @@ static void at_query_revision(struct ofono_devinfo *inf=
o,
 =

 	cbd->user =3D "+CGMR:";
 =

-	if (g_at_chat_send(chat, "AT+CGMR", NULL,
+	if (g_at_chat_send_full(chat, "AT+CGMR", NULL, NULL,
 				attr_cb, cbd, g_free) > 0)
 		return;
 =

@@ -163,7 +163,7 @@ static void at_query_serial(struct ofono_devinfo *info,
 =

 	cbd->user =3D "+CGSN:";
 =

-	if (g_at_chat_send(chat, "AT+CGSN", NULL,
+	if (g_at_chat_send_full(chat, "AT+CGSN", NULL, NULL,
 				attr_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index ba5f0c0..f27b495 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -183,7 +183,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				at_cgdata_cb, gc, NULL) > 0)
+				at_cgdata_cb, gc) > 0)
 		return;
 =

 	gcd->active_context =3D 0;
@@ -216,7 +216,7 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 				ctx->apn);
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				at_cgdcont_cb, gc, NULL) > 0)
+				at_cgdcont_cb, gc) > 0)
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
@@ -237,7 +237,7 @@ static void at_gprs_deactivate_primary(struct ofono_gpr=
s_context *gc,
 =

 	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				at_cgact_down_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 052417a..553f2cf 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -73,7 +73,7 @@ static void at_gprs_set_attached(struct ofono_gprs *gprs,=
 int attached,
 =

 	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
 =

-	if (g_at_chat_send(gd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gd->chat, buf, none_prefix, NULL,
 				at_cgatt_cb, cbd, g_free) > 0)
 		return;
 =

@@ -120,7 +120,7 @@ static void at_gprs_registration_status(struct ofono_gp=
rs *gprs,
 =

 	cbd->user =3D gd;
 =

-	if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
+	if (g_at_chat_send_full(gd->chat, "AT+CGREG?", cgreg_prefix, NULL,
 				at_cgreg_cb, cbd, g_free) > 0)
 		return;
 =

@@ -215,16 +215,16 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *=
result,
 	else
 		goto error;
 =

-	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL);
+	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL);
 =

 	/* ST-E modem does not support AT+CGEREP =3D 2,1 */
 	if (gd->vendor =3D=3D OFONO_VENDOR_STE)
 		g_at_chat_send(gd->chat, "AT+CGEREP=3D1,0", none_prefix,
-			gprs_initialized, gprs, NULL);
+			gprs_initialized, gprs);
 	else
 		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
-			gprs_initialized, gprs, NULL);
+			gprs_initialized, gprs);
 	return;
 =

 error:
@@ -279,7 +279,7 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult *=
result,
 	ofono_gprs_set_cid_range(gprs, min, max);
 =

 	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
-			at_cgreg_test_cb, gprs, NULL);
+			at_cgreg_test_cb, gprs);
 =

 	return;
 =

@@ -301,7 +301,7 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 	ofono_gprs_set_data(gprs, gd);
 =

 	g_at_chat_send(chat, "AT+CGDCONT=3D?", cgdcont_prefix,
-			at_cgdcont_test_cb, gprs, NULL);
+			at_cgdcont_test_cb, gprs);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f7aafbe..b712e33 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -114,9 +114,9 @@ static void at_registration_status(struct ofono_netreg =
*netreg,
 	 */
 	if (nd->vendor =3D=3D OFONO_VENDOR_MBM)
 		g_at_chat_send(nd->chat, "AT*ERINFO?", none_prefix,
-				NULL, NULL, NULL);
+				NULL, NULL);
 =

-	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
+	if (g_at_chat_send_full(nd->chat, "AT+CREG?", creg_prefix, NULL,
 				at_creg_cb, cbd, g_free) > 0)
 		return;
 =

@@ -242,20 +242,19 @@ static void at_current_operator(struct ofono_netreg *=
netreg,
 =

 	cbd->user =3D netreg;
 =

-	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,2", none_prefix,
-				NULL, NULL, NULL);
+	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,2", none_prefix, NULL, NULL);
 =

 	if (ok)
 		ok =3D g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
-					cops_numeric_cb, cbd, NULL);
+					cops_numeric_cb, cbd);
 =

 	if (ok)
 		ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,0", none_prefix,
-					NULL, NULL, NULL);
+					NULL, NULL);
 =

 	if (ok)
 		ok =3D g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
-					cops_cb, cbd, NULL);
+					cops_cb, cbd);
 =

 	if (ok)
 		return;
@@ -377,7 +376,7 @@ static void at_list_operators(struct ofono_netreg *netr=
eg,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(nd->chat, "AT+COPS=3D?", cops_prefix,
+	if (g_at_chat_send_full(nd->chat, "AT+COPS=3D?", cops_prefix, NULL,
 				cops_list_cb, cbd, g_free) > 0)
 		return;
 =

@@ -408,7 +407,7 @@ static void at_register_auto(struct ofono_netreg *netre=
g,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(nd->chat, "AT+COPS=3D0", none_prefix,
+	if (g_at_chat_send_full(nd->chat, "AT+COPS=3D0", none_prefix, NULL,
 				register_cb, cbd, g_free) > 0)
 		return;
 =

@@ -432,7 +431,7 @@ static void at_register_manual(struct ofono_netreg *net=
reg,
 =

 	snprintf(buf, sizeof(buf), "AT+COPS=3D1,2,\"%s%s\"", mcc, mnc);
 =

-	if (g_at_chat_send(nd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(nd->chat, buf, none_prefix, NULL,
 				register_cb, cbd, g_free) > 0)
 		return;
 =

@@ -452,7 +451,7 @@ static void at_deregister(struct ofono_netreg *netreg,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(nd->chat, "AT+COPS=3D2", none_prefix,
+	if (g_at_chat_send_full(nd->chat, "AT+COPS=3D2", none_prefix, NULL,
 				register_cb, cbd, g_free) > 0)
 		return;
 =

@@ -684,12 +683,12 @@ static void at_signal_strength(struct ofono_netreg *n=
etreg,
 	 * otherwise fall back to CSQ
 	 */
 	if (nd->signal_index > 0) {
-		if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
-					cind_cb, cbd, g_free) > 0)
+		if (g_at_chat_send_full(nd->chat, "AT+CIND?", cind_prefix,
+					NULL, cind_cb, cbd, g_free) > 0)
 			return;
 	} else {
-		if (g_at_chat_send(nd->chat, "AT+CSQ", csq_prefix,
-				csq_cb, cbd, g_free) > 0)
+		if (g_at_chat_send_full(nd->chat, "AT+CSQ", csq_prefix,
+				NULL, csq_cb, cbd, g_free) > 0)
 			return;
 	}
 =

@@ -816,8 +815,7 @@ static void cind_support_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	if (nd->signal_index =3D=3D 0)
 		goto error;
 =

-	g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
-			NULL, NULL, NULL);
+	g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL, NULL, NULL);
 	g_at_chat_register(nd->chat, "+CIEV:",
 				ciev_notify, FALSE, netreg, NULL);
 =

@@ -857,7 +855,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		break;
 	case OFONO_VENDOR_CALYPSO:
 		g_at_chat_send(nd->chat, "AT%CSQ=3D1", none_prefix,
-				NULL, NULL, NULL);
+				NULL, NULL);
 		g_at_chat_register(nd->chat, "%CSQ:", calypso_csq_notify,
 					FALSE, netreg, NULL);
 =

@@ -865,12 +863,9 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 		break;
 	case OFONO_VENDOR_OPTION_HSO:
-		g_at_chat_send(nd->chat, "AT_OSSYS=3D1", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OCTI=3D1", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OSQI=3D1", none_prefix,
-				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OSSYS=3D1", none_prefix, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OCTI=3D1", none_prefix, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OSQI=3D1", none_prefix, NULL, NULL);
 		g_at_chat_register(nd->chat, "_OSIGQ:", option_osigq_notify,
 					FALSE, netreg, NULL);
 		g_at_chat_register(nd->chat, "_OWCTI:", option_owcti_notify,
@@ -880,12 +875,9 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		g_at_chat_register(nd->chat, "_OSSYSI:", option_ossysi_notify,
 					FALSE, netreg, NULL);
 =

-		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix,
-				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix, NULL, NULL);
 =

 		/*
 		 * Option has the concept of Speech Service versus
@@ -898,10 +890,8 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		 *   0 =3D Speech Service enabled
 		 *   1 =3D Data Service only mode
 		 */
-		g_at_chat_send(nd->chat, "AT_ODO?", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_ODO=3D0", none_prefix,
-				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_ODO?", none_prefix, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_ODO=3D0", none_prefix, NULL, NULL);
 =

 		ofono_netreg_register(netreg);
 =

@@ -909,16 +899,16 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	case OFONO_VENDOR_MBM:
 		g_at_chat_send(nd->chat, "AT*ERINFO=3D1", none_prefix,
-				NULL, NULL, NULL);
+				NULL, NULL);
 		g_at_chat_register(nd->chat, "*ERINFO:", mbm_erinfo_notify,
 					FALSE, netreg, NULL);
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
-				cind_support_cb, netreg, NULL);
+				cind_support_cb, netreg);
 =

 		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
-				cind_support_cb, netreg, NULL);
+				cind_support_cb, netreg);
 		break;
 	}
 }
@@ -954,13 +944,13 @@ static void at_creg_test_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 =

 	if (creg2) {
 		g_at_chat_send(nd->chat, "AT+CREG=3D2", none_prefix,
-				at_creg_set_cb, netreg, NULL);
+				at_creg_set_cb, netreg);
 		return;
 	}
 =

 	if (creg1) {
 		g_at_chat_send(nd->chat, "AT+CREG=3D1", none_prefix,
-				at_creg_set_cb, netreg, NULL);
+				at_creg_set_cb, netreg);
 		return;
 	}
 =

@@ -983,7 +973,7 @@ static int at_netreg_probe(struct ofono_netreg *netreg,=
 unsigned int vendor,
 	ofono_netreg_set_data(netreg, nd);
 =

 	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
-			at_creg_test_cb, netreg, NULL);
+			at_creg_test_cb, netreg);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 5e7a52b..d398cef 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -231,7 +231,7 @@ static void at_read_entries_cb(gboolean ok, GAtResult *=
result,
 =

 	if (strcmp(pbd->old_charset, charset)) {
 		snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", pbd->old_charset);
-		g_at_chat_send(pbd->chat, buf, none_prefix, NULL, NULL, NULL);
+		g_at_chat_send(pbd->chat, buf, none_prefix, NULL, NULL);
 	}
 =

 	g_free(pbd->old_charset);
@@ -248,7 +248,7 @@ static void at_read_entries(struct cb_data *cbd)
 			pbd->index_min, pbd->index_max);
 	if (g_at_chat_send_listing(pbd->chat, buf, cpbr_prefix,
 					at_cpbr_notify, at_read_entries_cb,
-					cbd, NULL) > 0)
+					cbd) > 0)
 		return;
 =

 	/* If we get here, then most likely connection to the modem dropped
@@ -301,7 +301,7 @@ static void at_read_charset_cb(gboolean ok, GAtResult *=
result,
 =

 	snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", charset);
 	if (g_at_chat_send(pbd->chat, buf, none_prefix,
-				at_set_charset_cb, cbd, NULL) > 0)
+				at_set_charset_cb, cbd) > 0)
 		return;
 =

 error:
@@ -337,7 +337,7 @@ static void at_list_indices_cb(gboolean ok, GAtResult *=
result,
 		goto error;
 =

 	if (g_at_chat_send(pbd->chat, "AT+CSCS?", cscs_prefix,
-				at_read_charset_cb, cbd, NULL) > 0)
+				at_read_charset_cb, cbd) > 0)
 		return;
 =

 error:
@@ -355,7 +355,7 @@ static void at_select_storage_cb(gboolean ok, GAtResult=
 *result,
 		goto error;
 =

 	if (g_at_chat_send(pbd->chat, "AT+CPBR=3D?", cpbr_prefix,
-				at_list_indices_cb, cbd, NULL) > 0)
+				at_list_indices_cb, cbd) > 0)
 		return;
 =

 error:
@@ -376,7 +376,7 @@ static void at_export_entries(struct ofono_phonebook *p=
b, const char *storage,
 =

 	snprintf(buf, sizeof(buf), "AT+CPBS=3D\"%s\"", storage);
 	if (g_at_chat_send(pbd->chat, buf, none_prefix,
-				at_select_storage_cb, cbd, NULL) > 0)
+				at_select_storage_cb, cbd) > 0)
 		return;
 =

 error:
@@ -486,7 +486,7 @@ static void at_list_charsets_cb(gboolean ok, GAtResult =
*result,
 	}
 =

 	if (g_at_chat_send(pbd->chat, "AT+CPBS=3D?", cpbs_prefix,
-				at_list_storages_cb, pb, NULL) > 0)
+				at_list_storages_cb, pb) > 0)
 		return;
 =

 error:
@@ -498,7 +498,7 @@ static void at_list_charsets(struct ofono_phonebook *pb)
 	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
 =

 	if (g_at_chat_send(pbd->chat, "AT+CSCS=3D?", cscs_prefix,
-				at_list_charsets_cb, pb, NULL) > 0)
+				at_list_charsets_cb, pb) > 0)
 		return;
 =

 	phonebook_not_supported(pb);
diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
index f1a83e3..bd2caa6 100644
--- a/drivers/atmodem/sim-poll.c
+++ b/drivers/atmodem/sim-poll.c
@@ -107,8 +107,7 @@ static void sim_fetch_command(struct sim_poll_data *spd=
, int length)
 =

 	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
 =

-	g_at_chat_send(spd->chat, buf, csim_prefix,
-			at_csim_fetch_cb, spd, NULL);
+	g_at_chat_send(spd->chat, buf, csim_prefix, at_csim_fetch_cb, spd);
 }
 =

 static void sim_status_poll_schedule(struct sim_poll_data *spd)
@@ -212,7 +211,7 @@ static gboolean sim_status_poll(gpointer user_data)
 =

 	/* Send STATUS */
 	spd->status_cmd =3D g_at_chat_send(spd->chat, "AT+CSIM=3D8,A0F200C0",
-			csim_prefix, at_csim_status_cb, spd, NULL);
+			csim_prefix, at_csim_status_cb, spd);
 	if (spd->status_cmd =3D=3D 0)
 		at_csim_status_cb(FALSE, NULL, spd);
 =

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 13e7459..66c95e1 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -115,7 +115,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	if (sd->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM)
 		strcat(buf, ",0,0,255"); /* Maximum possible length */
 =

-	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
+	if (g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_info_cb, cbd, g_free) > 0)
 		return;
 =

@@ -179,7 +179,7 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,%i,%i,%i", fileid,
 			start >> 8, start & 0xff, length);
 =

-	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
+	if (g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

@@ -204,7 +204,7 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
 			record, length);
 =

-	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
+	if (g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

@@ -271,7 +271,7 @@ static void at_sim_update_binary(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -305,7 +305,7 @@ static void at_sim_update_record(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -337,7 +337,7 @@ static void at_sim_update_cyclic(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send_full(sd->chat, buf, crsm_prefix, NULL,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -389,7 +389,7 @@ static void at_read_imsi(struct ofono_sim *sim, ofono_s=
im_imsi_cb_t cb,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(sd->chat, "AT+CIMI", NULL,
+	if (g_at_chat_send_full(sd->chat, "AT+CIMI", NULL, NULL,
 				at_cimi_cb, cbd, g_free) > 0)
 		return;
 =

@@ -488,7 +488,7 @@ static void at_pin_query(struct ofono_sim *sim, ofono_s=
im_passwd_cb_t cb,
 =

 	cbd->user =3D sim;
 =

-	if (g_at_chat_send(sd->chat, "AT+CPIN?", NULL,
+	if (g_at_chat_send_full(sd->chat, "AT+CPIN?", NULL, NULL,
 				at_cpin_cb, cbd, g_free) > 0)
 		return;
 =

@@ -524,7 +524,7 @@ static void at_pin_send(struct ofono_sim *sim, const ch=
ar *passwd,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -553,7 +553,7 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -599,7 +599,7 @@ static void at_pin_enable(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
 			at_clck_cpwd_fac[passwd_type], enable ? 1 : 0, passwd);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -635,7 +635,7 @@ static void at_change_passwd(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
 			at_clck_cpwd_fac[passwd_type], old, new);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -698,7 +698,7 @@ static void at_pin_query_enabled(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
 			at_clck_cpwd_fac[passwd_type]);
 =

-	if (g_at_chat_send(sd->chat, buf, NULL,
+	if (g_at_chat_send_full(sd->chat, buf, NULL, NULL,
 				at_lock_status_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 13f5723..5f85964 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -109,7 +109,7 @@ static void at_csca_set(struct ofono_sms *sms,
 =

 	snprintf(buf, sizeof(buf), "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
 =

-	if (g_at_chat_send(data->chat, buf, csca_prefix,
+	if (g_at_chat_send_full(data->chat, buf, csca_prefix, NULL,
 				at_csca_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -175,7 +175,7 @@ static void at_csca_query(struct ofono_sms *sms, ofono_=
sms_sca_query_cb_t cb,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(data->chat, "AT+CSCA?", csca_prefix,
+	if (g_at_chat_send_full(data->chat, "AT+CSCA?", csca_prefix, NULL,
 				at_csca_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -232,14 +232,13 @@ static void at_cmgs(struct ofono_sms *sms, unsigned c=
har *pdu, int pdu_len,
 =

 	if (mms) {
 		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
-		g_at_chat_send(data->chat, buf, none_prefix,
-				NULL, NULL, NULL);
+		g_at_chat_send(data->chat, buf, none_prefix, NULL, NULL);
 	}
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
 	encode_hex_own_buf(pdu, pdu_len, 0, buf+len);
 =

-	if (g_at_chat_send(data->chat, buf, cmgs_prefix,
+	if (g_at_chat_send_full(data->chat, buf, cmgs_prefix, NULL,
 				at_cmgs_cb, cbd, g_free) > 0)
 		return;
 =

@@ -300,7 +299,7 @@ static void at_cds_notify(GAtResult *result, gpointer u=
ser_data)
 	else /* Should be a safe fallback */
 		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
 =

-	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL);
 }
 =

 static void at_cmt_notify(GAtResult *result, gpointer user_data)
@@ -335,7 +334,7 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	else /* Should be a safe fallback */
 		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
 =

-	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL);
 }
 =

 static void at_cmgr_notify(GAtResult *result, gpointer user_data)
@@ -403,11 +402,11 @@ static void at_cmti_cpms_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	data->store =3D req->store;
 =

 	snprintf(buf, sizeof(buf), "AT+CMGR=3D%d", req->index);
-	g_at_chat_send(data->chat, buf, none_prefix, at_cmgr_cb, NULL, NULL);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cmgr_cb, NULL);
 =

 	/* We don't buffer SMS on the SIM/ME, send along a CMGD as well */
 	snprintf(buf, sizeof(buf), "AT+CMGD=3D%d", req->index);
-	g_at_chat_send(data->chat, buf, none_prefix, at_cmgd_cb, NULL, NULL);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cmgd_cb, NULL);
 }
 =

 static void at_cmti_notify(GAtResult *result, gpointer user_data)
@@ -459,8 +458,8 @@ static void at_cmti_notify(GAtResult *result, gpointer =
user_data)
 		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
 				strstore, strstore, incoming);
 =

-		g_at_chat_send(data->chat, buf, cpms_prefix, at_cmti_cpms_cb,
-				req, g_free);
+		g_at_chat_send_full(data->chat, buf, cpms_prefix, NULL,
+					at_cmti_cpms_cb, req, g_free);
 	}
 =

 	return;
@@ -522,8 +521,7 @@ static void at_cmgl_notify(GAtResult *result, gpointer =
user_data)
 =

 		/* We don't buffer SMS on the SIM/ME, send along a CMGD */
 		snprintf(buf, sizeof(buf), "AT+CMGD=3D%d", index);
-		g_at_chat_send(data->chat, buf, none_prefix,
-				at_cmgd_cb, NULL, NULL);
+		g_at_chat_send(data->chat, buf, none_prefix, at_cmgd_cb, NULL);
 	}
 	return;
 =

@@ -556,7 +554,7 @@ static void at_cmgl_cpms_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	data->store =3D req->store;
 =

 	g_at_chat_send_pdu_listing(data->chat, "AT+CMGL=3D4", cmgl_prefix,
-					at_cmgl_notify, at_cmgl_cb, sms, NULL);
+					at_cmgl_notify, at_cmgl_cb, sms);
 }
 =

 static void at_cmgl_set_cpms(struct ofono_sms *sms, int store)
@@ -582,8 +580,8 @@ static void at_cmgl_set_cpms(struct ofono_sms *sms, int=
 store)
 		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
 				readwrite, readwrite, incoming);
 =

-		g_at_chat_send(data->chat, buf, cpms_prefix, at_cmgl_cpms_cb,
-				req, g_free);
+		g_at_chat_send_full(data->chat, buf, cpms_prefix, NULL,
+					at_cmgl_cpms_cb, req, g_free);
 	}
 }
 =

@@ -775,8 +773,7 @@ out:
 	if (!supported)
 		return at_sms_not_supported(sms);
 =

-	g_at_chat_send(data->chat, buf, cnmi_prefix,
-			at_cnmi_set_cb, sms, NULL);
+	g_at_chat_send(data->chat, buf, cnmi_prefix, at_cnmi_set_cb, sms);
 }
 =

 static void at_query_cnmi(struct ofono_sms *sms)
@@ -784,7 +781,7 @@ static void at_query_cnmi(struct ofono_sms *sms)
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	g_at_chat_send(data->chat, "AT+CNMI=3D?", cnmi_prefix,
-			at_cnmi_query_cb, sms, NULL);
+			at_cnmi_query_cb, sms);
 }
 =

 static void at_cpms_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -816,8 +813,7 @@ static gboolean set_cpms(gpointer user_data)
 	snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
 			store, store, incoming);
 =

-	g_at_chat_send(data->chat, buf, cpms_prefix,
-			at_cpms_set_cb, sms, NULL);
+	g_at_chat_send(data->chat, buf, cpms_prefix, at_cpms_set_cb, sms);
 	return FALSE;
 }
 =

@@ -848,7 +844,7 @@ static gboolean set_cmgf(gpointer user_data)
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	g_at_chat_send(data->chat, "AT+CMGF=3D0", cmgf_prefix,
-			at_cmgf_set_cb, sms, NULL);
+			at_cmgf_set_cb, sms);
 	return FALSE;
 }
 =

@@ -956,7 +952,7 @@ out:
 		return at_sms_not_supported(sms);
 =

 	g_at_chat_send(data->chat, "AT+CPMS=3D?", cpms_prefix,
-			at_cpms_query_cb, sms, NULL);
+			at_cpms_query_cb, sms);
 }
 =

 static void at_csms_status_cb(gboolean ok, GAtResult *result,
@@ -999,7 +995,7 @@ out:
 =

 	/* Now query supported text format */
 	g_at_chat_send(data->chat, "AT+CMGF=3D?", cmgf_prefix,
-			at_cmgf_query_cb, sms, NULL);
+			at_cmgf_query_cb, sms);
 }
 =

 static void at_csms_set_cb(gboolean ok, GAtResult *result,
@@ -1009,7 +1005,7 @@ static void at_csms_set_cb(gboolean ok, GAtResult *re=
sult,
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	g_at_chat_send(data->chat, "AT+CSMS?", csms_prefix,
-			at_csms_status_cb, sms, NULL);
+			at_csms_status_cb, sms);
 }
 =

 static void at_csms_query_cb(gboolean ok, GAtResult *result,
@@ -1041,8 +1037,7 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 =

 out:
 	snprintf(buf, sizeof(buf), "AT+CSMS=3D%d", cnma_supported ? 1 : 0);
-	g_at_chat_send(data->chat, buf, csms_prefix,
-			at_csms_set_cb, sms, NULL);
+	g_at_chat_send(data->chat, buf, csms_prefix, at_csms_set_cb, sms);
 }
 =

 static int at_sms_probe(struct ofono_sms *sms, unsigned int vendor,
@@ -1057,8 +1052,7 @@ static int at_sms_probe(struct ofono_sms *sms, unsign=
ed int vendor,
 =

 	ofono_sms_set_data(sms, data);
 =

-	g_at_chat_send(chat, "AT+CSMS=3D?", csms_prefix,
-			at_csms_query_cb, sms, NULL);
+	g_at_chat_send(chat, "AT+CSMS=3D?", csms_prefix, at_csms_query_cb, sms);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index f219cde..d9be0ba 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -115,7 +115,7 @@ static int at_ssn_probe(struct ofono_ssn *ssn, unsigned=
 int vendor,
 =

 	ofono_ssn_set_data(ssn, chat);
 	g_at_chat_send(chat, "AT+CSSN=3D1,1", none_prefix,
-			at_ssn_initialized, ssn, NULL);
+			at_ssn_initialized, ssn);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 8cff4a2..1470321 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -109,8 +109,8 @@ static void at_stk_envelope(struct ofono_stk *stk, int =
length,
 =

 	len +=3D sprintf(buf + len, "FF");
 =

-	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
-				at_csim_envelope_cb, cbd, g_free);
+	ret =3D g_at_chat_send_full(sd->chat, buf, csim_prefix, NULL,
+					at_csim_envelope_cb, cbd, g_free);
 =

 	g_free(buf);
 	buf =3D NULL;
@@ -191,8 +191,9 @@ static void at_stk_terminal_response(struct ofono_stk *=
stk, int length,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
-				at_csim_terminal_response_cb, cbd, g_free);
+	ret =3D g_at_chat_send_full(sd->chat, buf, csim_prefix, NULL,
+					at_csim_terminal_response_cb,
+					cbd, g_free);
 =

 	g_free(buf);
 	buf =3D NULL;
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 555ce13..db8425c 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -152,7 +152,7 @@ static void at_ussd_request(struct ofono_ussd *ussd, co=
nst char *str,
 	g_free(converted);
 	converted =3D NULL;
 =

-	if (g_at_chat_send(chat, buf, cusd_prefix,
+	if (g_at_chat_send_full(chat, buf, cusd_prefix, NULL,
 				cusd_request_cb, cbd, g_free) > 0)
 		return;
 =

@@ -186,7 +186,7 @@ static void at_ussd_cancel(struct ofono_ussd *ussd,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CUSD=3D2", none_prefix,
+	if (g_at_chat_send_full(chat, "AT+CUSD=3D2", none_prefix, NULL,
 				cusd_cancel_cb, cbd, g_free) > 0)
 		return;
 =

@@ -226,7 +226,7 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsig=
ned int vendor,
 =

 	ofono_ussd_set_data(ussd, chat);
 =

-	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd, NULL);
+	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd);
 =

 	return 0;
 }
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index fce9144..e1c56c8 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -201,8 +201,7 @@ static gboolean poll_clcc(gpointer user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc);
 =

 	vd->clcc_source =3D 0;
 =

@@ -230,7 +229,7 @@ static void generic_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	}
 =

 	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+			clcc_poll_cb, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -249,7 +248,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 		vd->local_release =3D 0x1 << req->id;
 =

 	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+			clcc_poll_cb, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -363,7 +362,7 @@ static void at_dial(struct ofono_voicecall *vc,
 =

 	strcat(buf, ";");
 =

-	if (g_at_chat_send(vd->chat, buf, atd_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, atd_prefix, NULL,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

@@ -389,7 +388,7 @@ static void at_template(const char *cmd, struct ofono_v=
oicecall *vc,
 	req->data =3D data;
 	req->affected_types =3D affected_types;
 =

-	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+	if (g_at_chat_send_full(vd->chat, cmd, none_prefix, NULL,
 				result_cb, req, g_free) > 0)
 		return;
 =

@@ -472,7 +471,7 @@ static void at_release_specific(struct ofono_voicecall =
*vc, int id,
 =

 	snprintf(buf, sizeof(buf), "AT+CHLD=3D1%d", id);
 =

-	if (g_at_chat_send(vd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				release_id_cb, req, g_free) > 0)
 		return;
 =

@@ -558,7 +557,7 @@ static void at_send_dtmf(struct ofono_voicecall *vc, co=
nst char *dtmf,
 	for (i =3D 1; i < len; i++)
 		s +=3D sprintf(buf + s, ";+VTS=3D\"%c\"", dtmf[i]);
 =

-	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
+	s =3D g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				vts_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -780,8 +779,7 @@ static void no_carrier_notify(GAtResult *result, gpoint=
er user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc);
 }
 =

 static void no_answer_notify(GAtResult *result, gpointer user_data)
@@ -789,8 +787,7 @@ static void no_answer_notify(GAtResult *result, gpointe=
r user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc);
 }
 =

 static void busy_notify(GAtResult *result, gpointer user_data)
@@ -802,8 +799,7 @@ static void busy_notify(GAtResult *result, gpointer use=
r_data)
 	 * or UDUB on the other side
 	 * TODO: Handle UDUB or other conditions somehow
 	 */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc);
 }
 =

 static void at_voicecall_initialized(gboolean ok, GAtResult *result,
@@ -831,7 +827,7 @@ static void at_voicecall_initialized(gboolean ok, GAtRe=
sult *result,
 	ofono_voicecall_register(vc);
 =

 	/* Populate the call list */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc);
 }
 =

 static int at_voicecall_probe(struct ofono_voicecall *vc, unsigned int ven=
dor,
@@ -845,11 +841,10 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CCWA=3D1", NULL,
-				at_voicecall_initialized, vc, NULL);
+	g_at_chat_send(chat, "AT+CRC=3D1", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CLIP=3D1", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+COLP=3D1", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CCWA=3D1", NULL, at_voicecall_initialized, vc);
 	return 0;
 }
 =

diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index ae49eb0..dd5a5dc 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -66,7 +66,7 @@ static void calypso_template(struct ofono_voicecall *vc, =
const char *cmd,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+	if (g_at_chat_send_full(vd->chat, cmd, none_prefix, NULL,
 				calypso_generic_cb, cbd, g_free) > 0)
 		return;
 =

@@ -318,8 +318,7 @@ static void cpi_notify(GAtResult *result, gpointer user=
_data)
 =

 	/* Need to send this on the calypso hardware to avoid echo issues */
 	if (msgtype =3D=3D 3 || msgtype =3D=3D 4)
-		g_at_chat_send(vd->chat, "AT%N0187", none_prefix,
-				NULL, NULL, NULL);
+		g_at_chat_send(vd->chat, "AT%N0187", none_prefix, NULL, NULL);
 =

 	switch (msgtype) {
 	case 0:
@@ -389,7 +388,7 @@ static int calypso_voicecall_probe(struct ofono_voiceca=
ll *vc, unsigned int vend
 	ofono_voicecall_set_data(vc, vd);
 =

 	g_at_chat_send(chat, "AT%CPI=3D3", NULL,
-				calypso_voicecall_initialized, vc, NULL);
+				calypso_voicecall_initialized, vc);
 =

 	return 0;
 }
diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 95065d2..9abcf7c 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -81,7 +81,7 @@ static void hfp_speaker_volume(struct ofono_call_volume *=
cv,
 	snprintf(buf, sizeof(buf), "AT+VGS=3D%d",
 				(int)(percent*HFP_CALL_VOLUME_MAX/100));
 =

-	if (g_at_chat_send(vd->chat, buf, vgs_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, vgs_prefix, NULL,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -109,7 +109,7 @@ static void hfp_microphone_volume(struct ofono_call_vol=
ume *cv,
 	snprintf(buf, sizeof(buf), "AT+VGM=3D%d",
 				(int)(percent*HFP_CALL_VOLUME_MAX/100));
 =

-	if (g_at_chat_send(vd->chat, buf, vgm_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, vgm_prefix, NULL,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 8478966..504800e 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -241,8 +241,8 @@ static void hfp_registration_status(struct ofono_netreg=
 *netreg,
 =

 	cbd->user =3D netreg;
 =

-	ok =3D g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
-				registration_status_cb, cbd, g_free);
+	ok =3D g_at_chat_send_full(nd->chat, "AT+CIND?", cind_prefix, NULL,
+					registration_status_cb, cbd, g_free);
 	if (ok)
 		return;
 =

@@ -265,12 +265,11 @@ static void hfp_current_operator(struct ofono_netreg =
*netreg,
 =

 	cbd->user =3D netreg;
 =

-	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,0", NULL,
-			NULL, cbd, NULL);
+	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,0", NULL, NULL, cbd);
 =

 	if (ok)
-		ok =3D g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
-				cops_cb, cbd, g_free);
+		ok =3D g_at_chat_send_full(nd->chat, "AT+COPS?", cops_prefix,
+				NULL, cops_cb, cbd, g_free);
 =

 	if (ok)
 		return;
@@ -290,7 +289,7 @@ static void hfp_signal_strength(struct ofono_netreg *ne=
treg,
 =

 	cbd->user =3D netreg;
 =

-	if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+	if (g_at_chat_send_full(nd->chat, "AT+CIND?", cind_prefix, NULL,
 				signal_strength_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f83f26a..26ee39f 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -284,8 +284,7 @@ static gboolean poll_clcc(gpointer user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc);
 =

 	vd->clcc_source =3D 0;
 =

@@ -375,7 +374,7 @@ static void hfp_dial(struct ofono_voicecall *vc,
 =

 	strcat(buf, ";");
 =

-	if (g_at_chat_send(vd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

@@ -401,7 +400,7 @@ static void hfp_template(const char *cmd, struct ofono_=
voicecall *vc,
 	req->data =3D data;
 	req->affected_types =3D affected_types;
 =

-	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+	if (g_at_chat_send_full(vd->chat, cmd, none_prefix, NULL,
 				result_cb, req, g_free) > 0)
 		return;
 =

@@ -518,7 +517,7 @@ static void hfp_release_specific(struct ofono_voicecall=
 *vc, int id,
 =

 	snprintf(buf, sizeof(buf), "AT+CHLD=3D1%d", id);
 =

-	if (g_at_chat_send(vd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				release_id_cb, req, g_free) > 0)
 		return;
 =

@@ -603,7 +602,7 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 =

 	sprintf(buf, "AT+VTS=3D%s", dtmf);
 =

-	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
+	s =3D g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				generic_cb, req, g_free);
 =

 	g_free(buf);
@@ -928,7 +927,7 @@ static void ciev_callsetup_notify(struct ofono_voicecal=
l *vc,
 	 */
 	if (waiting && dialing) {
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+				clcc_poll_cb, vc);
 		goto out;
 	}
 =

@@ -968,7 +967,7 @@ static void ciev_callsetup_notify(struct ofono_voicecal=
l *vc,
 			ofono_voicecall_notify(vc, call);
 		} else {
 			g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-					clcc_poll_cb, vc, NULL);
+					clcc_poll_cb, vc);
 		}
 =

 		break;
@@ -983,7 +982,7 @@ static void ciev_callsetup_notify(struct ofono_voicecal=
l *vc,
 		 * from AG: query and create call.
 		 */
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				sync_dialing_cb, vc, NULL);
+				sync_dialing_cb, vc);
 		break;
 =

 	case 3:
@@ -1025,7 +1024,7 @@ static void ciev_callheld_notify(struct ofono_voiceca=
ll *vc,
 		 * were merged
 		 */
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+				clcc_poll_cb, vc);
 		break;
 =

 	case 1:
@@ -1034,7 +1033,7 @@ static void ciev_callheld_notify(struct ofono_voiceca=
ll *vc,
 		 * chosed for private chat by CHLD=3D2x
 		 */
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+				clcc_poll_cb, vc);
 		break;
 	case 2:
 		if (callheld =3D=3D 0) {
@@ -1116,7 +1115,7 @@ static void hfp_voicecall_initialized(gboolean ok, GA=
tResult *result,
 	ofono_voicecall_register(vc);
 =

 	/* Populate the call list */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, hfp_clcc_cb, vc, NULL);
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, hfp_clcc_cb, vc);
 }
 =

 static int hfp_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
@@ -1136,9 +1135,9 @@ static int hfp_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL,
-				hfp_voicecall_initialized, vc, NULL);
+				hfp_voicecall_initialized, vc);
 	return 0;
 }
 =

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index 99de549..9f72fbd 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -136,7 +136,7 @@ static void hso_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	snprintf(buf, sizeof(buf), "AT_OWANCALL=3D%u,1,1", gcd->active_context);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				hso_owancall_up_cb, ncbd, g_free) > 0)
 		return;
 =

@@ -173,8 +173,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	else
 		snprintf(buf, sizeof(buf), "AT$QCPDPP=3D%u,0", ctx->cid);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				NULL, NULL, NULL) =3D=3D 0)
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL) =3D=3D 0)
 		goto error;
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
@@ -183,7 +182,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
 				ctx->apn);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				hso_cgdcont_cb, cbd, g_free) > 0)
 		return;
 error:
@@ -208,7 +207,7 @@ static void hso_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 =

 	snprintf(buf, sizeof(buf), "AT_OWANCALL=3D%u,0,1", cid);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				at_owancall_down_cb, cbd, g_free) > 0)
 		return;
 =

@@ -330,7 +329,7 @@ static void owancall_notifier(GAtResult *result, gpoint=
er user_data)
 					gcd->active_context);
 =

 			g_at_chat_send(gcd->chat, buf, owandata_prefix,
-					owandata_cb, gc, NULL);
+					owandata_cb, gc);
 		}
 =

 		break;
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index cca5087..565d147 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -151,7 +151,7 @@ static void mbm_get_ip_details(struct ofono_gprs_contex=
t *gc)
 =

 	if (gcd->have_e2ipcfg) {
 		g_at_chat_send(gcd->chat, "AT*E2IPCFG?", e2ipcfg_prefix,
-				mbm_e2ipcfg_cb, gc, NULL);
+				mbm_e2ipcfg_cb, gc);
 		return;
 	}
 =

@@ -239,7 +239,7 @@ static gboolean mbm_enap_poll(gpointer user_data)
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

 	g_at_chat_send(gcd->chat, "AT*ENAP?", enap_prefix,
-				mbm_enap_poll_cb, gc, NULL);
+				mbm_enap_poll_cb, gc);
 =

 	gcd->enap_source =3D 0;
 =

@@ -262,7 +262,7 @@ static void at_enap_down_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 		if (gcd->have_e2nap =3D=3D FALSE)
 			g_at_chat_send(gcd->chat, "AT*ENAP?", enap_prefix,
-					mbm_enap_poll_cb, gc, NULL);
+					mbm_enap_poll_cb, gc);
 =

 		return;
 	}
@@ -286,7 +286,7 @@ static void mbm_enap_up_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 		if (gcd->have_e2nap =3D=3D FALSE)
 			g_at_chat_send(gcd->chat, "AT*ENAP?", enap_prefix,
-					mbm_enap_poll_cb, gc, NULL);
+					mbm_enap_poll_cb, gc);
 =

 		return;
 	}
@@ -320,7 +320,7 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	snprintf(buf, sizeof(buf), "AT*ENAP=3D1,%u", gcd->active_context);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				mbm_enap_up_cb, ncbd, g_free) > 0)
 		return;
 =

@@ -354,7 +354,7 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
 				ctx->apn);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				mbm_cgdcont_cb, cbd, g_free) =3D=3D 0)
 		goto error;
 =

@@ -366,7 +366,7 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
 			ctx->cid, ctx->username, ctx->password);
 =

-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL);
 =

 	return;
 =

@@ -389,7 +389,7 @@ static void mbm_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 =

 	cbd->user =3D gc;
 =

-	if (g_at_chat_send(gcd->chat, "AT*ENAP=3D0", none_prefix,
+	if (g_at_chat_send_full(gcd->chat, "AT*ENAP=3D0", none_prefix, NULL,
 				at_enap_down_cb, cbd, g_free) > 0)
 		return;
 =

@@ -448,9 +448,9 @@ static int mbm_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 =

 	ofono_gprs_context_set_data(gc, gcd);
 =

-	g_at_chat_send(chat, "AT*E2NAP=3D1", none_prefix, mbm_e2nap_cb, gc, NULL);
+	g_at_chat_send(chat, "AT*E2NAP=3D1", none_prefix, mbm_e2nap_cb, gc);
 	g_at_chat_send(chat, "AT*E2IPCFG=3D?", e2ipcfg_prefix,
-			mbm_e2ipcfg_query_cb, gc, NULL);
+			mbm_e2ipcfg_query_cb, gc);
 =

 	return 0;
 }
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 2e54f9f..49ede13 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -391,7 +391,7 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%u,%u",
 			conn->channel_id, conn->cid);
 =

-	if (g_at_chat_send(gcd->chat, buf, NULL,
+	if (g_at_chat_send_full(gcd->chat, buf, NULL, NULL,
 				ste_eppsd_up_cb, ncbd, g_free) > 0)
 		return;
 =

@@ -426,7 +426,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
 				ctx->apn);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				ste_cgdcont_cb, cbd, g_free) =3D=3D 0)
 		goto error;
 =

@@ -438,7 +438,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
 			ctx->cid, ctx->username, ctx->password);
 =

-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL);
 =

 	return;
 =

@@ -478,7 +478,7 @@ static void ste_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 =

 	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%u,%u", conn->channel_id, id);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(gcd->chat, buf, none_prefix, NULL,
 				ste_eppsd_down_cb, cbd, g_free) > 0)
 		return;
 =

@@ -543,7 +543,7 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 			g_str_has_prefix(event, "ME DEACT ")) {
 		/* Ask what primary contexts are active now */
 		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
-				ste_cgact_read_cb, gc, NULL);
+				ste_cgact_read_cb, gc);
 	}
 }
 =

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index a56709a..0114e90 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -217,7 +217,7 @@ static void ste_dial(struct ofono_voicecall *vc,
 =

 	strcat(buf, ";");
 =

-	if (g_at_chat_send(vd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

@@ -243,7 +243,7 @@ static void ste_template(const char *cmd, struct ofono_=
voicecall *vc,
 	req->data =3D data;
 	req->affected_types =3D affected_types;
 =

-	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+	if (g_at_chat_send_full(vd->chat, cmd, none_prefix, NULL,
 				result_cb, req, g_free) > 0)
 		return;
 =

@@ -310,7 +310,7 @@ static void ste_release_specific(struct ofono_voicecall=
 *vc, int id,
 =

 	snprintf(buf, sizeof(buf), "AT+CHLD=3D1%d", id);
 =

-	if (g_at_chat_send(vd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				release_id_cb, req, g_free) > 0)
 		return;
 =

@@ -392,7 +392,7 @@ static void ste_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 =

 	sprintf(buf, "AT+VTS=3D%s", dtmf);
 =

-	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
+	s =3D g_at_chat_send_full(vd->chat, buf, none_prefix, NULL,
 				vts_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -544,7 +544,7 @@ static int ste_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(chat, "AT*ECAM=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT*ECAM=3D1", NULL, NULL, NULL);
 	g_at_chat_register(chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
 	ofono_voicecall_register(vc);
 =

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index f94605f..a44abae 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -49,6 +49,7 @@ struct at_command {
 	guint id;
 	GAtResultFunc callback;
 	GAtNotifyFunc listing;
+	GAtSubmitNotifyFunc submit_callback;
 	gpointer user_data;
 	GDestroyNotify notify;
 };
@@ -147,6 +148,7 @@ static gint at_command_compare_by_id(gconstpointer a, g=
constpointer b)
 static struct at_command *at_command_create(const char *cmd,
 						const char **prefix_list,
 						gboolean expect_pdu,
+						GAtSubmitNotifyFunc submit_func,
 						GAtNotifyFunc listing,
 						GAtResultFunc func,
 						gpointer user_data,
@@ -202,6 +204,7 @@ static struct at_command *at_command_create(const char =
*cmd,
 	c->expect_pdu =3D expect_pdu;
 	c->prefixes =3D prefixes;
 	c->callback =3D func;
+	c->submit_callback =3D submit_func;
 	c->listing =3D listing;
 	c->user_data =3D user_data;
 	c->notify =3D notify;
@@ -699,7 +702,7 @@ static gboolean wakeup_no_response(gpointer user_data)
 		return FALSE;
 =

 	g_at_chat_finish_command(chat, FALSE, NULL);
-	cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE,
+	cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE, NULL,
 				NULL, wakeup_cb, chat, NULL, TRUE);
 =

 	if (!cmd) {
@@ -751,7 +754,7 @@ static gboolean can_write_data(gpointer data)
 	}
 =

 	if (chat->cmd_bytes_written =3D=3D 0 && wakeup_first =3D=3D TRUE) {
-		cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE,
+		cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE, NULL,
 					NULL, wakeup_cb, chat, NULL, TRUE);
 =

 		if (!cmd)
@@ -789,6 +792,9 @@ static gboolean can_write_data(gpointer data)
 	if (bytes_written < towrite)
 		return TRUE;
 =

+	if (cmd->submit_callback)
+		cmd->submit_callback(cmd->id, cmd->user_data);
+
 	/* Full command submitted, update timer */
 	if (chat->wakeup_timer)
 		g_timer_start(chat->wakeup_timer);
@@ -966,7 +972,7 @@ gboolean g_at_chat_set_debug(GAtChat *chat,
 =

 static guint send_common(GAtChat *chat, const char *cmd,
 			const char **prefix_list,
-			gboolean expect_pdu,
+			gboolean expect_pdu, GAtSubmitNotifyFunc submit_func,
 			GAtNotifyFunc listing, GAtResultFunc func,
 			gpointer user_data, GDestroyNotify notify)
 {
@@ -975,8 +981,8 @@ static guint send_common(GAtChat *chat, const char *cmd,
 	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
 		return 0;
 =

-	c =3D at_command_create(cmd, prefix_list, expect_pdu, listing, func,
-				user_data, notify, FALSE);
+	c =3D at_command_create(cmd, prefix_list, expect_pdu, submit_func,
+				listing, func, user_data, notify, FALSE);
 =

 	if (!c)
 		return 0;
@@ -993,34 +999,45 @@ static guint send_common(GAtChat *chat, const char *c=
md,
 =

 guint g_at_chat_send(GAtChat *chat, const char *cmd,
 			const char **prefix_list, GAtResultFunc func,
-			gpointer user_data, GDestroyNotify notify)
+			gpointer user_data)
 {
-	return send_common(chat, cmd, prefix_list, FALSE, NULL, func,
-				user_data, notify);
+	return send_common(chat, cmd, prefix_list, FALSE, NULL, NULL, func,
+				user_data, NULL);
 }
 =

 guint g_at_chat_send_listing(GAtChat *chat, const char *cmd,
 				const char **prefix_list,
 				GAtNotifyFunc listing, GAtResultFunc func,
-				gpointer user_data, GDestroyNotify notify)
+				gpointer user_data)
 {
 	if (listing =3D=3D NULL)
 		return 0;
 =

-	return send_common(chat, cmd, prefix_list, FALSE, listing, func,
-				user_data, notify);
+	return send_common(chat, cmd, prefix_list, FALSE, NULL, listing, func,
+				user_data, NULL);
 }
 =

 guint g_at_chat_send_pdu_listing(GAtChat *chat, const char *cmd,
 				const char **prefix_list,
 				GAtNotifyFunc listing, GAtResultFunc func,
-				gpointer user_data, GDestroyNotify notify)
+				gpointer user_data)
 {
 	if (listing =3D=3D NULL)
 		return 0;
 =

-	return send_common(chat, cmd, prefix_list, TRUE, listing, func,
-				user_data, notify);
+	return send_common(chat, cmd, prefix_list, TRUE, NULL, listing, func,
+				user_data, NULL);
+}
+
+guint g_at_chat_send_full(GAtChat *chat, const char *cmd,
+				const char **prefix_list,
+				GAtSubmitNotifyFunc submit_notify,
+				GAtResultFunc result_notify,
+				gpointer user_data,
+				GDestroyNotify destroy_notify)
+{
+	return send_common(chat, cmd, prefix_list, FALSE, submit_notify, NULL,
+				result_notify, user_data, destroy_notify);
 }
 =

 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index ea6626e..4179ca5 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -37,6 +37,7 @@ typedef struct _GAtChat GAtChat;
 typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
 				gpointer user_data);
 typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
+typedef void (*GAtSubmitNotifyFunc)(guint id, gpointer user_data);
 =

 GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *syntax);
 GAtChat *g_at_chat_new_blocking(GIOChannel *channel, GAtSyntax *syntax);
@@ -91,7 +92,7 @@ gboolean g_at_chat_set_debug(GAtChat *chat,
  */
 guint g_at_chat_send(GAtChat *chat, const char *cmd,
 				const char **valid_resp, GAtResultFunc func,
-				gpointer user_data, GDestroyNotify notify);
+				gpointer user_data);
 =

 /*!
  * Same as the above command, except that the caller wishes to receive the
@@ -103,7 +104,7 @@ guint g_at_chat_send(GAtChat *chat, const char *cmd,
 guint g_at_chat_send_listing(GAtChat *chat, const char *cmd,
 				const char **valid_resp,
 				GAtNotifyFunc listing, GAtResultFunc func,
-				gpointer user_data, GDestroyNotify notify);
+				gpointer user_data);
 =

 /*!
  * Same as g_at_chat_send_listing except every response line in valid_resp
@@ -115,7 +116,23 @@ guint g_at_chat_send_listing(GAtChat *chat, const char=
 *cmd,
 guint g_at_chat_send_pdu_listing(GAtChat *chat, const char *cmd,
 				const char **valid_resp,
 				GAtNotifyFunc listing, GAtResultFunc func,
-				gpointer user_data, GDestroyNotify notify);
+				gpointer user_data);
+
+/*!
+ * Same as g_at_chat_send with an optional callback to destroy user_data
+ * and an optional notification at the moment the command finally leaves
+ * the queue and is submitted to lower layer.
+ *
+ * This parameter is useful for cases where the modem's response time
+ * needs to be measured, assuming that the lower layers processing time
+ * is shorter than the minimum accuracy needed.
+ */
+guint g_at_chat_send_full(GAtChat *chat, const char *cmd,
+				const char **valid_resp,
+				GAtSubmitNotifyFunc submit_notify,
+				GAtResultFunc result_notify,
+				gpointer user_data,
+				GDestroyNotify destroy_notify);
 =

 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index ea87c21..1a91d09 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -833,7 +833,7 @@ static void mux_query_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	sprintf(buf, "AT+CMUX=3D%u,0,%u,%u", msd->mode, speed, msd->frame_size);
 =

-	if (g_at_chat_send(msd->chat, buf, none_prefix,
+	if (g_at_chat_send_full(msd->chat, buf, none_prefix, NULL,
 				mux_setup_cb, nmsd, msd_free) > 0)
 		return;
 =

@@ -865,7 +865,7 @@ gboolean g_at_mux_setup_gsm0710(GAtChat *chat,
 	msd->user =3D user_data;
 	msd->destroy =3D destroy;
 =

-	if (g_at_chat_send(chat, "AT+CMUX=3D?", cmux_prefix,
+	if (g_at_chat_send_full(chat, "AT+CMUX=3D?", cmux_prefix, NULL,
 				mux_query_cb, msd, msd_free) > 0)
 		return TRUE;
 =

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a531aa3..903222f 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -110,7 +110,7 @@ static gboolean signal_cb(GIOChannel *channel, GIOCondi=
tion cond, gpointer data)
 				char buf[64];
 				sprintf(buf, "AT+CFUN=3D%u", option_offmode);
 				g_at_chat_send(control, buf, none_prefix,
-						power_down, NULL, NULL);
+						power_down, NULL);
 			} else
 				g_at_ppp_shutdown(ppp);
 		}
@@ -293,7 +293,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	else
 		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", option_cid);
 =

-	g_at_chat_send(modem, buf, none_prefix, connect_cb, NULL, NULL);
+	g_at_chat_send(modem, buf, none_prefix, connect_cb, NULL);
 }
 =

 static void setup_context(int status)
@@ -308,7 +308,7 @@ static void setup_context(int status)
 =

 	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", option_cid);
 	snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", option_apn);
-	g_at_chat_send(control, buf, none_prefix, at_cgdcont_cb, NULL, NULL);
+	g_at_chat_send(control, buf, none_prefix, at_cgdcont_cb, NULL);
 }
 =

 static void cgreg_notify(GAtResult *result, gpointer user_data)
@@ -353,8 +353,7 @@ static void attached_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if (!ok)
 		return;
 =

-	g_at_chat_send(control, "AT+CGREG?", cgreg_prefix,
-						cgreg_cb, NULL, NULL);
+	g_at_chat_send(control, "AT+CGREG?", cgreg_prefix, cgreg_cb, NULL);
 }
 =

 static void activate_gprs(int status)
@@ -364,8 +363,7 @@ static void activate_gprs(int status)
 					status =3D=3D 5 ? "true" : "false");
 =

 	g_print("Activating GPRS network...\n");
-	g_at_chat_send(control, "AT+CGATT=3D1", none_prefix,
-						attached_cb, NULL, NULL);
+	g_at_chat_send(control, "AT+CGATT=3D1", none_prefix, attached_cb, NULL);
 }
 =

 static void creg_notify(GAtResult *result, gpointer user_data)
@@ -415,8 +413,7 @@ static void register_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	state =3D STATE_REGISTERING;
 	g_print("Waiting for network registration...\n");
 =

-	g_at_chat_send(control, "AT+CREG?", creg_prefix,
-						creg_cb, NULL, NULL);
+	g_at_chat_send(control, "AT+CREG?", creg_prefix, creg_cb, NULL);
 }
 =

 static void start_dial(gboolean ok, GAtResult *result, gpointer user_data)
@@ -426,11 +423,10 @@ static void start_dial(gboolean ok, GAtResult *result=
, gpointer user_data)
 		exit(1);
 	}
 =

-	g_at_chat_send(control, "AT+CREG=3D2", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(control, "AT+CGREG=3D2", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(control, "AT+CREG=3D2", none_prefix, NULL, NULL);
+	g_at_chat_send(control, "AT+CGREG=3D2", none_prefix, NULL, NULL);
 =

-	g_at_chat_send(control, "AT+COPS=3D0", none_prefix,
-						register_cb, NULL, NULL);
+	g_at_chat_send(control, "AT+COPS=3D0", none_prefix, register_cb, NULL);
 }
 =

 static void check_pin(gboolean ok, GAtResult *result, gpointer user_data)
@@ -440,7 +436,7 @@ static void check_pin(gboolean ok, GAtResult *result, g=
pointer user_data)
 		exit(1);
 	}
 =

-	g_at_chat_send(control, "AT+CPIN?", NULL, start_dial, NULL, NULL);
+	g_at_chat_send(control, "AT+CPIN?", NULL, start_dial, NULL);
 }
 =

 static void check_mode(gboolean ok, GAtResult *result, gpointer user_data)
@@ -463,7 +459,7 @@ static void check_mode(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	g_at_chat_send(control, "AT+CFUN=3D1", NULL, check_pin, NULL, NULL);
+	g_at_chat_send(control, "AT+CFUN=3D1", NULL, check_pin, NULL);
 }
 =

 static int open_serial()
@@ -657,9 +653,8 @@ int main(int argc, char **argv)
 =

 	event_loop =3D g_main_loop_new(NULL, FALSE);
 =

-	g_at_chat_send(control, "ATE0Q0V1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(control, "AT+CFUN?", cfun_prefix,
-						check_mode, NULL, NULL);
+	g_at_chat_send(control, "ATE0Q0V1", NULL, NULL, NULL);
+	g_at_chat_send(control, "AT+CFUN?", cfun_prefix, check_mode, NULL);
 =

 	g_main_loop_run(event_loop);
 	g_source_remove(signal_source);
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 60f3242..4dcbc0f 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -172,24 +172,21 @@ static void setup_modem(struct ofono_modem *modem)
 =

 	/* Generate unsolicited notifications as soon as they're generated */
 	for (i =3D 0; i < NUM_DLC; i++) {
-		g_at_chat_send(data->dlcs[i], "ATE0", NULL, NULL, NULL, NULL);
-		g_at_chat_send(data->dlcs[i], "AT%CUNS=3D0",
-				NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->dlcs[i], "ATE0", NULL, NULL, NULL);
+		g_at_chat_send(data->dlcs[i], "AT%CUNS=3D0", NULL, NULL, NULL);
 	}
 =

 	/* CSTAT tells us when SMS & Phonebook are ready to be used */
 	g_at_chat_register(data->dlcs[SETUP_DLC], "%CSTAT:", cstat_notify,
 				FALSE, modem, NULL);
-	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%CSTAT=3D1", NULL,
-				NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%CSTAT=3D1", NULL, NULL, NULL);
 =

 	/* audio side tone: set to minimum */
 	g_at_chat_send(data->dlcs[SETUP_DLC], "AT(a)ST=3D\"-26\"", NULL,
-			NULL, NULL, NULL);
+			NULL, NULL);
 =

 	/* Disable deep sleep */
-	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%SLEEP=3D2", NULL,
-			NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%SLEEP=3D2", NULL, NULL, NULL);
 }
 =

 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -255,7 +252,7 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 	}
 =

 	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem, NULL);
+					cfun_set_on_cb, modem);
 }
 =

 static void modem_initialize(struct ofono_modem *modem)
@@ -304,7 +301,7 @@ static void modem_initialize(struct ofono_modem *modem)
 =

 	g_at_chat_set_wakeup_command(chat, "AT\r", 500, 5000);
 =

-	g_at_chat_send(chat, "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "ATE0", NULL, NULL, NULL);
 =

 	g_at_mux_setup_gsm0710(chat, mux_setup, modem, NULL);
 	g_at_chat_unref(chat);
diff --git a/plugins/em770.c b/plugins/em770.c
index de82f94..6ddb840 100644
--- a/plugins/em770.c
+++ b/plugins/em770.c
@@ -129,10 +129,9 @@ static int em770_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, em770_debug, NULL);
 =

-	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_enable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem);
 =

 	return 0;
 }
@@ -162,8 +161,7 @@ static int em770_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
-					cfun_disable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL, cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/g1.c b/plugins/g1.c
index fa96eb1..7487a8a 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -117,10 +117,10 @@ static int g1_enable(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, chat);
 =

 	/* ensure modem is in a known state; verbose on, echo/quiet off */
-	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL);
 =

 	/* power up modem */
-	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
+	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem);
 =

 	return 0;
 }
@@ -148,7 +148,7 @@ static int g1_disable(struct ofono_modem *modem)
 	/* power down modem */
 	g_at_chat_cancel_all(chat);
 	g_at_chat_unregister_all(chat);
-	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem, NULL);
+	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..98a8d8c 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -102,7 +102,7 @@ static void sevice_level_conn_established(struct ofono_=
modem *modem)
 =

 	ofono_info("Service level connection established");
 =

-	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL);
 }
 =

 static void service_level_conn_failed(struct ofono_modem *modem)
@@ -178,7 +178,7 @@ static void cmer_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 	if (data->ag_features & AG_FEATURE_3WAY)
 		g_at_chat_send(data->chat, "AT+CHLD=3D?", chld_prefix,
-			chld_cb, modem, NULL);
+			chld_cb, modem);
 	else
 		sevice_level_conn_established(modem);
 }
@@ -391,7 +391,7 @@ static void cind_status_cb(gboolean ok, GAtResult *resu=
lt,
 	}
 =

 	g_at_chat_send(data->chat, "AT+CMER=3D3,0,0,1", cmer_prefix,
-				cmer_cb, modem, NULL);
+				cmer_cb, modem);
 	return;
 =

 error:
@@ -451,7 +451,7 @@ static void cind_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	}
 =

 	g_at_chat_send(data->chat, "AT+CIND?", cind_prefix,
-			cind_status_cb, modem, NULL);
+			cind_status_cb, modem);
 	return;
 =

 error:
@@ -474,8 +474,7 @@ static void brsf_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 	g_at_result_iter_next_number(&iter, (gint *)&data->ag_features);
 =

-	g_at_chat_send(data->chat, "AT+CIND=3D?", cind_prefix,
-				cind_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CIND=3D?", cind_prefix, cind_cb, modem);
 	return;
 =

 error:
@@ -520,8 +519,7 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 		g_at_chat_set_debug(chat, hfp_debug, NULL);
 =

 	snprintf(buf, sizeof(buf), "AT+BRSF=3D%d", data->hf_features);
-	g_at_chat_send(chat, buf, brsf_prefix,
-				brsf_cb, modem, NULL);
+	g_at_chat_send(chat, buf, brsf_prefix, brsf_cb, modem);
 	data->chat =3D chat;
 =

 	return -EINPROGRESS;
diff --git a/plugins/hso.c b/plugins/hso.c
index dd9be67..1aa4ed1 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -149,11 +149,11 @@ static int hso_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->app, hso_debug, "App:");
 =

-	g_at_chat_send(data->control, "ATE0", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(data->app, "ATE0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->control, "ATE0", none_prefix, NULL, NULL);
+	g_at_chat_send(data->app, "ATE0", none_prefix, NULL, NULL);
 =

 	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
-					cfun_enable, modem, NULL);
+					cfun_enable, modem);
 =

 	return -EINPROGRESS;
 }
@@ -188,7 +188,7 @@ static int hso_disable(struct ofono_modem *modem)
 	data->app =3D NULL;
 =

 	g_at_chat_send(data->control, "AT+CFUN=3D0", none_prefix,
-					cfun_disable, modem, NULL);
+					cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/huawei.c b/plugins/huawei.c
index df4d177..13b209a 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -120,10 +120,9 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
 =

-	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_enable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem);
 =

 	return 0;
 }
@@ -153,8 +152,7 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
-					cfun_disable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL, cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/mbm.c b/plugins/mbm.c
index c67c7a5..53bd7ae 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -129,7 +129,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	if (status =3D=3D 4) {
 		g_at_chat_send(data->modem_port, "AT+CFUN=3D1", none_prefix,
-				cfun_enable, modem, NULL);
+				cfun_enable, modem);
 		return;
 	}
 =

@@ -156,7 +156,7 @@ static void emrdy_notifier(GAtResult *result, gpointer =
user_data)
 		return;
 =

 	g_at_chat_send(data->modem_port, "AT+CFUN?", cfun_prefix,
-					cfun_query, modem, NULL);
+					cfun_query, modem);
 }
 =

 static void emrdy_query(gboolean ok, GAtResult *result, gpointer user_data)
@@ -175,7 +175,7 @@ static void emrdy_query(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	 * triggered eventually and we send CFUN? again.
 	 */
 	g_at_chat_send(data->modem_port, "AT+CFUN?", cfun_prefix,
-					cfun_query, modem, NULL);
+					cfun_query, modem);
 };
 =

 static GAtChat *create_port(const char *device)
@@ -239,9 +239,9 @@ static int mbm_enable(struct ofono_modem *modem)
 					FALSE, modem, NULL);
 =

 	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", NULL,
-					NULL, NULL, NULL);
+					NULL, NULL);
 	g_at_chat_send(data->modem_port, "AT*EMRDY?", none_prefix,
-				emrdy_query, modem, NULL);
+				emrdy_query, modem);
 =

 	return -EINPROGRESS;
 }
@@ -275,7 +275,7 @@ static int mbm_disable(struct ofono_modem *modem)
 	g_at_chat_cancel_all(data->modem_port);
 	g_at_chat_unregister_all(data->modem_port);
 	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", NULL,
-					cfun_disable, modem, NULL);
+					cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/novatel.c b/plugins/novatel.c
index 792e17f..959b855 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -113,8 +113,7 @@ static int novatel_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, novatel_debug, NULL);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_enable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem);
 =

 	return 0;
 }
@@ -144,8 +143,7 @@ static int novatel_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
-					cfun_disable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL, cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 7d2aeb4..08ba3fd 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -129,11 +129,10 @@ static int palmpre_enable(struct ofono_modem *modem)
 		g_at_chat_set_debug(data->chat, palmpre_debug, NULL);
 =

 	/* Ensure terminal is in a known state */
-	g_at_chat_send(data->chat, "ATZ E0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "ATZ E0 +CMEE=3D1", NULL, NULL, NULL);
 =

 	/* Power modem up */
-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-			cfun_set_on_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem);
 =

 	return 0;
 }
@@ -161,8 +160,7 @@ static int palmpre_disable(struct ofono_modem *modem)
 	/* Power modem down */
 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
-			cfun_set_off_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..488dd47 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -163,8 +163,7 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 	if (data->calypso)
 		g_at_chat_set_wakeup_command(data->chat, "AT\r", 500, 5000);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem);
 }
 =

 static int phonesim_enable(struct ofono_modem *modem)
@@ -237,10 +236,9 @@ static int phonesim_enable(struct ofono_modem *modem)
 	if (data->calypso) {
 		g_at_chat_set_wakeup_command(data->chat, "AT\r", 500, 5000);
 =

-		g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL);
 =

-		g_at_chat_send(data->chat, "AT%CUNS=3D0",
-				NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->chat, "AT%CUNS=3D0", NULL, NULL, NULL);
 	}
 =

 	if (data->use_mux) {
@@ -249,7 +247,7 @@ static int phonesim_enable(struct ofono_modem *modem)
 		data->chat =3D NULL;
 	} else {
 		g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem, NULL);
+					cfun_set_on_cb, modem);
 	}
 =

 	return -EINPROGRESS;
diff --git a/plugins/ste.c b/plugins/ste.c
index f3ae0b2..71a9805 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -167,8 +167,8 @@ static int ste_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, ste_debug, NULL);
 =

-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem);
 =

 	return -EINPROGRESS;
 }
@@ -198,8 +198,7 @@ static int ste_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
-					cfun_disable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_disable, modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/unit/test-caif.c b/unit/test-caif.c
index 51e29bc..007a473 100644
--- a/unit/test-caif.c
+++ b/unit/test-caif.c
@@ -130,7 +130,7 @@ static void test_connect(gboolean use_socket)
 	}
 =

 	g_at_chat_set_debug(chat, caif_debug, NULL);
-	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL, caif_init, chat, NULL);
+	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL, caif_init, chat);
 =

 	mainloop =3D g_main_loop_new(NULL, FALSE);
 =

diff --git a/unit/test-mux.c b/unit/test-mux.c
index e80b47c..2bf8139 100644
--- a/unit/test-mux.c
+++ b/unit/test-mux.c
@@ -124,8 +124,8 @@ static void mux_setup(GAtMux *m, gpointer data)
 =

 	g_at_chat_set_debug(chat, mux_debug, "CHAT1");
 	g_at_chat_set_wakeup_command(chat, "\r", 1000, 5000);
-	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat, NULL);
+	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat);
 =

 	io =3D g_at_mux_create_channel(mux);
 	syntax =3D g_at_syntax_new_gsm_permissive();
@@ -135,8 +135,8 @@ static void mux_setup(GAtMux *m, gpointer data)
 =

 	g_at_chat_set_debug(chat, mux_debug, "CHAT2");
 	g_at_chat_set_wakeup_command(chat, "\r", 1000, 5000);
-	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat, NULL);
+	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat);
 =

 	io =3D g_at_mux_create_channel(mux);
 	syntax =3D g_at_syntax_new_gsm_permissive();
@@ -146,8 +146,8 @@ static void mux_setup(GAtMux *m, gpointer data)
 =

 	g_at_chat_set_debug(chat, mux_debug, "CHAT3");
 	g_at_chat_set_wakeup_command(chat, "\r", 1000, 5000);
-	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat, NULL);
+	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat);
 =

 	io =3D g_at_mux_create_channel(mux);
 	syntax =3D g_at_syntax_new_gsm_permissive();
@@ -157,8 +157,8 @@ static void mux_setup(GAtMux *m, gpointer data)
 =

 	g_at_chat_set_debug(chat, mux_debug, "CHAT4");
 	g_at_chat_set_wakeup_command(chat, "\r", 1000, 5000);
-	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat, NULL);
+	g_at_chat_send(chat, "AT+CGMI", NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGMR", NULL, chat_callback, chat);
 =

 	g_timeout_add_seconds(7, cleanup_callback, NULL);
 }
@@ -208,7 +208,7 @@ static void test_mux(void)
 =

 	g_at_chat_set_debug(chat, mux_debug, "MUX");
 	g_at_chat_set_wakeup_command(chat, "\r", 1000, 5000);
-	g_at_chat_send(chat, "ATE0", NULL, mux_init, chat, NULL);
+	g_at_chat_send(chat, "ATE0", NULL, mux_init, chat);
 =

 	mainloop =3D g_main_loop_new(NULL, FALSE);
 =

-- =

1.6.1


--===============0132518431753199621==--

