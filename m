Content-Type: multipart/mixed; boundary="===============8546748858442432680=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 06/14] ublox: add model flag HAVE_USBCONF
Date: Tue, 12 Mar 2019 12:10:00 +0100
Message-ID: <20190312111008.29258-7-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8546748858442432680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This flag should be set on devices that support multiple USB profiles
and will be used to determine whether or not querying USB profiles is
appropriate/necessary.
---
 drivers/ubloxmodem/ubloxmodem.c | 10 +++++-----
 drivers/ubloxmodem/ubloxmodem.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index 682b7cea..3998f55e 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -40,23 +40,23 @@ const struct ublox_model ublox_models[] =3D {
 	/* TOBY L2 series */
 	{
 		.name =3D "TOBY-L200",
-		.flags =3D UBLOX_F_TOBY_L2,
+		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
 	{
 		.name =3D "TOBY-L201",
-		.flags =3D UBLOX_F_TOBY_L2,
+		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
 	{
 		.name =3D "TOBY-L210",
-		.flags =3D UBLOX_F_TOBY_L2,
+		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
 	{
 		.name =3D "TOBY-L220",
-		.flags =3D UBLOX_F_TOBY_L2,
+		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
 	{
 		.name =3D "TOBY-L280",
-		.flags =3D UBLOX_F_TOBY_L2,
+		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
 	{ /* sentinal */ },
 };
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index e8f98b40..90749bff 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -25,6 +25,7 @@
 =

 enum ublox_flags {
 	UBLOX_F_TOBY_L2		=3D (1 << 0),
+	UBLOX_F_HAVE_USBCONF	=3D (1 << 2),
 };
 =

 struct ublox_model {
-- =

2.19.1


--===============8546748858442432680==--

