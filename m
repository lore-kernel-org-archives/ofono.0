Content-Type: multipart/mixed; boundary="===============3990532983839365907=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 18/32] palmpre: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:47 +0100
Message-ID: <1321981801-5452-19-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3990532983839365907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/palmpre.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index c495f28..425646c 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -212,6 +212,7 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver palmpre_driver =3D {
 	.name		=3D "palmpre",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D palmpre_probe,
 	.remove		=3D palmpre_remove,
 	.enable		=3D palmpre_enable,
-- =

1.7.8.rc1.14.g248db


--===============3990532983839365907==--

