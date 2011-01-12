Content-Type: multipart/mixed; boundary="===============5859646029301594997=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [gisi-notify-fix PATCH 1/4] gisi: remove before notify
Date: Wed, 12 Jan 2011 21:24:09 +0200
Message-ID: <1294860252-29570-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1294860252-29570-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5859646029301594997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Just in case, remove pending operations before calling notifys.
The notify function can remove client, service or modem.
---
 gisi/client.c |    6 ++--
 gisi/modem.c  |   71 +++++++++++++++++++++++++++++++++++++----------------=
----
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index 03ed5de..85e1fa7 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -66,11 +66,11 @@ static void pending_resp_notify(const GIsiMessage *msg,=
 void *data)
 	if (pd =3D=3D NULL)
 		return;
 =

-	if (pd->notify !=3D NULL)
-		pd->notify(msg, pd->data);
-
 	pd->client->pending =3D g_slist_remove(pd->client->pending,
 						g_isi_pending_from_msg(msg));
+
+	if (pd->notify !=3D NULL)
+		pd->notify(msg, pd->data);
 }
 =

 static void pending_notify(const GIsiMessage *msg, void *data)
diff --git a/gisi/modem.c b/gisi/modem.c
index 0682666..14827d8 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -155,9 +155,41 @@ static void pending_dispatch(GIsiPending *pend, GIsiMe=
ssage *msg)
 		g_isi_msg_resource(msg), g_isi_msg_id(msg),
 		g_isi_msg_utid(msg));
 =

+	msg->private =3D pend;
+
 	pend->notify(msg, pend->data);
 }
 =

+static void pending_remove_and_dispatch(GIsiPending *op, GIsiMessage *msg)
+{
+	GIsiModem *modem;
+
+	op->service->pending =3D g_slist_remove(op->service->pending, op);
+
+	if (op->notify =3D=3D NULL || msg =3D=3D NULL)
+		goto destroy;
+
+	modem =3D op->service->modem;
+
+	ISIDBG(modem, "%s %s to %p [res=3D0x%02X, id=3D0x%02X, utid=3D0x%02X]",
+		g_isi_msg_strerror(msg), pend_type_to_str(op->type), op,
+		g_isi_msg_resource(msg), g_isi_msg_id(msg),
+		g_isi_msg_utid(msg));
+
+	msg->private =3D op;
+
+	op->notify(msg, op->data);
+
+destroy:
+	if (op->timeout > 0)
+		g_source_remove(op->timeout);
+
+	if (op->destroy !=3D NULL)
+		op->destroy(op->data);
+
+	g_free(op);
+}
+
 static void service_dispatch(GIsiServiceMux *mux, GIsiMessage *msg,
 				gboolean is_indication)
 {
@@ -169,7 +201,6 @@ static void service_dispatch(GIsiServiceMux *mux, GIsiM=
essage *msg,
 	while (l !=3D NULL) {
 		GSList *next =3D l->next;
 		GIsiPending *pend =3D l->data;
-		msg->private =3D pend;
 =

 		/*
 		 * REQs, NTFs and INDs are dispatched on message ID.  While
@@ -192,24 +223,18 @@ static void service_dispatch(GIsiServiceMux *mux, GIs=
iMessage *msg,
 			pending_dispatch(pend, msg);
 =

 		} else if (pend->type =3D=3D GISI_MESSAGE_TYPE_RESP &&
-				!is_indication && pend->utid =3D=3D utid) {
+				 !is_indication && pend->utid =3D=3D utid) {
 =

-			pending_dispatch(pend, msg);
-			pend->notify =3D NULL;
-
-			g_isi_pending_remove(pend);
+			pending_remove_and_dispatch(pend, msg);
 			break;
 =

 		} else if (pend->type =3D=3D GISI_MESSAGE_TYPE_COMMON &&
 				msgid =3D=3D COMMON_MESSAGE &&
 				pend->msgid =3D=3D COMM_ISI_VERSION_GET_REQ) {
 =

-			pending_dispatch(pend, msg);
-			pend->notify =3D NULL;
-
-			g_isi_pending_remove(pend);
-
+			pending_remove_and_dispatch(pend, msg);
 		}
+
 		l =3D next;
 	}
 }
@@ -634,16 +659,15 @@ static void vtrace(struct sockaddr_pn *dst,
 =

 static gboolean resp_timeout(gpointer data)
 {
-	GIsiPending *resp =3D data;
+	GIsiPending *op =3D data;
 	GIsiMessage msg =3D {
 		.error =3D ETIMEDOUT,
-		.private =3D resp,
 	};
 =

-	pending_dispatch(resp, &msg);
-	resp->notify =3D NULL;
+	op->timeout =3D 0;
+
+	pending_remove_and_dispatch(op, &msg);
 =

-	g_isi_pending_remove(resp);
 	return FALSE;
 }
 =

@@ -755,8 +779,6 @@ void g_isi_pending_remove(GIsiPending *op)
 	if (op =3D=3D NULL)
 		return;
 =

-	op->service->pending =3D g_slist_remove(op->service->pending, op);
-
 	if (op->type =3D=3D GISI_MESSAGE_TYPE_IND)
 		service_subs_decr(op->service);
 =

@@ -766,12 +788,14 @@ void g_isi_pending_remove(GIsiPending *op)
 	if (op->type =3D=3D GISI_MESSAGE_TYPE_RESP && op->notify !=3D NULL) {
 		GIsiMessage msg =3D {
 			.error =3D ESHUTDOWN,
-			.private =3D op,
 		};
-		op->notify(&msg, op->data);
-		op->notify =3D NULL;
+
+		pending_remove_and_dispatch(op, &msg);
+		return;
 	}
 =

+	op->service->pending =3D g_slist_remove(op->service->pending, op);
+
 	pending_destroy(op, NULL);
 }
 =

@@ -1045,14 +1069,11 @@ static gboolean reachable_notify(gpointer data)
 	};
 	GIsiMessage msg =3D {
 		.version =3D &mux->version,
-		.private =3D pong,
 		.addr =3D &addr,
 	};
 =

-	pending_dispatch(pong, &msg);
-	pong->notify =3D NULL;
+	pending_remove_and_dispatch(pong, &msg);
 =

-	g_isi_pending_remove(pong);
 	return FALSE;
 }
 =

-- =

1.7.1


--===============5859646029301594997==--

