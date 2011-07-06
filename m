Content-Type: multipart/mixed; boundary="===============1693640388277181947=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Wed, 06 Jul 2011 03:06:11 -0700
Message-ID: <1309946773-7747-3-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1309946773-7747-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1693640388277181947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h     |    5 +++++
 src/voicecall.c |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6524806..118d762 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -266,6 +266,11 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_dial_cb_t cb, void *user_data);
 void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
 =

+void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
+						const char *message,
+						unsigned char icon_id);
+void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *vc);
+
 int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
 				const char *tone_str,
 				ofono_voicecall_tone_cb_t cb, void *user_data);
diff --git a/src/voicecall.c b/src/voicecall.c
index 9620838..b193d61 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -74,6 +74,8 @@ struct ofono_voicecall {
 	struct dial_request *dial_req;
 	GQueue *toneq;
 	guint tone_source;
+	char *message;
+	uint8_t icon_id;
 	unsigned int hfp_watch;
 	GKeyFile *settings;
 	char *imsi;
@@ -656,6 +658,11 @@ static struct voicecall *voicecall_create(struct ofono=
_voicecall *vc,
 	v->call =3D call;
 	v->vc =3D vc;
 =

+	if (vc->message !=3D NULL) {
+		v->message =3D g_strdup(vc->message);
+		v->icon_id =3D vc->icon_id;
+	}
+
 	return v;
 }
 =

@@ -3538,6 +3545,20 @@ void __ofono_voicecall_tone_cancel(struct ofono_voic=
ecall *vc, int id)
 	}
 }
 =

+void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
+						const char *message,
+						unsigned char icon_id)
+{
+	vc->message =3D g_strdup(message);
+	vc->icon_id =3D icon_id;
+}
+
+void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *vc)
+{
+	g_free(vc->message);
+	vc->icon_id =3D 0;
+}
+
 static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
 					unsigned int id, int code,
 					const struct ofono_phone_number *ph)
-- =

1.7.4.1


--===============1693640388277181947==--

