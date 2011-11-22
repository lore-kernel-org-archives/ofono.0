Content-Type: multipart/mixed; boundary="===============5998088317212536795=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 11/32] isiusb: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:40 +0100
Message-ID: <1321981801-5452-12-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5998088317212536795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/isiusb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index 82d2cc5..834f114 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -451,6 +451,7 @@ static int isiusb_disable(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver driver =3D {
 	.name =3D "isiusb",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe =3D isiusb_probe,
 	.remove =3D isiusb_remove,
 	.set_online =3D isiusb_online,
-- =

1.7.8.rc1.14.g248db


--===============5998088317212536795==--

