Content-Type: multipart/mixed; boundary="===============5623684900752379606=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/3] Add codepoints and debugging for radio access
Date: Wed, 03 Feb 2010 17:32:20 +0200
Message-ID: <1265211141-21294-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1265211141-21294-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5623684900752379606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    3 +-
 drivers/isimodem/debug.c   |   27 ++++++++++++++++++++
 drivers/isimodem/debug.h   |    5 ++++
 drivers/isimodem/gss.h     |   58 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/network.h |    7 +++++
 5 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 drivers/isimodem/gss.h

diff --git a/Makefile.am b/Makefile.am
index a18e4b9..5f67878 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -102,7 +102,8 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/call-settings.c \
 				drivers/isimodem/call-barring.c \
 				drivers/isimodem/call-meter.c \
-				drivers/isimodem/ss.h
+				drivers/isimodem/ss.h \
+				drivers/isimodem/gss.h
 endif
 =

 if ATMODEM
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 2f8f1f4..a1d8b89 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -717,6 +717,7 @@ const char *net_message_id_name(enum net_message_id val=
ue)
 		_(NET_RAT_IND);
 		_(NET_RAT_REQ);
 		_(NET_RAT_RESP);
+		_(NET_RADIO_INFO_IND);
 		_(NET_REG_STATUS_GET_REQ);
 		_(NET_REG_STATUS_GET_RESP);
 		_(NET_REG_STATUS_IND);
@@ -740,12 +741,32 @@ const char *net_subblock_name(enum net_subblock value)
 		_(NET_GSM_OPERATOR_INFO);
 		_(NET_GSM_BAND_INFO);
 		_(NET_RAT_INFO);
+		_(NET_UTRAN_RADIO_INFO);
 		_(NET_AVAIL_NETWORK_INFO_COMMON);
 		_(NET_OPER_NAME_INFO);
 	}
 	return "NET_<UNKNOWN>";
 }
 =

+const char *gss_message_id_name(enum gss_message_id value)
+{
+	switch (value) {
+		_(GSS_CS_SERVICE_REQ);
+		_(GSS_CS_SERVICE_RESP);
+		_(GSS_CS_SERVICE_FAIL_RESP);
+		_(GSS_SELECTED_RAT_IND);
+	}
+	return "GSS_<UNKNOWN>";
+}
+
+const char *gss_subblock_name(enum gss_subblock value)
+{
+	switch (value) {
+		_(GSS_RAT_INFO);
+	}
+	return "GSS_<UNKNOWN>";
+}
+
 #undef _
 =

 static void hex_dump(const char *name, const uint8_t m[], size_t len)
@@ -816,3 +837,9 @@ void net_debug(const void *restrict buf, size_t len, vo=
id *data)
 	const uint8_t *m =3D buf;
 	hex_dump(net_message_id_name(m[0]), m, len);
 }
+
+void gss_debug(const void *restrict buf, size_t len, void *data)
+{
+	const uint8_t *m =3D buf;
+	hex_dump(gss_message_id_name(m[0]), m, len);
+}
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index b9ee39a..fa316ba 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -29,6 +29,7 @@
 #include "info.h"
 #include "call.h"
 #include "network.h"
+#include "gss.h"
 =

 const char *ss_message_id_name(enum ss_message_id value);
 const char *ss_subblock_name(enum ss_subblock value);
@@ -61,6 +62,9 @@ const char *net_status_name(enum net_reg_status value);
 const char *net_message_id_name(enum net_message_id value);
 const char *net_subblock_name(enum net_subblock value);
 =

+const char *gss_message_id_name(enum gss_message_id value);
+const char *gss_subblock_name(enum gss_subblock value);
+
 void ss_debug(const void *restrict buf, size_t len, void *data);
 void mtc_debug(const void *restrict buf, size_t len, void *data);
 void sms_debug(const void *restrict buf, size_t len, void *data);
@@ -68,6 +72,7 @@ void sim_debug(const void *restrict buf, size_t len, void=
 *data);
 void info_debug(const void *restrict buf, size_t len, void *data);
 void call_debug(const void *restrict buf, size_t len, void *data);
 void net_debug(const void *restrict buf, size_t len, void *data);
+void gss_debug(const void *restrict buf, size_t len, void *data);
 =

 const char *pn_resource_name(int value);
 =

diff --git a/drivers/isimodem/gss.h b/drivers/isimodem/gss.h
new file mode 100644
index 0000000..a61c0b0
--- /dev/null
+++ b/drivers/isimodem/gss.h
@@ -0,0 +1,58 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM_GSS_H
+#define __ISIMODEM_GSS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_GSS			0x32
+#define GSS_TIMEOUT		5
+
+enum gss_message_id {
+	GSS_CS_SERVICE_REQ =3D 0x00,
+	GSS_CS_SERVICE_RESP =3D 0x01,
+	GSS_CS_SERVICE_FAIL_RESP =3D 0x02,
+	GSS_SELECTED_RAT_IND =3D 0x14
+};
+
+enum gss_subblock {
+	GSS_RAT_INFO =3D 0x0B
+};
+
+enum gss_selection_mode {
+	GSS_DUAL_RAT =3D 0x00,
+	GSS_GSM_RAT =3D 0x01,
+	GSS_UMTS_RAT =3D 0x02
+};
+
+enum gss_operation {
+	GSS_SELECTED_RAT_WRITE =3D 0x0E,
+	GSS_SELECTED_RAT_READ =3D 0x9C
+};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM_GSS_H */
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index ec52321..07b88b9 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -40,6 +40,7 @@ enum net_message_id {
 	NET_RAT_IND =3D 0x35,
 	NET_RAT_REQ =3D 0x36,
 	NET_RAT_RESP =3D 0x37,
+	NET_RADIO_INFO_IND =3D 0x3F,
 	NET_REG_STATUS_GET_REQ =3D 0xE0,
 	NET_REG_STATUS_GET_RESP =3D 0xE1,
 	NET_REG_STATUS_IND =3D 0xE2,
@@ -59,6 +60,7 @@ enum net_subblock {
 	NET_GSM_OPERATOR_INFO =3D 0x0C,
 	NET_GSM_BAND_INFO =3D 0x11,
 	NET_RAT_INFO =3D 0x2C,
+	NET_UTRAN_RADIO_INFO =3D 0x3C,
 	NET_AVAIL_NETWORK_INFO_COMMON =3D 0xE1,
 	NET_OPER_NAME_INFO =3D 0xE7
 };
@@ -164,6 +166,11 @@ enum net_search_mode {
 	NET_MANUAL_SEARCH =3D 0x00
 };
 =

+enum net_radio_state {
+	NET_UTRAN_RADIO_IDLE =3D 0x00,
+	NET_UTRAN_RADIO_CELL_DCH =3D 0x01
+};
+
 enum net_oper_name_type {
 	NET_HARDCODED_LATIN_OPER_NAME =3D 0x00
 };
-- =

1.6.3.3


--===============5623684900752379606==--

