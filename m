Content-Type: multipart/mixed; boundary="===============6108661585782664724=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] atmodem/atutil: at_util_gprs_proto_to_pdp_type
Date: Mon, 22 Oct 2018 20:56:07 +0200
Message-ID: <20181022185608.27760-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6108661585782664724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function converts the ofono enum ofono_gprs_auth_method
into the value of the 3GPP 27.007 to pass to the AT command
---
 drivers/atmodem/atutil.c | 16 ++++++++++++++++
 drivers/atmodem/atutil.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 6f4e8a20..ed57b55a 100644
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
@@ -654,3 +656,17 @@ int at_util_get_ipv4_address_and_netmask(const char *a=
ddrnetmask,
 =

 	return ret;
 }
+
+int at_util_auth_type_from_method(enum ofono_gprs_auth_method auth_method)
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
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 7113a4cd..006ad65a 100644
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
@@ -86,6 +87,8 @@ void at_util_sim_state_query_free(struct at_util_sim_stat=
e_query *req);
 int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
 						char *address, char *netmask);
 =

+int at_util_auth_type_from_method(enum ofono_gprs_auth_method auth_method);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

2.17.1


--===============6108661585782664724==--

