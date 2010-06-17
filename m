Content-Type: multipart/mixed; boundary="===============7676592073052564479=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] GAD shape tests
Date: Thu, 17 Jun 2010 15:42:07 +0200
Message-ID: <1276782135-26871-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7676592073052564479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    6 ++-
 unit/test-lcsutil.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 163 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-lcsutil.c

diff --git a/Makefile.am b/Makefile.am
index 2b59f01..a661200 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -360,7 +360,7 @@ unit_objects =3D
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-lcsutil
 =

 unit_test_common_SOURCES =3D unit/test-common.c src/common.c
 unit_test_common_LDADD =3D @GLIB_LIBS@
@@ -399,6 +399,10 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_=
sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_lcsutil_SOURCES =3D unit/test-lcsutil.c src/lcsutil.c
+unit_test_lcsutil_LDADD =3D @GLIB_LIBS@ -lm
+unit_objects +=3D $(unit_test_lcsutil_OBJECTS)
+
 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
diff --git a/unit/test-lcsutil.c b/unit/test-lcsutil.c
new file mode 100644
index 0000000..ca494d6
--- /dev/null
+++ b/unit/test-lcsutil.c
@@ -0,0 +1,158 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdint.h>
+#include <glib.h>
+
+#include <ofono/types.h>
+
+#include "lcsutil.h"
+
+struct gad_shape_test {
+	uint8_t coding[128];
+	int len;
+	struct gad_shape shape;
+};
+
+static const struct gad_shape_test gad_shape_valid[] =3D {
+	{
+		.coding =3D { 0x00, 0x49, 0xf4, 0x9f, 0x0e, 0xee, 0xee, },
+		.len =3D 7,
+		.shape =3D {
+			.type =3D GAD_TYPE_ELLIPSOID_POINT,
+			{ .ellipsoid_point =3D { .lat =3D 52, .lon =3D 21 } },
+		},
+	}, {
+		.coding =3D {
+			0x90, 0x49, 0xf4, 0x9f, 0x0e, 0xee, 0xee,
+			0x80, 0x64, 0x3c, 0x02, 0x02, 0x3c, 0x5d,
+		},
+		.len =3D 14,
+		.shape =3D {
+			.type =3D GAD_TYPE_ELLIPSOID_WITH_ALTITUDE,
+			{ .ellipsoid_with_altitude =3D {
+				.origin =3D { .lat =3D 52, .lon =3D 21 }, /* deg */
+				.r1 =3D 3000.0, /* m */
+				.r2 =3D 2.1, /* m */
+				.r3 =3D 153.0, /* m */
+				.a =3D 5.0, /* deg */
+				.altitude =3D -100.0, /* m undeground */
+				.confidence =3D 93, /* % */
+			}},
+		},
+	}, {
+		.coding =3D {
+			0x55, 0x4a, 0x3d, 0x70, 0x0e, 0xee, 0xee,
+			0x49, 0x3e, 0x93, 0x00, 0x15, 0xd8, 0x40,
+			0xb6, 0x0b, 0xa8, 0xbf, 0x26, 0x91, 0x11,
+			0x11, 0xc9, 0x3e, 0x94, 0xa5, 0x43, 0x20,
+			0x13, 0xe9, 0x3e,
+		},
+		.len =3D 31,
+		.shape =3D {
+			.type =3D GAD_TYPE_POLYGON,
+			{ .polygon =3D {
+				.count =3D 5,
+				.point =3D {
+					{ .lat =3D 52.2, .lon =3D 21.0 },
+					{ .lat =3D 51.5, .lon =3D 0.12 },
+					{ .lat =3D 45.5, .lon =3D -122.7 },
+					{ .lat =3D -12.0, .lon =3D -77.0 },
+					{ .lat =3D -26.2, .lon =3D 28.0 },
+				},
+			}},
+		},
+	},
+
+	{},
+};
+
+static void test_gad_shape(void) {
+	const struct gad_shape_test *test;
+	uint8_t buf[128];
+	int len;
+
+	for (test =3D gad_shape_valid; test->len; test++) {
+		len =3D sizeof(buf);
+		g_assert(gad_shape_encode(&test->shape, buf, &len));
+		g_assert(len =3D=3D test->len);
+		g_assert(memcmp(buf, test->coding, len) =3D=3D 0);
+	}
+}
+
+struct gad_velocity_test {
+	uint8_t coding[128];
+	int len;
+	struct gad_velocity velocity;
+};
+
+static const struct gad_velocity_test gad_velocity_valid[] =3D {
+	{
+		.coding =3D { 0x33, 0x0e, 0x00, 0x1e, 0x05, 0x01, 0x01, },
+		.len =3D 7,
+		.velocity =3D {
+			.horizontal =3D 30.0, /* kmh */
+			.bearing =3D 270.0, /* deg */
+			.has_vertical =3D TRUE,
+			.vertical =3D -5, /* kmh */
+			.has_uncertainty =3D TRUE,
+			.horizontal_uncertainty =3D 1, /* kmh */
+			.vertical_uncertainty =3D 1, /* kmh */
+		},
+	}, {
+		.coding =3D { 0x00, 0x05, 0x00, 0x1e, },
+		.len =3D 4,
+		.velocity =3D {
+			.horizontal =3D 30.0, /* kmh */
+			.bearing =3D 5.0, /* deg */
+		},
+	},
+
+	{},
+};
+
+static void test_gad_velocity(void) {
+	const struct gad_velocity_test *test;
+	uint8_t buf[128];
+	int len;
+
+	for (test =3D gad_velocity_valid; test->len; test++) {
+		len =3D sizeof(buf);
+		g_assert(gad_velocity_encode(&test->velocity, buf, &len));
+		g_assert(len =3D=3D test->len);
+		g_assert(memcmp(buf, test->coding, len) =3D=3D 0);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/testutil/GAD Shape", test_gad_shape);
+	g_test_add_func("/testutil/GAD Velocity", test_gad_velocity);
+
+	return g_test_run();
+}
-- =

1.7.1.86.g0e460.dirty


--===============7676592073052564479==--

