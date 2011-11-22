Content-Type: multipart/mixed; boundary="===============1478675989272054200=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 16/32] novatelcdma: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:45 +0100
Message-ID: <1321981801-5452-17-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1478675989272054200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/nokiacdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
index a25e2a0..a8d7b21 100644
--- a/plugins/nokiacdma.c
+++ b/plugins/nokiacdma.c
@@ -163,6 +163,7 @@ static void nokiacdma_post_online(struct ofono_modem *m=
odem)
 =

 static struct ofono_modem_driver nokiacdma_driver =3D {
 	.name		=3D "nokiacdma",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D nokiacdma_probe,
 	.remove		=3D nokiacdma_remove,
 	.enable		=3D nokiacdma_enable,
-- =

1.7.8.rc1.14.g248db


--===============1478675989272054200==--

