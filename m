Content-Type: multipart/mixed; boundary="===============1589195513230534789=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] gisi: log normal responses in a less confusing way
Date: Wed, 27 Apr 2011 15:45:14 +0300
Message-ID: <1303908314-28954-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1589195513230534789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 gisi/modem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index 384983d..070cb9c 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -163,7 +163,8 @@ static void pending_remove_and_dispatch(GIsiPending *op=
, GIsiMessage *msg)
 	modem =3D op->service->modem;
 =

 	ISIDBG(modem, "%s %s to %p [res=3D0x%02X, id=3D0x%02X, utid=3D0x%02X]",
-		g_isi_msg_strerror(msg), pend_type_to_str(op->type), op,
+		g_isi_msg_error(msg) ? g_isi_msg_strerror(msg) : "normal",
+		pend_type_to_str(op->type), op,
 		g_isi_msg_resource(msg), g_isi_msg_id(msg),
 		g_isi_msg_utid(msg));
 =

-- =

1.7.1


--===============1589195513230534789==--

