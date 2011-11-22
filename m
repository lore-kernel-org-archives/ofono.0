Content-Type: multipart/mixed; boundary="===============2145573671508645688=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 14/32] n900: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:43 +0100
Message-ID: <1321981801-5452-15-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2145573671508645688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/n900.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 44e2e75..ebee449 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -539,6 +539,7 @@ static int n900_disable(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver n900_driver =3D {
 	.name =3D "n900",
+	.modem_type =3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe =3D n900_probe,
 	.remove =3D n900_remove,
 	.enable =3D n900_enable,
-- =

1.7.8.rc1.14.g248db


--===============2145573671508645688==--

