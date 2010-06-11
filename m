Content-Type: multipart/mixed; boundary="===============8273996375211045083=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/15] test-common: Add GAD shape tests
Date: Fri, 11 Jun 2010 12:39:59 +0200
Message-ID: <1276252800-27515-14-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8273996375211045083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-common.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/unit/test-common.c b/unit/test-common.c
index f33f117..42089c4 100644
--- a/unit/test-common.c
+++ b/unit/test-common.c
@@ -182,6 +182,122 @@ static void test_apn()
 	}
 }
 =

+struct gad_shape_test {
+	guint8 coding[128];
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
+	guint8 buf[128];
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
+	guint8 coding[128];
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
+	guint8 buf[128];
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
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -189,6 +305,8 @@ int main(int argc, char **argv)
 	g_test_add_func("/testutil/Invalid", test_invalid);
 	g_test_add_func("/testutil/Valid", test_valid);
 	g_test_add_func("/testutil/APN", test_apn);
+	g_test_add_func("/testutil/GAD Shape", test_gad_shape);
+	g_test_add_func("/testutil/GAD Velocity", test_gad_velocity);
 =

 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============8273996375211045083==--

