Content-Type: multipart/mixed; boundary="===============5132809099231868437=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 08/10] unit: Add unit tests for ril parcel processing
Date: Thu, 15 Oct 2015 18:47:01 +0200
Message-ID: <1444927623-31141-9-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5132809099231868437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-rilreply.c   | 2141 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 unit/test-rilrequest.c | 1737 +++++++++++++++++++++++++++++++++++++++
 unit/test-rilunsol.c   |  698 ++++++++++++++++
 3 files changed, 4576 insertions(+)
 create mode 100644 unit/test-rilreply.c
 create mode 100644 unit/test-rilrequest.c
 create mode 100644 unit/test-rilunsol.c

diff --git a/unit/test-rilreply.c b/unit/test-rilreply.c
new file mode 100644
index 0000000..4def06e
--- /dev/null
+++ b/unit/test-rilreply.c
@@ -0,0 +1,2141 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013 Canonical Ltd.
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
+#include <stdio.h>
+#include <assert.h>
+#include <glib.h>
+#include <errno.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/types.h>
+
+#include "common.h"
+#include "drivers/rilmodem/rilreply.h"
+
+/*
+ * TODO: It may make sense to split this file into
+ * domain-specific files ( eg. test-grilreply-gprs-context.c )
+ * once more tests are added.
+ */
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+typedef struct reg_state_test reg_state_test;
+struct reg_state_test {
+	int status;
+	int tech;
+	const struct ril_msg msg;
+};
+
+typedef struct get_preferred_network_test get_preferred_network_test;
+struct get_preferred_network_test {
+	int preferred;
+	const struct ril_msg msg;
+};
+
+struct query_facility_lock_test {
+	int status;
+	const struct ril_msg msg;
+};
+
+struct set_facility_lock_test {
+	int retries;
+	const struct ril_msg msg;
+};
+
+struct sim_password_test {
+	int retries;
+	enum ofono_sim_password_type passwd_type;
+	const struct ril_msg msg;
+};
+
+struct oem_hook_raw_test {
+	const unsigned char *data;
+	int size;
+	const struct ril_msg msg;
+};
+
+struct oem_hook_strings_test {
+	int num_str;
+	const char **str;
+	const struct ril_msg msg;
+};
+
+/* Invalid RIL_REQUEST_DATA_REGISTRATION_STATE: buffer too small */
+static const struct ril_msg reply_data_reg_state_invalid_1 =3D {
+	.buf =3D "XYZ",
+	.buf_len =3D 3,
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hex data represents a RIL_REQUEST_DATA_REGISTRATION_STATE
+ * reply with an invalid number of parameters ( 0 ).
+ */
+static const guchar reply_data_reg_state_invalid_parcel2[] =3D {
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_reg_state_invalid_2 =3D {
+	.buf =3D (gchar *) &reply_data_reg_state_invalid_parcel2,
+	.buf_len =3D sizeof(reply_data_reg_state_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hex data represents a RIL_REQUEST_DATA_REGISTRATION_STATE
+ * reply with a null status parameter:
+ *
+ * {(null),1b3f,07eaf3dc,HSPA,(null),20}
+ */
+static const guchar reply_data_reg_state_invalid_parcel3[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x04, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00, 0x65, 0x00, 0x61, 0x00,
+	0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_reg_state_invalid_3 =3D {
+	.buf =3D (gchar *) &reply_data_reg_state_invalid_parcel3,
+	.buf_len =3D sizeof(reply_data_reg_state_invalid_parcel3),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_UNKNOWN (0)
+ *
+ * {registered,1b3f,07eaf3dc,UNKNOWN,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel1[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_1 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_UNKNOWN,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel1,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_GSM (16)
+ *
+ * {registered,1b3f,07eaf3dc,GSM,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel2[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_2 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_GSM,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel2,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_GPRS (1)
+ *
+ * {registered,1b3f,07eaf3dc,GPRS,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel3[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_3 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_GPRS,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel3,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel3),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_EDGE (2)
+ *
+ * {registered,1b3f,07eaf3dc,EDGE,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel4[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_4 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_EDGE,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel4,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel4),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_UMTS (3)
+ *
+ * {registered,1b3f,07eaf3dc,UMTS,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel5[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_5 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_UMTS,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel5,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel5),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_HSDPA (9)
+ *
+ * {registered,1b3f,07eaf3dc,HSDPA,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel6[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x39, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_6 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_HSDPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel6,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel6),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_HSUPA (10)
+ *
+ * {registered,1b3f,07eaf3dc,HSUPA,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel7[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test data_reg_valid_7 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_HSUPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel7,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel7),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_HSPA (11)
+ *
+ * {registered,1b3f,07eaf3dc,HSPA,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel8[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x31, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+
+static const reg_state_test data_reg_valid_8 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_HSPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel8,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel8),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_LTE (14)
+ *
+ * {registered,1b3f,07eaf3dc,LTE,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel9[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+
+static const reg_state_test data_reg_valid_9 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_LTE,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel9,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel9),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid RIL_REQUEST_DATA_REGISTRATION=
_STATE
+ * reply with the following parameters:
+ *
+ * RADIO_TECH_HSPAP (15)
+ *
+ * Note, as ofono currently doesn't define a bearer enum that represents H=
SPA+,
+ * it's currently mapped to HSPA.
+ *
+ * {registered,1b3f,07eaf3dc,HSPAP,(null),20}
+ */
+static const guchar reply_data_reg_state_valid_parcel10[] =3D {
+	0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x66, 0x00, 0x33, 0x00, 0x64, 0x00, 0x63, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x35, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+
+static const reg_state_test data_reg_valid_10 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_HSPAP,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_data_reg_state_valid_parcel10,
+		.buf_len =3D sizeof(reply_data_reg_state_valid_parcel10),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_DATA_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * TODO: investigate creation of a base reply, which could
+ * then be modified for each test, as opposed to duplicating
+ * the bulk of the data for each test.
+ */
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_UMTS (3)
+ *
+ * {registered,1b3f,07eaf3dc,UMTS,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel1[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x37, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_1 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_REGISTERED,
+	.tech =3D RADIO_TECH_UMTS,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel1,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ *
+ * RADIO_TECH_GPRS (1)
+ *
+ * {unregistered,1b3f,07eaf3dc,GPRS,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel2[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x37, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_2 =3D {
+	.status =3D (int) NETWORK_REGISTRATION_STATUS_NOT_REGISTERED,
+	.tech =3D RADIO_TECH_GPRS,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel2,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_GSM (16)
+ *
+ * {searching,1b3f,07eaf3dc,GSM,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel3[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_3 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_SEARCHING,
+	.tech =3D RADIO_TECH_GSM,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel3,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel3),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_EDGE (2)
+ *
+ * {denied,1b3f,07eaf3dc,EDGE,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel4[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_4 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_DENIED,
+	.tech =3D RADIO_TECH_EDGE,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel4,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel4),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_UNKNOWN (0)
+ *
+ * {unknown,1b3f,07eaf3dc,UNKNOWN,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel5[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_5 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN,
+	.tech =3D RADIO_TECH_UNKNOWN,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel5,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel5),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_LTE (14)
+ *
+ * {roaming,1b3f,07eaf3dc,LTE,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel6[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_6 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_ROAMING,
+	.tech =3D RADIO_TECH_LTE,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel6,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel6),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_HSDPA (9)
+ *
+ * {roaming,1b3f,07eaf3dc,HSDPA,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel7[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x39, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_7 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_ROAMING,
+	.tech =3D RADIO_TECH_HSDPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel7,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel7),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_HSUPA (10)
+ *
+ * {roaming,1b3f,07eaf3dc,HSUPA,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel8[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_8 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_ROAMING,
+	.tech =3D RADIO_TECH_HSUPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel8,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel8),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_HSPA (11)
+ *
+ * {roaming,1b3f,07eaf3dc,HSPA,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel9[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x31, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_9 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_ROAMING,
+	.tech =3D RADIO_TECH_HSPA,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel9,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel9),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * RADIO_TECH_HSPAP (15)
+ *
+ * {roaming,1b3f,07eaf3dc,HSPAP,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel10[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x62, 0x00, 0x33, 0x00, 0x66, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x65, 0x00, 0x61, 0x00, 0x35, 0x00, 0x31, 0x00, 0x30, 0x00, 0x61, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x35, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x35, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_10 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_ROAMING,
+	.tech =3D RADIO_TECH_HSPAP,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel10,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel10),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * {unregistered,(null),(null),UNKNOWN,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel11[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+};
+
+static const reg_state_test voice_reg_valid_11 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED,
+	.tech =3D RADIO_TECH_UNKNOWN,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel11,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel11),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hex data represents a valid
+ * RIL_REQUEST_VOICE_REGISTRATION_STATE reply with the following parameter=
s:
+ *
+ * {13,(null),(null),UNKNOWN,(null),(null)}
+ */
+static const guchar reply_voice_reg_state_valid_parcel12[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x31, 0x00, 0x33, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x62, 0x00, 0x65, 0x00, 0x00, 0x00
+};
+
+static const reg_state_test voice_reg_valid_12 =3D {
+	.status =3D NETWORK_REGISTRATION_STATUS_DENIED,
+	.tech =3D RADIO_TECH_UNKNOWN,
+	.msg =3D {
+		.buf =3D (gchar *) &reply_voice_reg_state_valid_parcel12,
+		.buf_len =3D sizeof(reply_voice_reg_state_valid_parcel12),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_VOICE_REGISTRATION_STATE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+static const struct ril_msg reply_operator_invalid_1 =3D {
+	.buf =3D "",
+	.buf_len =3D 0,
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_OPERATOR,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of an
+ * invalid RIL_REQUEST_OPERATOR with an invald number of parameters
+ *
+ * {lalpha=3DAT&T, salpha=3D}
+ */
+static const guchar reply_operator_invalid_parcel2[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x41, 0x00, 0x54, 0x00,
+	0x26, 0x00, 0x54, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_operator_invalid_2 =3D {
+	.buf =3D (char *) &reply_operator_invalid_parcel2,
+	.buf_len =3D sizeof(reply_operator_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_OPERATOR,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a
+ * valid RIL_REQUEST_OPERATOR with the following parameters:
+ *
+ * {lalpha=3DAT&T, salpha=3D, numeric=3D310410}
+ */
+static const guchar reply_operator_valid_parcel1[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x41, 0x00, 0x54, 0x00,
+	0x26, 0x00, 0x54, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x33, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x31, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_operator_valid_1 =3D {
+	.buf =3D (char *) &reply_operator_valid_parcel1,
+	.buf_len =3D sizeof(reply_operator_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_OPERATOR,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+static const struct ril_msg reply_avail_ops_invalid_1 =3D {
+	.buf =3D "",
+	.buf_len =3D 0,
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_QUERY_AVAILABLE_NETWORKS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of an
+ * invalid RIL_REQUEST_QUERY_AVAILABLE_NETWORKS with an invald
+ * number of strings ( not evenly divisible by 4, the count of
+ * strings per operator ).
+ */
+static const guchar reply_avail_ops_invalid_parcel2[] =3D {
+	0x0b, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_avail_ops_invalid_2 =3D {
+	.buf =3D (char *) &reply_avail_ops_invalid_parcel2,
+	.buf_len =3D sizeof(reply_avail_ops_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_QUERY_AVAILABLE_NETWORKS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a
+ * valid RIL_REQUEST_AVAILABLE_NETWORKS with the following parameters:
+ *
+ * {lalpha=3DAT&T, salpha=3D, numeric=3D310410, status=3Davailable}
+ */
+static const guchar reply_avail_ops_valid_parcel1[] =3D {
+	0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x41, 0x00, 0x54, 0x00,
+	0x26, 0x00, 0x54, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x33, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x31, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x09, 0x00, 0x00, 0x00, 0x61, 0x00, 0x76, 0x00, 0x61, 0x00, 0x69, 0x00,
+	0x6c, 0x00, 0x61, 0x00, 0x62, 0x00, 0x6c, 0x00, 0x65, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_avail_ops_valid_1 =3D {
+	.buf =3D (char *) &reply_avail_ops_valid_parcel1,
+	.buf_len =3D sizeof(reply_avail_ops_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_QUERY_AVAILABLE_NETWORKS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_SIM_IO reply with the following parameters:
+ *
+ * {sw1=3D0x90,sw2=3D0x00,0000000a2fe2040000000005020000}
+ * This is a reply to a select file for EF_ICCID.
+ */
+static const guchar reply_sim_io_valid_parcel1[] =3D {
+	0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x61, 0x00, 0x32, 0x00, 0x66, 0x00, 0x65, 0x00, 0x32, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x32, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_sim_io_valid_1 =3D {
+	.buf =3D (gchar *) reply_sim_io_valid_parcel1,
+	.buf_len =3D sizeof(reply_sim_io_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SIM_IO,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of an valid
+ * RIL_REQUEST_SIM_IO reply with the following parameters:
+ *
+ * {sw1=3D0x90,sw2=3D0x00,(null)}
+ * This is a reply to a select file for EF_ICCID.
+ */
+static const guchar reply_sim_io_valid_parcel2[] =3D {
+	0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff
+};
+
+static const struct ril_msg reply_sim_io_valid_2 =3D {
+	.buf =3D (gchar *) reply_sim_io_valid_parcel2,
+	.buf_len =3D sizeof(reply_sim_io_valid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SIM_IO,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of an invalid
+ * RIL_REQUEST_SIM_IO reply with the following parameters:
+ *
+ * Note - this is invalid because the response includes a non-hex char ('Z=
').
+ *
+ * {sw1=3D0x90,sw2=3D0x00,Z000000a2fe2040000000005020000}
+ * This is a reply to a select file for EF_ICCID.
+ */
+static const guchar reply_sim_io_invalid_parcel1[] =3D {
+	0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00,
+	0x5A, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x61, 0x00, 0x32, 0x00, 0x66, 0x00, 0x65, 0x00, 0x32, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x32, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_sim_io_invalid_1 =3D {
+	.buf =3D (gchar *) reply_sim_io_invalid_parcel1,
+	.buf_len =3D sizeof(reply_sim_io_invalid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SIM_IO,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of an invalid
+ * RIL_REQUEST_SIM_IO reply with the following parameters:
+ *
+ * {sw1=3D0x90,sw2=3D0x00,<malformed length>}
+ * This is a reply to a select file for EF_ICCID.
+ */
+static const guchar reply_sim_io_invalid_parcel2[] =3D {
+	0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff
+};
+
+static const struct ril_msg reply_sim_io_invalid_2 =3D {
+	.buf =3D (gchar *) reply_sim_io_invalid_parcel2,
+	.buf_len =3D sizeof(reply_sim_io_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SIM_IO,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_IMSI reply with the following parameters:
+ *
+ * {214060200695834}
+ */
+static const guchar reply_imsi_valid_parcel1[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x32, 0x00, 0x31, 0x00, 0x34, 0x00, 0x30, 0x00,
+	0x36, 0x00, 0x30, 0x00, 0x32, 0x00, 0x30, 0x00, 0x30, 0x00, 0x36, 0x00,
+	0x39, 0x00, 0x35, 0x00, 0x38, 0x00, 0x33, 0x00, 0x34, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_imsi_valid_1 =3D {
+	.buf =3D (gchar *) reply_imsi_valid_parcel1,
+	.buf_len =3D sizeof(reply_imsi_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_IMSI,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_SIM_STATUS reply with the following parameters:
+ *
+ * {card_state=3D1,universal_pin_state=3D0,gsm_umts_index=3D0,cdma_index=
=3D-1,
+ *  ims_index=3D-1, [app_type=3D1,app_state=3D5,perso_substate=3D2,aid_ptr=
=3D,
+ *  app_label_ptr=3D(null),pin1_replaced=3D0,pin1=3D3,pin2=3D1],}
+ */
+static const guchar reply_sim_status_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_sim_status_valid_1 =3D {
+	.buf =3D (gchar *) reply_sim_status_valid_parcel1,
+	.buf_len =3D sizeof(reply_sim_status_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_SIM_STATUS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_SMSC_ADDRESS reply with the following parameters:
+ *
+ * {type=3D145,number=3D34607003110}
+ */
+static const guchar reply_get_smsc_address_valid_parcel1[] =3D {
+	0x12, 0x00, 0x00, 0x00, 0x22, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00,
+	0x36, 0x00, 0x30, 0x00, 0x37, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x22, 0x00, 0x2c, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x35, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_smsc_address_valid_1 =3D {
+	.buf =3D (gchar *) reply_get_smsc_address_valid_parcel1,
+	.buf_len =3D sizeof(reply_get_smsc_address_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_SMSC_ADDRESS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_CURRENT_CALLS reply with the following parameters:
+ *
+ * {[id=3D2,status=3D0,type=3D1,number=3D686732222,name=3D]
+ *  [id=3D1,status=3D1,type=3D1,number=3D917525555,name=3D]}
+ */
+static const guchar reply_get_current_calls_valid_parcel1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x09, 0x00, 0x00, 0x00, 0x36, 0x00, 0x38, 0x00, 0x36, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x32, 0x00, 0x32, 0x00, 0x32, 0x00, 0x32, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x09, 0x00, 0x00, 0x00, 0x39, 0x00, 0x31, 0x00, 0x37, 0x00, 0x35, 0x00,
+	0x32, 0x00, 0x35, 0x00, 0x35, 0x00, 0x35, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_current_calls_valid_1 =3D {
+	.buf =3D (gchar *) reply_get_current_calls_valid_parcel1,
+	.buf_len =3D sizeof(reply_get_current_calls_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_CURRENT_CALLS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/* RIL_REQUEST_GET_CURRENT_CALLS NULL reply */
+static const struct ril_msg reply_get_current_calls_invalid_1 =3D {
+	.buf =3D NULL,
+	.buf_len =3D 0,
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_CURRENT_CALLS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/* RIL_REQUEST_GET_CURRENT_CALLS no calls */
+static const guchar reply_get_current_calls_invalid_parcel2[] =3D {
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct ril_msg reply_get_current_calls_invalid_2 =3D {
+	.buf =3D (gchar *) reply_get_current_calls_invalid_parcel2,
+	.buf_len =3D sizeof(reply_get_current_calls_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_CURRENT_CALLS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_LAST_CALL_FAIL_CAUSE reply with the following parameters:
+ *
+ * {16}
+ */
+static const guchar reply_call_fail_cause_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_call_fail_cause_valid_1 =3D {
+	.buf =3D (gchar *) reply_call_fail_cause_valid_parcel1,
+	.buf_len =3D sizeof(reply_call_fail_cause_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_LAST_CALL_FAIL_CAUSE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_MUTE reply with the following parameters:
+ *
+ * {muted=3D0}
+ */
+static const guchar reply_get_mute_off_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_mute_off_1 =3D {
+	.buf =3D (gchar *) reply_get_mute_off_parcel1,
+	.buf_len =3D sizeof(reply_get_mute_off_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_MUTE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_MUTE reply with the following parameters:
+ *
+ * {muted=3D1}
+ */
+static const guchar reply_get_mute_on_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_mute_on_1 =3D {
+	.buf =3D (gchar *) reply_get_mute_on_parcel1,
+	.buf_len =3D sizeof(reply_get_mute_on_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_MUTE,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_BASEBAND_VERSION reply with the following parameters:
+ *
+ * {M9615A-CEFWMAZM-2.0.1700.48}
+ */
+static const guchar reply_baseband_version_valid_parcel1[] =3D {
+	0x1b, 0x00, 0x00, 0x00, 0x4d, 0x00, 0x39, 0x00, 0x36, 0x00, 0x31, 0x00,
+	0x35, 0x00, 0x41, 0x00, 0x2d, 0x00, 0x43, 0x00, 0x45, 0x00, 0x46, 0x00,
+	0x57, 0x00, 0x4d, 0x00, 0x41, 0x00, 0x5a, 0x00, 0x4d, 0x00, 0x2d, 0x00,
+	0x32, 0x00, 0x2e, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x37, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x34, 0x00, 0x38, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_baseband_version_valid_1 =3D {
+	.buf =3D (gchar *) reply_baseband_version_valid_parcel1,
+	.buf_len =3D sizeof(reply_baseband_version_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_BASEBAND_VERSION,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_IMEI reply with the following parameters:
+ *
+ * {355136050779043}
+ */
+static const guchar reply_get_imei_valid_parcel1[] =3D {
+	0x0f, 0x00, 0x00, 0x00, 0x33, 0x00, 0x35, 0x00, 0x35, 0x00, 0x31, 0x00,
+	0x33, 0x00, 0x36, 0x00, 0x30, 0x00, 0x35, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x37, 0x00, 0x39, 0x00, 0x30, 0x00, 0x34, 0x00, 0x33, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_imei_valid_1 =3D {
+	.buf =3D (gchar *) reply_get_imei_valid_parcel1,
+	.buf_len =3D sizeof(reply_get_imei_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_IMEI,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_QUERY_CALL_WAITING reply with the following parameters:
+ *
+ * {1,0x30}
+ */
+static const guchar reply_query_call_waiting_valid_parcel1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_query_call_waiting_valid_1 =3D {
+	.buf =3D (gchar *) reply_query_call_waiting_valid_parcel1,
+	.buf_len =3D sizeof(reply_query_call_waiting_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_QUERY_CALL_WAITING,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_QUERY_CLIP reply with the following parameters:
+ *
+ * {1}
+ */
+static const guchar reply_query_clip_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_query_clip_valid_1 =3D {
+	.buf =3D (gchar *) reply_query_clip_valid_parcel1,
+	.buf_len =3D sizeof(reply_query_clip_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_QUERY_CLIP,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_CLIR reply with the following parameters:
+ *
+ * {2,4}
+ */
+static const guchar reply_get_clir_valid_parcel1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_get_clir_valid_1 =3D {
+	.buf =3D (gchar *) reply_get_clir_valid_parcel1,
+	.buf_len =3D sizeof(reply_get_clir_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_GET_CLIR,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE reply with the following paramet=
ers:
+ *
+ * {0}
+ */
+static const guchar reply_get_preferred_network_type_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const get_preferred_network_test
+		reply_get_preferred_network_type_valid_1 =3D {
+	.preferred =3D 0,
+	.msg =3D {
+		.buf =3D (gchar *) reply_get_preferred_network_type_valid_parcel1,
+		.buf_len =3D
+			sizeof(reply_get_preferred_network_type_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_QUERY_FACILITY_LOCK reply with the following parameters:
+ *
+ * {0}
+ */
+static const guchar reply_query_facility_lock_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct query_facility_lock_test
+				reply_query_facility_lock_valid_1 =3D {
+	.status =3D 0,
+	.msg =3D {
+		.buf =3D (gchar *) reply_query_facility_lock_valid_parcel1,
+		.buf_len =3D sizeof(reply_query_facility_lock_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_QUERY_FACILITY_LOCK,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hexadecimal data contains the event data of a valid
+ * RIL_REQUEST_QUERY_FACILITY_LOCK reply with the following parameters:
+ *
+ * {0,0} (infineon: two integers are returned)
+ */
+static const guchar reply_query_facility_lock_valid_parcel2[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct query_facility_lock_test
+				reply_query_facility_lock_valid_2 =3D {
+	.status =3D 0,
+	.msg =3D {
+		.buf =3D (gchar *) reply_query_facility_lock_valid_parcel2,
+		.buf_len =3D sizeof(reply_query_facility_lock_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_QUERY_FACILITY_LOCK,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_SET_FACILITY_LOCK reply with no parameters.
+ */
+static const struct set_facility_lock_test reply_set_facility_lock_valid_1=
 =3D {
+	.retries =3D -1,
+	.msg =3D {
+		.buf =3D NULL,
+		.buf_len =3D 0,
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_SET_FACILITY_LOCK,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_SET_FACILITY_LOCK reply with parameter {2}
+ */
+static const guchar reply_set_facility_lock_valid_parcel2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
+};
+
+static const struct set_facility_lock_test reply_set_facility_lock_valid_2=
 =3D {
+	.retries =3D 2,
+	.msg =3D {
+		.buf =3D (gchar *) reply_set_facility_lock_valid_parcel2,
+		.buf_len =3D sizeof(reply_set_facility_lock_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_SET_FACILITY_LOCK,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_ENTER_SIM_PIN reply with parameter {0}
+ */
+static const guchar reply_enter_sim_pin_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct sim_password_test reply_enter_sim_pin_valid_1 =3D {
+	.retries =3D -1,
+	.passwd_type =3D OFONO_SIM_PASSWORD_SIM_PIN,
+	.msg =3D {
+		.buf =3D (gchar *) reply_enter_sim_pin_valid_parcel1,
+		.buf_len =3D sizeof(reply_enter_sim_pin_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_ENTER_SIM_PIN,
+		.serial_no =3D 0,
+		.error =3D RIL_E_SUCCESS,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_ENTER_SIM_PIN reply with parameter {2}
+ */
+static const guchar reply_enter_sim_pin_valid_parcel2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
+};
+
+static const struct sim_password_test reply_enter_sim_pin_valid_2 =3D {
+	.retries =3D 2,
+	.passwd_type =3D OFONO_SIM_PASSWORD_SIM_PIN,
+	.msg =3D {
+		.buf =3D (gchar *) reply_enter_sim_pin_valid_parcel2,
+		.buf_len =3D sizeof(reply_enter_sim_pin_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_ENTER_SIM_PIN,
+		.serial_no =3D 0,
+		.error =3D RIL_E_PASSWORD_INCORRECT,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_OEM_HOOK_RAW reply with parameter {4,0x11111111}
+ */
+static const guchar reply_oem_hook_raw_valid_parcel1[] =3D {
+	0x04, 0x00, 0x00, 0x00, 0x11, 0x11, 0x11, 0x11
+};
+
+static const struct oem_hook_raw_test reply_oem_hook_raw_valid_1 =3D {
+	.data =3D reply_oem_hook_raw_valid_parcel1 + sizeof(int32_t),
+	.size =3D (int) (sizeof(reply_oem_hook_raw_valid_parcel1)
+			- sizeof(int32_t)),
+	.msg =3D {
+		.buf =3D (gchar *) reply_oem_hook_raw_valid_parcel1,
+		.buf_len =3D sizeof(reply_oem_hook_raw_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_OEM_HOOK_RAW,
+		.serial_no =3D 0,
+		.error =3D RIL_E_SUCCESS,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_OEM_HOOK_RAW reply with parameter {-1}
+ */
+static const guchar reply_oem_hook_raw_valid_parcel2[] =3D {
+	0xFF, 0xFF, 0xFF, 0xFF
+};
+
+static const struct oem_hook_raw_test reply_oem_hook_raw_valid_2 =3D {
+	.data =3D NULL,
+	.size =3D -1,
+	.msg =3D {
+		.buf =3D (gchar *) reply_oem_hook_raw_valid_parcel2,
+		.buf_len =3D sizeof(reply_oem_hook_raw_valid_parcel2),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_OEM_HOOK_RAW,
+		.serial_no =3D 0,
+		.error =3D RIL_E_SUCCESS,
+	}
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_OEM_HOOK_STRINGS reply with parameter {+EPINC: 3, 3, 10, 10}
+ */
+static const guchar reply_oem_hook_strings_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x45, 0x00,
+	0x50, 0x00, 0x49, 0x00, 0x4e, 0x00, 0x43, 0x00, 0x3a, 0x00, 0x20, 0x00,
+	0x33, 0x00, 0x2c, 0x00, 0x20, 0x00, 0x33, 0x00, 0x2c, 0x00, 0x20, 0x00,
+	0x31, 0x00, 0x30, 0x00, 0x2c, 0x00, 0x20, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const char *strings_valid_parcel1[] =3D { "+EPINC: 3, 3, 10, 10" };
+
+static const struct oem_hook_strings_test reply_oem_hook_strings_valid_1 =
=3D {
+	.msg =3D {
+		.buf =3D (gchar *) reply_oem_hook_strings_valid_parcel1,
+		.buf_len =3D sizeof(reply_oem_hook_strings_valid_parcel1),
+		.unsolicited =3D FALSE,
+		.req =3D RIL_REQUEST_OEM_HOOK_STRINGS,
+		.serial_no =3D 0,
+		.error =3D RIL_E_SUCCESS,
+	},
+	.num_str =3D G_N_ELEMENTS(strings_valid_parcel1),
+	.str =3D strings_valid_parcel1
+};
+
+static void test_reply_voice_reg_state_valid(gconstpointer data)
+{
+	const reg_state_test *test =3D data;
+	struct reply_reg_state *reply =3D
+		g_ril_reply_parse_voice_reg_state(NULL, &test->msg);
+
+	g_assert(reply !=3D NULL);
+	g_assert(reply->status =3D=3D test->status);
+
+	g_assert(reply->tech =3D=3D test->tech);
+	g_free(reply);
+}
+
+static void test_reply_data_reg_state_invalid(gconstpointer data)
+{
+	struct reply_data_reg_state *reply =3D
+		g_ril_reply_parse_data_reg_state(NULL, data);
+	g_assert(reply =3D=3D NULL);
+}
+
+static void test_reply_data_reg_state_valid(gconstpointer data)
+{
+	const reg_state_test *test =3D data;
+	struct reply_data_reg_state *reply =3D
+		g_ril_reply_parse_data_reg_state(NULL, &test->msg);
+
+	g_assert(reply !=3D NULL);
+	g_assert(reply->reg_state.status =3D=3D test->status);
+
+	g_assert(reply->reg_state.tech =3D=3D test->tech);
+	g_free(reply);
+}
+
+static void test_reply_operator_invalid(gconstpointer data)
+{
+	struct reply_operator *reply =3D g_ril_reply_parse_operator(NULL, data);
+	g_assert(reply =3D=3D NULL);
+}
+
+static void test_reply_operator_valid(gconstpointer data)
+{
+	struct reply_operator *reply =3D g_ril_reply_parse_operator(NULL, data);
+	g_assert(reply !=3D NULL);
+}
+
+static void test_reply_avail_ops_invalid(gconstpointer data)
+{
+	struct reply_avail_ops *reply =3D g_ril_reply_parse_avail_ops(NULL, data);
+	g_assert(reply =3D=3D NULL);
+}
+
+static void test_reply_avail_ops_valid(gconstpointer data)
+{
+	struct reply_avail_ops *reply =3D g_ril_reply_parse_avail_ops(NULL, data);
+	g_assert(reply !=3D NULL);
+}
+
+static void test_reply_sim_io_valid(gconstpointer data)
+{
+	struct reply_sim_io *reply =3D g_ril_reply_parse_sim_io(NULL, data);
+	g_assert(reply !=3D NULL);
+	g_ril_reply_free_sim_io(reply);
+}
+
+static void test_reply_sim_io_invalid(gconstpointer data)
+{
+	struct reply_sim_io *reply =3D g_ril_reply_parse_sim_io(NULL, data);
+	g_assert(reply =3D=3D NULL);
+}
+
+static void test_reply_imsi_valid(gconstpointer data)
+{
+	gchar *reply =3D g_ril_reply_parse_imsi(NULL, data);
+	g_assert(reply !=3D NULL);
+	g_free(reply);
+}
+
+static void test_reply_sim_status_valid(gconstpointer data)
+{
+	struct reply_sim_status *reply;
+
+	reply =3D g_ril_reply_parse_sim_status(NULL, data);
+	g_assert(reply !=3D NULL);
+	g_ril_reply_free_sim_status(reply);
+}
+
+static void test_reply_get_smsc_address_valid(gconstpointer data)
+{
+	struct ofono_phone_number *reply;
+
+	reply =3D g_ril_reply_parse_get_smsc_address(NULL, data);
+
+	g_assert(reply !=3D NULL);
+	g_free(reply);
+}
+
+static void test_reply_get_current_calls_valid(gconstpointer data)
+{
+	GSList *calls;
+
+	calls =3D g_ril_reply_parse_get_calls(NULL, data);
+
+	g_assert(calls !=3D NULL);
+
+	g_slist_foreach(calls, (GFunc) g_free, NULL);
+	g_slist_free(calls);
+}
+
+static void test_reply_get_current_calls_invalid(gconstpointer data)
+{
+	GSList *calls;
+
+	calls =3D g_ril_reply_parse_get_calls(NULL, data);
+
+	g_assert(calls =3D=3D NULL);
+}
+
+static void test_reply_call_fail_cause_valid(gconstpointer data)
+{
+	enum ofono_disconnect_reason reason;
+
+	reason =3D g_ril_reply_parse_call_fail_cause(NULL, data);
+
+	g_assert(reason >=3D 0);
+}
+
+static void test_reply_get_mute_off(gconstpointer data)
+{
+	int muted;
+
+	muted =3D g_ril_reply_parse_get_mute(NULL, data);
+
+	g_assert(muted =3D=3D 0);
+}
+
+static void test_reply_get_mute_on(gconstpointer data)
+{
+	int muted;
+
+	muted =3D g_ril_reply_parse_get_mute(NULL, data);
+
+	g_assert(muted =3D=3D 1);
+}
+
+static void test_reply_baseband_version_valid(gconstpointer data)
+{
+	char *version;
+
+	version =3D g_ril_reply_parse_baseband_version(NULL, data);
+
+	g_assert(version !=3D NULL);
+
+	g_free(version);
+}
+
+static void test_reply_get_imei_valid(gconstpointer data)
+{
+	char *imei;
+
+	imei =3D g_ril_reply_parse_get_imei(NULL, data);
+
+	g_assert(imei !=3D NULL);
+
+	g_free(imei);
+}
+
+static void test_reply_query_call_waiting_valid(gconstpointer data)
+{
+	int cls;
+
+	cls =3D g_ril_reply_parse_query_call_waiting(NULL, data);
+
+	g_assert(cls !=3D -1);
+}
+
+static void test_reply_query_clip_valid(gconstpointer data)
+{
+	int clip_status;
+
+	clip_status =3D g_ril_reply_parse_query_clip(NULL, data);
+
+	g_assert(clip_status !=3D -1);
+}
+
+static void test_reply_get_clir_valid(gconstpointer data)
+{
+	struct reply_clir *reply;
+
+	reply =3D g_ril_reply_parse_get_clir(NULL, data);
+
+	g_assert(reply !=3D NULL);
+
+	g_ril_reply_free_get_clir(reply);
+}
+
+static void test_reply_get_preferred_network_type_valid(gconstpointer data)
+{
+	const get_preferred_network_test *test =3D data;
+	int type =3D
+		g_ril_reply_parse_get_preferred_network_type(NULL, &test->msg);
+
+	g_assert(type =3D=3D test->preferred);
+}
+
+static void test_reply_query_facility_lock_valid(gconstpointer data)
+{
+	const struct query_facility_lock_test *test =3D data;
+	int status =3D g_ril_reply_parse_query_facility_lock(NULL, &test->msg);
+
+	g_assert(status =3D=3D test->status);
+}
+
+static void test_reply_set_facility_lock_valid(gconstpointer data)
+{
+	const struct set_facility_lock_test *test =3D data;
+	int retries =3D g_ril_reply_parse_set_facility_lock(NULL, &test->msg);
+
+	g_assert(retries =3D=3D test->retries);
+}
+
+static void test_reply_enter_sim_pin_valid(gconstpointer data)
+{
+	const struct sim_password_test *test =3D data;
+	int *retries =3D g_ril_reply_parse_retries(NULL, &test->msg,
+							test->passwd_type);
+
+	g_assert(retries !=3D NULL);
+	g_assert(retries[test->passwd_type] =3D=3D test->retries);
+
+	g_free(retries);
+}
+
+static void test_reply_oem_hook_raw_valid(gconstpointer data)
+{
+	const struct oem_hook_raw_test *test =3D data;
+	struct reply_oem_hook *reply =3D
+		g_ril_reply_oem_hook_raw(NULL, &test->msg);
+
+	g_assert(reply->length =3D=3D test->size);
+	if (reply->length >=3D 0)
+		g_assert(!memcmp(reply->data, test->data, test->size));
+	else
+		g_assert(reply->data =3D=3D NULL);
+
+	g_ril_reply_free_oem_hook(reply);
+}
+
+static void test_reply_oem_hook_strings_valid(gconstpointer data)
+{
+	int i;
+	const struct oem_hook_strings_test *test =3D data;
+	struct parcel_str_array *reply =3D
+		g_ril_reply_oem_hook_strings(NULL, &test->msg);
+
+	g_assert(reply !=3D NULL);
+	g_assert(reply->num_str =3D=3D test->num_str);
+
+	for (i =3D 0; i < reply->num_str; ++i)
+		g_assert(strcmp(reply->str[i], test->str[i]) =3D=3D 0);
+
+	parcel_free_str_array(reply);
+}
+
+#endif
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"invalid DATA_REG_STATE Test 1",
+				&reply_data_reg_state_invalid_1,
+				test_reply_data_reg_state_invalid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"invalid DATA_REG_STATE Test 2",
+				&reply_data_reg_state_invalid_2,
+				test_reply_data_reg_state_invalid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"invalid DATA_REG_STATE Test 3",
+				&reply_data_reg_state_invalid_3,
+				test_reply_data_reg_state_invalid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 1",
+				&data_reg_valid_1,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 2",
+				&data_reg_valid_2,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 3",
+				&data_reg_valid_3,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 4",
+				&data_reg_valid_4,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 5",
+				&data_reg_valid_5,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 6",
+				&data_reg_valid_6,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 7",
+				&data_reg_valid_7,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 8",
+				&data_reg_valid_8,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 9",
+				&data_reg_valid_9,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/gprs: "
+				"valid DATA_REG_STATE Test 10",
+				&data_reg_valid_10,
+				test_reply_data_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 1",
+				&voice_reg_valid_1,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 2",
+				&voice_reg_valid_2,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 3",
+				&voice_reg_valid_3,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 4",
+				&voice_reg_valid_4,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 5",
+				&voice_reg_valid_5,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 6",
+				&voice_reg_valid_6,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 7",
+				&voice_reg_valid_7,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 8",
+				&voice_reg_valid_8,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 9",
+				&voice_reg_valid_9,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 10",
+				&voice_reg_valid_10,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 11",
+				&voice_reg_valid_11,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid VOICE_REG_STATE Test 12",
+				&voice_reg_valid_12,
+				test_reply_voice_reg_state_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"invalid GET_OPERATOR Test 1",
+				&reply_operator_invalid_1,
+				test_reply_operator_invalid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"invalid GET_OPERATOR Test 2",
+				&reply_operator_invalid_2,
+				test_reply_operator_invalid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid GET_OPERATOR Test 1",
+				&reply_operator_valid_1,
+				test_reply_operator_valid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"invalid QUERY_AVAIL_OPS Test 1",
+				&reply_avail_ops_invalid_1,
+				test_reply_avail_ops_invalid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"invalid QUERY_AVAIL_OPS Test 2",
+				&reply_avail_ops_invalid_2,
+				test_reply_avail_ops_invalid);
+
+	g_test_add_data_func("/testgrilreply/netreg: "
+				"valid QUERY_AVAIL_OPS Test 1",
+				&reply_avail_ops_valid_1,
+				test_reply_avail_ops_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid SIM_IO Test 1",
+				&reply_sim_io_valid_1,
+				test_reply_sim_io_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid SIM_IO Test 2",
+				&reply_sim_io_valid_2,
+				test_reply_sim_io_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"invalid SIM_IO Test 1",
+				&reply_sim_io_invalid_1,
+				test_reply_sim_io_invalid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"invalid SIM_IO Test 2",
+				&reply_sim_io_invalid_2,
+				test_reply_sim_io_invalid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid GET_IMSI Test 1",
+				&reply_imsi_valid_1,
+				test_reply_imsi_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid GET_SIM_STATUS Test 1",
+				&reply_sim_status_valid_1,
+				test_reply_sim_status_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid GET_SMSC_ADDRESS Test 1",
+				&reply_get_smsc_address_valid_1,
+				test_reply_get_smsc_address_valid);
+
+	g_test_add_data_func("/testgrilreply/voicecall: "
+				"valid GET_CURRENT_CALLS Test 1",
+				&reply_get_current_calls_valid_1,
+				test_reply_get_current_calls_valid);
+
+	g_test_add_data_func("/testgrilreply/voicecall: "
+				"invalid GET_CURRENT_CALLS Test 1",
+				&reply_get_current_calls_invalid_1,
+				test_reply_get_current_calls_invalid);
+
+	g_test_add_data_func("/testgrilreply/voicecall: "
+				"invalid GET_CURRENT_CALLS Test 2",
+				&reply_get_current_calls_invalid_2,
+				test_reply_get_current_calls_invalid);
+
+	g_test_add_data_func("/testgrilreply/voicecall: "
+				"valid CALL_FAIL_CAUSE Test 1",
+				&reply_call_fail_cause_valid_1,
+				test_reply_call_fail_cause_valid);
+
+	g_test_add_data_func("/testgrilreply/call-volume: "
+				"off GET_MUTE Test 1",
+				&reply_get_mute_off_1,
+				test_reply_get_mute_off);
+
+	g_test_add_data_func("/testgrilreply/call-volume: "
+				"on GET_MUTE Test 1",
+				&reply_get_mute_on_1,
+				test_reply_get_mute_on);
+
+	g_test_add_data_func("/testgrilreply/devinfo: "
+				"valid BASEBAND_VERSION Test 1",
+				&reply_baseband_version_valid_1,
+				test_reply_baseband_version_valid);
+
+	g_test_add_data_func("/testgrilreply/devinfo: "
+				"valid GET_IMEI Test 1",
+				&reply_get_imei_valid_1,
+				test_reply_get_imei_valid);
+
+	g_test_add_data_func("/testgrilreply/call-settings: "
+				"valid QUERY_CALL_WAITING Test 1",
+				&reply_query_call_waiting_valid_1,
+				test_reply_query_call_waiting_valid);
+
+	g_test_add_data_func("/testgrilreply/call-settings: "
+				"valid QUERY_CLIP Test 1",
+				&reply_query_clip_valid_1,
+				test_reply_query_clip_valid);
+
+	g_test_add_data_func("/testgrilreply/call-settings: "
+				"valid GET_CLIR Test 1",
+				&reply_get_clir_valid_1,
+				test_reply_get_clir_valid);
+
+	g_test_add_data_func("/testgrilreply/radio-settings: "
+				"valid GET_PREFERRED_NETWORK_TYPE Test 1",
+				&reply_get_preferred_network_type_valid_1,
+				test_reply_get_preferred_network_type_valid);
+
+	g_test_add_data_func("/testgrilreply/call-barring: "
+				"valid QUERY_FACILITY_LOCK Test 1",
+				&reply_query_facility_lock_valid_1,
+				test_reply_query_facility_lock_valid);
+
+	g_test_add_data_func("/testgrilreply/call-barring: "
+				"valid QUERY_FACILITY_LOCK Test 2",
+				&reply_query_facility_lock_valid_2,
+				test_reply_query_facility_lock_valid);
+
+	g_test_add_data_func("/testgrilreply/call-barring: "
+				"valid SET_FACILITY_LOCK Test 1",
+				&reply_set_facility_lock_valid_1,
+				test_reply_set_facility_lock_valid);
+
+	g_test_add_data_func("/testgrilreply/call-barring: "
+				"valid SET_FACILITY_LOCK Test 2",
+				&reply_set_facility_lock_valid_2,
+				test_reply_set_facility_lock_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid ENTER_SIM_PIN Test 1",
+				&reply_enter_sim_pin_valid_1,
+				test_reply_enter_sim_pin_valid);
+
+	g_test_add_data_func("/testgrilreply/sim: "
+				"valid ENTER_SIM_PIN Test 2",
+				&reply_enter_sim_pin_valid_2,
+				test_reply_enter_sim_pin_valid);
+
+	g_test_add_data_func("/testgrilreply/oem: "
+				"valid OEM_HOOK_RAW Test 1",
+				&reply_oem_hook_raw_valid_1,
+				test_reply_oem_hook_raw_valid);
+
+	g_test_add_data_func("/testgrilreply/oem: "
+				"valid OEM_HOOK_RAW Test 2",
+				&reply_oem_hook_raw_valid_2,
+				test_reply_oem_hook_raw_valid);
+
+	g_test_add_data_func("/testgrilreply/oem: "
+				"valid OEM_HOOK_STRINGS Test 1",
+				&reply_oem_hook_strings_valid_1,
+				test_reply_oem_hook_strings_valid);
+
+#endif
+
+	return g_test_run();
+}
diff --git a/unit/test-rilrequest.c b/unit/test-rilrequest.c
new file mode 100644
index 0000000..00bd5e1
--- /dev/null
+++ b/unit/test-rilrequest.c
@@ -0,0 +1,1737 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013 Canonical Ltd.
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
+#include <string.h>
+#include <stdio.h>
+#include <assert.h>
+#include <glib.h>
+#include <errno.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/types.h>
+
+#include "drivers/rilmodem/rilrequest.h"
+
+/*
+ * TODO: It may make sense to split this file into
+ * domain-specific files ( eg. test-grilrequest-gprs-context.c )
+ * once more tests are added.
+ */
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+struct request_test_data {
+	gconstpointer request;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const struct req_deactivate_data_call req_deact_data_call_invalid_1=
 =3D {
+	.cid =3D 1,
+	.reason =3D 10,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_REQUEST_DEACTIVATE_DATA_CALL message
+ * with the following parameters:
+ *
+ * (cid=3D1,reason=3D0)
+ */
+static const guchar req_deact_data_call_valid_parcel1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
+};
+
+static const struct req_deactivate_data_call req_deact_data_call_valid_1 =
=3D {
+	.cid =3D 1,
+	.reason =3D RIL_DEACTIVATE_DATA_CALL_NO_REASON,
+};
+
+static const struct request_test_data deact_data_call_valid_test_1 =3D {
+	.request =3D &req_deact_data_call_valid_1,
+	.parcel_data =3D (guchar *) &req_deact_data_call_valid_parcel1,
+	.parcel_size =3D sizeof(req_deact_data_call_valid_parcel1),
+};
+
+
+static const struct req_setup_data_call req_setup_data_call_invalid_1 =3D {
+	.tech =3D RADIO_TECH_UNKNOWN,
+};
+
+static const struct req_setup_data_call req_setup_data_call_invalid_2 =3D {
+	.tech =3D 2112,
+};
+
+static const struct req_setup_data_call req_setup_data_call_invalid_3 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D 5,
+};
+
+static const struct req_setup_data_call req_setup_data_call_invalid_4 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D NULL,
+};
+
+static const struct req_setup_data_call req_setup_data_call_invalid_5 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.auth_type =3D 4,
+};
+
+static const struct req_setup_data_call req_setup_data_call_invalid_6 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.auth_type =3D RIL_AUTH_BOTH,
+	.protocol =3D 3,
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_1 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.username =3D NULL,
+	.password =3D NULL,
+	.auth_type =3D RIL_AUTH_BOTH,
+	.protocol =3D OFONO_GPRS_PROTO_IP,
+
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_2 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.username =3D "",
+	.password =3D "",
+	.auth_type =3D RIL_AUTH_NONE,
+	.protocol =3D OFONO_GPRS_PROTO_IP,
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_3 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.username =3D "phablet",
+	.password =3D "phablet",
+	.auth_type =3D RIL_AUTH_BOTH,
+	.protocol =3D OFONO_GPRS_PROTO_IPV4V6,
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_4 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "test.apn",
+	.username =3D "phablet",
+	.password =3D "phablet",
+	.auth_type =3D RIL_AUTH_BOTH,
+	.protocol =3D OFONO_GPRS_PROTO_IPV6,
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_5 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "",
+};
+
+static const struct req_setup_data_call req_setup_data_call_valid_6 =3D {
+	.tech =3D RADIO_TECH_GPRS,
+	.data_profile =3D RIL_DATA_PROFILE_DEFAULT,
+	.apn =3D "12345678901234567890123456789012345678901234567890"
+		"123456789012345678901234567890123456789012345678901",
+};
+
+static const char sim_read_info_path_valid_1[] =3D {0x3F, 0x00};
+
+static const struct req_sim_read_info req_sim_read_info_valid_1 =3D {
+	.app_type =3D RIL_APPTYPE_USIM,
+	.aid_str =3D "1234567890123456",
+	.fileid =3D 0x7F01,
+	.path =3D (const unsigned char *) sim_read_info_path_valid_1,
+	.path_len =3D sizeof(sim_read_info_path_valid_1),
+};
+
+static const unsigned char sim_read_info_path_invalid_1[] =3D
+	{0x3F, 0x00, 0x11, 0x22, 0x7F, 0x00, 0x11, 0x22};
+
+static const struct req_sim_read_info req_sim_read_info_invalid_1 =3D {
+	.app_type =3D RIL_APPTYPE_ISIM + 10,
+	.aid_str =3D "1234567890123456",
+	.fileid =3D 0x7F01,
+	.path =3D sim_read_info_path_invalid_1,
+	.path_len =3D sizeof(sim_read_info_path_invalid_1),
+};
+
+/* sim_read_binary tests */
+
+static const guchar req_sim_read_binary_parcel_valid_1[] =3D {
+	0xb0, 0x00, 0x00, 0x00, 0xe2, 0x2f, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+	0x33, 0x00, 0x46, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const unsigned char sim_read_binary_path_valid_1[] =3D {0x3F, 0x00};
+
+static const struct req_sim_read_binary req_sim_read_binary_valid_1 =3D {
+	.app_type =3D RIL_APPTYPE_UNKNOWN,
+	.aid_str =3D "",
+	.fileid =3D 0x2FE2,
+	.path =3D sim_read_binary_path_valid_1,
+	.path_len =3D sizeof(sim_read_binary_path_valid_1),
+	.start =3D 0,
+	.length =3D 0x0A,
+};
+
+static const struct request_test_data sim_read_binary_valid_test_1 =3D {
+	.request =3D &req_sim_read_binary_valid_1,
+	.parcel_data =3D (guchar *) &req_sim_read_binary_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sim_read_binary_parcel_valid_1),
+};
+
+/* sim_read_record tests */
+
+static const guchar req_sim_read_record_parcel_valid_1[] =3D {
+	0xb2, 0x00, 0x00, 0x00, 0xe2, 0x2f, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+	0x33, 0x00, 0x46, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const unsigned char sim_read_record_path_valid_1[] =3D {0x3F, 0x00};
+
+static const struct req_sim_read_record req_sim_read_record_valid_1 =3D {
+	.app_type =3D RIL_APPTYPE_UNKNOWN,
+	.aid_str =3D "",
+	.fileid =3D 0x2FE2,
+	.path =3D sim_read_record_path_valid_1,
+	.path_len =3D sizeof(sim_read_record_path_valid_1),
+	.record =3D 5,
+	.length =3D 0x0A,
+};
+
+static const struct request_test_data sim_read_record_valid_test_1 =3D {
+	.request =3D &req_sim_read_record_valid_1,
+	.parcel_data =3D (guchar *) &req_sim_read_record_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sim_read_record_parcel_valid_1),
+};
+
+/* sim_write_binary tests */
+
+static const guchar req_sim_write_binary_parcel_valid_1[] =3D {
+	0xd6, 0x00, 0x00, 0x00, 0xcb, 0x6f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
+	0x33, 0x00, 0x46, 0x00, 0x30, 0x00, 0x30, 0x00, 0x37, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0x20, 0x00, 0x00, 0x00, 0x61, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x38, 0x00, 0x37, 0x00,
+	0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x32, 0x00, 0x66, 0x00, 0x66, 0x00,
+	0x34, 0x00, 0x34, 0x00, 0x66, 0x00, 0x66, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x38, 0x00, 0x39, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const unsigned char sim_write_binary_path_valid_1[] =3D
+	{ 0x3F, 0x00, 0x7F, 0xFF };
+
+static const struct req_sim_write_binary req_sim_write_binary_valid_1 =3D {
+	.app_type =3D RIL_APPTYPE_UNKNOWN,
+	.aid_str =3D "a0000000871002ff44ff128900000100",
+	.fileid =3D 0x6FCB,
+	.path =3D sim_write_binary_path_valid_1,
+	.path_len =3D sizeof(sim_write_binary_path_valid_1),
+	.start =3D 0,
+	.length =3D 16,
+	.data =3D (unsigned char[]) {
+		0x01, 0x00, 0x01, 0x80, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF }
+};
+
+static const struct request_test_data sim_write_binary_valid_test_1 =3D {
+	.request =3D &req_sim_write_binary_valid_1,
+	.parcel_data =3D (guchar *) &req_sim_write_binary_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sim_write_binary_parcel_valid_1),
+};
+
+/* sim_write_record tests */
+
+static const guchar req_sim_write_record_parcel_valid_1[] =3D {
+	0xdc, 0x00, 0x00, 0x00, 0xcb, 0x6f, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
+	0x33, 0x00, 0x46, 0x00, 0x30, 0x00, 0x30, 0x00, 0x37, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00, 0x46, 0x00,
+	0x46, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0x20, 0x00, 0x00, 0x00, 0x61, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x38, 0x00, 0x37, 0x00,
+	0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x32, 0x00, 0x66, 0x00, 0x66, 0x00,
+	0x34, 0x00, 0x34, 0x00, 0x66, 0x00, 0x66, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x38, 0x00, 0x39, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const unsigned char sim_write_record_path_valid_1[] =3D
+	{0x3F, 0x00, 0x7F, 0xFF};
+
+static const struct req_sim_write_record req_sim_write_record_valid_1 =3D {
+	.app_type =3D RIL_APPTYPE_UNKNOWN,
+	.aid_str =3D "a0000000871002ff44ff128900000100",
+	.fileid =3D 0x6FCB,
+	.path =3D sim_write_record_path_valid_1,
+	.path_len =3D sizeof(sim_write_record_path_valid_1),
+	.mode =3D GRIL_REC_ACCESS_MODE_ABSOLUTE,
+	.record =3D 1,
+	.length =3D 16,
+	.data =3D (unsigned char[]) {
+		0x01, 0x00, 0x01, 0x80, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF }
+};
+
+static const struct request_test_data sim_write_record_valid_test_1 =3D {
+	.request =3D &req_sim_write_record_valid_1,
+	.parcel_data =3D (guchar *) &req_sim_write_record_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sim_write_record_parcel_valid_1),
+};
+
+/* read_imsi tests */
+
+static const guchar req_read_imsi_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const char read_imsi_aid_str_1[] =3D "";
+
+static const struct request_test_data read_imsi_valid_test_1 =3D {
+	.request =3D &read_imsi_aid_str_1,
+	.parcel_data =3D (guchar *) &req_read_imsi_parcel_valid_1,
+	.parcel_size =3D sizeof(req_read_imsi_parcel_valid_1),
+};
+
+/* pin_send tests */
+
+struct request_test_pin_send_data {
+	const char *passwd;
+	const gchar *aid_str;
+	guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_pin_send_parcel_valid_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct request_test_pin_send_data pin_send_record_valid_test_=
1 =3D {
+	.passwd =3D "1234",
+	.aid_str =3D "",
+	.parcel_data =3D (guchar *) &req_pin_send_parcel_valid_1,
+	.parcel_size =3D sizeof(req_pin_send_parcel_valid_1),
+};
+
+/* pin_change_state tests */
+
+static const guchar req_pin_change_state_valid_1[] =3D {
+	0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x50, 0x00, 0x53, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xFF, 0xFF, 0xFF, 0xFF,
+};
+
+static const struct req_pin_change_state req_pin_change_state_valid1 =3D {
+	.aid_str =3D NULL,
+	.passwd_type =3D OFONO_SIM_PASSWORD_PHSIM_PIN,
+	.enable =3D 0,
+	.passwd =3D "1234",
+};
+
+static const struct request_test_data pin_change_state_valid_test_1 =3D {
+	.request =3D &req_pin_change_state_valid1,
+	.parcel_data =3D (guchar *) &req_pin_change_state_valid_1,
+	.parcel_size =3D sizeof(req_pin_change_state_valid_1),
+};
+
+/* pin_send_puk tests */
+
+struct request_test_pin_send_puk_data {
+	const char *puk;
+	const char *passwd;
+	const gchar *aid_str;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_pin_send_puk_parcel_valid_1[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct request_test_pin_send_puk_data pin_send_puk_valid_test=
_1 =3D {
+	.puk =3D "12345678",
+	.passwd =3D "1234",
+	.aid_str =3D "",
+	.parcel_data =3D req_pin_send_puk_parcel_valid_1,
+	.parcel_size =3D sizeof(req_pin_send_puk_parcel_valid_1),
+};
+
+/* change_passwd tests */
+
+struct request_test_change_passwd_data {
+	const char *old_passwd;
+	const char *new_passwd;
+	const gchar *aid_str;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_change_passwd_parcel_valid_1[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+	0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct request_test_change_passwd_data
+						change_passwd_valid_test_1 =3D {
+	.old_passwd =3D "1234",
+	.new_passwd =3D "5678",
+	.aid_str =3D "",
+	.parcel_data =3D req_change_passwd_parcel_valid_1,
+	.parcel_size =3D sizeof(req_change_passwd_parcel_valid_1),
+};
+
+/* sms_cmgs tests */
+
+static const unsigned char req_sms_cmgs_pdu_valid_1[] =3D {
+	0x00, 0x11, 0x00, 0x09, 0x81, 0x36, 0x54, 0x39, 0x80, 0xf5, 0x00, 0x00,
+	0xa7, 0x0a, 0xc8, 0x37, 0x3b, 0x0c, 0x6a, 0xd7, 0xdd, 0xe4, 0x37
+};
+
+static const guchar req_sms_cmgs_parcel_valid_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x2c, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x39, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x39, 0x00, 0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x41, 0x00, 0x37, 0x00,
+	0x30, 0x00, 0x41, 0x00, 0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x42, 0x00, 0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,
+	0x44, 0x00, 0x37, 0x00, 0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct req_sms_cmgs req_sms_cmgs_valid1 =3D {
+	.pdu =3D req_sms_cmgs_pdu_valid_1,
+	.pdu_len =3D sizeof(req_sms_cmgs_pdu_valid_1),
+	.tpdu_len =3D sizeof(req_sms_cmgs_pdu_valid_1) - 1,
+};
+
+static const struct request_test_data sms_cmgs_valid_test_1 =3D {
+	.request =3D &req_sms_cmgs_valid1,
+	.parcel_data =3D (guchar *) &req_sms_cmgs_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sms_cmgs_parcel_valid_1),
+};
+
+/* sms_acknowledge tests */
+
+static const guchar req_sms_acknowledge_parcel_valid_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data sms_acknowledge_valid_test_1 =3D {
+	.request =3D NULL,
+	.parcel_data =3D (guchar *) &req_sms_acknowledge_parcel_valid_1,
+	.parcel_size =3D sizeof(req_sms_acknowledge_parcel_valid_1),
+};
+
+/* set_smsc_address tests */
+
+static const guchar req_set_smsc_address_valid_parcel1[] =3D {
+	0x0e, 0x00, 0x00, 0x00, 0x22, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00,
+	0x36, 0x00, 0x30, 0x00, 0x37, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ofono_phone_number smsc_address_valid1 =3D {
+	.type =3D 145,
+	.number =3D "34607003110"
+};
+
+static const struct request_test_data smsc_address_valid_test_1 =3D {
+	.request =3D &smsc_address_valid1,
+	.parcel_data =3D (guchar *) &req_set_smsc_address_valid_parcel1,
+	.parcel_size =3D sizeof(req_set_smsc_address_valid_parcel1),
+};
+
+/* dial tests */
+
+struct request_test_dial_data {
+	const struct ofono_phone_number ph;
+	enum ofono_clir_option clir;
+	const guchar *parcel_data;
+	size_t parcel_size;
+};
+
+static const guchar req_dial_parcel_valid_1[] =3D {
+	0x09, 0x00, 0x00, 0x00, 0x39, 0x00, 0x31, 0x00, 0x37, 0x00, 0x35, 0x00,
+	0x32, 0x00, 0x35, 0x00, 0x35, 0x00, 0x35, 0x00, 0x35, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct request_test_dial_data dial_valid_test_1 =3D {
+	.ph =3D { .number =3D "917525555", .type =3D 129 },
+	.clir =3D OFONO_CLIR_OPTION_DEFAULT,
+	.parcel_data =3D req_dial_parcel_valid_1,
+	.parcel_size =3D sizeof(req_dial_parcel_valid_1),
+};
+
+/* hangup tests */
+
+static const guchar req_hangup_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static unsigned hangup_call_id_valid_1 =3D 1;
+
+static const struct request_test_data set_hangup_valid_test_1 =3D {
+	.request =3D &hangup_call_id_valid_1,
+	.parcel_data =3D req_hangup_parcel_valid_1,
+	.parcel_size =3D sizeof(req_hangup_parcel_valid_1),
+};
+
+/* dtmf tests */
+
+static const guchar req_dtmf_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00
+};
+
+static char dtmf_char_valid_1 =3D '4';
+
+static const struct request_test_data dtmf_valid_test_1 =3D {
+	.request =3D &dtmf_char_valid_1,
+	.parcel_data =3D req_dtmf_parcel_valid_1,
+	.parcel_size =3D sizeof(req_dtmf_parcel_valid_1),
+};
+
+/* separate_conn tests */
+
+static const guchar req_separate_conn_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static unsigned separate_conn_call_id_valid_1 =3D 1;
+
+static const struct request_test_data separate_conn_valid_test_1 =3D {
+	.request =3D &separate_conn_call_id_valid_1,
+	.parcel_data =3D req_separate_conn_parcel_valid_1,
+	.parcel_size =3D sizeof(req_separate_conn_parcel_valid_1),
+};
+
+/* set_supp_svc_notif tests */
+
+static const guchar req_set_supp_svc_notif_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data set_supp_svc_notif_valid_test_1 =3D {
+	.request =3D NULL,
+	.parcel_data =3D req_set_supp_svc_notif_parcel_valid_1,
+	.parcel_size =3D sizeof(req_set_supp_svc_notif_parcel_valid_1),
+};
+
+/* set_mute tests */
+
+static const int mute_off =3D 0;
+static const int mute_on =3D 1;
+
+static const guchar req_set_mute_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data set_mute_valid_test_1 =3D {
+	.request =3D &mute_off,
+	.parcel_data =3D (guchar *) &req_set_mute_valid_parcel1,
+	.parcel_size =3D sizeof(req_set_mute_valid_parcel1),
+};
+
+static const guchar req_set_mute_valid_parcel2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data set_mute_valid_test_2 =3D {
+	.request =3D &mute_on,
+	.parcel_data =3D (guchar *) &req_set_mute_valid_parcel2,
+	.parcel_size =3D sizeof(req_set_mute_valid_parcel2),
+};
+
+/* send_ussd tests */
+
+static const guchar req_send_ussd_parcel_valid_1[] =3D {
+	0x05, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x31, 0x00, 0x31, 0x00, 0x38, 0x00,
+	0x23, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data send_ussd_valid_test_1 =3D {
+	.request =3D "*118#",
+	.parcel_data =3D req_send_ussd_parcel_valid_1,
+	.parcel_size =3D sizeof(req_send_ussd_parcel_valid_1),
+};
+
+/* set_call_waiting tests */
+
+struct request_test_set_call_waiting {
+	int enabled;
+	int serviceclass;
+	const char *parcel_data;
+	size_t parcel_size;
+};
+
+static const char req_set_call_waiting_parcel_valid_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_set_call_waiting
+		set_call_waiting_valid_test_1 =3D {
+	.enabled =3D 0,
+	.serviceclass =3D 0x01,
+	.parcel_data =3D req_set_call_waiting_parcel_valid_1,
+	.parcel_size =3D sizeof(req_set_call_waiting_parcel_valid_1),
+};
+
+/* query_call_waiting tests */
+
+const int query_call_waiting_mode_0 =3D 0;
+
+static const guchar req_query_call_waiting_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data query_call_waiting_valid_test_1 =3D {
+	.request =3D &query_call_waiting_mode_0,
+	.parcel_data =3D req_query_call_waiting_parcel_valid_1,
+	.parcel_size =3D sizeof(req_query_call_waiting_parcel_valid_1),
+};
+
+/* set_clir tests */
+
+const int set_clir_mode_0 =3D 0;
+
+static const guchar req_set_clir_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data set_clir_valid_test_1 =3D {
+	.request =3D &set_clir_mode_0,
+	.parcel_data =3D req_set_clir_parcel_valid_1,
+	.parcel_size =3D sizeof(req_set_clir_parcel_valid_1),
+};
+
+/* screen_state tests */
+
+const int screen_state_0 =3D 0;
+const int screen_state_1 =3D 1;
+
+static const guchar req_screen_state_parcel_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data screen_state_valid_test_1 =3D {
+	.request =3D &screen_state_0,
+	.parcel_data =3D req_screen_state_parcel_valid_1,
+	.parcel_size =3D sizeof(req_screen_state_parcel_valid_1),
+};
+
+static const guchar req_screen_state_parcel_valid_2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data screen_state_valid_test_2 =3D {
+	.request =3D &screen_state_1,
+	.parcel_data =3D req_screen_state_parcel_valid_2,
+	.parcel_size =3D sizeof(req_screen_state_parcel_valid_2),
+};
+
+/* set_preferred_network_type tests */
+
+const int preferred_network_type_gsm_only =3D PREF_NET_TYPE_GSM_ONLY;
+
+static const guchar req_set_preferred_network_type_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_data
+		set_preferred_network_type_valid_test_1 =3D {
+	.request =3D &preferred_network_type_gsm_only,
+	.parcel_data =3D req_set_preferred_network_type_valid_1,
+	.parcel_size =3D sizeof(req_set_preferred_network_type_valid_1),
+};
+
+/* query_facility_lock tests */
+
+struct request_test_query_facility_lock_data {
+	const char *facility;
+	int services;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_query_facility_lock_valid_1[] =3D {
+	0x04, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x41, 0x00, 0x4f, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff
+};
+
+static const struct request_test_query_facility_lock_data
+		query_facility_lock_valid_test_1 =3D {
+	.facility =3D "AO",
+	.services =3D SERVICE_CLASS_NONE,
+	.parcel_data =3D req_query_facility_lock_valid_1,
+	.parcel_size =3D sizeof(req_query_facility_lock_valid_1),
+};
+
+/* set_facility_lock tests */
+
+struct request_test_set_facility_lock_data {
+	const char *facility;
+	int enable;
+	const char *passwd;
+	int services;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_set_facility_lock_valid_1[] =3D {
+	0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x49, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff
+};
+
+static const struct request_test_set_facility_lock_data
+		set_facility_lock_valid_test_1 =3D {
+	.facility =3D "OI",
+	.enable =3D 0,
+	.passwd =3D "0000",
+	.services =3D SERVICE_CLASS_NONE,
+	.parcel_data =3D req_set_facility_lock_valid_1,
+	.parcel_size =3D sizeof(req_set_facility_lock_valid_1),
+};
+
+/* change_barring_password tests */
+
+struct request_test_change_barring_password_data {
+	const char *facility;
+	const char *old_passwd;
+	const char *new_passwd;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_change_barring_password_valid_1[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x41, 0x00, 0x42, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_change_barring_password_data
+		change_barring_password_valid_test_1 =3D {
+	.facility =3D "AB",
+	.old_passwd =3D "1111",
+	.new_passwd =3D "0000",
+	.parcel_data =3D req_change_barring_password_valid_1,
+	.parcel_size =3D sizeof(req_change_barring_password_valid_1),
+};
+
+/* oem_hook_raw tests */
+
+struct request_test_oem_hook_raw_data {
+	const guchar *data;
+	gsize size;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_oem_hook_raw_valid_1[] =3D {
+	0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_oem_hook_raw_data oem_hook_raw_valid_test=
_1 =3D {
+	.data =3D req_oem_hook_raw_valid_1 + sizeof(int32_t),
+	.size =3D sizeof(req_oem_hook_raw_valid_1) - sizeof(int32_t),
+	.parcel_data =3D (guchar *) &req_oem_hook_raw_valid_1,
+	.parcel_size =3D sizeof(req_oem_hook_raw_valid_1),
+};
+
+static const guchar req_oem_hook_raw_valid_2[] =3D {
+	0xFF, 0xFF, 0xFF, 0xFF
+};
+
+static const struct request_test_oem_hook_raw_data oem_hook_raw_valid_test=
_2 =3D {
+	.data =3D NULL,
+	.size =3D 0,
+	.parcel_data =3D (guchar *) &req_oem_hook_raw_valid_2,
+	.parcel_size =3D sizeof(req_oem_hook_raw_valid_2),
+};
+
+/* set_initial_attach_apn tests */
+
+struct request_test_set_initial_attach_apn {
+	const char *apn;
+	const int proto;
+	const char *user;
+	const char *passwd;
+	const char *mccmnc;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_set_initial_attach_apn_valid_1[] =3D {
+	0x0c, 0x00, 0x00, 0x00, 0x61, 0x00, 0x69, 0x00, 0x72, 0x00, 0x74, 0x00,
+	0x65, 0x00, 0x6c, 0x00, 0x77, 0x00, 0x61, 0x00, 0x70, 0x00, 0x2e, 0x00,
+	0x65, 0x00, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0x07, 0x00, 0x00, 0x00, 0x77, 0x00, 0x61, 0x00, 0x70, 0x00, 0x40, 0x00,
+	0x77, 0x00, 0x61, 0x00, 0x70, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00,
+	0x77, 0x00, 0x61, 0x00, 0x70, 0x00, 0x31, 0x00, 0x32, 0x00, 0x35, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct request_test_set_initial_attach_apn
+					set_initial_attach_apn_valid_test_1 =3D {
+	.apn =3D "airtelwap.es",
+	.proto =3D OFONO_GPRS_PROTO_IP,
+	.user =3D "wap(a)wap",
+	.passwd =3D "wap125",
+	.mccmnc =3D "21401",
+	.parcel_data =3D req_set_initial_attach_apn_valid_1,
+	.parcel_size =3D sizeof(req_set_initial_attach_apn_valid_1),
+};
+
+/* oem_hook_strings tests */
+
+struct request_test_oem_hook_strings {
+	const int num_str;
+	const char **str;
+	const guchar *parcel_data;
+	gsize parcel_size;
+};
+
+static const guchar req_oem_hook_strings_valid_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x41, 0x00, 0x54, 0x00,
+	0x2b, 0x00, 0x45, 0x00, 0x50, 0x00, 0x49, 0x00, 0x4e, 0x00, 0x43, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x45, 0x00,
+	0x50, 0x00, 0x49, 0x00, 0x4e, 0x00, 0x43, 0x00, 0x3a, 0x00, 0x00, 0x00
+};
+
+static const char *oem_hook_strings_valid_1[] =3D { "AT+EPINC", "+EPINC:" =
};
+
+static const struct request_test_oem_hook_strings
+					oem_hook_strings_valid_test_1 =3D {
+	.num_str =3D G_N_ELEMENTS(oem_hook_strings_valid_1),
+	.str =3D oem_hook_strings_valid_1,
+	.parcel_data =3D req_oem_hook_strings_valid_1,
+	.parcel_size =3D sizeof(req_oem_hook_strings_valid_1),
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_REQUEST_RADIO_POWER 'OFF' message.
+ */
+static const guchar req_power_off_valid_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_REQUEST_RADIO_POWER 'ON' message.
+ */
+static const guchar req_power_on_valid_parcel2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const gboolean power_off =3D FALSE;
+static const gboolean power_on =3D TRUE;
+
+static const struct request_test_data power_valid_test_1 =3D {
+	.request =3D &power_off,
+	.parcel_data =3D (guchar *) &req_power_off_valid_parcel1,
+	.parcel_size =3D sizeof(req_power_off_valid_parcel1),
+};
+
+static const struct request_test_data power_valid_test_2 =3D {
+	.request =3D &power_on,
+	.parcel_data =3D (guchar *) &req_power_on_valid_parcel2,
+	.parcel_size =3D sizeof(req_power_on_valid_parcel2),
+};
+
+static void test_deactivate_data_call_invalid(gconstpointer data)
+{
+	const struct req_deactivate_data_call *request =3D data;
+	gboolean result;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	/*
+	 * No parcel_init needed, as these tests all fail during
+	 * param validation
+	 */
+	result =3D g_ril_request_deactivate_data_call(NULL, request,
+								&rilp, &error);
+	g_assert(result =3D=3D FALSE);
+	g_assert(error.type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
+			error.error =3D=3D -EINVAL);
+}
+
+static void test_deactivate_data_call_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_deactivate_data_call *request =3D test_data->request;
+	gboolean result;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	result =3D g_ril_request_deactivate_data_call(NULL, request,
+								&rilp, &error);
+	g_assert(result =3D=3D TRUE);
+	g_assert(error.type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			error.error =3D=3D 0);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+						test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_setup_data_call_invalid(gconstpointer data)
+{
+	const struct req_setup_data_call *request =3D data;
+	gboolean result;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	/*
+	 * No parcel_init needed, as these tests all fail during
+	 * param validation
+	 */
+	result =3D g_ril_request_setup_data_call(NULL, request, &rilp, &error);
+	g_assert(result =3D=3D FALSE);
+	g_assert(error.type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
+			error.error =3D=3D -EINVAL);
+}
+
+static void test_request_setup_data_call_valid(gconstpointer data)
+{
+	const struct req_setup_data_call *request =3D data;
+	gboolean result;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	result =3D g_ril_request_setup_data_call(NULL, request, &rilp, &error);
+	g_assert(result =3D=3D TRUE);
+	g_assert(error.type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			error.error =3D=3D 0);
+
+	parcel_free(&rilp);
+
+	/* TODO: add unit 3 tests to validate binary parcel result */
+}
+
+static void test_request_power_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const gboolean *online =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_power(NULL, *online, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+						test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_read_info_valid(gconstpointer data)
+{
+	const struct req_sim_read_info *req =3D data;
+	gboolean result;
+	struct parcel rilp;
+
+	result =3D g_ril_request_sim_read_info(NULL, req, &rilp);
+	g_assert(result =3D=3D TRUE);
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_read_info_invalid(gconstpointer data)
+{
+	const struct req_sim_read_info *req =3D data;
+	gboolean result;
+	struct parcel rilp;
+
+	result =3D g_ril_request_sim_read_info(NULL, req, &rilp);
+	g_assert(result =3D=3D FALSE);
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_read_binary_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_sim_read_binary *req =3D test_data->request;
+	struct parcel rilp;
+	gboolean result;
+
+	result =3D g_ril_request_sim_read_binary(NULL, req, &rilp);
+
+	g_assert(result =3D=3D TRUE);
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_read_record_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_sim_read_record *req =3D test_data->request;
+	struct parcel rilp;
+	gboolean result;
+
+	result =3D g_ril_request_sim_read_record(NULL, req, &rilp);
+
+	g_assert(result =3D=3D TRUE);
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_write_binary_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_sim_write_binary *req =3D test_data->request;
+	struct parcel rilp;
+	gboolean result;
+
+	result =3D g_ril_request_sim_write_binary(NULL, req, &rilp);
+
+	g_assert(result =3D=3D TRUE);
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sim_write_record_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_sim_write_record *req =3D test_data->request;
+	struct parcel rilp;
+	gboolean result;
+
+	result =3D g_ril_request_sim_write_record(NULL, req, &rilp);
+
+	g_assert(result =3D=3D TRUE);
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_read_imsi(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const char *aid_str =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_read_imsi(NULL, aid_str, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_pin_send(gconstpointer data)
+{
+	const struct request_test_pin_send_data *test_data =3D data;
+	const char *passwd =3D test_data->passwd;
+	const char *aid_str =3D test_data->aid_str;
+	struct parcel rilp;
+
+	g_ril_request_pin_send(NULL, passwd, aid_str, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_pin_change_state(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_pin_change_state *req =3D test_data->request;
+	struct parcel rilp;
+	gboolean result;
+
+	result =3D g_ril_request_pin_change_state(NULL, req, &rilp);
+
+	g_assert(result =3D=3D TRUE);
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_pin_send_puk(gconstpointer data)
+{
+	const struct request_test_pin_send_puk_data *test_data =3D data;
+	const char *puk =3D test_data->puk;
+	const char *passwd =3D test_data->passwd;
+	const char *aid_str =3D test_data->aid_str;
+	struct parcel rilp;
+
+	g_ril_request_pin_send_puk(NULL, puk, passwd, aid_str, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_change_passwd(gconstpointer data)
+{
+	const struct request_test_change_passwd_data *test_data =3D data;
+	const char *old_passwd =3D test_data->old_passwd;
+	const char *new_passwd =3D test_data->new_passwd;
+	const char *aid_str =3D test_data->aid_str;
+	struct parcel rilp;
+
+	g_ril_request_change_passwd(NULL, old_passwd, new_passwd,
+					aid_str, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sms_cmgs(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct req_sms_cmgs *req =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_sms_cmgs(NULL, req, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_sms_acknowledge(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_sms_acknowledge(NULL, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_smsc_address(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const struct ofono_phone_number *number =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_set_smsc_address(NULL, number, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_dial(gconstpointer data)
+{
+	const struct request_test_dial_data *test_data =3D data;
+	const struct ofono_phone_number *ph =3D &test_data->ph;
+	enum ofono_clir_option clir =3D test_data->clir;
+	struct parcel rilp;
+
+	g_ril_request_dial(NULL, ph, clir, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_hangup(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const unsigned *call_id =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_hangup(NULL, *call_id, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_dtmf(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const char *dtmf_char =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_dtmf(NULL, *dtmf_char, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_separate_conn(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const unsigned *call_id =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_separate_conn(NULL, *call_id, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_supp_svc_notif(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_set_supp_svc_notif(NULL, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+			test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_mute_valid(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	const int *muted =3D test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_set_mute(NULL, *muted, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_send_ussd(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_send_ussd(NULL, test_data->request, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_call_waiting(gconstpointer data)
+{
+	const struct request_test_set_call_waiting *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_set_call_waiting(NULL, test_data->enabled,
+					test_data->serviceclass, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_query_call_waiting(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	int mode =3D *(int *) test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_query_call_waiting(NULL, mode, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_clir(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	int mode =3D *(int *) test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_set_clir(NULL, mode, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_screen_state(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	int state =3D *(int *) test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_screen_state(NULL, state, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_preferred_network_type(gconstpointer data)
+{
+	const struct request_test_data *test_data =3D data;
+	int preferred_network_type =3D *(int *) test_data->request;
+	struct parcel rilp;
+
+	g_ril_request_set_preferred_network_type(NULL, preferred_network_type,
+							&rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_query_facility_lock(gconstpointer data)
+{
+	const struct request_test_query_facility_lock_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_query_facility_lock(NULL, test_data->facility, "",
+						test_data->services, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_facility_lock(gconstpointer data)
+{
+	const struct request_test_set_facility_lock_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_set_facility_lock(NULL, test_data->facility,
+					test_data->enable, test_data->passwd,
+					test_data->services, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_set_initial_attach_apn(gconstpointer data)
+{
+	const struct request_test_set_initial_attach_apn *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_set_initial_attach_apn(NULL, test_data->apn,
+					test_data->proto, test_data->user,
+					test_data->passwd, test_data->mccmnc,
+					&rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_change_barring_password(gconstpointer data)
+{
+	const struct request_test_change_barring_password_data *test_data =3D
+									data;
+	struct parcel rilp;
+
+	g_ril_request_change_barring_password(NULL, test_data->facility,
+						test_data->old_passwd,
+						test_data->new_passwd, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_oem_hook_raw(gconstpointer data)
+{
+	const struct request_test_oem_hook_raw_data *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_oem_hook_raw(NULL, test_data->data,
+					test_data->size, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+static void test_request_oem_hook_strings(gconstpointer data)
+{
+	const struct request_test_oem_hook_strings *test_data =3D data;
+	struct parcel rilp;
+
+	g_ril_request_oem_hook_strings(NULL, test_data->str,
+					test_data->num_str, &rilp);
+
+	g_assert(!memcmp(rilp.data, test_data->parcel_data,
+				test_data->parcel_size));
+
+	parcel_free(&rilp);
+}
+
+#endif
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid DEACTIVATE_DATA_CALL Test 1",
+				&req_deact_data_call_invalid_1,
+				test_deactivate_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid DEACTIVATE_DATA_CALL Test 1",
+				&deact_data_call_valid_test_1,
+				test_deactivate_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 1",
+				&req_setup_data_call_invalid_1,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 2",
+				&req_setup_data_call_invalid_2,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 3",
+				&req_setup_data_call_invalid_3,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 4",
+				&req_setup_data_call_invalid_4,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 5",
+				&req_setup_data_call_invalid_5,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 6",
+				&req_setup_data_call_invalid_6,
+				test_request_setup_data_call_invalid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 1",
+				&req_setup_data_call_valid_1,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 2",
+				&req_setup_data_call_valid_2,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 3",
+				&req_setup_data_call_valid_3,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 4",
+				&req_setup_data_call_valid_4,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 5",
+				&req_setup_data_call_valid_5,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/gprs-context: "
+				"valid SETUP_DATA_CALL Test 6",
+				&req_setup_data_call_valid_6,
+				test_request_setup_data_call_valid);
+
+	g_test_add_data_func("/testgrilrequest/power: "
+				"valid POWER Test 1",
+				&power_valid_test_1,
+				test_request_power_valid);
+
+	g_test_add_data_func("/testgrilrequest/power: "
+				"valid POWER Test 2",
+				&power_valid_test_2,
+				test_request_power_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid SIM_READ_INFO Test 1",
+				&req_sim_read_info_valid_1,
+				test_request_sim_read_info_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"invalid SIM_READ_INFO Test 1",
+				&req_sim_read_info_invalid_1,
+				test_request_sim_read_info_invalid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid SIM_READ_BINARY Test 1",
+				&sim_read_binary_valid_test_1,
+				test_request_sim_read_binary_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid SIM_READ_RECORD Test 1",
+				&sim_read_record_valid_test_1,
+				test_request_sim_read_record_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid SIM_WRITE_BINARY Test 1",
+				&sim_write_binary_valid_test_1,
+				test_request_sim_write_binary_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid SIM_WRITE_RECORD Test 1",
+				&sim_write_record_valid_test_1,
+				test_request_sim_write_record_valid);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid READ_IMSI Test 1",
+				&read_imsi_valid_test_1,
+				test_request_read_imsi);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid PIN_SEND Test 1",
+				&pin_send_record_valid_test_1,
+				test_request_pin_send);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid PIN_CHANGE_STATE Test 1",
+				&pin_change_state_valid_test_1,
+				test_request_pin_change_state);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid PIN_SEND_PUK Test 1",
+				&pin_send_puk_valid_test_1,
+				test_request_pin_send_puk);
+
+	g_test_add_data_func("/testgrilrequest/sim: "
+				"valid CHANGE_PASSWD Test 1",
+				&change_passwd_valid_test_1,
+				test_request_change_passwd);
+
+	g_test_add_data_func("/testgrilrequest/sms: "
+				"valid SMS_CMGS Test 1",
+				&sms_cmgs_valid_test_1,
+				test_request_sms_cmgs);
+
+	g_test_add_data_func("/testgrilrequest/sms: "
+				"valid SMS_ACKNOWLEDGE Test 1",
+				&sms_acknowledge_valid_test_1,
+				test_request_sms_acknowledge);
+
+	g_test_add_data_func("/testgrilrequest/sms: "
+				"valid SET_SMSC_ADDRESS Test 1",
+				&smsc_address_valid_test_1,
+				test_request_set_smsc_address);
+
+	g_test_add_data_func("/testgrilrequest/voicecall: "
+				"valid DIAL Test 1",
+				&dial_valid_test_1,
+				test_request_dial);
+
+	g_test_add_data_func("/testgrilrequest/voicecall: "
+				"valid HANGUP Test 1",
+				&set_hangup_valid_test_1,
+				test_request_hangup);
+
+	g_test_add_data_func("/testgrilrequest/voicecall: "
+				"valid DTMF Test 1",
+				&dtmf_valid_test_1,
+				test_request_dtmf);
+
+	g_test_add_data_func("/testgrilrequest/voicecall: "
+				"valid SEPARATE_CONN Test 1",
+				&separate_conn_valid_test_1,
+				test_request_separate_conn);
+
+	g_test_add_data_func("/testgrilrequest/voicecall: "
+				"valid SET_SUPP_SVC_NOTIF Test 1",
+				&set_supp_svc_notif_valid_test_1,
+				test_request_set_supp_svc_notif);
+
+	g_test_add_data_func("/testgrilrequest/call-volume: "
+				"valid SET_MUTE Test 1",
+				&set_mute_valid_test_1,
+				test_request_set_mute_valid);
+
+	g_test_add_data_func("/testgrilrequest/call-volume: "
+				"valid SET_MUTE Test 2",
+				&set_mute_valid_test_2,
+				test_request_set_mute_valid);
+
+	g_test_add_data_func("/testgrilrequest/ussd: "
+				"valid SEND_USSD Test 1",
+				&send_ussd_valid_test_1,
+				test_request_send_ussd);
+
+	g_test_add_data_func("/testgrilrequest/call-settings: "
+				"valid SET_CALL_WAITING Test 1",
+				&set_call_waiting_valid_test_1,
+				test_request_set_call_waiting);
+
+	g_test_add_data_func("/testgrilrequest/call-settings: "
+				"valid QUERY_CALL_WAITING Test 1",
+				&query_call_waiting_valid_test_1,
+				test_request_query_call_waiting);
+
+	g_test_add_data_func("/testgrilrequest/call-settings: "
+				"valid SET_CLIR Test 1",
+				&set_clir_valid_test_1,
+				test_request_set_clir);
+
+	g_test_add_data_func("/testgrilrequest/radio-settings: "
+				"valid SCREEN_STATE Test 1",
+				&screen_state_valid_test_1,
+				test_request_screen_state);
+
+	g_test_add_data_func("/testgrilrequest/radio-settings: "
+				"valid SCREEN_STATE Test 2",
+				&screen_state_valid_test_2,
+				test_request_screen_state);
+
+	g_test_add_data_func("/testgrilrequest/radio-settings: "
+				"valid SET_PREFERRED_NETWORK_TYPE Test 1",
+				&set_preferred_network_type_valid_test_1,
+				test_request_set_preferred_network_type);
+
+	g_test_add_data_func("/testgrilrequest/call-barring: "
+				"valid QUERY_FACILITY_LOCK Test 1",
+				&query_facility_lock_valid_test_1,
+				test_request_query_facility_lock);
+
+	g_test_add_data_func("/testgrilrequest/call-barring: "
+				"valid SET_FACILITY_LOCK Test 1",
+				&set_facility_lock_valid_test_1,
+				test_request_set_facility_lock);
+
+	g_test_add_data_func("/testgrilrequest/call-barring: "
+				"valid CHANGE_BARRING_PASSWORD Test 1",
+				&change_barring_password_valid_test_1,
+				test_request_change_barring_password);
+
+	g_test_add_data_func("/testgrilrequest/oem-hook-raw: "
+				"valid OEM_HOOK_RAW Test 1",
+				&oem_hook_raw_valid_test_1,
+				test_request_oem_hook_raw);
+
+	g_test_add_data_func("/testgrilrequest/oem-hook-raw: "
+				"valid OEM_HOOK_RAW Test 2",
+				&oem_hook_raw_valid_test_2,
+				test_request_oem_hook_raw);
+
+	g_test_add_data_func("/testgrilrequest/set-ia-apn: "
+				"valid SET_INITIAL_ATTACH_APN Test 1",
+				&set_initial_attach_apn_valid_test_1,
+				test_request_set_initial_attach_apn);
+
+	g_test_add_data_func("/testgrilrequest/oem-hook-strings: "
+				"valid OEM_HOOK_STRINGS Test 1",
+				&oem_hook_strings_valid_test_1,
+				test_request_oem_hook_strings);
+
+#endif
+	return g_test_run();
+}
diff --git a/unit/test-rilunsol.c b/unit/test-rilunsol.c
new file mode 100644
index 0000000..415fb63
--- /dev/null
+++ b/unit/test-rilunsol.c
@@ -0,0 +1,698 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013 Canonical Ltd.
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
+#include <stdio.h>
+#include <assert.h>
+#include <glib.h>
+#include <errno.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/types.h>
+
+#include "gril.h"
+#include "drivers/rilmodem/rilunsol.h"
+
+/*
+ * TODO: It may make sense to split this file into
+ * domain-specific files ( eg. test-grilrequest-gprs-context.c )
+ * once more tests are added.
+ */
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+typedef struct signal_strength_test signal_strength_test;
+struct signal_strength_test {
+	int strength;
+	int ril_tech;
+	const struct ril_msg msg;
+};
+
+static const struct ril_msg reply_data_call_invalid_1 =3D {
+	.buf =3D "",
+	.buf_len =3D 0,
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data equates te the following
+ * RIL_REQUEST_SETUP_DATA_CALL reply parameters:
+ *
+ * {version=3D2,num=3D2 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DI=
P}
+ * Parcel is truncated, as num=3D2 should trigger a failure.
+ */
+static const guchar reply_data_call_invalid_parcel2[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_invalid_2 =3D {
+	.buf =3D (gchar *) &reply_data_call_invalid_parcel2,
+	.buf_len =3D sizeof(reply_data_call_invalid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data is a binary representation of
+ * a parcel containing an invalid RIL_REQUEST_SETUP_DATA_CALL reply
+ * with a NULL string specified for 'type':
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DN=
ULL
+ * ifname=3Drmnet_usb0,address=3D10.181.235.154/30,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3D10.181.235.153]}
+ */
+static const guchar reply_data_call_invalid_parcel3[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00, 0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x2f, 0x00, 0x33, 0x00, 0x30, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00, 0x33, 0x00, 0x35, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_invalid_3 =3D {
+	.buf =3D (gchar *) &reply_data_call_invalid_parcel3,
+	.buf_len =3D sizeof(reply_data_call_invalid_parcel3),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data is a binary representation of
+ * a parcel containing an invalid RIL_REQUEST_SETUP_DATA_CALL reply
+ * with a NULL string specified for 'ifname':
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DIP
+ * ifname=3DNULL,address=3D10.181.235.154/30,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3D10.181.235.153]}
+ */
+static const guchar reply_data_call_invalid_parcel4[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x11, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x2f, 0x00, 0x33, 0x00, 0x30, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00, 0x33, 0x00, 0x35, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_invalid_4 =3D {
+	.buf =3D (gchar *) &reply_data_call_invalid_parcel4,
+	.buf_len =3D sizeof(reply_data_call_invalid_parcel4),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data is a binary representation of
+ * a parcel containing an invalid RIL_REQUEST_SETUP_DATA_CALL reply
+ * with a NULL string specified for 'address':
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DIP
+ * ifname=3Drmnet_usb0,address=3DNULL,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3D10.181.235.153]}
+ */
+static const guchar reply_data_call_invalid_parcel5[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00, 0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00, 0x33, 0x00, 0x35, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_invalid_5 =3D {
+	.buf =3D (gchar *) &reply_data_call_invalid_parcel5,
+	.buf_len =3D sizeof(reply_data_call_invalid_parcel5),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing an invalid RIL_REQUEST_SETUP_DATA_CALL reply
+ * with a NULL string specified for 'gateways':
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DIP
+ * ifname=3Drmnet_usb0,address=3D10.181.235.154/30,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3DNULL]}
+ */
+static const guchar reply_data_call_invalid_parcel6[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00, 0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x2f, 0x00, 0x33, 0x00, 0x30, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff
+};
+
+static const struct ril_msg reply_data_call_invalid_6 =3D {
+	.buf =3D (gchar *) &reply_data_call_invalid_parcel6,
+	.buf_len =3D sizeof(reply_data_call_invalid_parcel6),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_REQUEST_SETUP_DATA_CALL reply with the
+ * following parameters:
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DI=
P,
+ * ifname=3Drmnet_usb0,address=3D10.181.235.154/30,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3D10.181.235.153]}
+ */
+static const guchar reply_data_call_valid_parcel1[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00, 0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x2f, 0x00, 0x33, 0x00, 0x30, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x33, 0x00, 0x00, 0x00,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00, 0x33, 0x00, 0x35, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_valid_1 =3D {
+	.buf =3D (gchar *) &reply_data_call_valid_parcel1,
+	.buf_len =3D sizeof(reply_data_call_valid_parcel1),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing an valid RIL_REQUEST_SETUP_DATA_CALL reply with
+ * a NULL string specified for 'dns' (note that some data calls without DNS
+ * information might still be rejected by the GPRS context driver):
+ *
+ * {version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D2,type=3DIP
+ * ifname=3Drmnet_usb0,address=3D10.181.235.154/30,
+ * dns=3DNULL,gateways=3D10.181.235.153]}
+ */
+static const guchar reply_data_call_valid_parcel2[] =3D {
+	0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00, 0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x33, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x2f, 0x00, 0x33, 0x00, 0x30, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x2e, 0x00, 0x32, 0x00, 0x33, 0x00, 0x35, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x35, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg reply_data_call_valid_2 =3D {
+	.buf =3D (gchar *) &reply_data_call_valid_parcel2,
+	.buf_len =3D sizeof(reply_data_call_valid_parcel2),
+	.unsolicited =3D FALSE,
+	.req =3D RIL_REQUEST_SETUP_DATA_CALL,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+static const struct ril_msg unsol_data_call_list_changed_invalid_1 =3D {
+	.buf =3D "",
+	.buf_len =3D 0,
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_DATA_CALL_LIST_CHANGED,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_DATA_CALL_LIST_CHANGED message
+ * with the following parameters:
+ *
+ * (version=3D7,num=3D1 [status=3D0,retry=3D-1,cid=3D0,active=3D1,type=3DI=
P,
+ * ifname=3Drmnet_usb0,address=3D10.209.114.102/30,
+ * dns=3D172.16.145.103 172.16.145.103,gateways=3D10.209.114.101]}
+ */
+static const char unsol_data_call_list_changed_parcel1[] =3D {
+	0x00, 0x00, 0x00, 0xd4, 0x01, 0x00, 0x00, 0x00, 0xf2, 0x03, 0x00, 0x00,
+	0x07, 0x00, 0x00, 0x00,	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,	0x01, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x49, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, 0x00, 0x00, 0x00, 0x72, 0x00, 0x6d, 0x00, 0x6e, 0x00, 0x65, 0x00,
+	0x74, 0x00, 0x5f, 0x00,	0x75, 0x00, 0x73, 0x00, 0x62, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00,	0x31, 0x00, 0x30, 0x00,
+	0x2e, 0x00, 0x32, 0x00, 0x30, 0x00, 0x39, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x34, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00, 0x32, 0x00,
+	0x2f, 0x00, 0x33, 0x00,	0x30, 0x00, 0x00, 0x00, 0x1d, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x36, 0x00,
+	0x2e, 0x00, 0x31, 0x00, 0x34, 0x00, 0x35, 0x00, 0x2e, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x33, 0x00, 0x20, 0x00, 0x31, 0x00, 0x37, 0x00, 0x32, 0x00,
+	0x2e, 0x00, 0x31, 0x00,	0x36, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x35, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x30, 0x00,	0x33, 0x00, 0x00, 0x00,
+	0x0e, 0x00, 0x00, 0x00, 0x31, 0x00, 0x30, 0x00, 0x2e, 0x00, 0x32, 0x00,
+	0x30, 0x00, 0x39, 0x00, 0x2e, 0x00, 0x31, 0x00, 0x31, 0x00, 0x34, 0x00,
+	0x2e, 0x00, 0x31, 0x00,	0x30, 0x00, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg unsol_data_call_list_changed_valid_1 =3D {
+	.buf =3D (gchar *) &unsol_data_call_list_changed_parcel1,
+	.buf_len =3D sizeof(unsol_data_call_list_changed_parcel1),
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_DATA_CALL_LIST_CHANGED,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_RESPONSE_NEW_SMS message
+ * with the following parameter (SMSC address length is 7):
+ *
+ * {07914306073011F0040B914336543980F50000310113212002400AC8373B0C6AD7DDE4=
37}
+ */
+static const char unsol_response_new_sms_parcel1[] =3D {
+	0x48, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x30, 0x00, 0x36, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x30, 0x00, 0x31, 0x00, 0x31, 0x00, 0x46, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x30, 0x00, 0x42, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x39, 0x00, 0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x31, 0x00, 0x33, 0x00, 0x32, 0x00, 0x31, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x30, 0x00, 0x32, 0x00, 0x34, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x41, 0x00, 0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x42, 0x00, 0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,
+	0x44, 0x00, 0x37, 0x00, 0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg unsol_response_new_sms_valid_1 =3D {
+	.buf =3D (gchar *) &unsol_response_new_sms_parcel1,
+	.buf_len =3D sizeof(unsol_response_new_sms_parcel1),
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_RESPONSE_NEW_SMS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_RESPONSE_NEW_SMS message
+ * with the following parameter (SMSC address length is 6):
+ *
+ * {069143060730F0040B914336543980F50000310113212002400AC8373B0C6AD7DDE437}
+ */
+static const char unsol_response_new_sms_parcel2[] =3D {
+	0x46, 0x00, 0x00, 0x00, 0x30, 0x00, 0x36, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x30, 0x00, 0x36, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x30, 0x00, 0x46, 0x00, 0x30, 0x00,	0x30, 0x00, 0x34, 0x00,
+	0x30, 0x00, 0x42, 0x00, 0x39, 0x00, 0x31, 0x00,	0x34, 0x00, 0x33, 0x00,
+	0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,	0x33, 0x00, 0x39, 0x00,
+	0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,	0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x33, 0x00, 0x31, 0x00,	0x30, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x33, 0x00, 0x32, 0x00, 0x31, 0x00,	0x32, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x32, 0x00, 0x34, 0x00, 0x30, 0x00,	0x30, 0x00, 0x41, 0x00,
+	0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,	0x33, 0x00, 0x42, 0x00,
+	0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,	0x44, 0x00, 0x37, 0x00,
+	0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,	0x33, 0x00, 0x37, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg unsol_response_new_sms_valid_2 =3D {
+	.buf =3D (gchar *) &unsol_response_new_sms_parcel2,
+	.buf_len =3D sizeof(unsol_response_new_sms_parcel2),
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_RESPONSE_NEW_SMS,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_SUPP_SVC_NOTIFICATION message
+ * with the following parameters:
+ *
+ * {1,2,0,0,} -> call has been put on hold
+ */
+static const guchar unsol_supp_svc_notif_parcel1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff
+};
+
+static const struct ril_msg unsol_supp_svc_notif_valid_1 =3D {
+	.buf =3D (gchar *) &unsol_supp_svc_notif_parcel1,
+	.buf_len =3D sizeof(unsol_supp_svc_notif_parcel1),
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_SUPP_SVC_NOTIFICATION,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_SIGNAL_STRENGTH message
+ * with the following parameters:
+ *
+ * (gw: 14, cdma: -1, evdo: -1, lte: 99)
+ *
+ * Note, the return value for gw sigmal is: (gw * 100) / 31, which
+ * in this case equals 45.
+ */
+static const guchar unsol_signal_strength_parcel1[] =3D {
+	0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x63, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x7f,
+	0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff, 0x7f
+};
+
+static const signal_strength_test unsol_signal_strength_valid_1 =3D {
+	.strength =3D 45,
+	.ril_tech =3D RADIO_TECH_GPRS,
+	.msg =3D {
+		.buf =3D (gchar *) &unsol_signal_strength_parcel1,
+		.buf_len =3D sizeof(unsol_signal_strength_parcel1),
+		.unsolicited =3D TRUE,
+		.req =3D RIL_UNSOL_SIGNAL_STRENGTH,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_SIGNAL_STRENGTH message
+ * with the following parameters:
+ *
+ * (gw: 99, cdma: 0, evdo: 0, lte: 99)
+ */
+static const guchar unsol_signal_strength_parcel2[] =3D {
+	0x63, 0x00, 0x00, 0x00, 0x63, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x63, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x7f,
+	0xff, 0xff, 0xff, 0x7f, 0x2d, 0x01, 0x00, 0x00, 0xff, 0xff, 0xff, 0x7f,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const signal_strength_test unsol_signal_strength_valid_2 =3D {
+	.strength =3D -1,
+	.ril_tech =3D RADIO_TECH_GPRS,
+	.msg =3D {
+		.buf =3D (gchar *) &unsol_signal_strength_parcel2,
+		.buf_len =3D sizeof(unsol_signal_strength_parcel2),
+		.unsolicited =3D TRUE,
+		.req =3D RIL_UNSOL_SIGNAL_STRENGTH,
+		.serial_no =3D 0,
+		.error =3D 0,
+	}
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_ON_USSD message with the following
+ * parameters:
+ *
+ * {0,Spain 12:56 09/12/13  Canary 11:56 09/12/13  }
+ */
+static const guchar unsol_on_ussd_parcel1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x2d, 0x00, 0x00, 0x00, 0x53, 0x00, 0x70, 0x00, 0x61, 0x00, 0x69, 0x00,
+	0x6e, 0x00, 0x20, 0x00, 0x31, 0x00, 0x32, 0x00, 0x3a, 0x00, 0x35, 0x00,
+	0x36, 0x00, 0x20, 0x00, 0x30, 0x00, 0x39, 0x00, 0x2f, 0x00, 0x31, 0x00,
+	0x32, 0x00, 0x2f, 0x00, 0x31, 0x00, 0x33, 0x00, 0x20, 0x00, 0x20, 0x00,
+	0x43, 0x00, 0x61, 0x00, 0x6e, 0x00, 0x61, 0x00, 0x72, 0x00, 0x79, 0x00,
+	0x20, 0x00, 0x31, 0x00, 0x31, 0x00, 0x3a, 0x00, 0x35, 0x00, 0x36, 0x00,
+	0x20, 0x00, 0x30, 0x00, 0x39, 0x00, 0x2f, 0x00, 0x31, 0x00, 0x32, 0x00,
+	0x2f, 0x00, 0x31, 0x00, 0x33, 0x00, 0x20, 0x00, 0x20, 0x00, 0x00, 0x00
+};
+
+static const struct ril_msg unsol_on_ussd_valid_1 =3D {
+	.buf =3D (gchar *) &unsol_on_ussd_parcel1,
+	.buf_len =3D sizeof(unsol_on_ussd_parcel1),
+	.unsolicited =3D TRUE,
+	.req =3D RIL_UNSOL_ON_USSD,
+	.serial_no =3D 0,
+	.error =3D 0,
+};
+
+static void test_reply_data_call_invalid(gconstpointer data)
+{
+	struct ril_data_call_list *call_list;
+
+	call_list =3D g_ril_unsol_parse_data_call_list(NULL, data);
+	g_assert(call_list =3D=3D NULL);
+}
+
+static void test_reply_data_call_valid(gconstpointer data)
+{
+	struct ril_data_call_list *call_list =3D
+		g_ril_unsol_parse_data_call_list(NULL, data);
+
+	g_assert(call_list !=3D NULL);
+	g_ril_unsol_free_data_call_list(call_list);
+}
+
+static void test_unsol_data_call_list_changed_invalid(gconstpointer data)
+{
+	struct ril_data_call_list *unsol;
+
+	unsol =3D g_ril_unsol_parse_data_call_list(NULL, data);
+	g_assert(unsol =3D=3D NULL);
+}
+
+static void test_unsol_data_call_list_changed_valid(gconstpointer data)
+{
+	struct ril_data_call_list *unsol;
+
+	unsol =3D g_ril_unsol_parse_data_call_list(NULL, data);
+	g_assert(unsol !=3D NULL);
+	g_ril_unsol_free_data_call_list(unsol);
+}
+
+static void test_signal_strength_valid(gconstpointer data)
+{
+	const signal_strength_test *test =3D data;
+	int strength =3D g_ril_unsol_parse_signal_strength(NULL, &test->msg,
+								test->ril_tech);
+	g_assert(strength =3D=3D test->strength);
+}
+
+static void test_unsol_response_new_sms_valid(gconstpointer data)
+{
+	struct unsol_sms_data *sms_data;
+
+	sms_data =3D g_ril_unsol_parse_new_sms(NULL, data);
+
+	g_assert(sms_data !=3D NULL);
+	g_assert(sms_data->data !=3D NULL);
+	g_assert(sms_data->length > 0);
+
+	g_ril_unsol_free_sms_data(sms_data);
+}
+
+static void test_unsol_supp_svc_notif_valid(gconstpointer data)
+{
+	struct unsol_supp_svc_notif *unsol;
+
+	unsol =3D g_ril_unsol_parse_supp_svc_notif(NULL,
+						(struct ril_msg *) data);
+	g_assert(unsol !=3D NULL);
+	g_ril_unsol_free_supp_svc_notif(unsol);
+}
+
+static void test_unsol_on_ussd_valid(gconstpointer data)
+{
+	struct unsol_ussd *unsol;
+
+	unsol =3D g_ril_unsol_parse_ussd(NULL, (struct ril_msg *) data);
+
+	g_assert(unsol !=3D NULL);
+	g_ril_unsol_free_ussd(unsol);
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid DATA_CALL_LIST_CHANGED Test 1",
+				&unsol_data_call_list_changed_invalid_1,
+				test_unsol_data_call_list_changed_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"valid DATA_CALL_LIST_CHANGED Test 1",
+				&unsol_data_call_list_changed_valid_1,
+				test_unsol_data_call_list_changed_valid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 1",
+				&reply_data_call_invalid_1,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 2",
+				&reply_data_call_invalid_2,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 3",
+				&reply_data_call_invalid_3,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 4",
+				&reply_data_call_invalid_4,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 5",
+				&reply_data_call_invalid_5,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"invalid SETUP_DATA_CALL Test 6",
+				&reply_data_call_invalid_6,
+				test_reply_data_call_invalid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"valid SETUP_DATA_CALL Test 1",
+				&reply_data_call_valid_1,
+				test_reply_data_call_valid);
+
+	g_test_add_data_func("/testgrilunsol/gprs-context: "
+				"valid SETUP_DATA_CALL Test 2",
+				&reply_data_call_valid_2,
+				test_reply_data_call_valid);
+
+	g_test_add_data_func("/testgrilunsol/sms: "
+				"valid RESPONSE_NEW_SMS Test 1",
+				&unsol_response_new_sms_valid_1,
+				test_unsol_response_new_sms_valid);
+
+	g_test_add_data_func("/testgrilunsol/sms: "
+				"valid RESPONSE_NEW_SMS Test 2",
+				&unsol_response_new_sms_valid_2,
+				test_unsol_response_new_sms_valid);
+
+	g_test_add_data_func("/testgrilunsol/voicecall: "
+				"valid SUPP_SVC_NOTIF Test 1",
+				&unsol_supp_svc_notif_valid_1,
+				test_unsol_supp_svc_notif_valid);
+
+	g_test_add_data_func("/testgrilunsol/voicecall: "
+				"valid SIGNAL_STRENGTH Test 1",
+				&unsol_signal_strength_valid_1,
+				test_signal_strength_valid);
+
+	g_test_add_data_func("/testgrilunsol/voicecall: "
+				"valid SIGNAL_STRENGTH Test 2",
+				&unsol_signal_strength_valid_2,
+				test_signal_strength_valid);
+
+	g_test_add_data_func("/testgrilunsol/ussd: "
+				"valid ON_USSD Test 1",
+				&unsol_on_ussd_valid_1,
+				test_unsol_on_ussd_valid);
+
+#endif
+	return g_test_run();
+}
-- =

2.1.4


--===============5132809099231868437==--

