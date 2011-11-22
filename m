Content-Type: multipart/mixed; boundary="===============5372057237834108190=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 17/32] novatel: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:46 +0100
Message-ID: <1321981801-5452-18-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5372057237834108190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/novatel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/novatel.c b/plugins/novatel.c
index a64364d..ba7c1c3 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -354,6 +354,7 @@ static void novatel_post_online(struct ofono_modem *mod=
em)
 =

 static struct ofono_modem_driver novatel_driver =3D {
 	.name		=3D "novatel",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D novatel_probe,
 	.remove		=3D novatel_remove,
 	.enable		=3D novatel_enable,
-- =

1.7.8.rc1.14.g248db


--===============5372057237834108190==--

