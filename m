Content-Type: multipart/mixed; boundary="===============5072534689382639350=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3][RfC] atmodem: Handle pauses in DTMF string
Date: Wed, 06 Oct 2010 12:35:03 +0200
Message-ID: <1286361303-8712-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286361303-8712-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5072534689382639350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |  162 +++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 134 insertions(+), 28 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 8b43865..cc75803 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -47,6 +47,9 @@
  /* Amount of time we give for CLIP to arrive before we commence CLCC poll=
 */
 #define CLIP_INTERVAL 200
 =

+ /* When +VTD returns 0, an unspecified manufacturer specific delay is use=
d */
+#define TONE_DURATION 1000
+
 static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -59,6 +62,8 @@ struct voicecall_data {
 	unsigned int clcc_source;
 	GAtChat *chat;
 	unsigned int vendor;
+	struct tone_req *tr;
+	unsigned int tone_duration;
 };
 =

 struct release_id_req {
@@ -75,7 +80,18 @@ struct change_state_req {
 	int affected_types;
 };
 =

+struct tone_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	char *tone_str;
+	char *left;
+	int delay;
+	guint source;
+};
+
 static gboolean poll_clcc(gpointer user_data);
+static gboolean tone_request_run(gpointer user_data);
 =

 static int class_to_call_type(int cls)
 {
@@ -522,52 +538,116 @@ static void at_deflect(struct ofono_voicecall *vc,
 	at_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
 }
 =

-static void vts_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void tone_request_finish(struct tone_req *tr, GAtResult *result, in=
t err)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_voicecall_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(tr->vc);
 =

-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
+	if (tr->source)
+		g_source_remove(tr->source);
+
+	if (result)
+		decode_at_error(&error, g_at_result_final_response(result));
+	else {
+		error.type =3D err ? OFONO_ERROR_TYPE_FAILURE :
+			OFONO_ERROR_TYPE_NO_ERROR;
+		error.error =3D err;
+	}
+
+	tr->cb(&error, tr->data);
+
+	g_free(vd->tr);
+	vd->tr =3D NULL;
 }
 =

-static void at_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
-			ofono_voicecall_cb_t cb, void *data)
+static void vts_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	int len =3D strlen(dtmf);
+	struct tone_req *tr =3D user_data;
+
+	if (!ok) {
+		tone_request_finish(tr, result, 0);
+		return;
+	}
+
+	tr->source =3D g_timeout_add(tr->delay, tone_request_run, tr);
+}
+
+static gboolean tone_request_run(gpointer user_data)
+{
+	struct tone_req *tr =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(tr->vc);
+	static const char *dtmf =3D "0123456789#*ABCDabcd";
+	char buf[2048], *i;
 	int s;
-	int i;
-	char *buf;
 =

-	if (!cbd)
-		goto error;
+	tr->source =3D 0;
 =

-	/* strlen("+VTS=3D\"T\";") =3D 9 + initial AT + null */
-	buf =3D g_try_new(char, len * 9 + 3);
+	if (*tr->left =3D=3D '\0') {
+		tone_request_finish(tr, NULL, 0);
+		return FALSE;
+	}
 =

-	if (!buf)
-		goto error;
+	strcpy(buf, "AT");
+	i =3D buf + 2;
 =

-	s =3D sprintf(buf, "AT+VTS=3D\"%c\"", dtmf[0]);
+	tr->delay =3D 0;
 =

-	for (i =3D 1; i < len; i++)
-		s +=3D sprintf(buf + s, ";+VTS=3D\"%c\"", dtmf[i]);
+	while (*tr->left && strchr(dtmf, *tr->left)) {
+		if (tr->delay)
+			*i++ =3D ';';
+		i +=3D sprintf(i, "+VTS=3D\"%c\"", *tr->left++);
 =

-	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
-				vts_cb, cbd, g_free);
+		tr->delay +=3D vd->tone_duration;
+	}
 =

-	g_free(buf);
+	if (*tr->left && *tr->left !=3D ',') {
+		tone_request_finish(tr, NULL, EINVAL);
+		return FALSE;
+	}
 =

-	if (s > 0)
+	/*
+	 * Wait 3 seconds per PAUSE, same as for DTMF separator characters
+	 * passed in a telephone number according to TS 22.101 A.21,
+	 * although 27.007 claims this delay can be set using S8 and
+	 * defaults to 2 seconds.
+	 */
+	while (*tr->left =3D=3D ',') {
+		tr->left++;
+		tr->delay +=3D 3000;
+	}
+
+	if (i > buf + 2) {
+		s =3D g_at_chat_send(vd->chat, buf, none_prefix, vts_cb,
+					tr, NULL);
+
+		if (s <=3D 0)
+			tone_request_finish(tr, NULL, EIO);
+	} else
+		vts_cb(TRUE, NULL, tr);
+
+	return FALSE;
+}
+
+static void at_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct tone_req *tr =3D g_try_new0(struct tone_req, 1);
+
+	if (!tr || vd->tr) {
+		CALLBACK_WITH_FAILURE(cb, data);
 		return;
+	}
 =

-error:
-	g_free(cbd);
+	tr->vc =3D vc;
+	tr->cb =3D cb;
+	tr->data =3D data;
+	tr->tone_str =3D g_strdup(dtmf);
+	tr->left =3D tr->tone_str;
 =

-	CALLBACK_WITH_FAILURE(cb, data);
+	vd->tr =3D tr;
+
+	tone_request_run(tr);
 }
 =

 static void ring_notify(GAtResult *result, gpointer user_data)
@@ -800,6 +880,26 @@ static void busy_notify(GAtResult *result, gpointer us=
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
@@ -840,12 +940,15 @@ static int at_voicecall_probe(struct ofono_voicecall =
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

@@ -859,6 +962,9 @@ static void at_voicecall_remove(struct ofono_voicecall =
*vc)
 	if (vd->clcc_source)
 		g_source_remove(vd->clcc_source);
 =

+	if (vd->tr)
+		tone_request_finish(vd->tr, NULL, ESHUTDOWN);
+
 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
 =

-- =

1.7.1.86.g0e460.dirty


--===============5072534689382639350==--

