Content-Type: multipart/mixed; boundary="===============4849101015667660204=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 19/32] phonesim: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:48 +0100
Message-ID: <1321981801-5452-20-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4849101015667660204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/phonesim.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 5f4940f..80017d8 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -787,6 +787,7 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 =

 static struct ofono_modem_driver phonesim_driver =3D {
 	.name		=3D "phonesim",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D phonesim_probe,
 	.remove		=3D phonesim_remove,
 	.enable		=3D phonesim_enable,
@@ -911,6 +912,7 @@ static void localhfp_pre_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver localhfp_driver =3D {
 	.name		=3D "localhfp",
+	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
 	.probe		=3D localhfp_probe,
 	.remove		=3D localhfp_remove,
 	.enable		=3D localhfp_enable,
-- =

1.7.8.rc1.14.g248db


--===============4849101015667660204==--

