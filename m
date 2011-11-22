Content-Type: multipart/mixed; boundary="===============1257595235041655258=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 09/32] huaweicdma: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:38 +0100
Message-ID: <1321981801-5452-10-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1257595235041655258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/huaweicdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..41f09ac 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -218,6 +218,7 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 static struct ofono_modem_driver huaweicdma_driver =3D {
 	.name		=3D "huaweicdma",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D huaweicdma_probe,
 	.remove		=3D huaweicdma_remove,
 	.enable		=3D huaweicdma_enable,
-- =

1.7.8.rc1.14.g248db


--===============1257595235041655258==--

