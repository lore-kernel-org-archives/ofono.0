Content-Type: multipart/mixed; boundary="===============4220936072000629239=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/15] Add 23.032 GAD Shape structs and encoding utility
Date: Fri, 11 Jun 2010 12:39:58 +0200
Message-ID: <1276252800-27515-13-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4220936072000629239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not sure if common.c is the right place for this, or should it be in
util.c or somewhere else.
---
 Makefile.am  |    5 +-
 src/common.c |  395 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/common.h |   79 ++++++++++++
 3 files changed, 477 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2ca0703..6476ec1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -271,7 +271,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c
 =

-src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
+src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ \
+			-ldl -lm
 =

 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic -Wl,--version-script=3Dsrc/ofo=
no.ver
 =

@@ -362,7 +363,7 @@ noinst_PROGRAMS =3D unit/test-common unit/test-util uni=
t/test-idmap \
 					unit/test-stkutil
 =

 unit_test_common_SOURCES =3D unit/test-common.c src/common.c
-unit_test_common_LDADD =3D @GLIB_LIBS@
+unit_test_common_LDADD =3D @GLIB_LIBS@ -lm
 unit_objects +=3D $(unit_test_common_OBJECTS)
 =

 unit_test_util_SOURCES =3D unit/test-util.c src/util.c
diff --git a/src/common.c b/src/common.c
index 4eaff5e..3ae6acf 100644
--- a/src/common.c
+++ b/src/common.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <errno.h>
+#include <math.h>
 =

 #include <glib.h>
 =

@@ -686,3 +687,397 @@ gboolean is_valid_apn(const char *apn)
 =

 	return TRUE;
 }
+
+/* 23.032 Section 6.1 */
+static ofono_bool_t gad_point_encode(guint8 *buffer,
+					const struct gad_ellipsoid_point *pt)
+{
+	int val;
+
+	if (pt->lat < -90.0 || pt->lat > 90.0)
+		return FALSE;
+
+	if (pt->lat < 0.0)
+		buffer[0] =3D 0x80;
+	else
+		buffer[0] =3D 0x00;
+
+	val =3D fabs(pt->lat) * (1 << 23) / 90.0;
+	buffer[0] |=3D val >> 16;
+	buffer[1] =3D (val >> 8) & 0xff;
+	buffer[2] =3D (val >> 0) & 0xff;
+
+	val =3D pt->lon * (1 << 24) / 360.0;
+	buffer[3] =3D (val >> 16) & 0xff;
+	buffer[4] =3D (val >> 8) & 0xff;
+	buffer[5] =3D (val >> 0) & 0xff;
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.2 */
+static ofono_bool_t gad_uncertainty_encode(guint8 *buffer, double r)
+{
+	if (r < 0.0)
+		return FALSE;
+
+	buffer[0] =3D MIN(127.0, round(log(r / 10.0 + 1) / log(1.1)));
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.3 */
+static ofono_bool_t gad_altitude_encode(guint8 *buffer, double a)
+{
+	int val;
+
+	val =3D MIN(fabs@, 32767.0);
+	if (a >=3D 0.0)
+		buffer[0] =3D 0x00;
+	else
+		buffer[0] =3D 0x80;
+	buffer[0] |=3D val >> 8;
+	buffer[1] =3D val & 0xff;
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.4 */
+static ofono_bool_t gad_uncertainty_altitude_encode(guint8 *buffer, double=
 h)
+{
+	if (h < 0.0)
+		return FALSE;
+
+	buffer[0] =3D MIN(127.0, round(log(h / 45.0 + 1) / log(1.025)));
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.5 */
+static ofono_bool_t gad_confidence_encode(guint8 *buffer, int p)
+{
+	if (p < 0 || p > 100)
+		return FALSE;
+
+	buffer[0] =3D p;
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.6 */
+static ofono_bool_t gad_radius_encode(guint8 *buffer, double r)
+{
+	int val;
+
+	if (r < 0.0)
+		return FALSE;
+
+	val =3D MIN(r / 5.0, 65535.0);
+	buffer[0] |=3D val >> 8;
+	buffer[1] =3D val & 0xff;
+
+	return TRUE;
+}
+
+/* 23.032 Section 6.7 */
+static ofono_bool_t gad_offset_angle_encode(guint8 *buffer, double ao)
+{
+	if (ao < 0.0 || ao >=3D 360.0)
+		return FALSE;
+
+	buffer[0] =3D ao / 2.0;
+
+	return TRUE;
+}
+
+static ofono_bool_t gad_include_angle_encode(guint8 *buffer, double ai)
+{
+	if (ai <=3D 0.0 || ai > 360.0)
+		return FALSE;
+
+	buffer[0] =3D ceil(ai / 2.0);
+
+	return TRUE;
+}
+
+/* 23.032 Section 8.7 */
+static ofono_bool_t gad_horiz_speed_encode(guint8 *buffer, double h)
+{
+	int val;
+
+	if (h < 0.0)
+		return FALSE;
+
+	val =3D MIN(MAX(0.0, h + 0.5), 65535.5);
+	buffer[0] =3D val >> 8;
+	buffer[1] =3D val & 0xff;
+
+	return TRUE;
+}
+
+/* 23.032 Section 8.8 */
+static ofono_bool_t gad_bearing_encode(guint8 *buffer, double b)
+{
+	int val;
+
+	if (b < 0.0 || b >=3D 360.0)
+		return FALSE;
+
+	val =3D b;
+	buffer[0] |=3D val >> 8;
+	buffer[1] =3D val & 0xff;
+
+	return TRUE;
+}
+
+/* 23.032 Sections 8.9, 8.10 */
+static ofono_bool_t gad_vert_speed_encode(guint8 *buffer, double v)
+{
+	buffer[0] =3D MIN(MAX(0.0, fabs(v) + 0.5), 255.5);
+
+	return TRUE;
+}
+
+/*
+ * Encode 'shape' into 'buffer'.  'len' is an in/out parameter that must
+ * initially contain the buffer capacity and receives the number of bytes
+ * written into the buffer.  Returns TRUE on success.
+ */
+ofono_bool_t gad_shape_encode(const struct gad_shape *shape,
+				guint8 *buffer, int *len)
+{
+	int i;
+
+	if (*len < 7)
+		return FALSE;
+
+	buffer[0] =3D shape->type << 4;
+
+	switch (shape->type) {
+	case GAD_TYPE_ELLIPSOID_POINT:
+		*len =3D 7;
+
+		return gad_point_encode(buffer + 1, &shape->ellipsoid_point);
+
+	case GAD_TYPE_ELLIPSOID_CIRCLE:
+		if (*len < 8)
+			return FALSE;
+
+		if (gad_point_encode(buffer + 1,
+					&shape->ellipsoid_circle.origin) !=3D
+				TRUE)
+			return FALSE;
+
+		*len =3D 8;
+		return gad_uncertainty_encode(buffer + 7,
+						shape->ellipsoid_circle.r);
+
+	case GAD_TYPE_ELLIPSOID_ELLIPSE:
+		if (*len < 11)
+			return FALSE;
+
+		if (gad_point_encode(buffer + 1,
+					&shape->ellipsoid_ellipse.origin) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_encode(buffer + 7,
+						shape->ellipsoid_ellipse.r1) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_encode(buffer + 8,
+						shape->ellipsoid_ellipse.r2) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_offset_angle_encode(buffer + 9,
+						shape->ellipsoid_ellipse.a) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_confidence_encode(buffer + 10,
+					shape->ellipsoid_ellipse.confidence) !=3D
+				TRUE)
+			return FALSE;
+
+		*len =3D 11;
+		return TRUE;
+
+	case GAD_TYPE_POLYGON:
+		if (shape->polygon.count < 3 || shape->polygon.count > 15)
+			return FALSE;
+		if (*len < 1 + 6 * shape->polygon.count)
+			return FALSE;
+
+		buffer[0] |=3D shape->polygon.count;
+		for (i =3D 0; i < shape->polygon.count; i++)
+			if (gad_point_encode(buffer + i * 6 + 1,
+						&shape->polygon.point[i]) !=3D
+					TRUE)
+				return FALSE;
+
+		*len =3D 1 + 6 * shape->polygon.count;
+		return TRUE;
+
+	case GAD_TYPE_POINT_WITH_ALTITUDE:
+		if (*len < 9)
+			return FALSE;
+
+		if (gad_point_encode(buffer + 1,
+					&shape->point_with_altitude.origin) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_altitude_encode(buffer + 7,
+					shape->point_with_altitude.altitude) !=3D
+				TRUE)
+			return FALSE;
+
+		*len =3D 9;
+		return TRUE;
+
+	case GAD_TYPE_ELLIPSOID_WITH_ALTITUDE:
+		if (*len < 14)
+			return FALSE;
+		if (shape->ellipsoid_with_altitude.r1 <
+				shape->ellipsoid_with_altitude.r2)
+			return FALSE;
+
+		if (gad_point_encode(buffer + 1,
+				&shape->ellipsoid_with_altitude.origin) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_altitude_encode(buffer + 7,
+				shape->ellipsoid_with_altitude.altitude) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_encode(buffer + 9,
+					shape->ellipsoid_with_altitude.r1) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_encode(buffer + 10,
+					shape->ellipsoid_with_altitude.r2) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_offset_angle_encode(buffer + 11,
+					shape->ellipsoid_with_altitude.a) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_altitude_encode(buffer + 12,
+					shape->ellipsoid_with_altitude.r3) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_confidence_encode(buffer + 13,
+				shape->ellipsoid_with_altitude.confidence) !=3D
+				TRUE)
+			return FALSE;
+
+		*len =3D 14;
+		return TRUE;
+
+	case GAD_TYPE_ELLIPSOID_ARC:
+		if (*len < 13)
+			return FALSE;
+
+		if (gad_point_encode(buffer + 1,
+					&shape->ellipsoid_arc.origin) !=3D TRUE)
+			return FALSE;
+		if (gad_radius_encode(buffer + 7, shape->ellipsoid_arc.r1) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_uncertainty_encode(buffer + 9,
+						shape->ellipsoid_arc.r2) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_offset_angle_encode(buffer + 10,
+						shape->ellipsoid_arc.alpha) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_include_angle_encode(buffer + 11,
+						shape->ellipsoid_arc.beta) !=3D
+				TRUE)
+			return FALSE;
+		if (gad_confidence_encode(buffer + 12,
+					shape->ellipsoid_arc.confidence) !=3D
+				TRUE)
+			return FALSE;
+
+		*len =3D 13;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+ofono_bool_t gad_velocity_encode(const struct gad_velocity *velocity,
+				guint8 *buffer, int *len)
+{
+	if (velocity->has_vertical !=3D TRUE &&
+			velocity->has_uncertainty !=3D TRUE) {
+		if (*len < 4)
+			return FALSE;
+		buffer[0] =3D GAD_VELOCITY_TYPE_HORIZ << 4;
+
+		if (gad_bearing_encode(buffer + 0, velocity->bearing) !=3D TRUE)
+			return FALSE;
+		if (gad_horiz_speed_encode(buffer + 2,
+						velocity->horizontal) !=3D TRUE)
+			return FALSE;
+
+		*len =3D 4;
+		return TRUE;
+	} else if (velocity->has_vertical =3D=3D TRUE &&
+			velocity->has_uncertainty !=3D TRUE) {
+		if (*len < 5)
+			return FALSE;
+		buffer[0] =3D GAD_VELOCITY_TYPE_HORIZ_VERT << 4;
+		if (velocity->vertical < 0.0)
+			buffer[0] |=3D 1 << 1; /* Direction of Vert Speed bit */
+
+		if (gad_bearing_encode(buffer + 0, velocity->bearing) !=3D TRUE)
+			return FALSE;
+		if (gad_horiz_speed_encode(buffer + 2,
+						velocity->horizontal) !=3D TRUE)
+			return FALSE;
+		if (gad_vert_speed_encode(buffer + 4,
+						velocity->vertical) !=3D TRUE)
+			return FALSE;
+
+		*len =3D 5;
+		return TRUE;
+	} else if (velocity->has_vertical !=3D TRUE &&
+			velocity->has_uncertainty =3D=3D TRUE) {
+		if (*len < 5)
+			return FALSE;
+		buffer[0] =3D GAD_VELOCITY_TYPE_HORIZ_UNCERTAINTY << 4;
+
+		if (gad_bearing_encode(buffer + 0, velocity->bearing) !=3D TRUE)
+			return FALSE;
+		if (gad_horiz_speed_encode(buffer + 2,
+						velocity->horizontal) !=3D TRUE)
+			return FALSE;
+		buffer[4] =3D velocity->horizontal_uncertainty;
+
+		*len =3D 5;
+		return TRUE;
+	} else if (velocity->has_vertical =3D=3D TRUE &&
+			velocity->has_uncertainty =3D=3D TRUE) {
+		if (*len < 7)
+			return FALSE;
+		buffer[0] =3D GAD_VELOCITY_TYPE_HORIZ_VERT_UNCERTAINTY << 4;
+		if (velocity->vertical < 0.0)
+			buffer[0] |=3D 1 << 1; /* Direction of Vert Speed bit */
+
+		if (gad_bearing_encode(buffer + 0, velocity->bearing) !=3D TRUE)
+			return FALSE;
+		if (gad_horiz_speed_encode(buffer + 2,
+						velocity->horizontal) !=3D TRUE)
+			return FALSE;
+		if (gad_vert_speed_encode(buffer + 4,
+						velocity->vertical) !=3D TRUE)
+			return FALSE;
+		buffer[5] =3D velocity->horizontal_uncertainty;
+		buffer[6] =3D velocity->vertical_uncertainty;
+
+		*len =3D 7;
+		return TRUE;
+	}
+
+	return FALSE;
+}
diff --git a/src/common.h b/src/common.h
index c43e46d..2fc09b1 100644
--- a/src/common.h
+++ b/src/common.h
@@ -122,6 +122,80 @@ enum pin_type {
 	PIN_TYPE_NET,
 };
 =

+enum gad_shape_type {
+	GAD_TYPE_ELLIPSOID_POINT		=3D 0,
+	GAD_TYPE_ELLIPSOID_CIRCLE		=3D 1,
+	GAD_TYPE_ELLIPSOID_ELLIPSE		=3D 3,
+	GAD_TYPE_POLYGON			=3D 5,
+	GAD_TYPE_POINT_WITH_ALTITUDE		=3D 8,
+	GAD_TYPE_ELLIPSOID_WITH_ALTITUDE	=3D 9,
+	GAD_TYPE_ELLIPSOID_ARC			=3D 10,
+};
+
+struct gad_ellipsoid_point {
+	double lat, lon;
+};
+
+struct gad_ellipsoid_circle {
+	struct gad_ellipsoid_point origin;
+	double r;
+};
+
+struct gad_ellipsoid_ellipse {
+	struct gad_ellipsoid_point origin;
+	double r1, r2, a;
+	int confidence;
+};
+
+struct gad_ellipsoid_polygon {
+	struct gad_ellipsoid_point point[15];
+	int count;
+};
+
+struct gad_point_with_altitude {
+	struct gad_ellipsoid_point origin;
+	double altitude;
+};
+
+struct gad_ellipsoid_with_altitude {
+	struct gad_ellipsoid_point origin;
+	double r1, r2, r3, a, altitude;
+	int confidence;
+};
+
+struct gad_ellipsoid_arc {
+	struct gad_ellipsoid_point origin;
+	double r1, r2, alpha, beta;
+	int confidence;
+};
+
+struct gad_shape {
+	enum gad_shape_type type;
+	union {
+		struct gad_ellipsoid_point ellipsoid_point;
+		struct gad_ellipsoid_circle ellipsoid_circle;
+		struct gad_ellipsoid_ellipse ellipsoid_ellipse;
+		struct gad_ellipsoid_polygon polygon;
+		struct gad_point_with_altitude point_with_altitude;
+		struct gad_ellipsoid_with_altitude ellipsoid_with_altitude;
+		struct gad_ellipsoid_arc ellipsoid_arc;
+	};
+};
+
+enum gad_velocity_type {
+	GAD_VELOCITY_TYPE_HORIZ				=3D 0,
+	GAD_VELOCITY_TYPE_HORIZ_VERT			=3D 1,
+	GAD_VELOCITY_TYPE_HORIZ_UNCERTAINTY		=3D 2,
+	GAD_VELOCITY_TYPE_HORIZ_VERT_UNCERTAINTY	=3D 3,
+};
+
+struct gad_velocity {
+	double horizontal, vertical, bearing;
+	guint8 horizontal_uncertainty, vertical_uncertainty;
+	ofono_bool_t has_vertical;
+	ofono_bool_t has_uncertainty;
+};
+
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
@@ -147,3 +221,8 @@ const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
 =

 gboolean is_valid_apn(const char *apn);
+
+ofono_bool_t gad_shape_encode(const struct gad_shape *shape,
+				guint8 *buffer, int *len);
+ofono_bool_t gad_velocity_encode(const struct gad_velocity *velocity,
+					guint8 *buffer, int *len);
-- =

1.7.1.86.g0e460.dirty


--===============4220936072000629239==--

