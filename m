Content-Type: multipart/mixed; boundary="===============7896182313554977706=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 05/32] gobi: Add mode type hardware
Date: Tue, 22 Nov 2011 18:09:34 +0100
Message-ID: <1321981801-5452-6-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7896182313554977706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/gobi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index d8c974b..bc779e1 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -324,6 +324,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver gobi_driver =3D {
 	.name		=3D "gobi",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D gobi_probe,
 	.remove		=3D gobi_remove,
 	.enable		=3D gobi_enable,
-- =

1.7.8.rc1.14.g248db


--===============7896182313554977706==--

