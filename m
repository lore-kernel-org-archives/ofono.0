Content-Type: multipart/mixed; boundary="===============2644232686860623321=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v5b 1/3] stemodem: Fix for error handling,
 memleak and changed some defines
Date: Fri, 12 Nov 2010 16:02:38 +0100
Message-ID: <1289574160-22899-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289574160-22899-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2644232686860623321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

* renamed MAX_LEN to IP_ADDR_LEN
* removed memory leak from unneeded strdup when parsing xml response.
* better handling of AT error responses
* reduced number of caif interfaces to 4
---
 drivers/stemodem/gprs-context.c |   54 ++++++++++++++++++++++-------------=
---
 1 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 9f59579..05fec3f 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -47,9 +47,9 @@
 #include "caif_socket.h"
 #include "if_caif.h"
 =

-#define MAX_CAIF_DEVICES 7
+#define MAX_CAIF_DEVICES 4
 #define MAX_DNS 2
-#define MAX_ELEM 20
+#define IP_ADDR_LEN 20
 =

 #define AUTH_BUF_LENGTH (OFONO_GPRS_MAX_USERNAME_LENGTH + \
 			OFONO_GPRS_MAX_PASSWORD_LENGTH + 128)
@@ -73,13 +73,13 @@ struct conn_info {
 =

 struct eppsd_response {
 	char *current;
-	char ip_address[MAX_ELEM];
-	char subnet_mask[MAX_ELEM];
-	char mtu[MAX_ELEM];
-	char default_gateway[MAX_ELEM];
-	char dns_server1[MAX_ELEM];
-	char dns_server2[MAX_ELEM];
-	char p_cscf_server[MAX_ELEM];
+	char ip_address[IP_ADDR_LEN];
+	char subnet_mask[IP_ADDR_LEN];
+	char mtu[IP_ADDR_LEN];
+	char default_gateway[IP_ADDR_LEN];
+	char dns_server1[IP_ADDR_LEN];
+	char dns_server2[IP_ADDR_LEN];
+	char p_cscf_server[IP_ADDR_LEN];
 };
 =

 static void start_element_handler(GMarkupParseContext *context,
@@ -122,8 +122,8 @@ static void text_handler(GMarkupParseContext *context,
 	struct eppsd_response *rsp =3D user_data;
 =

 	if (rsp->current) {
-		strncpy(rsp->current, text, MAX_ELEM);
-		rsp->current[MAX_ELEM] =3D 0;
+		strncpy(rsp->current, text, IP_ADDR_LEN);
+		rsp->current[IP_ADDR_LEN] =3D 0;
 	}
 }
 =

@@ -191,12 +191,16 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult =
*result,
 	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct ofono_error error;
 	struct conn_info *conn;
 	GSList *l;
 =

-	if (!ok)
-		goto error;
+	if (!ok) {
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, cbd->data);
+		return;
+	}
 =

 	l =3D g_slist_find_custom(g_caif_devices,
 				GUINT_TO_POINTER(gcd->active_context),
@@ -217,9 +221,6 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 	}
 =

 	conn->cid =3D 0;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
 	return;
 =

 error:
@@ -237,7 +238,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	GSList *l;
 	int i;
 	gsize length;
-	char *res_string;
+	const char *res_string;
 	const char *dns[MAX_DNS + 1];
 	struct eppsd_response rsp;
 	GMarkupParseContext *context =3D NULL;
@@ -255,8 +256,15 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	conn =3D l->data;
 =

-	if (!ok)
-		goto error;
+	if (!ok) {
+		struct ofono_error error;
+
+		conn->cid =3D 0;
+		gcd->active_context =3D 0;
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		return;
+	}
 =

 	rsp.current =3D NULL;
 	context =3D g_markup_parse_context_new(&parser, 0, &rsp, NULL);
@@ -266,7 +274,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
 		g_at_result_iter_next(&iter, NULL);
-		res_string =3D strdup(g_at_result_iter_raw_line(&iter));
+		res_string =3D g_at_result_iter_raw_line(&iter);
 		length =3D strlen(res_string);
 =

 		if (!g_markup_parse_context_parse(context, res_string,
@@ -326,7 +334,6 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		struct ofono_error error;
 =

 		gcd->active_context =3D 0;
-
 		decode_at_error(&error, g_at_result_final_response(result));
 		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 		return;
@@ -389,7 +396,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	 * Set username and password, this should be done after CGDCONT
 	 * or an error can occur.  We don't bother with error checking
 	 * here
-	 * */
+	 */
 	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
 			ctx->cid, ctx->username, ctx->password);
 =

@@ -398,6 +405,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	return;
 =

 error:
+	gcd->active_context =3D 0;
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
-- =

1.6.3.3


--===============2644232686860623321==--

