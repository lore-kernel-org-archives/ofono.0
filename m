Content-Type: multipart/mixed; boundary="===============6100632147225438470=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] atmodem: Delay return from send_dtmf
Date: Thu, 21 Oct 2010 07:09:07 +0200
Message-ID: <1287637748-7230-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1287637748-7230-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6100632147225438470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+VTS responds with an OK immediately, so add a wait in the driver
before returning so that core knows when the tone has finished.  Note
that some modems actually do wait against 27.007, and other modems
use a manufacturer specific AT command and the drivers will need to
handle accordingly.
---
 drivers/atmodem/voicecall.c |   63 +++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index b3c658f..10b8f4b 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -47,6 +47,9 @@
  /* Amount of time we give for CLIP to arrive before we commence CLCC poll=
 */
 #define CLIP_INTERVAL 200
 =

+ /* When +VTD returns 0, an unspecified manufacturer-specific delay is use=
d */
+#define TONE_DURATION 1000
+
 static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -59,6 +62,9 @@ struct voicecall_data {
 	unsigned int clcc_source;
 	GAtChat *chat;
 	unsigned int vendor;
+	unsigned int tone_duration;
+	guint vts_source;
+	unsigned int vts_delay;
 };
 =

 struct release_id_req {
@@ -522,14 +528,37 @@ static void at_deflect(struct ofono_voicecall *vc,
 	at_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
 }
 =

+static gboolean vts_timeout_cb(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct voicecall_data *vd =3D cbd->user;
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+
+	vd->vts_source =3D 0;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	g_free(cbd);
+
+	return FALSE;
+}
+
 static void vts_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
+	struct voicecall_data *vd =3D cbd->user;
 	ofono_voicecall_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
+
+	if (!ok) {
+		cb(&error, cbd->data);
+
+		g_free(cbd);
+		return;
+	}
+
+	vd->vts_source =3D g_timeout_add(vd->vts_delay, vts_timeout_cb, cbd);
 }
 =

 static void at_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
@@ -545,6 +574,8 @@ static void at_send_dtmf(struct ofono_voicecall *vc, co=
nst char *dtmf,
 	if (!cbd)
 		goto error;
 =

+	cbd->user =3D vd;
+
 	/* strlen("+VTS=3DT;") =3D 7 + initial AT + null */
 	buf =3D g_try_new(char, len * 9 + 3);
 	if (!buf)
@@ -555,8 +586,10 @@ static void at_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 	for (i =3D 1; i < len; i++)
 		s +=3D sprintf(buf + s, ";+VTS=3D%c", dtmf[i]);
 =

+	vd->vts_delay =3D vd->tone_duration * len;
+
 	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
-				vts_cb, cbd, g_free);
+				vts_cb, cbd, NULL);
 =

 	g_free(buf);
 =

@@ -799,6 +832,26 @@ static void busy_notify(GAtResult *result, gpointer us=
er_data)
 			clcc_poll_cb, vc, NULL);
 }
 =

+static void vtd_query_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	int duration;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "+VTD:");
+
+	if (!g_at_result_iter_next_number(&iter, &duration))
+		return;
+
+	if (duration)
+		vd->tone_duration =3D duration * 100;
+}
+
 static void at_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -839,12 +892,15 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 =

 	vd->chat =3D g_at_chat_clone(chat);
 	vd->vendor =3D vendor;
+	vd->tone_duration =3D TONE_DURATION;
 =

 	ofono_voicecall_set_data(vc, vd);
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+VTD?", NULL,
+				vtd_query_cb, vc, NULL);
 	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL,
 				at_voicecall_initialized, vc, NULL);
 =

@@ -858,6 +914,9 @@ static void at_voicecall_remove(struct ofono_voicecall =
*vc)
 	if (vd->clcc_source)
 		g_source_remove(vd->clcc_source);
 =

+	if (vd->vts_source)
+		g_source_remove(vd->vts_source);
+
 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
 =

-- =

1.7.1.86.g0e460.dirty


--===============6100632147225438470==--

