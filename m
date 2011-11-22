Content-Type: multipart/mixed; boundary="===============3662095820727761039=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 25/32] ste: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:54 +0100
Message-ID: <1321981801-5452-26-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3662095820727761039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/ste.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 900e20d..26078cf 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -497,6 +497,7 @@ static void ste_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver ste_driver =3D {
 	.name		=3D "ste",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D ste_probe,
 	.remove		=3D ste_remove,
 	.enable		=3D ste_enable,
-- =

1.7.8.rc1.14.g248db


--===============3662095820727761039==--

