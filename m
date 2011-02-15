Content-Type: multipart/mixed; boundary="===============3297661711170384126=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 04/18] gisi: fix subscription for wgmodem2.5
Date: Tue, 15 Feb 2011 13:30:58 +0100
Message-ID: <ffc8a75a856d2d2af65696f1878fb2b5ad7c5045.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3297661711170384126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 gisi/modem.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gisi/modem.c b/gisi/modem.c
index 734c4f1..143e761 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -370,13 +370,15 @@ static gboolean modem_subs_update(gpointer data)
 =

 		if (legacy)
 			msg[3 + count] =3D mux->resource;
-		else
+		else {
 			/* Resource field is 32bit and Little-endian */
 			msg[4 + count * 4 + 3] =3D mux->resource;
+		}
 =

 		count++;
 	}
 =

+	commgr.spn_dev =3D legacy ? modem->device : PN_DEV_MODEM;
 	len =3D legacy ? 3 + count : 4 + count * 4;
 	msg[2] =3D count;
 =

-- =

1.7.3.5


--===============3297661711170384126==--

