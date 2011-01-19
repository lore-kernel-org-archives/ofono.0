Content-Type: multipart/mixed; boundary="===============6314576602344050251=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 1/2] atutil: add pin retry count parser function
Date: Wed, 19 Jan 2011 16:03:01 +0200
Message-ID: <1295445782-31136-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1295445782-31136-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6314576602344050251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c |   66 ++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/atmodem/atutil.h |    3 ++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index da17253..8edcd02 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -31,6 +31,8 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/log.h>
 #include <ofono/types.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
 =

 #include "atutil.h"
 #include "vendor.h"
@@ -480,3 +482,67 @@ gboolean at_util_parse_attr(GAtResult *result, const c=
har *prefix,
 =

 	return TRUE;
 }
+
+gboolean at_util_parse_pin_retries(GAtResult *result, int *retries,
+					int retries_cnt, unsigned int vendor)
+{
+	GAtResultIter iter;
+	enum ofono_sim_password_type passwd_types[OFONO_SIM_PASSWORD_INVALID];
+	int i;
+	int passwd_types_cnt;
+
+	g_at_result_iter_init(&iter, result);
+
+	switch (vendor) {
+	case OFONO_VENDOR_HUAWEI:
+		if (!g_at_result_iter_next(&iter, "^CPIN:"))
+			return FALSE;
+
+		/* Skip status since we are not interested in this */
+		if (!g_at_result_iter_skip_next(&iter))
+			return FALSE;
+
+		/*
+		 * Skip "overall counter" since we'll grab each one
+		 * individually.
+		 */
+		if (!g_at_result_iter_skip_next(&iter))
+			return FALSE;
+
+		passwd_types[0] =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		passwd_types[1] =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		passwd_types[2] =3D OFONO_SIM_PASSWORD_SIM_PUK2;
+		passwd_types[3] =3D OFONO_SIM_PASSWORD_SIM_PIN2;
+		passwd_types_cnt =3D 4;
+		break;
+	case OFONO_VENDOR_IFX:
+		if (!g_at_result_iter_next(&iter, "+XPINCNT:"))
+			return FALSE;
+
+		passwd_types[0] =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		passwd_types[1] =3D OFONO_SIM_PASSWORD_SIM_PIN2;
+		passwd_types[2] =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		passwd_types[3] =3D OFONO_SIM_PASSWORD_SIM_PUK2;
+		passwd_types_cnt =3D 4;
+		break;
+	default:
+		return FALSE;
+	}
+
+	for (i =3D 0; i < retries_cnt; i++)
+		retries[i] =3D -1;
+
+	for (i =3D 0; i < passwd_types_cnt; i++) {
+		int val;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			return FALSE;
+
+		retries[passwd_types[i]] =3D val;
+
+		DBG("retry counter id=3D%d, val=3D%d", passwd_types[i],
+						retries[passwd_types[i]]);
+	}
+
+	return TRUE;
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 3d13b84..a22f4a4 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -74,6 +74,9 @@ gboolean at_util_parse_cscs_query(GAtResult *result,
 gboolean at_util_parse_attr(GAtResult *result, const char *prefix,
 				const char **out_attr);
 =

+gboolean at_util_parse_pin_retries(GAtResult *result, int *retries,
+					int retries_cnt, unsigned int vendor);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

1.7.0.4


--===============6314576602344050251==--

