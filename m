Content-Type: multipart/mixed; boundary="===============7204176600888353370=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 02/32] alcatel: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:31 +0100
Message-ID: <1321981801-5452-3-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7204176600888353370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/alcatel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/alcatel.c b/plugins/alcatel.c
index fd0e4ec..87a2a38 100644
--- a/plugins/alcatel.c
+++ b/plugins/alcatel.c
@@ -255,6 +255,7 @@ static void alcatel_post_online(struct ofono_modem *mod=
em)
 =

 static struct ofono_modem_driver alcatel_driver =3D {
 	.name		=3D "alcatel",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D alcatel_probe,
 	.remove		=3D alcatel_remove,
 	.enable		=3D alcatel_enable,
-- =

1.7.8.rc1.14.g248db


--===============7204176600888353370==--

