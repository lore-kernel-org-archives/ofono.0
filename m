Content-Type: multipart/mixed; boundary="===============8806959537633743750=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 04/11] hfpmodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:37 -0800
Message-ID: <1296308084-3726-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8806959537633743750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/call-volume.c          |    8 --------
 drivers/hfpmodem/network-registration.c |   12 ------------
 drivers/hfpmodem/voicecall.c            |    4 ----
 3 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 19f57c4..ee4e352 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -73,9 +73,6 @@ static void hfp_speaker_volume(struct ofono_call_volume *=
cv,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	vd->sp_volume =3D percent;
 =

 	snprintf(buf, sizeof(buf), "AT+VGS=3D%d",
@@ -85,7 +82,6 @@ static void hfp_speaker_volume(struct ofono_call_volume *=
cv,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -100,9 +96,6 @@ static void hfp_microphone_volume(struct ofono_call_volu=
me *cv,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	vd->mic_volume =3D percent;
 =

 	snprintf(buf, sizeof(buf), "AT+VGM=3D%d",
@@ -112,7 +105,6 @@ static void hfp_microphone_volume(struct ofono_call_vol=
ume *cv,
 				cv_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 273490e..23852e7 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -236,9 +236,6 @@ static void hfp_registration_status(struct ofono_netreg=
 *netreg,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	gboolean ok;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D netreg;
 =

 	ok =3D g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
@@ -246,7 +243,6 @@ static void hfp_registration_status(struct ofono_netreg=
 *netreg,
 	if (ok)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, data);
@@ -259,9 +255,6 @@ static void hfp_current_operator(struct ofono_netreg *n=
etreg,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	gboolean ok;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D netreg;
 =

 	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,0", NULL,
@@ -274,7 +267,6 @@ static void hfp_current_operator(struct ofono_netreg *n=
etreg,
 	if (ok)
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

@@ -284,16 +276,12 @@ static void hfp_signal_strength(struct ofono_netreg *=
netreg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D netreg;
 =

 	if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
 				signal_strength_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d12a5ef..b9bee62 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -362,9 +362,6 @@ static void hfp_dial(struct ofono_voicecall *vc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[256];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vc;
 	if (ph->type =3D=3D 145)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
@@ -377,7 +374,6 @@ static void hfp_dial(struct ofono_voicecall *vc,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4


--===============8806959537633743750==--

