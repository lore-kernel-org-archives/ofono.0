Content-Type: multipart/mixed; boundary="===============2697794565764764884=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/4] modem: move dial_request_cb function
Date: Sat, 13 Nov 2010 18:33:51 +0200
Message-ID: <2fa15bac2d8cb29d57b4f3d63656094214b33a7f.1289664478.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289664478.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2697794565764764884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   70 +++++++++++++++++++++++++++------------------------=
---
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..3af614b 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2202,6 +2202,41 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void dial_request_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	gboolean need_to_emit;
+	struct voicecall *v;
+
+	v =3D dial_handle_result(vc, error,
+				phone_number_to_string(&vc->dial_req->ph),
+				&need_to_emit);
+
+	if (v =3D=3D NULL) {
+		dial_request_finish(vc);
+		return;
+	}
+
+	v->message =3D vc->dial_req->message;
+	v->icon_id =3D vc->dial_req->icon_id;
+
+	vc->dial_req->message =3D NULL;
+	vc->dial_req->call =3D v;
+
+	/*
+	 * TS 102 223 Section 6.4.13: The terminal shall not store
+	 * in the UICC the call set-up details (called party number
+	 * and associated parameters)
+	 */
+	v->untracked =3D TRUE;
+
+	if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
+		dial_request_finish(vc);
+
+	if (need_to_emit)
+		voicecalls_emit_call_added(vc, v);
+}
+
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2294,41 +2329,6 @@ ofono_bool_t __ofono_voicecall_is_busy(struct ofono_=
voicecall *vc,
 	return TRUE;
 }
 =

-static void dial_request_cb(const struct ofono_error *error, void *data)
-{
-	struct ofono_voicecall *vc =3D data;
-	gboolean need_to_emit;
-	struct voicecall *v;
-
-	v =3D dial_handle_result(vc, error,
-				phone_number_to_string(&vc->dial_req->ph),
-				&need_to_emit);
-
-	if (v =3D=3D NULL) {
-		dial_request_finish(vc);
-		return;
-	}
-
-	v->message =3D vc->dial_req->message;
-	v->icon_id =3D vc->dial_req->icon_id;
-
-	vc->dial_req->message =3D NULL;
-	vc->dial_req->call =3D v;
-
-	/*
-	 * TS 102 223 Section 6.4.13: The terminal shall not store
-	 * in the UICC the call set-up details (called party number
-	 * and associated parameters)
-	 */
-	v->untracked =3D TRUE;
-
-	if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
-		dial_request_finish(vc);
-
-	if (need_to_emit)
-		voicecalls_emit_call_added(vc, v);
-}
-
 static void dial_request(struct ofono_voicecall *vc)
 {
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
-- =

1.7.0.4


--===============2697794565764764884==--

