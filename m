Content-Type: multipart/mixed; boundary="===============8414808383939501543=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 03/13] gprs: driver interface changes for IPv6
Date: Tue, 08 Feb 2011 17:22:16 +0200
Message-ID: <1297178546-9371-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297178546-9371-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8414808383939501543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..f2d6df4 100644
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
@@ -47,6 +48,12 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

+enum ofono_gprs_addrconf {
+	OFONO_GPRS_ADDRCONF_NONE,
+	OFONO_GPRS_ADDRCONF_STATIC,
+	OFONO_GPRS_ADDRCONF_DHCP,
+};
+
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
@@ -58,10 +65,6 @@ struct ofono_gprs_primary_context {
 =

 typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
 					void *data);
-typedef void (*ofono_gprs_context_up_cb_t)(const struct ofono_error *error,
-				const char *interface, ofono_bool_t static_ip,
-				const char *address, const char *netmask,
-				const char *gw, const char **dns, void *data);
 =

 struct ofono_gprs_context_driver {
 	const char *name;
@@ -70,7 +73,7 @@ struct ofono_gprs_context_driver {
 	void (*remove)(struct ofono_gprs_context *gc);
 	void (*activate_primary)(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data);
+				ofono_gprs_context_cb_t cb, void *data);
 	void (*deactivate_primary)(struct ofono_gprs_context *gc,
 					unsigned int id,
 					ofono_gprs_context_cb_t cb, void *data);
@@ -94,6 +97,20 @@ struct ofono_modem *ofono_gprs_context_get_modem(struct =
ofono_gprs_context *gc);
 =

 void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
 					enum ofono_gprs_context_type type);
+void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
+					const char *interface);
+void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
+					enum ofono_gprs_addrconf method);
+void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
+					const char *address);
+void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
+					const char *netmask);
+void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
+					const char *netmask);
+void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+					const char *address);
+void ofono_gprs_context_set_dns_servers(struct ofono_gprs_context *gc,
+					const char **dns);
 =

 #ifdef __cplusplus
 }
-- =

1.7.1


--===============8414808383939501543==--

