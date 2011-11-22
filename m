Content-Type: multipart/mixed; boundary="===============7973760616183573251=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 26/32] tc65: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:55 +0100
Message-ID: <1321981801-5452-27-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7973760616183573251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/tc65.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/tc65.c b/plugins/tc65.c
index eb64b89..c63ac51 100644
--- a/plugins/tc65.c
+++ b/plugins/tc65.c
@@ -221,6 +221,7 @@ static void tc65_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver tc65_driver =3D {
 	.name		=3D "tc65",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D tc65_probe,
 	.remove		=3D tc65_remove,
 	.enable		=3D tc65_enable,
-- =

1.7.8.rc1.14.g248db


--===============7973760616183573251==--

