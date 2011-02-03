Content-Type: multipart/mixed; boundary="===============6793732725242905324=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Thu, 03 Feb 2011 11:03:19 +0200
Message-ID: <1296723809-32676-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296723809-32676-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6793732725242905324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..88530f6 100644
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
@@ -94,6 +101,20 @@ struct ofono_modem *ofono_gprs_context_get_modem(struct=
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


--===============6793732725242905324==--

