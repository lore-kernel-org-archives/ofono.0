Content-Type: multipart/mixed; boundary="===============2404615184200363995=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 10/14] ublox: add TOBY L4 models
Date: Tue, 12 Mar 2019 12:10:04 +0100
Message-ID: <20190312111008.29258-11-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2404615184200363995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ubloxmodem/ubloxmodem.c | 23 +++++++++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index 3998f55e..49a824ed 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -58,6 +58,23 @@ const struct ublox_model ublox_models[] =3D {
 		.name =3D "TOBY-L280",
 		.flags =3D UBLOX_F_TOBY_L2|UBLOX_F_HAVE_USBCONF,
 	},
+	/* TOBY L4 series */
+	{
+		.name =3D "TOBY-L4006",
+		.flags =3D UBLOX_F_TOBY_L4,
+	},
+	{
+		.name =3D "TOBY-L4106",
+		.flags =3D UBLOX_F_TOBY_L4,
+	},
+	{
+		.name =3D "TOBY-L4206",
+		.flags =3D UBLOX_F_TOBY_L4,
+	},
+	{
+		.name =3D "TOBY-L4906",
+		.flags =3D UBLOX_F_TOBY_L4,
+	},
 	{ /* sentinal */ },
 };
 =

@@ -88,6 +105,12 @@ int ublox_is_toby_l2(const struct ublox_model* model)
 	return model->flags & UBLOX_F_TOBY_L2;
 }
 =

+int ublox_is_toby_l4(const struct ublox_model* model)
+{
+	return model->flags & UBLOX_F_TOBY_L4;
+}
+
+
 static int ubloxmodem_init(void)
 {
 	ublox_gprs_context_init();
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index 90749bff..8a499c11 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -25,6 +25,7 @@
 =

 enum ublox_flags {
 	UBLOX_F_TOBY_L2		=3D (1 << 0),
+	UBLOX_F_TOBY_L4		=3D (1 << 1),
 	UBLOX_F_HAVE_USBCONF	=3D (1 << 2),
 };
 =

@@ -37,6 +38,7 @@ const struct ublox_model* ublox_model_from_name(const cha=
r* name);
 const struct ublox_model* ublox_model_from_id(int id);
 int ublox_model_to_id(const struct ublox_model* model);
 int ublox_is_toby_l2(const struct ublox_model* model);
+int ublox_is_toby_l4(const struct ublox_model* model);
 =

 extern void ublox_gprs_context_init(void);
 extern void ublox_gprs_context_exit(void);
-- =

2.19.1


--===============2404615184200363995==--

