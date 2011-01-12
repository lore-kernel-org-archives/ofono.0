Content-Type: multipart/mixed; boundary="===============1141722990536469973=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [gisi-notify-fix PATCH 3/4] gisi: remove g_isi_pending_from_msg()
Date: Wed, 12 Jan 2011 21:24:11 +0200
Message-ID: <1294860252-29570-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1294860252-29570-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1141722990536469973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 gisi/modem.c |    9 ---------
 gisi/modem.h |    2 --
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index ba79a31..0d19acd 100644
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
 static void foreach_destroy(GIsiPending *op)
 {
 	if (op->type =3D=3D GISI_MESSAGE_TYPE_IND)
diff --git a/gisi/modem.h b/gisi/modem.h
index 91fe3d0..52de7ab 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -107,8 +107,6 @@ int g_isi_response_vsend(GIsiModem *modem, const GIsiMe=
ssage *req,
 				const struct iovec *__restrict iov,
 				size_t iovlen);
 =

-GIsiPending *g_isi_pending_from_msg(const GIsiMessage *msg);
-
 void g_isi_pending_own(GIsiPending *op, gpointer owner);
 void g_isi_remove_all_my_pending(GIsiModem *modem, uint8_t resource,
 					gpointer owner);
-- =

1.7.1


--===============1141722990536469973==--

