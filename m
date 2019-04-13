Content-Type: multipart/mixed; boundary="===============5171388288916590193=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/1] ublox: detect and support LARA R2 series
Date: Sat, 13 Apr 2019 07:29:15 +0200
Message-ID: <20190413052915.8561-1-jonas@norrbonn.se>
In-Reply-To: <00bd01d4f05c9debed0d9c3c70iwavesystems.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5171388288916590193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi Krishna,

This patch isn't tested, but this is roughly what you'd need to get the
LARA R2 detected and running.  After that, it's just a matter of going
through the details of where ofono has issues.

From what I can see at a quick glance at the documentation, there's
nothing that particularly stands out here so I suspect things will
mostly just work.  Give the patch a try and let me know how it goes.

Regards,
Jonas

 drivers/ubloxmodem/ubloxmodem.c | 9 +++++++++
 drivers/ubloxmodem/ubloxmodem.h | 1 +
 plugins/udevng.c                | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index a52a67ea..85d72684 100644
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
index 2c5b7433..7fe58df3 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -27,6 +27,7 @@ enum ublox_flags {
 	UBLOX_F_TOBY_L2		=3D (1 << 0),
 	UBLOX_F_TOBY_L4		=3D (1 << 1),
 	UBLOX_F_HAVE_USBCONF	=3D (1 << 2),
+	UBLOX_F_LARA_R2		=3D (1 << 3),
 };
 =

 struct ublox_model {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index f689b756..397ac931 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1700,6 +1700,8 @@ static struct {
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


--===============5171388288916590193==--

