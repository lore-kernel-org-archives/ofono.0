Content-Type: multipart/mixed; boundary="===============3086502223241604801=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2][RfC] voicecall: __ofono_voicecall_send_tone internal api.
Date: Wed, 08 Sep 2010 19:59:54 +0200
Message-ID: <1283968796-5308-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1283968796-5308-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3086502223241604801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides a way for other atoms to send DTMF tones during a call.
---
 src/ofono.h     |    6 +++
 src/voicecall.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 142 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index d95f2f2..ce734c5 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -182,6 +182,7 @@ enum ofono_voicecall_interaction {
 };
 =

 typedef void (*ofono_voicecall_dial_cb_t)(struct ofono_call *call, void *d=
ata);
+typedef void (*ofono_voicecall_tone_cb_t)(int error, void *data);
 =

 ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
 					enum ofono_voicecall_interaction type);
@@ -193,6 +194,11 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_dial_cb_t cb, void *user_data);
 void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
 =

+int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_tone_cb_t cb, void *user_data);
+void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc);
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/voicecall.c b/src/voicecall.c
index a5ee2ed..3bd4dff 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -59,6 +59,7 @@ struct ofono_voicecall {
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct dial_request *dial_req;
+	struct tone_request *tone_req;
 };
 =

 struct voicecall {
@@ -82,12 +83,22 @@ struct dial_request {
 	struct ofono_phone_number ph;
 };
 =

+struct tone_request {
+	char *tone_str;
+	char *left;
+	int delay;
+	guint source;
+	ofono_voicecall_tone_cb_t cb;
+	void *user_data;
+};
+
 static const char *default_en_list[] =3D { "911", "112", NULL };
 static const char *default_en_list_no_sim[] =3D { "119", "118", "999", "11=
0",
 						"08", "000", NULL };
 =

 static void generic_callback(const struct ofono_error *error, void *data);
 static void multirelease_callback(const struct ofono_error *err, void *dat=
a);
+static gboolean tone_request_run(gpointer user_data);
 =

 static gint call_compare_by_id(gconstpointer a, gconstpointer b)
 {
@@ -229,6 +240,22 @@ static void dial_request_finish(struct ofono_voicecall=
 *vc, gboolean callback)
 	vc->dial_req =3D NULL;
 }
 =

+static void tone_request_finish(struct ofono_voicecall *vc, int error)
+{
+	struct tone_request *tone_req =3D vc->tone_req;
+
+	vc->tone_req =3D NULL;
+
+	if (tone_req->cb)
+		tone_req->cb(-error, tone_req->user_data);
+
+	if (tone_req->source)
+		g_source_remove(tone_req->source);
+
+	g_free(tone_req->tone_str);
+	g_free(tone_req);
+}
+
 static void append_voicecall_properties(struct voicecall *v,
 					DBusMessageIter *dict)
 {
@@ -574,6 +601,9 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
 			call =3D=3D call->vc->dial_req->call)
 		dial_request_finish(call->vc, TRUE);
+
+	if (old_status =3D=3D CALL_STATUS_ACTIVE && call->vc->tone_req)
+		tone_request_finish(call->vc, ENOENT);
 }
 =

 static void voicecall_set_call_lineid(struct voicecall *v,
@@ -1956,6 +1986,9 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 	if (vc->dial_req)
 		dial_request_finish(vc, TRUE);
 =

+	if (vc->tone_req)
+		tone_request_finish(vc, ENOENT);
+
 	for (l =3D vc->call_list; l; l =3D l->next)
 		voicecall_dbus_unregister(vc, l->data);
 =

@@ -2311,3 +2344,106 @@ void __ofono_voicecall_dial_cancel(struct ofono_voi=
cecall *vc)
 =

 	vc->dial_req->cb =3D NULL;
 }
+
+static void tone_request_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (!vc->tone_req)
+		return;
+
+	if (error && error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("command failed with error: %s",
+				telephony_error_to_str(error));
+
+		tone_request_finish(vc, EIO);
+		return;
+	}
+
+	vc->tone_req->source =3D g_timeout_add_seconds(vc->tone_req->delay,
+							tone_request_run, vc);
+}
+
+static gboolean tone_request_run(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	static const char *dtmf =3D "0123456789ABDEFabdef";
+	char tones[256], *i;
+
+	if (!vc->tone_req)
+		return FALSE;
+
+	vc->tone_req->source =3D 0;
+
+	if (*vc->tone_req->left =3D=3D '\0') {
+		tone_request_finish(vc, 0);
+		return FALSE;
+	}
+
+	i =3D tones;
+	vc->tone_req->delay =3D 0;
+
+	/* Wait 3 seconds per tone */
+	while (*vc->tone_req->left && strchr(dtmf, *vc->tone_req->left)) {
+		*i++ =3D *vc->tone_req->left++;
+		vc->tone_req->delay +=3D 3;
+	}
+
+	while (*vc->tone_req->left && *vc->tone_req->left !=3D 'c') {
+		tone_request_finish(vc, EINVAL);
+		return FALSE;
+	}
+
+	while (*vc->tone_req->left =3D=3D 'c') {
+		vc->tone_req->left++;
+		vc->tone_req->delay +=3D 3;
+	}
+
+	if (i > tones) {
+		*i =3D '\0';
+
+		vc->driver->send_tones(vc, tones, tone_request_cb, vc);
+	} else
+		tone_request_cb(NULL, vc);
+
+	return FALSE;
+}
+
+int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_tone_cb_t cb, void *user_data)
+{
+	struct tone_request *req;
+
+	if (!vc->driver->send_tones)
+		return -ENOSYS;
+
+	/* Send DTMFs only if we have at least one connected call */
+	if (!voicecalls_can_dtmf(vc))
+		return -ENOENT;
+
+	if (vc->tone_req)
+		return -EBUSY;
+
+	req =3D g_try_new0(struct tone_request, 1);
+	req->tone_str =3D g_strdup(tone_str);
+	req->left =3D req->tone_str;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	vc->tone_req =3D req;
+
+	tone_request_run(vc);
+
+	return 0;
+}
+
+void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc)
+{
+	if (!vc->tone_req || !vc->tone_req->cb)
+		return;
+
+	vc->tone_req->cb =3D NULL;
+
+	tone_request_finish(vc, 0);
+}
-- =

1.7.1.86.g0e460.dirty


--===============3086502223241604801==--

