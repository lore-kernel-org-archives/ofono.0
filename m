Content-Type: multipart/mixed; boundary="===============2428670152614388830=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 15/32] nokia: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:44 +0100
Message-ID: <1321981801-5452-16-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2428670152614388830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/nokia.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/nokia.c b/plugins/nokia.c
index ae6c997..59efec5 100644
--- a/plugins/nokia.c
+++ b/plugins/nokia.c
@@ -253,6 +253,7 @@ static void nokia_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver nokia_driver =3D {
 	.name		=3D "nokia",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D nokia_probe,
 	.remove		=3D nokia_remove,
 	.enable		=3D nokia_enable,
-- =

1.7.8.rc1.14.g248db


--===============2428670152614388830==--

