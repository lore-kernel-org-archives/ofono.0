Content-Type: multipart/mixed; boundary="===============7988120217343845132=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [gisi-notify-fix PATCHv2 2/2] gisi: remove g_isi_pending_from_msg()
Date: Tue, 18 Jan 2011 23:27:09 +0200
Message-ID: <1295386029-32624-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1295386029-32624-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7988120217343845132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 gisi/modem.c |    9 ---------
 gisi/modem.h |    2 --
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index f80d671..8750367 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -156,8 +156,6 @@ static void pending_dispatch(GIsiPending *pend, GIsiMes=
sage *msg)
 		g_isi_msg_resource(msg), g_isi_msg_id(msg),
 		g_isi_msg_utid(msg));
 =

-	msg->private =3D pend;
-
 	pend->notify(msg, pend->data);
 }
 =

@@ -177,8 +175,6 @@ static void pending_remove_and_dispatch(GIsiPending *op=
, GIsiMessage *msg)
 		g_isi_msg_resource(msg), g_isi_msg_id(msg),
 		g_isi_msg_utid(msg));
 =

-	msg->private =3D op;
-
 	op->notify(msg, op->data);
 =

 destroy:
@@ -770,11 +766,6 @@ uint8_t g_isi_request_utid(GIsiPending *resp)
 	return resp !=3D NULL ? resp->utid : 0;
 }
 =

-GIsiPending *g_isi_pending_from_msg(const GIsiMessage *msg)
-{
-	return msg !=3D NULL ? msg->private : NULL;
-}
-
 void g_isi_pending_remove(GIsiPending *op)
 {
 	if (op =3D=3D NULL)
diff --git a/gisi/modem.h b/gisi/modem.h
index 0de720d..f0a1617 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -107,8 +107,6 @@ int g_isi_response_vsend(GIsiModem *modem, const GIsiMe=
ssage *req,
 				const struct iovec *__restrict iov,
 				size_t iovlen);
 =

-GIsiPending *g_isi_pending_from_msg(const GIsiMessage *msg);
-
 void g_isi_pending_remove(GIsiPending *op);
 void g_isi_pending_set_owner(GIsiPending *op, gpointer owner);
 void g_isi_remove_pending_by_owner(GIsiModem *modem, uint8_t resource,
-- =

1.7.1


--===============7988120217343845132==--

