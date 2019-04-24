Content-Type: multipart/mixed; boundary="===============3129758677884437768=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: handling of IPv6 address for activated context
Date: Wed, 24 Apr 2019 11:24:50 +0530
Message-ID: <1556085290-14876-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3129758677884437768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled IPv6 address after activating PDP context.
Received IPv6 address is of format addr + netmask in the same string
in the form of "a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.
m1.m2.m3.m4.m5.m6.m7.m8.m9.m10.m11.m12.m13.m14.m15.m16"
---
 drivers/atmodem/atutil.c        | 39 +++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h        |  3 +++
 drivers/ifxmodem/gprs-context.c | 48 +++++++++++++++++++++++++++++--------=
----
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 98e3a2f..adcca85 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -656,6 +656,45 @@ int at_util_get_ipv4_address_and_netmask(const char *a=
ddrnetmask,
 	return ret;
 }
 =

+/*
+ * CGCONTRDP returns addr + netmask in the same string in the form
+ * of "a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.m1.m2.
+ * m3.m4.m5.m6.m7.m8.m9.m10.m11.m12.m13.m14.m15.m16" for IPv6.
+ * address/netmask must be able to hold 64 characters.
+ */
+int at_util_get_ipv6_address_and_netmask(const char *addrnetmask,
+						char *address, char *netmask)
+{
+	const char *s =3D addrnetmask;
+	const char *net =3D NULL;
+
+	int ret =3D -EINVAL;
+	int i;
+
+	/* Count 31 dots for ipv6, less or more means error. */
+	for (i =3D 0; i < 33; i++, s++) {
+		s =3D strchr(s, '.');
+
+		if (!s)
+			break;
+
+		if (i =3D=3D 15) {
+			/* set netmask ptr and break the string */
+			net =3D s + 1;
+		}
+	}
+
+	if (i =3D=3D 31) {
+		memcpy(address, addrnetmask, net - addrnetmask);
+		address[net - addrnetmask - 1] =3D '\0';
+		strcpy(netmask, net);
+
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
 int at_util_gprs_auth_method_to_auth_prot(
 					enum ofono_gprs_auth_method auth_method)
 {
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 69e8b49..61800ff 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -86,6 +86,9 @@ void at_util_sim_state_query_free(struct at_util_sim_stat=
e_query *req);
 =

 int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
 						char *address, char *netmask);
+int at_util_get_ipv6_address_and_netmask(const char *addrnetmask,
+						char *address, char *netmask);
+
 =

 int at_util_gprs_auth_method_to_auth_prot(
 				enum ofono_gprs_auth_method auth_method);
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 6042004..5336f71 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -44,6 +44,7 @@
 #define TUN_DEV "/dev/net/tun"
 =

 #define STATIC_IP_NETMASK "255.255.255.255"
+#define IPV6_DEFAULT_PREFIX_LEN 8
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *xdns_prefix[] =3D { "+XDNS:", NULL };
@@ -352,10 +353,39 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	DBG("DNS: %s, %s\n", gcd->dns1, gcd->dns2);
 =

-	if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
-					gcd->address, gcd->netmask) < 0) {
-		failed_setup(gc, NULL, TRUE);
-		return;
+	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {
+		if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
+						gcd->address, gcd->netmask) < 0) {
+			failed_setup(gc, NULL, TRUE);
+			return;
+		}
+
+		ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
+
+		if (gcd->netmask[0])
+			ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
+
+		if (gcd->gateway[0])
+			ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
+
+		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+	}
+
+	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
+		if (!laddrnetmask || at_util_get_ipv6_address_and_netmask(laddrnetmask,
+						gcd->address, gcd->netmask) < 0) {
+			failed_setup(gc, NULL, TRUE);
+			return;
+		}
+
+		ofono_gprs_context_set_ipv6_address(gc, gcd->address);
+
+		if (gcd->gateway[0])
+			ofono_gprs_context_set_ipv6_gateway(gc, gcd->gateway);
+
+		ofono_gprs_context_set_ipv6_dns_servers(gc, dns);
+
+		ofono_gprs_context_set_ipv6_prefix_length(gc, IPV6_DEFAULT_PREFIX_LEN);
 	}
 =

 	if (gw)
@@ -373,16 +403,6 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	interface =3D ofono_gprs_context_get_interface(gc);
 	datapath =3D get_datapath(modem, interface);
 =

-	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
-
-	if (gcd->netmask[0])
-		ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
-
-	if (gcd->gateway[0])
-		ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
-
-	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
-
 	snprintf(buf, sizeof(buf), "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u",
 			ctrlpath, datapath, gcd->active_context);
 	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
-- =

1.9.1


--===============3129758677884437768==--

