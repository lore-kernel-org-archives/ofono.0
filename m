Content-Type: multipart/mixed; boundary="===============7176294659562339549=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] atmodem/atutil: at_util_get_cgdcont_command
Date: Mon, 22 Oct 2018 20:56:08 +0200
Message-ID: <20181022185608.27760-2-gciofono@gmail.com>
In-Reply-To: <20181022185608.27760-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7176294659562339549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function at_util_get_cgdcont_command computes the AT+CGDCONT
string, as per 3GPP 27.007.
It uses a second function, at_util_gprs_proto_to_pdp_type,
that returns the pdp_type string for the command
---
 drivers/atmodem/atutil.c | 27 +++++++++++++++++++++++++++
 drivers/atmodem/atutil.h | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index ed57b55a..7725513a 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -670,3 +670,30 @@ int at_util_auth_type_from_method(enum ofono_gprs_auth=
_method auth_method)
 =

 	return 0;
 }
+
+const char *at_util_gprs_proto_to_pdp_type(enum ofono_gprs_proto proto)
+{
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		return "IPV6";
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return "IPV4V6";
+		break;
+	case OFONO_GPRS_PROTO_IP:
+		return "IP";
+	}
+
+	return NULL;
+}
+
+char *at_util_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
+								const char *apn)
+{
+	const char *pdp_type =3D at_util_gprs_proto_to_pdp_type(proto);
+
+	if (!apn)
+		return g_strdup_printf("AT+CGDCONT=3D%u", cid);
+
+	return g_strdup_printf("AT+CGDCONT=3D%u,\"%s\",\"%s\"", cid, pdp_type,
+									apn);
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 006ad65a..a924b6f0 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -89,6 +89,19 @@ int at_util_get_ipv4_address_and_netmask(const char *add=
rnetmask,
 =

 int at_util_auth_type_from_method(enum ofono_gprs_auth_method auth_method);
 =

+const char *at_util_gprs_proto_to_pdp_type(enum ofono_gprs_proto proto);
+
+/*
+ * at_util_get_cgdcont_command
+ * if the apn pointer is NULL, the context will be removed: the resulting
+ * string will be like: AT+CGDCONT=3D7
+ * but if apn pointer is not NULL and the string is empty, then
+ * this function will create a normal context with empty apn, like:
+ * AT+CGDCONT=3D4,"IPV6",""
+ */
+char *at_util_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
+							const char *apn);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

2.17.1


--===============7176294659562339549==--

