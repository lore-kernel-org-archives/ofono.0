Content-Type: multipart/mixed; boundary="===============6578135497601850048=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 23/32] speedup: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:52 +0100
Message-ID: <1321981801-5452-24-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6578135497601850048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/speedup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index a90dfe3..f81d4a2 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -276,6 +276,7 @@ static void speedup_post_online(struct ofono_modem *mod=
em)
 =

 static struct ofono_modem_driver speedup_driver =3D {
 	.name		=3D "speedup",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D speedup_probe,
 	.remove		=3D speedup_remove,
 	.enable		=3D speedup_enable,
-- =

1.7.8.rc1.14.g248db


--===============6578135497601850048==--

