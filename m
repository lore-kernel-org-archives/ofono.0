Content-Type: multipart/mixed; boundary="===============4215365509990910895=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RFC 2/5] gprs: driver interface changes for IPv6
Date: Wed, 26 Jan 2011 18:22:47 +0200
Message-ID: <1296058970-11815-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4215365509990910895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |   41 +++++++++++++++++++++++++++++++++++++++++
 src/gprs.c             |    2 ++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..eee8e18 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -37,6 +37,7 @@ struct ofono_gprs_context;
 enum ofono_gprs_proto {
 	OFONO_GPRS_PROTO_IP =3D 0,
 	OFONO_GPRS_PROTO_IPV6,
+	OFONO_GPRS_PROTO_IPV4V6,
 };
 =

 enum ofono_gprs_context_type {
@@ -47,6 +48,14 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

+enum ofono_gprs_addrconf_method {
+	OFONO_GPRS_ADDRCONF_NONE,
+	OFONO_GPRS_ADDRCONF_STATIC,
+	OFONO_GPRS_ADDRCONF_DHCP,
+	OFONO_GPRS_ADDRCONF_STATELESS,
+	OFONO_GPRS_ADDRCONF_DHCPV6,
+};
+
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
@@ -56,6 +65,26 @@ struct ofono_gprs_primary_context {
 	enum ofono_gprs_proto proto;
 };
 =

+void ofono_gprs_context_set_ip_interface(struct ofono_gprs_context *gc,
+					const char *interface);
+void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
+					enum ofono_gprs_addrconf_method method);
+void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
+					const char *address);
+void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
+					const char *netmask);
+void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
+					const char *netmask);
+void ofono_gprs_context_set_ip_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns);
+
+void ofono_gprs_context_set_ipv6_interface(struct ofono_gprs_context *gc,
+					const char *interface);
+void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+						const char *address);
+void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns);
+
 typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
 					void *data);
 typedef void (*ofono_gprs_context_up_cb_t)(const struct ofono_error *error,
@@ -63,6 +92,10 @@ typedef void (*ofono_gprs_context_up_cb_t)(const struct =
ofono_error *error,
 				const char *address, const char *netmask,
 				const char *gw, const char **dns, void *data);
 =

+typedef void (*ofono_gprs_context_activate_cb_t)(const struct ofono_error =
*error,
+					ofono_bool_t single_bearers,
+					void *data);
+
 struct ofono_gprs_context_driver {
 	const char *name;
 	int (*probe)(struct ofono_gprs_context *gc, unsigned int vendor,
@@ -71,6 +104,14 @@ struct ofono_gprs_context_driver {
 	void (*activate_primary)(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_up_cb_t cb, void *data);
+	void (*activate_primary_new)(struct ofono_gprs_context *gc,
+					unsigned int id,
+					const char *apn,
+					enum ofono_gprs_proto proto,
+					const char *username,
+					const char *password,
+					ofono_gprs_context_activate_cb_t cb,
+					void *data);
 	void (*deactivate_primary)(struct ofono_gprs_context *gc,
 					unsigned int id,
 					ofono_gprs_context_cb_t cb, void *data);
diff --git a/src/gprs.c b/src/gprs.c
index 92d0b1a..37e7aee 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -224,6 +224,8 @@ static const char *gprs_proto_to_string(enum ofono_gprs=
_proto proto)
 		return "ip";
 	case OFONO_GPRS_PROTO_IPV6:
 		return "ipv6";
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return "ipv4v6";
 	};
 =

 	return NULL;
-- =

1.7.1


--===============4215365509990910895==--

