Content-Type: multipart/mixed; boundary="===============6520819944928736191=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 06/32] hfp_hf: Add modem type hfp
Date: Tue, 22 Nov 2011 18:09:35 +0100
Message-ID: <1321981801-5452-7-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6520819944928736191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/hfp_hf.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index c4c90ff..48a734a 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -499,6 +499,7 @@ static void hfp_post_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver hfp_driver =3D {
 	.name		=3D "hfp",
+	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
 	.probe		=3D hfp_probe,
 	.remove		=3D hfp_remove,
 	.enable		=3D hfp_enable,
-- =

1.7.8.rc1.14.g248db


--===============6520819944928736191==--

