Content-Type: multipart/mixed; boundary="===============2056629152315139751=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 29/32] wavecom: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:58 +0100
Message-ID: <1321981801-5452-30-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2056629152315139751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/wavecom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index 5d30f39..9d8cc1e 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -165,6 +165,7 @@ static void wavecom_post_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver wavecom_driver =3D {
 	.name		=3D "wavecom",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D wavecom_probe,
 	.remove		=3D wavecom_remove,
 	.enable		=3D wavecom_enable,
-- =

1.7.8.rc1.14.g248db


--===============2056629152315139751==--

