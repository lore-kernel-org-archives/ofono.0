Content-Type: multipart/mixed; boundary="===============2395286570155119365=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v7 4/7] atmodem/atutil: shared functions for cgdcont
Date: Thu, 18 Oct 2018 20:49:49 +0200
Message-ID: <20181018184952.10797-5-gciofono@gmail.com>
In-Reply-To: <20181018184952.10797-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2395286570155119365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

included two new functions:

at_get_auth_type: converts the ofono internal ofono_gprs_auth_method
	into the value of the 3GPP 27.007 to pass to the AT command

at_get_cgdcont_command: computes the AT+CGDCONT string, standard version
---
 drivers/atmodem/atutil.c | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h |  6 +++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 6f4e8a20..dc1ef3d3 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -27,6 +28,7 @@
 #include <gatchat.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
@@ -654,3 +656,50 @@ int at_util_get_ipv4_address_and_netmask(const char *a=
ddrnetmask,
 =

 	return ret;
 }
+
+int at_get_auth_type(enum ofono_gprs_auth_method auth_method)
+{
+	switch (auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return 1;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return 2;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return 0;
+	}
+
+	return 0;
+}
+
+char *at_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
+							const char *apn)
+{
+	size_t buflen =3D 32 + OFONO_GPRS_MAX_APN_LENGTH + 1;
+	char *buf =3D g_new(char, buflen);
+	int len;
+
+	len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
+	buflen -=3D len;
+
+	/*
+	 * if apn is null, it will remove the context.
+	 * but if apn is empty, it will create a context with empty apn
+	 */
+	if (!apn)
+		goto finished;
+
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IP:
+		snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
+		break;
+	}
+
+finished:
+	return buf;
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 7113a4cd..6a40d045 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -86,6 +87,11 @@ void at_util_sim_state_query_free(struct at_util_sim_sta=
te_query *req);
 int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
 						char *address, char *netmask);
 =

+int at_get_auth_type(enum ofono_gprs_auth_method auth_method);
+
+char *at_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
+							const char *apn);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

2.17.1


--===============2395286570155119365==--

