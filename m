Content-Type: multipart/mixed; boundary="===============9091956639453402581=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ussd-mmi PATCH 3/4] voicecall: remove dial_request_finish() cb param
Date: Wed, 06 Oct 2010 17:52:18 +0300
Message-ID: <1286376739-20677-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286376739-20677-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9091956639453402581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

There is no need for callback param anymore.
---
 src/voicecall.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index e072be8..8be7487 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -213,11 +213,11 @@ static unsigned int voicecalls_num_connecting(struct =
ofono_voicecall *vc)
 	return r;
 }
 =

-static void dial_request_finish(struct ofono_voicecall *vc, gboolean callb=
ack)
+static void dial_request_finish(struct ofono_voicecall *vc)
 {
 	struct dial_request *dial_req =3D vc->dial_req;
 =

-	if (callback && dial_req->cb)
+	if (dial_req->cb)
 		dial_req->cb(dial_req->call ? dial_req->call->call : NULL,
 				dial_req->user_data);
 =

@@ -338,7 +338,7 @@ static void dial_request_user_cancel(struct ofono_voice=
call *vc,
 		return;
 =

 	if (!call || call =3D=3D vc->dial_req->call)
-		dial_request_finish(vc, TRUE);
+		dial_request_finish(vc);
 }
 =

 static DBusMessage *voicecall_hangup(DBusConnection *conn,
@@ -577,12 +577,12 @@ static void voicecall_set_call_status(struct voicecal=
l *call, int status)
 						&timestr);
 =

 		if (call->vc->dial_req && call =3D=3D call->vc->dial_req->call)
-			dial_request_finish(call->vc, TRUE);
+			dial_request_finish(call->vc);
 	}
 =

 	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
 			call =3D=3D call->vc->dial_req->call)
-		dial_request_finish(call->vc, TRUE);
+		dial_request_finish(call->vc);
 }
 =

 static void voicecall_set_call_lineid(struct voicecall *v,
@@ -1970,7 +1970,7 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 	}
 =

 	if (vc->dial_req)
-		dial_request_finish(vc, TRUE);
+		dial_request_finish(vc);
 =

 	for (l =3D vc->call_list; l; l =3D l->next)
 		voicecall_dbus_unregister(vc, l->data);
@@ -2207,7 +2207,7 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 				&need_to_emit);
 =

 	if (v =3D=3D NULL) {
-		dial_request_finish(vc, TRUE);
+		dial_request_finish(vc);
 		return;
 	}
 =

@@ -2225,7 +2225,7 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 	v->untracked =3D TRUE;
 =

 	if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
-		dial_request_finish(vc, TRUE);
+		dial_request_finish(vc);
 =

 	if (need_to_emit)
 		voicecalls_emit_call_added(vc, v);
@@ -2242,7 +2242,7 @@ static void dial_req_disconnect_cb(const struct ofono=
_error *error, void *data)
 	struct ofono_voicecall *vc =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		dial_request_finish(vc, TRUE);
+		dial_request_finish(vc);
 		return;
 	}
 =

-- =

1.7.0.4


--===============9091956639453402581==--

