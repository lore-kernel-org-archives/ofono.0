Content-Type: multipart/mixed; boundary="===============2051916459988312146=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 28/32] u8500: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:57 +0100
Message-ID: <1321981801-5452-29-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2051916459988312146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/u8500.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/u8500.c b/plugins/u8500.c
index 73ff4fa..6da665e 100644
--- a/plugins/u8500.c
+++ b/plugins/u8500.c
@@ -660,6 +660,7 @@ static void u8500_devinfo_remove(struct ofono_devinfo *=
info)
 =

 static struct ofono_modem_driver driver =3D {
 	.name =3D "u8500",
+	.modem_type =3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe =3D u8500_probe,
 	.remove =3D u8500_remove,
 	.set_online =3D u8500_online,
-- =

1.7.8.rc1.14.g248db


--===============2051916459988312146==--

