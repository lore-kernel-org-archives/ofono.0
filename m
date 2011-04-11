Content-Type: multipart/mixed; boundary="===============6788225610484626361=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 06/20] phonesim: use generalised packet source files
Date: Mon, 11 Apr 2011 13:20:04 +0300
Message-ID: <1302517218-2147-7-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6788225610484626361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |  120 ++++++++++++++++++++++++++----------------------=
----
 1 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 1a6703d..13f942e 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -56,8 +56,8 @@
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
-#include <ofono/gprs.h>
-#include <ofono/gprs-context.h>
+#include <ofono/packet-service.h>
+#include <ofono/packet-context.h>
 #include <ofono/gnss.h>
 =

 #include <drivers/atmodem/vendor.h>
@@ -75,18 +75,18 @@ struct phonesim_data {
 	gboolean use_mux;
 };
 =

-struct gprs_context_data {
+struct packet_context_data {
 	GAtChat *chat;
 	char *interface;
-	enum ofono_gprs_proto proto;
+	enum ofono_packet_proto proto;
 };
 =

 static void at_cgact_up_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_cb_t cb =3D cbd->cb;
-	struct ofono_gprs_context *gc =3D cbd->user;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	ofono_packet_context_cb_t cb =3D cbd->cb;
+	struct ofono_packet_context *pc =3D cbd->user;
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
 	struct ofono_error error;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
@@ -94,16 +94,16 @@ static void at_cgact_up_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	if (ok =3D=3D FALSE)
 		goto done;
 =

-	ofono_gprs_context_set_interface(gc, gcd->interface);
+	ofono_packet_context_set_interface(pc, pcd->interface);
 =

-	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IP ||
-			gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV4V6)
-		ofono_gprs_context_set_ipv4_address(gc, NULL, FALSE);
+	if (pcd->proto =3D=3D OFONO_PACKET_PROTO_IP ||
+			pcd->proto =3D=3D OFONO_PACKET_PROTO_IPV4V6)
+		ofono_packet_context_set_ipv4_address(pc, NULL, FALSE);
 =

-	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV6 ||
-			gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV4V6) {
-		ofono_gprs_context_set_ipv6_address(gc, "fe80::1");
-		ofono_gprs_context_set_ipv6_prefix_length(gc, 10);
+	if (pcd->proto =3D=3D OFONO_PACKET_PROTO_IPV6 ||
+			pcd->proto =3D=3D OFONO_PACKET_PROTO_IPV4V6) {
+		ofono_packet_context_set_ipv6_address(pc, "fe80::1");
+		ofono_packet_context_set_ipv6_prefix_length(pc, 10);
 	}
 =

 done:
@@ -113,37 +113,37 @@ done:
 static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	ofono_packet_context_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
 =

-static void phonesim_activate_primary(struct ofono_gprs_context *gc,
-				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_cb_t cb, void *data)
+static void phonesim_activate_context(struct ofono_packet_context *pc,
+				const struct ofono_packet_context_param *ctx,
+				ofono_packet_context_cb_t cb, void *data)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	char buf[OFONO_PS_MAX_APN_LENGTH + 128];
 	int len =3D 0;
 =

-	cbd->user =3D gc;
-	gcd->proto =3D ctx->proto;
+	cbd->user =3D pc;
+	pcd->proto =3D ctx->proto;
 =

 	switch (ctx->proto) {
-	case OFONO_GPRS_PROTO_IP:
+	case OFONO_PACKET_PROTO_IP:
 		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
 				ctx->cid);
 		break;
 =

-	case OFONO_GPRS_PROTO_IPV6:
+	case OFONO_PACKET_PROTO_IPV6:
 		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
 				ctx->cid);
 		break;
 =

-	case OFONO_GPRS_PROTO_IPV4V6:
+	case OFONO_PACKET_PROTO_IPV4V6:
 		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
 				ctx->cid);
 		break;
@@ -154,11 +154,11 @@ static void phonesim_activate_primary(struct ofono_gp=
rs_context *gc,
 				ctx->apn);
 =

 	/* Assume always succeeds */
-	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=3D =
0)
+	if (g_at_chat_send(pcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=3D =
0)
 		goto error;
 =

 	sprintf(buf, "AT+CGACT=3D1,%u", ctx->cid);
-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send(pcd->chat, buf, none_prefix,
 				at_cgact_up_cb, cbd, g_free) > 0)
 		return;
 =

@@ -168,19 +168,19 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void phonesim_deactivate_primary(struct ofono_gprs_context *gc,
+static void phonesim_deactivate_context(struct ofono_packet_context *pc,
 					unsigned int id,
-					ofono_gprs_context_cb_t cb, void *data)
+					ofono_packet_context_cb_t cb, void *data)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
 =

-	cbd->user =3D gc;
+	cbd->user =3D pc;
 =

 	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+	if (g_at_chat_send(pcd->chat, buf, none_prefix,
 				at_cgact_down_cb, cbd, g_free) > 0)
 		return;
 =

@@ -189,36 +189,36 @@ static void phonesim_deactivate_primary(struct ofono_=
gprs_context *gc,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static int phonesim_context_probe(struct ofono_gprs_context *gc,
+static int phonesim_context_probe(struct ofono_packet_context *pc,
 					unsigned int vendor, void *data)
 {
 	GAtChat *chat =3D data;
-	struct gprs_context_data *gcd;
+	struct packet_context_data *pcd;
 =

-	gcd =3D g_try_new0(struct gprs_context_data, 1);
-	if (gcd =3D=3D NULL)
+	pcd =3D g_try_new0(struct packet_context_data, 1);
+	if (pcd =3D=3D NULL)
 		return -ENOMEM;
 =

-	gcd->chat =3D g_at_chat_clone(chat);
-	gcd->interface =3D g_strdup_printf("dummy%d", next_iface++);
+	pcd->chat =3D g_at_chat_clone(chat);
+	pcd->interface =3D g_strdup_printf("dummy%d", next_iface++);
 =

-	ofono_gprs_context_set_data(gc, gcd);
+	ofono_packet_context_set_data(pc, pcd);
 =

 	return 0;
 }
 =

-static void phonesim_context_remove(struct ofono_gprs_context *gc)
+static void phonesim_context_remove(struct ofono_packet_context *pc)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
 =

 	DBG("");
 =

-	ofono_gprs_context_set_data(gc, NULL);
+	ofono_packet_context_set_data(pc, NULL);
 =

-	g_at_chat_unref(gcd->chat);
-	g_free(gcd->interface);
+	g_at_chat_unref(pcd->chat);
+	g_free(pcd->interface);
 =

-	g_free(gcd);
+	g_free(pcd);
 }
 =

 static void phonesim_ctm_support_cb(gboolean ok, GAtResult *result,
@@ -340,12 +340,12 @@ static void phonesim_ctm_set(struct ofono_ctm *ctm, o=
fono_bool_t enable,
 	g_free(cbd);
 }
 =

-static struct ofono_gprs_context_driver context_driver =3D {
+static struct ofono_packet_context_driver context_driver =3D {
 	.name                   =3D "phonesim",
 	.probe                  =3D phonesim_context_probe,
 	.remove                 =3D phonesim_context_remove,
-	.activate_primary       =3D phonesim_activate_primary,
-	.deactivate_primary     =3D phonesim_deactivate_primary,
+	.activate_context       =3D phonesim_activate_context,
+	.deactivate_context     =3D phonesim_deactivate_context,
 };
 =

 static struct ofono_ctm_driver ctm_driver =3D {
@@ -667,8 +667,8 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc1, *gc2;
+	struct ofono_packet_service *ps;
+	struct ofono_packet_context *pc1, *pc2;
 =

 	DBG("%p", modem);
 =

@@ -689,15 +689,15 @@ static void phonesim_post_online(struct ofono_modem *=
modem)
 	if (!data->calypso)
 		ofono_cbs_create(modem, 0, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	ps =3D ofono_packet_service_create(modem, 0, "atmodem", data->chat);
 =

-	gc1 =3D ofono_gprs_context_create(modem, 0, "phonesim", data->chat);
-	if (gprs && gc1)
-		ofono_gprs_add_context(gprs, gc1);
+	pc1 =3D ofono_packet_context_create(modem, 0, "phonesim", data->chat);
+	if (ps && pc1)
+		ofono_packet_service_add_context(ps, pc1);
 =

-	gc2 =3D ofono_gprs_context_create(modem, 0, "phonesim", data->chat);
-	if (gprs && gc2)
-		ofono_gprs_add_context(gprs, gc2);
+	pc2 =3D ofono_packet_context_create(modem, 0, "phonesim", data->chat);
+	if (ps && pc2)
+		ofono_packet_service_add_context(ps, pc2);
 =

 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
@@ -816,7 +816,7 @@ static int phonesim_init(void)
 	if (err < 0)
 		return err;
 =

-	ofono_gprs_context_driver_register(&context_driver);
+	ofono_packet_context_driver_register(&context_driver);
 =

 	ofono_ctm_driver_register(&ctm_driver);
 =

@@ -840,7 +840,7 @@ static void phonesim_exit(void)
 =

 	ofono_ctm_driver_unregister(&ctm_driver);
 =

-	ofono_gprs_context_driver_unregister(&context_driver);
+	ofono_packet_context_driver_unregister(&context_driver);
 =

 	ofono_modem_driver_unregister(&phonesim_driver);
 }
-- =

1.7.0.4


--===============6788225610484626361==--

