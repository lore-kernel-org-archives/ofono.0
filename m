Content-Type: multipart/mixed; boundary="===============6405835513160067191=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 2/2] rilmodem: Add IPv6 support in gprs-context
Date: Fri, 22 Apr 2016 08:55:48 +0530
Message-ID: <1461295548-21423-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6405835513160067191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/gprs-context.c | 251 +++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 225 insertions(+), 26 deletions(-)

diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index 1e5f6ed..558231e 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -142,6 +142,217 @@ static void ril_gprs_context_call_list_changed(struct=
 ril_msg *message,
 	}
 }
 =

+static int gprs_context_set_dns_servers(struct ofono_gprs_context *gc,
+					enum ofono_gprs_proto protocol,
+					char **dns_addrs)
+{
+	char **dns_ipv4_addrs, **dns_ipv6_addrs;
+	int proto;
+	int ipv4_idx, ipv6_idx;
+	int dns_strv_len;
+	int i;
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IP) {
+		ofono_gprs_context_set_ipv4_dns_servers(gc,
+						(const char **) dns_addrs);
+		return 0;
+	}
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IPV6) {
+		ofono_gprs_context_set_ipv6_dns_servers(gc,
+						(const char **) dns_addrs);
+		return 0;
+	}
+
+	dns_strv_len =3D g_strv_length(dns_addrs);
+
+	dns_ipv4_addrs =3D g_new0(char *, dns_strv_len + 1);
+	dns_ipv6_addrs =3D g_new0(char *, dns_strv_len + 1);
+
+	for (i =3D 0, ipv4_idx =3D 0, ipv6_idx =3D 0; dns_addrs[i]; i++) {
+		proto =3D ril_util_address_to_gprs_proto(dns_addrs[i]);
+
+		if (proto =3D=3D OFONO_GPRS_PROTO_IP)
+			dns_ipv4_addrs[ipv4_idx++] =3D dns_addrs[i];
+
+		else if (proto =3D=3D OFONO_GPRS_PROTO_IPV6)
+			dns_ipv6_addrs[ipv6_idx++] =3D dns_addrs[i];
+	}
+
+	if (ipv4_idx)
+		ofono_gprs_context_set_ipv4_dns_servers(gc,
+					(const char **) dns_ipv4_addrs);
+
+	if (ipv6_idx)
+		ofono_gprs_context_set_ipv6_dns_servers(gc,
+					(const char **) dns_ipv6_addrs);
+
+	g_free(dns_ipv4_addrs);
+	g_free(dns_ipv6_addrs);
+
+	return 0;
+}
+
+static int gprs_context_set_gateway(struct ofono_gprs_context *gc,
+				enum ofono_gprs_proto protocol,
+				char **gateways)
+{
+	int proto;
+	gboolean ipv4_flag, ipv6_flag;
+	int i;
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IP) {
+		ofono_gprs_context_set_ipv4_gateway(gc, gateways[0]);
+
+		return 0;
+	}
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IPV6) {
+		ofono_gprs_context_set_ipv6_gateway(gc, gateways[0]);
+
+		return 0;
+	}
+
+	ipv4_flag =3D FALSE;
+	ipv6_flag =3D FALSE;
+
+	for (i =3D 0; gateways[i]; i++) {
+		proto =3D ril_util_address_to_gprs_proto(gateways[i]);
+
+		if (!ipv4_flag && proto =3D=3D OFONO_GPRS_PROTO_IP) {
+			ofono_gprs_context_set_ipv4_gateway(gc, gateways[i]);
+
+			ipv4_flag =3D TRUE;
+
+		} else if (!ipv6_flag && proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
+			ofono_gprs_context_set_ipv6_gateway(gc, gateways[i]);
+
+			ipv6_flag =3D TRUE;
+		}
+
+		/*
+		 * both IPv4 and IPv6 gateways
+		 * have been set, job done
+		 */
+		if (ipv4_flag && ipv6_flag)
+			break;
+	}
+
+	return 0;
+}
+
+static int gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
+				const char *addrs)
+{
+	char **split_addrs =3D g_strsplit(addrs, "/", 2);
+	char *netmask;
+
+	/*
+	 * Note - the address may optionally include a prefix size
+	 * ( Eg. "/30" ).  As this confuses NetworkManager, we
+	 * explicitly strip any prefix after calculating the netmask
+	 */
+	if (split_addrs =3D=3D NULL || g_strv_length(split_addrs) =3D=3D 0) {
+		g_strfreev(split_addrs);
+		return -1;
+	}
+
+	netmask =3D ril_util_get_netmask(addrs);
+
+	if (netmask)
+		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
+
+	ofono_gprs_context_set_ipv4_address(gc, split_addrs[0], TRUE);
+
+	g_strfreev(split_addrs);
+
+	return 0;
+}
+
+static int gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+				const char *addrs)
+{
+	char **split_addrs =3D g_strsplit(addrs, "/", 2);
+	guint64 prefix_ull;
+	char *endptr;
+	unsigned char prefix;
+
+	if (split_addrs =3D=3D NULL || g_strv_length(split_addrs) =3D=3D 0) {
+		g_strfreev(split_addrs);
+		return -1;
+	}
+
+	ofono_gprs_context_set_ipv6_address(gc, split_addrs[0]);
+
+	/*
+	 * We will set ipv6 prefix length if present
+	 * otherwise let connection manager decide
+	 */
+	if (!split_addrs[1]) {
+		g_strfreev(split_addrs);
+		return 0;
+	}
+
+	prefix_ull =3D g_ascii_strtoull(split_addrs[1], &endptr, 10);
+
+	/* Discard in case of conversion failure or invalid prefix length */
+	if (split_addrs[1] =3D=3D endptr || *endptr !=3D '\0' || prefix_ull > 128=
) {
+		g_strfreev(split_addrs);
+		return -1;
+	}
+
+	prefix =3D prefix_ull;
+
+	ofono_gprs_context_set_ipv6_prefix_length(gc, prefix);
+
+	g_strfreev(split_addrs);
+
+	return 0;
+}
+
+static int gprs_context_set_address(struct ofono_gprs_context *gc,
+				enum ofono_gprs_proto protocol,
+				char **ip_addrs)
+{
+	int proto;
+	gboolean ipv4_flag, ipv6_flag;
+	int i;
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IP)
+		return gprs_context_set_ipv4_address(gc, ip_addrs[0]);
+
+	if (protocol =3D=3D OFONO_GPRS_PROTO_IPV6)
+		return gprs_context_set_ipv6_address(gc, ip_addrs[0]);
+
+	ipv4_flag =3D FALSE;
+	ipv6_flag =3D FALSE;
+
+	for (i =3D 0; ip_addrs[i]; i++) {
+		proto =3D ril_util_address_to_gprs_proto(ip_addrs[i]);
+
+		if (!ipv4_flag && proto =3D=3D OFONO_GPRS_PROTO_IP) {
+			if (gprs_context_set_ipv4_address(gc,
+						ip_addrs[i]) !=3D 0)
+				return -1;
+
+			ipv4_flag =3D TRUE;
+
+		} else if (!ipv6_flag &&
+			proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
+			if (gprs_context_set_ipv6_address(gc,
+						ip_addrs[i]) !=3D 0)
+				return -1;
+
+			ipv6_flag =3D TRUE;
+		}
+
+		if (ipv4_flag && ipv6_flag)
+			break;
+	}
+
+	return 0;
+}
+
 static void ril_setup_data_call_cb(struct ril_msg *message, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -238,8 +449,12 @@ static void ril_setup_data_call_cb(struct ril_msg *mes=
sage, gpointer user_data)
 			goto error_free;
 		}
 =

-		ofono_gprs_context_set_ipv4_dns_servers(gc,
-						(const char **) dns_addrs);
+		if (gprs_context_set_dns_servers(gc,
+					protocol, dns_addrs) !=3D 0) {
+			g_strfreev(dns_addrs);
+			goto error_free;
+		}
+
 		g_strfreev(dns_addrs);
 	}
 =

@@ -256,7 +471,11 @@ static void ril_setup_data_call_cb(struct ril_msg *mes=
sage, gpointer user_data)
 			goto error_free;
 		}
 =

-		ofono_gprs_context_set_ipv4_gateway(gc, gateways[0]);
+		if (gprs_context_set_gateway(gc, protocol, gateways) !=3D 0) {
+			g_strfreev(gateways);
+			goto error_free;
+		}
+
 		g_strfreev(gateways);
 	} else
 		goto error_free;
@@ -274,8 +493,6 @@ static void ril_setup_data_call_cb(struct ril_msg *mess=
age, gpointer user_data)
 	 */
 	if (raw_addrs) {
 		char **ip_addrs =3D g_strsplit(raw_addrs, " ", 3);
-		char **split_ip_addr;
-		char *netmask;
 =

 		if (ip_addrs =3D=3D NULL || g_strv_length(ip_addrs) =3D=3D 0) {
 			g_strfreev(ip_addrs);
@@ -284,30 +501,12 @@ static void ril_setup_data_call_cb(struct ril_msg *me=
ssage, gpointer user_data)
 			goto error_free;
 		}
 =

-		if (g_strv_length(ip_addrs) > 1)
-			ofono_warn("%s: more than one IP addr returned: %s",
-					__func__, raw_addrs);
-		/*
-		 * Note - the address may optionally include a prefix size
-		 * ( Eg. "/30" ).  As this confuses NetworkManager, we
-		 * explicitly strip any prefix after calculating the netmask
-		 */
-		split_ip_addr =3D g_strsplit(ip_addrs[0], "/", 2);
-
-		netmask =3D ril_util_get_netmask(ip_addrs[0]);
-
-		g_strfreev(ip_addrs);
-
-		if (split_ip_addr =3D=3D NULL ||
-				g_strv_length(split_ip_addr) =3D=3D 0) {
-			g_strfreev(split_ip_addr);
+		if (gprs_context_set_address(gc, protocol, ip_addrs) !=3D 0) {
+			g_strfreev(ip_addrs);
 			goto error_free;
 		}
 =

-		if (netmask)
-			ofono_gprs_context_set_ipv4_netmask(gc, netmask);
-
-		ofono_gprs_context_set_ipv4_address(gc, split_ip_addr[0], TRUE);
+		g_strfreev(ip_addrs);
 	}
 =

 	g_free(type);
-- =

1.9.1


--===============6405835513160067191==--

