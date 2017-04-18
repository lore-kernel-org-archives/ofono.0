Content-Type: multipart/mixed; boundary="===============5722806216137158394=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 3/6] qmi: move rat_to_tech() into own module
Date: Tue, 18 Apr 2017 09:50:49 +0200
Message-ID: <20170418075052.23980-3-jonas@southpole.se>
In-Reply-To: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5722806216137158394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to use this function from multiple atoms so this patch moves
it out to its own module for NAS-related helper functions.
---
 Makefile.am                             |  1 +
 drivers/qmimodem/nas.c                  | 38 +++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/nas.h                  |  2 ++
 drivers/qmimodem/network-registration.c | 18 ++--------------
 4 files changed, 43 insertions(+), 16 deletions(-)
 create mode 100644 drivers/qmimodem/nas.c

diff --git a/Makefile.am b/Makefile.am
index b232f97..c894496 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -210,6 +210,7 @@ qmi_sources =3D drivers/qmimodem/qmi.h drivers/qmimodem=
/qmi.c \
 					drivers/qmimodem/ctl.h \
 					drivers/qmimodem/dms.h \
 					drivers/qmimodem/nas.h \
+					drivers/qmimodem/nas.c \
 					drivers/qmimodem/uim.h \
 					drivers/qmimodem/wms.h \
 					drivers/qmimodem/wds.h \
diff --git a/drivers/qmimodem/nas.c b/drivers/qmimodem/nas.c
new file mode 100644
index 0000000..48d7f11
--- /dev/null
+++ b/drivers/qmimodem/nas.c
@@ -0,0 +1,38 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Jonas Bonn. All rights reserved.
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
+#include "nas.h"
+
+#include "src/common.h"
+
+int qmi_nas_rat_to_tech(uint8_t rat)
+{
+	switch (rat) {
+	case QMI_NAS_NETWORK_RAT_GSM:
+		return ACCESS_TECHNOLOGY_GSM;
+	case QMI_NAS_NETWORK_RAT_UMTS:
+		return ACCESS_TECHNOLOGY_UTRAN;
+	case QMI_NAS_NETWORK_RAT_LTE:
+		return ACCESS_TECHNOLOGY_EUTRAN;
+	}
+
+	return -1;
+}
diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index b4bc012..09807f8 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -162,3 +162,5 @@ struct qmi_nas_home_network {
 	uint8_t desc_len;
 	char desc[0];
 } __attribute__((__packed__));
+
+int qmi_nas_rat_to_tech(uint8_t rat);
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index c29a733..e2a5082 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -43,20 +43,6 @@ struct netreg_data {
 	uint8_t current_rat;
 };
 =

-static int rat_to_tech(uint8_t rat)
-{
-	switch (rat) {
-	case QMI_NAS_NETWORK_RAT_GSM:
-		return ACCESS_TECHNOLOGY_GSM;
-	case QMI_NAS_NETWORK_RAT_UMTS:
-		return ACCESS_TECHNOLOGY_UTRAN;
-	case QMI_NAS_NETWORK_RAT_LTE:
-		return ACCESS_TECHNOLOGY_EUTRAN;
-	}
-
-	return -1;
-}
-
 static bool extract_ss_info(struct qmi_result *result, int *status,
 				int *lac, int *cellid, int *tech,
 				struct ofono_network_operator *operator)
@@ -82,7 +68,7 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status,
 	for (i =3D 0; i < ss->radio_if_count; i++) {
 		DBG("radio in use %d", ss->radio_if[i]);
 =

-		*tech =3D rat_to_tech(ss->radio_if[i]);
+		*tech =3D qmi_nas_rat_to_tech(ss->radio_if[i]);
 	}
 =

 	if (qmi_result_get_uint8(result, QMI_NAS_RESULT_ROAMING_STATUS,
@@ -278,7 +264,7 @@ static void scan_nets_cb(struct qmi_result *result, voi=
d *user_data)
 		DBG("%03d:%02d %d", netrat->info[i].mcc, netrat->info[i].mnc,
 							netrat->info[i].rat);
 =

-		list[i].tech =3D rat_to_tech(netrat->info[i].rat);
+		list[i].tech =3D qmi_nas_rat_to_tech(netrat->info[i].rat);
 	}
 =

 done:
-- =

2.9.3


--===============5722806216137158394==--

