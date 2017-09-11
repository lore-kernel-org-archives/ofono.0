Content-Type: multipart/mixed; boundary="===============3466931763782208103=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/2] network.c: notify_status_watches: check for NULL
Date: Mon, 11 Sep 2017 02:25:42 +0200
Message-ID: <20170911002543.31030-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3466931763782208103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In rare cases when ofono_netreg_status_notify() is called before
ofono_netreg_register() netreg->status_watches is NULL.
---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index a3d41a74d555..6e69b078495f 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1186,6 +1186,9 @@ static void notify_status_watches(struct ofono_netreg=
 *netreg)
 	const char *mcc =3D NULL;
 	const char *mnc =3D NULL;
 =

+	if (netreg->status_watches =3D=3D NULL)
+		return;
+
 	if (netreg->current_operator) {
 		mcc =3D netreg->current_operator->mcc;
 		mnc =3D netreg->current_operator->mnc;
-- =

2.14.1


--===============3466931763782208103==--

