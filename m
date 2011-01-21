Content-Type: multipart/mixed; boundary="===============1381720767943219229=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/3] message-waiting: add allocation checks
Date: Fri, 21 Jan 2011 14:44:05 +0200
Message-ID: <1295613846-19309-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1295613846-19309-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1381720767943219229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/message-waiting.c |   45 ++++++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 0e376b6..5d1126b 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -179,20 +179,22 @@ static DBusMessage *set_cphs_mbdn(struct ofono_messag=
e_waiting *mw,
 =

 	if ((mw->ef_cphs_mbdn_length && !mw_mailbox_to_cphs_record[mailbox]) ||
 			mw->cphs_mbdn_not_provided =3D=3D TRUE) {
-		if (msg)
+		if (msg !=3D NULL)
 			return __ofono_error_not_supported(msg);
 =

 		return NULL;
 	}
 =

 	if (mw->ef_cphs_mbdn_length =3D=3D 0) {
-		if (msg)
+		if (msg !=3D NULL)
 			return __ofono_error_sim_not_ready(msg);
 =

 		return NULL;
 	}
 =

 	req =3D g_new0(struct mbdn_set_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
 =

 	req->mw =3D mw;
 	req->mailbox =3D mailbox;
@@ -206,13 +208,17 @@ static DBusMessage *set_cphs_mbdn(struct ofono_messag=
e_waiting *mw,
 			sync ? cphs_mbdn_sync_cb : mbdn_set_cb,
 			OFONO_SIM_FILE_STRUCTURE_FIXED,
 			mw_mailbox_to_cphs_record[mailbox],
-			efmbdn, mw->ef_cphs_mbdn_length, req) =3D=3D -1) {
-		g_free(req);
+			efmbdn, mw->ef_cphs_mbdn_length, req) =3D=3D -1)
+		goto error;
 =

-		if (msg)
-			return __ofono_error_failed(msg);
-	} else
-		req->msg =3D msg ? dbus_message_ref(msg) : NULL;
+	req->msg =3D msg ? dbus_message_ref(msg) : NULL;
+	return NULL;
+
+error:
+	g_free(req);
+
+	if (msg !=3D NULL)
+		return __ofono_error_failed(msg);
 =

 	return NULL;
 }
@@ -292,6 +298,8 @@ static DBusMessage *set_mbdn(struct ofono_message_waiti=
ng *mw, int mailbox,
 	}
 =

 	req =3D g_new0(struct mbdn_set_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
 =

 	req->mw =3D mw;
 	req->mailbox =3D mailbox;
@@ -303,13 +311,17 @@ static DBusMessage *set_mbdn(struct ofono_message_wai=
ting *mw, int mailbox,
 	if (ofono_sim_write(req->mw->sim, SIM_EFMBDN_FILEID, mbdn_set_cb,
 			OFONO_SIM_FILE_STRUCTURE_FIXED,
 			req->mw->efmbdn_record_id[mailbox],
-			efmbdn, req->mw->efmbdn_length, req) =3D=3D -1) {
-		g_free(req);
+			efmbdn, req->mw->efmbdn_length, req) =3D=3D -1)
+		goto error;
 =

-		if (msg)
-			return __ofono_error_failed(msg);
-	} else
-		req->msg =3D msg ? dbus_message_ref(msg) : NULL;
+	req->msg =3D msg ? dbus_message_ref(msg) : NULL;
+	return NULL;
+
+error:
+	g_free(req);
+
+	if (msg)
+		return __ofono_error_failed(msg);
 =

 	return NULL;
 }
@@ -990,13 +1002,16 @@ struct ofono_message_waiting *ofono_message_waiting_=
create(struct ofono_modem *m
 	struct ofono_message_waiting *mw;
 =

 	mw =3D g_try_new0(struct ofono_message_waiting, 1);
-
 	if (mw =3D=3D NULL)
 		return NULL;
 =

 	mw->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_MESSAGE_WAITING,
 					mw_remove, mw);
+	if (mw->atom =3D=3D NULL) {
+		g_free(mw);
+		return NULL;
+	}
 =

 	return mw;
 }
-- =

1.7.1


--===============1381720767943219229==--

