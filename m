Content-Type: multipart/mixed; boundary="===============2403829025384772794=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 22/32] sierra: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:51 +0100
Message-ID: <1321981801-5452-23-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2403829025384772794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/sierra.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index c41e2d1..6404ca6 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -243,6 +243,7 @@ static void sierra_post_online(struct ofono_modem *mode=
m)
 =

 static struct ofono_modem_driver sierra_driver =3D {
 	.name		=3D "sierra",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D sierra_probe,
 	.remove		=3D sierra_remove,
 	.enable		=3D sierra_enable,
-- =

1.7.8.rc1.14.g248db


--===============2403829025384772794==--

