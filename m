Content-Type: multipart/mixed; boundary="===============8197325585829601041=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH v4 1/2] voicecall: api for set/clear alpha and icon id
Date: Mon, 25 Jul 2011 11:15:26 -0700
Message-ID: <1311617727-10294-2-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1311617727-10294-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8197325585829601041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h     |    6 +++++
 src/voicecall.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6524806..808a8f1 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -266,6 +266,12 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_dial_cb_t cb, void *user_data);
 void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
 =

+void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
+						const char *addr, int addr_type,
+						const char *message,
+						unsigned char icon_id);
+void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *vc);
+
 int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
 				const char *tone_str,
 				ofono_voicecall_tone_cb_t cb, void *user_data);
diff --git a/src/voicecall.c b/src/voicecall.c
index f4c2358..14b5d22 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -42,6 +42,7 @@
 #define MAX_VOICE_CALLS 16
 =

 #define VOICECALL_FLAG_SIM_ECC_READY 0x1
+#define VOICECALL_FLAG_STK_MODEM_CALLSETUP 0x2
 =

 #define SETTINGS_STORE "voicecall"
 #define SETTINGS_GROUP "Settings"
@@ -2223,6 +2224,39 @@ void ofono_voicecall_notify(struct ofono_voicecall *=
vc,
 		goto error;
 	}
 =

+	if (vc->flags & VOICECALL_FLAG_STK_MODEM_CALLSETUP) {
+		struct dial_request *req =3D vc->dial_req;
+		const char *number =3D phone_number_to_string(&req->ph);
+
+		if (!strcmp(number, "112")) {
+			struct ofono_modem *modem =3D
+					__ofono_atom_get_modem(vc->atom);
+
+			__ofono_modem_inc_emergency_mode(modem);
+		}
+
+		if (v->call->clip_validity =3D=3D CLIP_VALIDITY_NOT_AVAILABLE) {
+			v->call->phone_number.type =3D req->ph.type;
+			strncpy(v->call->phone_number.number, req->ph.number,
+									20);
+			v->call->clip_validity =3D CLIP_VALIDITY_VALID;
+		}
+
+		v->message =3D req->message;
+		v->icon_id =3D req->icon_id;
+
+		req->message =3D NULL;
+		req->call =3D v;
+
+		/*
+		 * TS 102 223 Section 6.4.13: The terminal shall not store
+		 * in the UICC the call set-up details (called party number
+		 * and associated parameters)
+		 */
+		v->untracked =3D TRUE;
+		vc->flags &=3D ~VOICECALL_FLAG_STK_MODEM_CALLSETUP;
+	}
+
 	v->detect_time =3D time(NULL);
 =

 	if (!voicecall_dbus_register(v)) {
@@ -3682,6 +3716,37 @@ void __ofono_voicecall_tone_cancel(struct ofono_voic=
ecall *vc, int id)
 	}
 }
 =

+void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
+						const char *addr, int addr_type,
+						const char *message,
+						unsigned char icon_id)
+{
+	struct dial_request *req;
+
+	req =3D g_new0(struct dial_request, 1);
+
+	req->message =3D g_strdup(message);
+	req->icon_id =3D icon_id;
+
+	req->ph.type =3D addr_type;
+	strncpy(req->ph.number, addr, 20);
+
+	vc->dial_req =3D req;
+
+	vc->flags |=3D VOICECALL_FLAG_STK_MODEM_CALLSETUP;
+}
+
+void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *vc)
+{
+	g_free(vc->dial_req->message);
+	vc->dial_req->message =3D NULL;
+
+	g_free(vc->dial_req);
+	vc->dial_req =3D NULL;
+
+	vc->flags &=3D ~VOICECALL_FLAG_STK_MODEM_CALLSETUP;
+}
+
 static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
 					unsigned int id, int code,
 					const struct ofono_phone_number *ph)
-- =

1.7.4.1


--===============8197325585829601041==--

