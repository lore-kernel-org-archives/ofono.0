Content-Type: multipart/mixed; boundary="===============1352355988385680811=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 03/32] calypso: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:32 +0100
Message-ID: <1321981801-5452-4-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1352355988385680811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/calypso.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index 8154899..3a54bec 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -542,6 +542,7 @@ static void calypso_post_sim(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver calypso_driver =3D {
 	.name		=3D "calypso",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D calypso_probe,
 	.remove		=3D calypso_remove,
 	.enable		=3D calypso_enable,
-- =

1.7.8.rc1.14.g248db


--===============1352355988385680811==--

