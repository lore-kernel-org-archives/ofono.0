Content-Type: multipart/mixed; boundary="===============0381381827146277005=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] gisi: fix use of unitialised variable.
Date: Thu, 23 Dec 2010 05:39:39 +0100
Message-ID: <1293079181-13648-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0381381827146277005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set no msg.version if it's not available.
---
 gisi/modem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index ff06cf2..9fb4d34 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -293,7 +293,6 @@ static gboolean isi_callback(GIOChannel *channel, GIOCo=
ndition cond,
 		msg.error =3D 0;
 		msg.data =3D buf;
 		msg.len =3D len;
-		msg.version =3D &mux->version;
 =

 		if (modem->trace !=3D NULL)
 			modem->trace(&msg, NULL);
@@ -311,6 +310,8 @@ static gboolean isi_callback(GIOChannel *channel, GIOCo=
ndition cond,
 			return TRUE;
 		}
 =

+		msg.version =3D &mux->version;
+
 		if (g_isi_msg_id(&msg) =3D=3D COMMON_MESSAGE)
 			common_message_decode(mux, &msg);
 =

-- =

1.7.1.86.g0e460.dirty


--===============0381381827146277005==--

