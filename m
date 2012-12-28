Content-Type: multipart/mixed; boundary="===============4638043756976971570=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 3/8] sierramodem: Add ERI parsing functions
Date: Fri, 28 Dec 2012 14:35:08 -0500
Message-ID: <20121228193508.GI18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4638043756976971570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

These were borrowed from ModemManager.
---
 Makefile.am               |    2 +
 drivers/sierramodem/eri.c |  282 +++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/sierramodem/eri.h |   23 ++++
 3 files changed, 307 insertions(+), 0 deletions(-)
 create mode 100644 drivers/sierramodem/eri.c
 create mode 100644 drivers/sierramodem/eri.h

diff --git a/Makefile.am b/Makefile.am
index 074326c..f799874 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -321,6 +321,8 @@ builtin_modules +=3D sierramodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/sierramodem/sierramodem.h \
 			drivers/sierramodem/sierramodem.c \
+			drivers/sierramodem/eri.h \
+			drivers/sierramodem/eri.c \
 			drivers/sierramodem/cdma-netreg.c
 =

 if PHONESIM
diff --git a/drivers/sierramodem/eri.c b/drivers/sierramodem/eri.c
new file mode 100644
index 0000000..0a7929f
--- /dev/null
+++ b/drivers/sierramodem/eri.c
@@ -0,0 +1,282 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Novell, Inc.
+ *  Copyright (C) 2009-2012  Red Hat, Inc.
+ *  Copyright (C) 2011-2012  Google, Inc.
+ *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <glib.h>
+#include <errno.h>
+#include <stdlib.h>
+
+/* NOTE: The following functions originated in ModemManager. */
+
+static gboolean get_uint_from_str(const gchar *str, guint *out)
+{
+	gulong num;
+
+	if (!str || !str[0])
+		return FALSE;
+
+	for (num =3D 0; str[num]; num++) {
+		if (!g_ascii_isdigit(str[num]))
+			return FALSE;
+	}
+
+	errno =3D 0;
+	num =3D strtoul(str, NULL, 10);
+	if (!errno && num <=3D G_MAXUINT) {
+		*out =3D (guint)num;
+		return TRUE;
+	}
+	return FALSE;
+}
+
+typedef struct {
+	gint num;
+	gboolean roam_ind;
+	const gchar *banner;
+} EriItem;
+
+/* NOTE: these may be Sprint-specific for now... */
+static const EriItem eris[] =3D {
+	{ 0, TRUE, "Digital or Analog Roaming" },
+	{ 1, FALSE, "Home" },
+	{ 2, TRUE, "Digital or Analog Roaming" },
+	{ 3, TRUE, "Out of neighborhood" },
+	{ 4, TRUE, "Out of building" },
+	{ 5, TRUE, "Preferred system" },
+	{ 6, TRUE, "Available System" },
+	{ 7, TRUE, "Alliance Partner" },
+	{ 8, TRUE, "Premium Partner" },
+	{ 9, TRUE, "Full Service Functionality" },
+	{ 10, TRUE, "Partial Service Functionality" },
+	{ 64, TRUE, "Preferred system" },
+	{ 65, TRUE, "Available System" },
+	{ 66, TRUE, "Alliance Partner" },
+	{ 67, TRUE, "Premium Partner" },
+	{ 68, TRUE, "Full Service Functionality" },
+	{ 69, TRUE, "Partial Service Functionality" },
+	{ 70, TRUE, "Analog A" },
+	{ 71, TRUE, "Analog B" },
+	{ 72, TRUE, "CDMA 800 A" },
+	{ 73, TRUE, "CDMA 800 B" },
+	{ 74, TRUE, "International Roaming" },
+	{ 75, TRUE, "Extended Network" },
+	{ 76, FALSE, "Campus" },
+	{ 77, FALSE, "In Building" },
+	{ 78, TRUE, "Regional" },
+	{ 79, TRUE, "Community" },
+	{ 80, TRUE, "Business" },
+	{ 81, TRUE, "Zone 1" },
+	{ 82, TRUE, "Zone 2" },
+	{ 83, TRUE, "National" },
+	{ 84, TRUE, "Local" },
+	{ 85, TRUE, "City" },
+	{ 86, TRUE, "Government" },
+	{ 87, TRUE, "USA" },
+	{ 88, TRUE, "State" },
+	{ 89, TRUE, "Resort" },
+	{ 90, TRUE, "Headquarters" },
+	{ 91, TRUE, "Personal" },
+	{ 92, FALSE, "Home" },
+	{ 93, TRUE, "Residential" },
+	{ 94, TRUE, "University" },
+	{ 95, TRUE, "College" },
+	{ 96, TRUE, "Hotel Guest" },
+	{ 97, TRUE, "Rental" },
+	{ 98, FALSE, "Corporate" },
+	{ 99, FALSE, "Home Provider" },
+	{ 100, FALSE, "Campus" },
+	{ 101, FALSE, "In Building" },
+	{ 102, TRUE, "Regional" },
+	{ 103, TRUE, "Community" },
+	{ 104, TRUE, "Business" },
+	{ 105, TRUE, "Zone 1" },
+	{ 106, TRUE, "Zone 2" },
+	{ 107, TRUE, "National" },
+	{ 108, TRUE, "Local" },
+	{ 109, TRUE, "City" },
+	{ 110, TRUE, "Government" },
+	{ 111, TRUE, "USA" },
+	{ 112, TRUE, "State" },
+	{ 113, TRUE, "Resort" },
+	{ 114, TRUE, "Headquarters" },
+	{ 115, TRUE, "Personal" },
+	{ 116, FALSE, "Home" },
+	{ 117, TRUE, "Residential" },
+	{ 118, TRUE, "University" },
+	{ 119, TRUE, "College" },
+	{ 120, TRUE, "Hotel Guest" },
+	{ 121, TRUE, "Rental" },
+	{ 122, FALSE, "Corporate" },
+	{ 123, FALSE, "Home Provider" },
+	{ 124, TRUE, "International" },
+	{ 125, TRUE, "International" },
+	{ 126, TRUE, "International" },
+	{ 127, FALSE, "Premium Service" },
+	{ 128, FALSE, "Enhanced Service" },
+	{ 129, FALSE, "Enhanced Digital" },
+	{ 130, FALSE, "Enhanced Roaming" },
+	{ 131, FALSE, "Alliance Service" },
+	{ 132, FALSE, "Alliance Network" },
+	{ 133, FALSE, "Data Roaming" },	/* Sprint: Vision Roaming */
+	{ 134, FALSE, "Extended Service" },
+	{ 135, FALSE, "Expanded Services" },
+	{ 136, FALSE, "Expanded Network" },
+	{ 137, TRUE, "Premium Service" },
+	{ 138, TRUE, "Enhanced Service" },
+	{ 139, TRUE, "Enhanced Digital" },
+	{ 140, TRUE, "Enhanced Roaming" },
+	{ 141, TRUE, "Alliance Service" },
+	{ 142, TRUE, "Alliance Network" },
+	{ 143, TRUE, "Data Roaming" },	/* Sprint: Vision Roaming */
+	{ 144, TRUE, "Extended Service" },
+	{ 145, TRUE, "Expanded Services" },
+	{ 146, TRUE, "Expanded Network" },
+	{ 147, TRUE, "Premium Service" },
+	{ 148, TRUE, "Enhanced Service" },
+	{ 149, TRUE, "Enhanced Digital" },
+	{ 150, TRUE, "Enhanced Roaming" },
+	{ 151, TRUE, "Alliance Service" },
+	{ 152, TRUE, "Alliance Network" },
+	{ 153, TRUE, "Data Roaming" },	/* Sprint: Vision Roaming */
+	{ 154, TRUE, "Extended Service" },
+	{ 155, TRUE, "Expanded Services" },
+	{ 156, TRUE, "Expanded Network" },
+	{ 157, TRUE, "Premium International" },
+	{ 158, TRUE, "Premium International" },
+	{ 159, TRUE, "Premium International" },
+	{ 160, TRUE, NULL },
+	{ 161, TRUE, NULL },
+	{ 162, FALSE, NULL },
+	{ 163, FALSE, NULL },
+	{ 164, FALSE, "Extended Voice/Data Network" },
+	{ 165, FALSE, "Extended Voice/Data Network" },
+	{ 166, TRUE, "Extended Voice/Data Network" },
+	{ 167, FALSE, "Extended Broadband" },
+	{ 168, FALSE, "Extended Broadband" },
+	{ 169, TRUE, "Extended Broadband" },
+	{ 170, FALSE, "Extended Data" },
+	{ 171, FALSE, "Extended Data" },
+	{ 172, TRUE, "Extended Data" },
+	{ 173, FALSE, "Extended Data Network" },
+	{ 174, FALSE, "Extended Data Network" },
+	{ 175, TRUE, "Extended Data Network" },
+	{ 176, FALSE, "Extended Network" },
+	{ 177, FALSE, "Extended Network" },
+	{ 178, TRUE, "Extended Network" },
+	{ 179, FALSE, "Extended Service" },
+	{ 180, TRUE, "Extended Service" },
+	{ 181, FALSE, "Extended Voice" },
+	{ 182, FALSE, "Extended Voice" },
+	{ 183, TRUE, "Extended Voice" },
+	{ 184, FALSE, "Extended Voice/Data" },
+	{ 185, FALSE, "Extended Voice/Data" },
+	{ 186, TRUE, "Extended Voice/Data" },
+	{ 187, FALSE, "Extended Voice Network" },
+	{ 188, FALSE, "Extended Voice Network" },
+	{ 189, TRUE, "Extended Voice Network" },
+	{ 190, FALSE, "Extended Voice/Data" },
+	{ 191, FALSE, "Extended Voice/Data" },
+	{ 192, TRUE, "Extended Voice/Data" },
+	{ 193, TRUE, "International" },
+	{ 194, FALSE, "International Services" },
+	{ 195, FALSE, "International Voice" },
+	{ 196, FALSE, "International Voice/Data" },
+	{ 197, FALSE, "International Voice/Data" },
+	{ 198, TRUE, "International Voice/Data" },
+	{ 199, FALSE, "Extended Voice/Data Network" },
+	{ 200, TRUE, "Extended Voice/Data Network" },
+	{ 201, TRUE, "Extended Voice/Data Network" },
+	{ 202, FALSE, "Extended Broadband" },
+	{ 203, TRUE, "Extended Broadband" },
+	{ 204, TRUE, "Extended Broadband" },
+	{ 205, FALSE, "Extended Data" },
+	{ 206, TRUE, "Extended Data" },
+	{ 207, TRUE, "Extended Data" },
+	{ 208, FALSE, "Extended Data Network" },
+	{ 209, TRUE, "Extended Data Network" },
+	{ 210, TRUE, "Extended Data Network" },
+	{ 211, FALSE, "Extended Network" },
+	{ 212, TRUE, "Extended Network" },
+	{ 213, FALSE, "Extended Service" },
+	{ 214, TRUE, "Extended Service" },
+	{ 215, TRUE, "Extended Service" },
+	{ 216, FALSE, "Extended Voice" },
+	{ 217, TRUE, "Extended Voice" },
+	{ 218, TRUE, "Extended Voice" },
+	{ 219, FALSE, "Extended Voice/Data" },
+	{ 220, TRUE, "Extended Voice/Data" },
+	{ 221, TRUE, "Extended Voice/Data" },
+	{ 222, FALSE, "Extended Voice Network" },
+	{ 223, FALSE, "Extended Voice Network" },
+	{ 224, TRUE, "Extended Voice Network" },
+	{ 225, FALSE, "Extended Voice/Data" },
+	{ 226, TRUE, "Extended Voice/Data" },
+	{ 227, TRUE, "Extended Voice/Data" },
+	{ 228, TRUE, "International" },
+	{ 229, TRUE, "International" },
+	{ 230, TRUE, "International Services" },
+	{ 231, TRUE, "International Voice" },
+	{ 232, FALSE, "International Voice/Data" },
+	{ 233, TRUE, "International Voice/Data" },
+	{ 234, TRUE, "International Voice/Data" },
+	{ 235, TRUE, "Premium International" },
+	{ 236, TRUE, NULL },
+	{ 237, TRUE, NULL },
+	{ 238, FALSE, NULL },
+	{ 239, FALSE, NULL },
+	{ -1, FALSE, NULL },
+};
+
+gboolean sierramodem_parse_eri(const gchar *reply, gboolean *out_roaming,
+					guint *out_ind, const gchar **out_desc)
+{
+	guint ind;
+	const EriItem *iter =3D &eris[0];
+	gboolean found =3D FALSE;
+
+	g_return_val_if_fail(reply !=3D NULL, FALSE);
+	g_return_val_if_fail(out_roaming !=3D NULL, FALSE);
+
+	if (get_uint_from_str(reply, &ind)) {
+		if (out_ind)
+			*out_ind =3D ind;
+
+		while (iter->num !=3D -1) {
+			if (iter->num =3D=3D ind) {
+				*out_roaming =3D iter->roam_ind;
+				if (out_desc)
+					*out_desc =3D iter->banner;
+				found =3D TRUE;
+				break;
+			}
+			iter++;
+		}
+	}
+
+	return found;
+}
diff --git a/drivers/sierramodem/eri.h b/drivers/sierramodem/eri.h
new file mode 100644
index 0000000..cecb0c5
--- /dev/null
+++ b/drivers/sierramodem/eri.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+gboolean sierramodem_parse_eri(const gchar *reply, gboolean *out_roaming,
+					guint *out_ind, const gchar **out_desc);
-- =

1.7.0.4

--===============4638043756976971570==--

