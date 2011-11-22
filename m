Content-Type: multipart/mixed; boundary="===============2984114247167875584=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 12/32] linktop: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:41 +0100
Message-ID: <1321981801-5452-13-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2984114247167875584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/linktop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/linktop.c b/plugins/linktop.c
index bb0d7b8..4229ea4 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -282,6 +282,7 @@ static void linktop_post_online(struct ofono_modem *mod=
em)
 =

 static struct ofono_modem_driver linktop_driver =3D {
 	.name		=3D "linktop",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D linktop_probe,
 	.remove		=3D linktop_remove,
 	.enable		=3D linktop_enable,
-- =

1.7.8.rc1.14.g248db


--===============2984114247167875584==--

