Content-Type: multipart/mixed; boundary="===============6207022544363686910=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND PATCH 06/13] isimodem: IPv6 support
Date: Mon, 14 Feb 2011 13:50:38 +0200
Message-ID: <1297684245-9737-7-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6207022544363686910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/gprs-context.c |  119 ++++++++++++++++++++++++-----------=
----
 1 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 6d579d8..942cb13 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -62,10 +62,7 @@ struct context_data {
 	uint16_t gpds;	/* GPDS object handle */
 	unsigned cid;	/* oFono core context ID */
 	struct ofono_gprs_context *context;
-	union {
-		ofono_gprs_context_up_cb_t up_cb;
-		ofono_gprs_context_cb_t down_cb;
-	};
+	ofono_gprs_context_cb_t cb;
 	void *data;
 =

 	GIsiPEP *pep;
@@ -112,15 +109,14 @@ typedef void (*ContextFailFunc)(struct context_data *=
cd);
 =

 static void gprs_up_fail(struct context_data *cd)
 {
-	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
-				cd->data);
 	reset_context(cd);
+	CALLBACK_WITH_FAILURE(cd->cb, cd->data);
 }
 =

 static void gprs_down_fail(struct context_data *cd)
 {
-	CALLBACK_WITH_FAILURE(cd->down_cb, cd->data);
 	reset_context(cd);
+	CALLBACK_WITH_FAILURE(cd->cb, cd->data);
 }
 =

 static gboolean check_resp(const GIsiMessage *msg, uint8_t id, size_t minl=
en,
@@ -206,12 +202,12 @@ static void activate_ind_cb(const GIsiMessage *msg, v=
oid *opaque)
 {
 	struct context_data *cd =3D opaque;
 	GIsiSubBlockIter iter;
+	const char *dns[5];
+	int dns_count =3D 0;
 =

 	char ifname[IF_NAMESIZE];
-	char *ip =3D NULL;
-	char *pdns =3D NULL;
-	char *sdns =3D NULL;
-	const char *dns[3];
+	char *ip_addr =3D NULL;
+	char *ipv6_addr =3D NULL;
 =

 	if (!check_ind(msg, 2, cd))
 		return;
@@ -225,8 +221,6 @@ static void activate_ind_cb(const GIsiMessage *msg, voi=
d *opaque)
 =

 		switch (g_isi_sb_iter_get_id(&iter)) {
 =

-		/* TODO: IPv6 address support */
-
 		case GPDS_PDP_ADDRESS_INFO:
 =

 			if (!g_isi_sb_iter_get_byte(&iter, &addr_len, 3))
@@ -236,9 +230,15 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 							4))
 				goto error;
 =

-			ip =3D alloca(INET_ADDRSTRLEN);
-			inet_ntop(AF_INET, (const void *)addr_value, ip,
-					INET_ADDRSTRLEN);
+			if (addr_len =3D=3D 4) {
+				ip_addr =3D alloca(INET_ADDRSTRLEN);
+				inet_ntop(AF_INET, (const void *)addr_value,
+						ip_addr, INET_ADDRSTRLEN);
+			} else if (addr_len =3D=3D 16) {
+				ipv6_addr =3D alloca(INET6_ADDRSTRLEN);
+				inet_ntop(AF_INET6, (const void *)addr_value,
+						ipv6_addr, INET6_ADDRSTRLEN);
+			}
 			break;
 =

 		case GPDS_PDNS_ADDRESS_INFO:
@@ -250,9 +250,17 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 							4))
 				break;
 =

-			pdns =3D alloca(INET_ADDRSTRLEN);
-			inet_ntop(AF_INET, (const void *)addr_value, pdns,
-					INET_ADDRSTRLEN);
+			if (addr_len =3D=3D 4) {
+				char *addr =3D alloca(INET_ADDRSTRLEN);
+				inet_ntop(AF_INET, (const void *)addr_value,
+						addr, INET_ADDRSTRLEN);
+				dns[dns_count++] =3D addr;
+			} else if (addr_len =3D=3D 16) {
+				char *addr =3D alloca(INET6_ADDRSTRLEN);
+				inet_ntop(AF_INET6, (const void *)addr_value,
+						addr, INET6_ADDRSTRLEN);
+				dns[dns_count++] =3D addr;
+			}
 			break;
 =

 		case GPDS_SDNS_ADDRESS_INFO:
@@ -264,9 +272,17 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 							4))
 				break;
 =

-			sdns =3D alloca(INET_ADDRSTRLEN);
-			inet_ntop(AF_INET, (const void *)addr_value, sdns,
-					INET_ADDRSTRLEN);
+			if (addr_len =3D=3D 4) {
+				char *addr =3D alloca(INET_ADDRSTRLEN);
+				inet_ntop(AF_INET, (const void *)addr_value,
+						addr, INET_ADDRSTRLEN);
+				dns[dns_count++] =3D addr;
+			} else if (addr_len =3D=3D 16) {
+				char *addr =3D alloca(INET6_ADDRSTRLEN);
+				inet_ntop(AF_INET6, (const void *)addr_value,
+						addr, INET6_ADDRSTRLEN);
+				dns[dns_count++] =3D addr;
+			}
 			break;
 =

 		default:
@@ -279,26 +295,26 @@ static void activate_ind_cb(const GIsiMessage *msg, v=
oid *opaque)
 	if (!g_isi_pep_get_ifname(cd->pep, ifname))
 		goto error;
 =

-	dns[0] =3D pdns;
-	dns[1] =3D sdns;
-	dns[2] =3D 0;
+	ofono_gprs_context_set_interface(cd->context, ifname);
 =

-	CALLBACK_WITH_SUCCESS(cd->up_cb, ifname, TRUE, (const char *)ip,
-					STATIC_IP_NETMASK, NULL,
-					dns, cd->data);
-	return;
+	if (ip_addr !=3D NULL) {
+		ofono_gprs_context_set_ip_addrconf(cd->context,
+						OFONO_GPRS_ADDRCONF_STATIC);
+		ofono_gprs_context_set_ip_address(cd->context, ip_addr);
+		ofono_gprs_context_set_ip_netmask(cd->context,
+							STATIC_IP_NETMASK);
+	}
 =

-error:
-	gprs_up_fail(cd);
-}
+	if (ipv6_addr !=3D NULL)
+		ofono_gprs_context_set_ipv6_address(cd->context, ipv6_addr);
 =

-static void activate_fail_ind_cb(const GIsiMessage *msg, void *opaque)
-{
-	struct context_data *cd =3D opaque;
+	dns[dns_count] =3D 0;
+	ofono_gprs_context_set_dns_servers(cd->context, dns);
 =

-	if (!check_ind(msg, 2, cd))
-		return;
+	CALLBACK_WITH_SUCCESS(cd->cb, cd->data);
+	return;
 =

+error:
 	gprs_up_fail(cd);
 }
 =

@@ -319,8 +335,6 @@ static void send_context_activate(GIsiClient *client, v=
oid *opaque)
 =

 	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_ACTIVATE_IND,
 				activate_ind_cb, cd);
-	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_ACTIVATE_FAIL_IND,
-				activate_fail_ind_cb, cd);
 	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_DEACTIVATE_IND,
 				deactivate_ind_cb, cd);
 =

@@ -460,7 +474,7 @@ static void create_pipe_cb(GIsiPipe *pipe)
 =

 static void isi_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

@@ -468,8 +482,7 @@ static void isi_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 =

 	if (cd =3D=3D NULL || !cd->gpds) {
 		/* GPDS is not reachable */
-		CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL,
-					NULL, data);
+		CALLBACK_WITH_FAILURE(cb, data);
 		return;
 	}
 =

@@ -480,12 +493,26 @@ static void isi_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	}
 =

 	cd->cid =3D ctx->cid;
-	cd->up_cb =3D cb;
+	cd->cb =3D cb;
 	cd->data =3D data;
 	cd->pep =3D NULL;
 	cd->pipe =3D NULL;
 	cd->handle =3D INVALID_ID;
-	cd->type =3D GPDS_PDP_TYPE_IPV4;
+
+	switch (ctx->proto) {
+	case OFONO_GPRS_PROTO_IP:
+		cd->type =3D GPDS_PDP_TYPE_IPV4;
+		break;
+
+	case OFONO_GPRS_PROTO_IPV6:
+		cd->type =3D GPDS_PDP_TYPE_IPV6;
+		break;
+
+	case OFONO_GPRS_PROTO_IPV4V6:
+		/* Not supported by modem */
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
 =

 	if (strlen(ctx->apn) >=3D GPDS_MAX_APN_STRING_LENGTH
 			|| strlen(ctx->username) >=3D GPDS_MAX_USERNAME_LENGTH
@@ -527,7 +554,7 @@ static void context_deactivate_cb(const GIsiMessage *ms=
g, void *opaque)
 			gprs_down_fail))
 		return;
 =

-	CALLBACK_WITH_SUCCESS(cd->down_cb, cd->data);
+	CALLBACK_WITH_SUCCESS(cd->cb, cd->data);
 	reset_context(cd);
 }
 =

@@ -545,7 +572,7 @@ static void isi_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	if (cd =3D=3D NULL)
 		return;
 =

-	cd->down_cb =3D cb;
+	cd->cb =3D cb;
 	cd->data =3D data;
 =

 	msg[1] =3D cd->handle;
-- =

1.7.1


--===============6207022544363686910==--

