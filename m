Content-Type: multipart/mixed; boundary="===============6345261704144204828=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 07/32] hso: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:36 +0100
Message-ID: <1321981801-5452-8-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6345261704144204828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/hso.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 897cd12..4b6df20 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -406,6 +406,7 @@ static void hso_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver hso_driver =3D {
 	.name		=3D "hso",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D hso_probe,
 	.remove		=3D hso_remove,
 	.enable		=3D hso_enable,
-- =

1.7.8.rc1.14.g248db


--===============6345261704144204828==--

