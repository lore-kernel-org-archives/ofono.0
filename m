Content-Type: multipart/mixed; boundary="===============3600877635495012693=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 04/14] ublox: create model data structures
Date: Tue, 12 Mar 2019 12:09:58 +0100
Message-ID: <20190312111008.29258-5-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3600877635495012693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This sets up some device model data structures and adds some helpers for
manipulating them.  These data structures are a first step to trying to
support the large number of devices that ublox produces with a common
driver structure.
---
 drivers/ubloxmodem/ubloxmodem.c | 55 +++++++++++++++++++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.h | 14 +++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index a325b1f0..682b7cea 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -33,6 +33,61 @@
 =

 #include "ubloxmodem.h"
 =

+const struct ublox_model ublox_models[] =3D {
+	{
+		.name =3D "SARA-G270",
+	},
+	/* TOBY L2 series */
+	{
+		.name =3D "TOBY-L200",
+		.flags =3D UBLOX_F_TOBY_L2,
+	},
+	{
+		.name =3D "TOBY-L201",
+		.flags =3D UBLOX_F_TOBY_L2,
+	},
+	{
+		.name =3D "TOBY-L210",
+		.flags =3D UBLOX_F_TOBY_L2,
+	},
+	{
+		.name =3D "TOBY-L220",
+		.flags =3D UBLOX_F_TOBY_L2,
+	},
+	{
+		.name =3D "TOBY-L280",
+		.flags =3D UBLOX_F_TOBY_L2,
+	},
+	{ /* sentinal */ },
+};
+
+const struct ublox_model* ublox_model_from_name(const char* name)
+{
+	const struct ublox_model* m;
+
+	for (m =3D ublox_models; m->name; m++) {
+		if (!strcmp(name, m->name))
+			return m;
+	}
+
+	return NULL;
+}
+
+const struct ublox_model* ublox_model_from_id(int id)
+{
+	return ublox_models + id;
+}
+
+int ublox_model_to_id(const struct ublox_model* model)
+{
+	return model - ublox_models;
+}
+
+int ublox_is_toby_l2(const struct ublox_model* model)
+{
+	return model->flags & UBLOX_F_TOBY_L2;
+}
+
 static int ubloxmodem_init(void)
 {
 	ublox_gprs_context_init();
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index bfb01064..e8f98b40 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -23,6 +23,20 @@
 =

 #define UBLOXMODEM "ubloxmodem"
 =

+enum ublox_flags {
+	UBLOX_F_TOBY_L2		=3D (1 << 0),
+};
+
+struct ublox_model {
+	char* name;
+	int flags;
+};
+
+const struct ublox_model* ublox_model_from_name(const char* name);
+const struct ublox_model* ublox_model_from_id(int id);
+int ublox_model_to_id(const struct ublox_model* model);
+int ublox_is_toby_l2(const struct ublox_model* model);
+
 extern void ublox_gprs_context_init(void);
 extern void ublox_gprs_context_exit(void);
 =

-- =

2.19.1


--===============3600877635495012693==--

