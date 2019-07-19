Content-Type: multipart/mixed; boundary="===============9041369702725820087=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/1] ublox: detect and support LARA R2 series
Date: Fri, 19 Jul 2019 09:04:15 +0200
Message-ID: <20190719070415.3184-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9041369702725820087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ubloxmodem/ubloxmodem.c | 9 +++++++++
 drivers/ubloxmodem/ubloxmodem.h | 3 ++-
 plugins/udevng.c                | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index 719c77a0..034f7db1 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -77,6 +77,15 @@ const struct ublox_model ublox_models[] =3D {
 		.name =3D "TOBY-L4906",
 		.flags =3D UBLOX_F_TOBY_L4,
 	},
+	/* LARA L2 series */
+	{
+		.name =3D "LARA-R202",
+		.flags =3D UBLOX_F_LARA_R2,
+	},
+	{
+		.name =3D "LARA-R211",
+		.flags =3D UBLOX_F_LARA_R2,
+	},
 	{ /* sentinel */ },
 };
 =

diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index 81fe9481..0bd7ef23 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -26,7 +26,8 @@
 enum ublox_flags {
 	UBLOX_F_TOBY_L2		=3D (1 << 0),
 	UBLOX_F_TOBY_L4		=3D (1 << 1),
-	UBLOX_F_HAVE_USBCONF	=3D (1 << 2),
+	UBLOX_F_LARA_R2		=3D (1 << 2),
+	UBLOX_F_HAVE_USBCONF	=3D (1 << 3),
 };
 =

 struct ublox_model {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 35354a16..1b54b4a2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1759,6 +1759,8 @@ static struct {
 	{ "ublox",	"cdc_acm",	"1546", "1010"	},
 	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
+	{ "ublox",	"cdc_acm",	"1546", "110a"	},
+	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
-- =

2.20.1


--===============9041369702725820087==--

