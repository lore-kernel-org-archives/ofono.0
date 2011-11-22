Content-Type: multipart/mixed; boundary="===============3461671747374969632=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 10/32] ifx: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:39 +0100
Message-ID: <1321981801-5452-11-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3461671747374969632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/ifx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index e9ef4bc..a5184b5 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -749,6 +749,7 @@ static void ifx_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver ifx_driver =3D {
 	.name		=3D "ifx",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D ifx_probe,
 	.remove		=3D ifx_remove,
 	.enable		=3D ifx_enable,
-- =

1.7.8.rc1.14.g248db


--===============3461671747374969632==--

