Content-Type: multipart/mixed; boundary="===============5078170820467315073=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] stkutil: Add the Geographical Location Reporting envelope
 builder
Date: Thu, 17 Jun 2010 15:42:08 +0200
Message-ID: <1276782135-26871-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5078170820467315073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    4 +-
 src/stk.c           |    1 +
 src/stkutil.c       |   66 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h       |   15 +++++++++++
 unit/test-stkutil.c |    1 +
 5 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a661200..3784627 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,8 +385,8 @@ unit_objects +=3D $(unit_test_simutil_OBJECTS)
 =

 unit_test_stkutil_SOURCES =3D unit/test-stkutil.c src/util.c \
 				src/storage.c src/smsutil.c \
-				src/simutil.c src/stkutil.c
-unit_test_stkutil_LDADD =3D @GLIB_LIBS@
+				src/simutil.c src/stkutil.c src/lcsutil.c
+unit_test_stkutil_LDADD =3D @GLIB_LIBS@ -lm
 unit_objects +=3D $(unit_test_stkutil_OBJECTS)
 =

 unit_test_mux_SOURCES =3D unit/test-mux.c $(gatchat_sources)
diff --git a/src/stk.c b/src/stk.c
index b5c6919..2325326 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -35,6 +35,7 @@
 #include "ofono.h"
 =

 #include "smsutil.h"
+#include "lcsutil.h"
 #include "stkutil.h"
 =

 static GSList *g_drivers =3D NULL;
diff --git a/src/stkutil.c b/src/stkutil.c
index 44a8eff..914ac1f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -31,6 +31,7 @@
 =

 #include <ofono/types.h>
 #include "smsutil.h"
+#include "lcsutil.h"
 #include "stkutil.h"
 #include "simutil.h"
 #include "util.h"
@@ -5155,6 +5156,60 @@ static gboolean build_dataobj_rejection_cause_code(s=
truct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.95 */
+static gboolean build_dataobj_gad_shape(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_gad_shapes *shapes =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_GAD_SHAPE;
+	unsigned char shape_buf[128];
+	unsigned char velocity_buf[8];
+	int shape_len =3D sizeof(shape_buf);
+	int velocity_len =3D sizeof(velocity_buf);
+
+	if (shapes->has_shape !=3D TRUE)
+		return TRUE;
+
+	if (gad_shape_encode(&shapes->shape, shape_buf, &shape_len) !=3D TRUE)
+		return FALSE;
+
+	if (shapes->has_velocity =3D=3D TRUE) {
+		if (gad_velocity_encode(&shapes->velocity,
+					velocity_buf, &velocity_len) !=3D TRUE)
+			return FALSE;
+	} else
+		velocity_len =3D 0;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, shape_len) &&
+		stk_tlv_builder_append_bytes(tlv, shape_buf, shape_len) &&
+		stk_tlv_builder_append_byte(tlv, velocity_len) &&
+		stk_tlv_builder_append_bytes(tlv, velocity_buf, velocity_len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 131.111 Section 8.96 */
+static gboolean build_dataobj_nmea_sentence(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const char *nmea =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_NMEA_SENTENCE;
+	int len;
+
+	if (nmea =3D=3D NULL)
+		return TRUE;
+
+	len =3D strlen(nmea);
+	if (len > 0x7e)
+		return FALSE;
+
+	/* No need to convert because NMEA only uses basic ASCII, UTF8 subset */
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, len) &&
+		stk_tlv_builder_append_bytes(tlv, (void *) nmea, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 131.111 Section 8.98, 3GPP 24.301 Section 6.5.1 */
 static gboolean build_dataobj_eps_pdn_conn_params(struct stk_tlv_builder *=
tlv,
 						const void *data, gboolean cr)
@@ -5883,6 +5938,17 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 	case STK_ENVELOPE_TYPE_TERMINAL_APP:
 		ok =3D build_envelope_terminal_apps(&builder, envelope);
 		break;
+	case STK_ENVELOPE_TYPE_GEOLOCATION_REPORT:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_gad_shape, 0,
+					&envelope->geolocation_report.shape,
+					build_dataobj_nmea_sentence, 0,
+					&envelope->geolocation_report.nmea,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 471e10f..8141383 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -182,6 +182,7 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_ROUTING_AREA_INFO =3D		0x73,
 	STK_DATA_OBJECT_TYPE_UPDATE_ATTACH_TYPE =3D		0x74,
 	STK_DATA_OBJECT_TYPE_REJECTION_CAUSE_CODE =3D		0x75,
+	STK_DATA_OBJECT_TYPE_GAD_SHAPE =3D			0x77,
 	STK_DATA_OBJECT_TYPE_NMEA_SENTENCE =3D			0x78,
 	STK_DATA_OBJECT_TYPE_PLMN_LIST =3D			0x79,
 	STK_DATA_OBJECT_TYPE_BROADCAST_NETWORK_INFO =3D		0x7A,
@@ -1031,6 +1032,14 @@ struct stk_routing_area_info {
 	unsigned char rac;
 };
 =

+/* Defined in TS 131.111 Section 8.95 */
+struct stk_gad_shapes {
+	struct gad_shape shape;
+	struct gad_velocity velocity;
+	ofono_bool_t has_shape; /* Whether the struct is valid */
+	ofono_bool_t has_velocity; /* Whether velocity is known */
+};
+
 /* Defined in TS 131.111 Section 8.99 */
 struct stk_tracking_area_id {
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
@@ -1592,6 +1601,11 @@ struct stk_envelope_terminal_apps {
 	ofono_bool_t last;
 };
 =

+struct stk_envelope_geolocation_report {
+	struct stk_gad_shapes shape;
+	const char *nmea;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1608,6 +1622,7 @@ struct stk_envelope {
 		struct stk_envelope_mms_transfer_status mms_status;
 		struct stk_envelope_mms_notification_download mms_notification;
 		struct stk_envelope_terminal_apps terminal_apps;
+		struct stk_envelope_geolocation_report geolocation_report;
 	};
 };
 =

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 706dd85..0c38dab 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -34,6 +34,7 @@
 =

 #include <ofono/types.h>
 #include "smsutil.h"
+#include "lcsutil.h"
 #include "stkutil.h"
 #include "util.h"
 =

-- =

1.7.1.86.g0e460.dirty


--===============5078170820467315073==--

