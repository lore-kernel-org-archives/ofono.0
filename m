Content-Type: multipart/mixed; boundary="===============2872596709568385177=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 04/32] g1: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:33 +0100
Message-ID: <1321981801-5452-5-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2872596709568385177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/g1.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/g1.c b/plugins/g1.c
index d915a56..6a6a2ce 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -193,6 +193,7 @@ static void g1_post_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver g1_driver =3D {
 	.name		=3D "g1",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D g1_probe,
 	.remove		=3D g1_remove,
 	.enable		=3D g1_enable,
-- =

1.7.8.rc1.14.g248db


--===============2872596709568385177==--

