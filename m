Content-Type: multipart/mixed; boundary="===============1286223087271880386=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 1/2] rilmodem: Add address to protocol type util func
Date: Fri, 22 Apr 2016 08:55:06 +0530
Message-ID: <1461295506-21381-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1286223087271880386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/rilutil.c | 27 +++++++++++++++++++++++++++
 drivers/rilmodem/rilutil.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/rilmodem/rilutil.c b/drivers/rilmodem/rilutil.c
index 44e5a9c..6cdce9a 100644
--- a/drivers/rilmodem/rilutil.c
+++ b/drivers/rilmodem/rilutil.c
@@ -28,6 +28,7 @@
 #include <gril.h>
 #include <string.h>
 #include <stdlib.h>
+#include <arpa/inet.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/log.h>
@@ -132,3 +133,29 @@ int ril_util_registration_state_to_status(int reg_stat=
e)
 =

 	return reg_state;
 }
+
+int ril_util_address_to_gprs_proto(const char *addr)
+{
+	int ret =3D -1;
+	struct in_addr ipv4;
+	struct in6_addr ipv6;
+	char **addr_split =3D g_strsplit(addr, "/", 2);
+
+	if (addr_split =3D=3D NULL || g_strv_length(addr_split) =3D=3D 0)
+		goto done;
+
+	if (inet_pton(AF_INET, addr_split[0], &ipv4) > 0) {
+		ret =3D OFONO_GPRS_PROTO_IP;
+		goto done;
+	}
+
+	if (inet_pton(AF_INET6, addr_split[0], &ipv6) > 0) {
+		ret =3D OFONO_GPRS_PROTO_IPV6;
+		goto done;
+	}
+
+done:
+	g_strfreev(addr_split);
+
+	return ret;
+}
diff --git a/drivers/rilmodem/rilutil.h b/drivers/rilmodem/rilutil.h
index 0361801..1791cda 100644
--- a/drivers/rilmodem/rilutil.h
+++ b/drivers/rilmodem/rilutil.h
@@ -109,6 +109,8 @@ const char *ril_util_gprs_proto_to_ril_string(enum ofon=
o_gprs_proto);
 =

 int ril_util_registration_state_to_status(int reg_state);
 =

+int ril_util_address_to_gprs_proto(const char *addr);
+
 #define DECLARE_FAILURE(e)			\
 	struct ofono_error e;			\
 	e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
-- =

1.9.1


--===============1286223087271880386==--

