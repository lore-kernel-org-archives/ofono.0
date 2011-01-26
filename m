Content-Type: multipart/mixed; boundary="===============3384116818679237465=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RFC 5/5] isimodem: IPv6 support
Date: Wed, 26 Jan 2011 18:22:50 +0200
Message-ID: <1296058970-11815-6-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3384116818679237465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/gprs-context.c |  137 ++++++++++++++++++++++++-----------=
---
 1 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 6d579d8..4665198 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -63,7 +63,7 @@ struct context_data {
 	unsigned cid;	/* oFono core context ID */
 	struct ofono_gprs_context *context;
 	union {
-		ofono_gprs_context_up_cb_t up_cb;
+		ofono_gprs_context_activate_cb_t up_cb;
 		ofono_gprs_context_cb_t down_cb;
 	};
 	void *data;
@@ -112,15 +112,14 @@ typedef void (*ContextFailFunc)(struct context_data *=
cd);
 =

 static void gprs_up_fail(struct context_data *cd)
 {
-	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
-				cd->data);
 	reset_context(cd);
+	CALLBACK_WITH_FAILURE(cd->up_cb, FALSE, cd->data);
 }
 =

 static void gprs_down_fail(struct context_data *cd)
 {
-	CALLBACK_WITH_FAILURE(cd->down_cb, cd->data);
 	reset_context(cd);
+	CALLBACK_WITH_FAILURE(cd->down_cb, cd->data);
 }
 =

 static gboolean check_resp(const GIsiMessage *msg, uint8_t id, size_t minl=
en,
@@ -208,9 +207,12 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 	GIsiSubBlockIter iter;
 =

 	char ifname[IF_NAMESIZE];
-	char *ip =3D NULL;
-	char *pdns =3D NULL;
-	char *sdns =3D NULL;
+	char *ip_addr =3D NULL;
+	char *ip_pdns =3D NULL;
+	char *ip_sdns =3D NULL;
+	char *ipv6_addr =3D NULL;
+	char *ipv6_pdns =3D NULL;
+	char *ipv6_sdns =3D NULL;
 	const char *dns[3];
 =

 	if (!check_ind(msg, 2, cd))
@@ -225,8 +227,6 @@ static void activate_ind_cb(const GIsiMessage *msg, voi=
d *opaque)
 =

 		switch (g_isi_sb_iter_get_id(&iter)) {
 =

-		/* TODO: IPv6 address support */
-
 		case GPDS_PDP_ADDRESS_INFO:
 =

 			if (!g_isi_sb_iter_get_byte(&iter, &addr_len, 3))
@@ -236,9 +236,16 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
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
+				DBG("IPv6 addr =3D <%s>", ipv6_addr);
+			}
 			break;
 =

 		case GPDS_PDNS_ADDRESS_INFO:
@@ -250,9 +257,15 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 							4))
 				break;
 =

-			pdns =3D alloca(INET_ADDRSTRLEN);
-			inet_ntop(AF_INET, (const void *)addr_value, pdns,
-					INET_ADDRSTRLEN);
+			if (addr_len =3D=3D 4) {
+				ip_pdns =3D alloca(INET_ADDRSTRLEN);
+				inet_ntop(AF_INET, (const void *)addr_value,
+						ip_pdns, INET_ADDRSTRLEN);
+			} else if (addr_len =3D=3D 16) {
+				ipv6_pdns =3D alloca(INET6_ADDRSTRLEN);
+				inet_ntop(AF_INET6, (const void *)addr_value,
+						ipv6_pdns, INET6_ADDRSTRLEN);
+			}
 			break;
 =

 		case GPDS_SDNS_ADDRESS_INFO:
@@ -264,9 +277,15 @@ static void activate_ind_cb(const GIsiMessage *msg, vo=
id *opaque)
 							4))
 				break;
 =

-			sdns =3D alloca(INET_ADDRSTRLEN);
-			inet_ntop(AF_INET, (const void *)addr_value, sdns,
-					INET_ADDRSTRLEN);
+			if (addr_len =3D=3D 4) {
+				ip_sdns =3D alloca(INET_ADDRSTRLEN);
+				inet_ntop(AF_INET, (const void *)addr_value,
+						ip_sdns, INET_ADDRSTRLEN);
+			} else if (addr_len =3D=3D 16) {
+				ipv6_sdns =3D alloca(INET6_ADDRSTRLEN);
+				inet_ntop(AF_INET6, (const void *)addr_value,
+						ipv6_sdns, INET6_ADDRSTRLEN);
+			}
 			break;
 =

 		default:
@@ -279,29 +298,29 @@ static void activate_ind_cb(const GIsiMessage *msg, v=
oid *opaque)
 	if (!g_isi_pep_get_ifname(cd->pep, ifname))
 		goto error;
 =

-	dns[0] =3D pdns;
-	dns[1] =3D sdns;
-	dns[2] =3D 0;
+	if (ip_addr !=3D NULL) {
+		const char *dns[3] =3D { ip_pdns, ip_sdns, 0 };
+		ofono_gprs_context_set_ip_interface(cd->context, ifname);
+		ofono_gprs_context_set_ip_address(cd->context, ip_addr);
+		ofono_gprs_context_set_ip_addrconf(cd->context,
+						OFONO_GPRS_ADDRCONF_STATIC);
+		ofono_gprs_context_set_ip_dns_servers(cd->context, dns);
+	}
+
+	if (ipv6_addr !=3D NULL) {
+		const char *dns[3] =3D { ipv6_pdns, ipv6_sdns, 0 };
+		ofono_gprs_context_set_ipv6_interface(cd->context, ifname);
+		ofono_gprs_context_set_ipv6_address(cd->context, ipv6_addr);
+		ofono_gprs_context_set_ipv6_dns_servers(cd->context, dns);
+	}
 =

-	CALLBACK_WITH_SUCCESS(cd->up_cb, ifname, TRUE, (const char *)ip,
-					STATIC_IP_NETMASK, NULL,
-					dns, cd->data);
+	CALLBACK_WITH_SUCCESS(cd->up_cb, TRUE, cd->data);
 	return;
 =

 error:
 	gprs_up_fail(cd);
 }
 =

-static void activate_fail_ind_cb(const GIsiMessage *msg, void *opaque)
-{
-	struct context_data *cd =3D opaque;
-
-	if (!check_ind(msg, 2, cd))
-		return;
-
-	gprs_up_fail(cd);
-}
-
 static void context_activate_cb(const GIsiMessage *msg, void *cd)
 {
 	check_resp(msg, GPDS_CONTEXT_ACTIVATE_RESP, 6, cd, gprs_up_fail);
@@ -319,8 +338,6 @@ static void send_context_activate(GIsiClient *client, v=
oid *opaque)
 =

 	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_ACTIVATE_IND,
 				activate_ind_cb, cd);
-	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_ACTIVATE_FAIL_IND,
-				activate_fail_ind_cb, cd);
 	g_isi_client_ind_subscribe(client, GPDS_CONTEXT_DEACTIVATE_IND,
 				deactivate_ind_cb, cd);
 =

@@ -458,18 +475,22 @@ static void create_pipe_cb(GIsiPipe *pipe)
 		gprs_up_fail(cd);
 }
 =

-static void isi_gprs_activate_primary(struct ofono_gprs_context *gc,
-				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+static void isi_gprs_activate_primary_new(struct ofono_gprs_context *gc,
+					unsigned int id,
+					const char *apn,
+					enum ofono_gprs_proto proto,
+					const char *username,
+					const char *password,
+					ofono_gprs_context_activate_cb_t cb,
+					void *data)
 {
 	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

-	DBG("activate: gpds =3D 0x%04x", cd->gpds);
+	DBG("activate: gpds =3D 0x%04x apn=3D%s proto=3D%d", cd->gpds, apn, proto=
);
 =

 	if (cd =3D=3D NULL || !cd->gpds) {
 		/* GPDS is not reachable */
-		CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL,
-					NULL, data);
+		CALLBACK_WITH_FAILURE(cb, FALSE, data);
 		return;
 	}
 =

@@ -479,26 +500,40 @@ static void isi_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 		cd->reset =3D 0;
 	}
 =

-	cd->cid =3D ctx->cid;
+	cd->cid =3D id;
 	cd->up_cb =3D cb;
 	cd->data =3D data;
 	cd->pep =3D NULL;
 	cd->pipe =3D NULL;
 	cd->handle =3D INVALID_ID;
-	cd->type =3D GPDS_PDP_TYPE_IPV4;
 =

-	if (strlen(ctx->apn) >=3D GPDS_MAX_APN_STRING_LENGTH
-			|| strlen(ctx->username) >=3D GPDS_MAX_USERNAME_LENGTH
-			|| strlen(ctx->password) >=3D GPDS_MAX_PASSWORD_LENGTH)
+	switch (proto) {
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
+		CALLBACK_WITH_FAILURE(cb, TRUE, data);
+		return;
+	}
+
+	if (strlen(apn) >=3D GPDS_MAX_APN_STRING_LENGTH
+			|| strlen(username) >=3D GPDS_MAX_USERNAME_LENGTH
+			|| strlen(password) >=3D GPDS_MAX_PASSWORD_LENGTH)
 		goto error;
 =

-	strncpy(cd->apn, ctx->apn, GPDS_MAX_APN_STRING_LENGTH);
+	strncpy(cd->apn, apn, GPDS_MAX_APN_STRING_LENGTH);
 	cd->apn[GPDS_MAX_APN_STRING_LENGTH] =3D '\0';
 =

-	strncpy(cd->username, ctx->username, GPDS_MAX_USERNAME_LENGTH);
+	strncpy(cd->username, username, GPDS_MAX_USERNAME_LENGTH);
 	cd->username[GPDS_MAX_USERNAME_LENGTH] =3D '\0';
 =

-	strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_LENGTH);
+	strncpy(cd->password, password, GPDS_MAX_PASSWORD_LENGTH);
 	cd->username[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
 =

 	cd->pep =3D g_isi_pep_create(cd->idx, NULL, NULL);
@@ -618,7 +653,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_gprs_context_probe,
 	.remove			=3D isi_gprs_context_remove,
-	.activate_primary	=3D isi_gprs_activate_primary,
+	.activate_primary_new	=3D isi_gprs_activate_primary_new,
 	.deactivate_primary	=3D isi_gprs_deactivate_primary,
 };
 =

-- =

1.7.1


--===============3384116818679237465==--

