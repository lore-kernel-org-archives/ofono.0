Content-Type: multipart/mixed; boundary="===============8467533040310538571=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] gisi/verify: check g_try_new0 return value
Date: Wed, 06 Oct 2010 18:01:39 +0300
Message-ID: <1286377300-21614-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8467533040310538571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 gisi/verify.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gisi/verify.c b/gisi/verify.c
index fae9d13..322f1d1 100644
--- a/gisi/verify.c
+++ b/gisi/verify.c
@@ -116,6 +116,9 @@ GIsiRequest *g_isi_verify(GIsiClient *client, GIsiVerif=
yFunc func,
 	struct verify_data *data =3D g_try_new0(struct verify_data, 1);
 	GIsiRequest *req =3D NULL;
 =

+	if (data =3D=3D NULL)
+		return NULL;
+
 	data->func =3D func;
 	data->data =3D opaque;
 =

-- =

1.7.0.4


--===============8467533040310538571==--

