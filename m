Content-Type: multipart/mixed; boundary="===============5789345141705015335=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/4] isimodem: revector GPRS context driver
Date: Wed, 10 Nov 2010 14:22:30 +0200
Message-ID: <1289391751-2844-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1289391751-2844-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5789345141705015335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/gprs-context.c |  280 +++++++++++++++++------------------=
----
 1 files changed, 121 insertions(+), 159 deletions(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 47e858a..62f7ac2 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -50,22 +50,20 @@
 #include "debug.h"
 =

 #define STATIC_IP_NETMASK "255.255.255.255"
+#define ACTIVATE_TIMEOUT	(6 * 30)	/* 6 * T3380 */
+#define DEACTIVATE_TIMEOUT	(6 * 8)		/* 6 * T3390 */
 =

 #define INVALID_ID (0xff)
 # if (INVALID_ID < GPDS_MAX_CONTEXT_COUNT)
 #   error Uho! This should not happen!
 #endif
 =

-struct gprs_context_data {
+struct context_data {
 	GIsiClient *client;
 	GIsiModem *idx;
 	uint16_t gpds;	/* GPDS object handle */
-	GSList *contexts;
-};
-
-struct context_data {
 	unsigned cid;	/* oFono core context ID */
-	struct ofono_gprs_context *driver;
+	struct ofono_gprs_context *context;
 	union {
 		ofono_gprs_context_up_cb_t up_cb;
 		ofono_gprs_context_cb_t down_cb;
@@ -74,6 +72,8 @@ struct context_data {
 =

 	GIsiPEP *pep;
 	GIsiPipe *pipe;
+	guint activate_timeout;
+	guint deactivate_timeout;
 =

 	char apn[GPDS_MAX_APN_STRING_LENGTH + 1];
 	char username[GPDS_MAX_USERNAME_LENGTH + 1];
@@ -83,40 +83,24 @@ struct context_data {
 	uint8_t type;
 };
 =

-static struct context_data *find_context_by_cid(GSList *contexts,
-						unsigned int cid)
-{
-	GSList *m =3D NULL;
-
-	for (m =3D contexts; m; m =3D m->next) {
-		struct context_data *cd =3D m->data;
-
-		if (cd->cid =3D=3D cid)
-			return cd;
-	}
-	return NULL;
-}
-
-static struct context_data *find_context_by_handle(GSList *contexts,
-							uint8_t handle)
-{
-	GSList *m =3D NULL;
-
-	for (m =3D contexts; m; m =3D m->next) {
-		struct context_data *cd =3D m->data;
-
-		if (cd->handle =3D=3D handle)
-			return cd;
-	}
-	return NULL;
-}
-
-static void destroy_context(struct context_data *cd)
+static void reset_context(struct context_data *cd)
 {
 	if (!cd)
 		return;
 =

-	DBG("destroying %p (cid=3D%u)", cd, cd->cid);
+	g_isi_remove_subscription(cd->client, PN_GPDS,
+				GPDS_CONTEXT_ACTIVATE_IND);
+	g_isi_remove_subscription(cd->client,
+				PN_GPDS, GPDS_CONTEXT_ACTIVATE_FAIL_IND);
+	g_isi_remove_subscription(cd->client,
+				PN_GPDS, GPDS_CONTEXT_DEACTIVATE_IND);
+	g_isi_commit_subscriptions(cd->client);
+
+	if (cd->activate_timeout)
+		g_source_remove(cd->activate_timeout);
+
+	if (cd->deactivate_timeout)
+		g_source_remove(cd->deactivate_timeout);
 =

 	if (cd->pipe)
 		g_isi_pipe_destroy(cd->pipe);
@@ -124,34 +108,48 @@ static void destroy_context(struct context_data *cd)
 	if (cd->pep)
 		g_isi_pep_destroy(cd->pep);
 =

-	g_free(cd);
+	cd->activate_timeout =3D 0;
+	cd->deactivate_timeout =3D 0;
+	cd->pep =3D NULL;
+	cd->pipe =3D NULL;
+	cd->handle =3D INVALID_ID;
 }
 =

 static gboolean gprs_up_fail(struct context_data *cd)
 {
-	struct ofono_gprs_context *gc =3D cd->driver;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-
 	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
 				cd->data);
 =

-	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
-	destroy_context(cd);
+	reset_context(cd);
 	return TRUE;
 }
 =

 static gboolean gprs_down_fail(struct context_data *cd)
 {
-	struct ofono_gprs_context *gc =3D cd->driver;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-
 	CALLBACK_WITH_FAILURE(cd->down_cb, cd->data);
 =

-	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
-	destroy_context(cd);
+	reset_context(cd);
 	return TRUE;
 }
 =

+static gboolean gprs_up_timeout(gpointer data)
+{
+	struct context_data *cd =3D data;
+
+	cd->activate_timeout =3D 0;
+	gprs_up_fail(cd);
+	return FALSE;
+}
+
+static gboolean gprs_down_timeout(gpointer data)
+{
+	struct context_data *cd =3D data;
+
+	cd->deactivate_timeout =3D 0;
+	gprs_down_fail(cd);
+	return FALSE;
+}
+
 static gboolean check_resp(GIsiClient *client,
 				const uint8_t *restrict msg, size_t len,
 				uint_fast8_t cmd, struct context_data *cd)
@@ -191,12 +189,29 @@ static gboolean check_resp(GIsiClient *client,
 	return TRUE;
 }
 =

+static void deactivate_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	const unsigned char *msg =3D data;
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_DEACTIVATE_IND ||
+		msg[1] !=3D cd->handle)
+		return;
+
+	DBG("context deactivated: %s (0x%02"PRIx8")",
+		gpds_isi_cause_name(msg[3]), msg[3]);
+
+	ofono_gprs_context_deactivated(cd->context, cd->cid);
+	reset_context(cd);
+}
+
 static void activate_ind_cb(GIsiClient *client,
 				const void *restrict data, size_t len,
 				uint16_t object, void *opaque)
 {
-	struct gprs_context_data *gcd =3D opaque;
-	struct context_data *cd;
+	struct context_data *cd =3D opaque;
 =

 	const unsigned char *msg =3D data;
 	GIsiSubBlockIter iter;
@@ -207,15 +222,10 @@ static void activate_ind_cb(GIsiClient *client,
 	char *sdns =3D NULL;
 	const char *dns[3];
 =

-	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_ACTIVATE_IND)
+	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_ACTIVATE_IND ||
+		msg[1] !=3D cd->handle)
 		return;
 =

-	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
-	if (!cd) {
-		DBG("unknown context: 0x%02"PRIx8, msg[1]);
-		return;
-	}
-
 	for (g_isi_sb_iter_init(&iter, msg, len, 3);
 		g_isi_sb_iter_is_valid(&iter);
 		g_isi_sb_iter_next(&iter)) {
@@ -277,6 +287,9 @@ static void activate_ind_cb(GIsiClient *client,
 	CALLBACK_WITH_SUCCESS(cd->up_cb, ifname, TRUE, (const char *)ip,
 					STATIC_IP_NETMASK, NULL,
 					dns, cd->data);
+
+	g_source_remove(cd->activate_timeout);
+	cd->activate_timeout =3D 0;
 	return;
 =

 error:
@@ -288,18 +301,11 @@ static void activate_fail_ind_cb(GIsiClient *client,
 					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
-	struct gprs_context_data *gcd =3D opaque;
-	struct context_data *cd;
+	struct context_data *cd =3D opaque;
 =

 	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_ACTIVATE_FAIL_IND)
 		return;
 =

-	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
-	if (cd =3D=3D NULL) {
-		DBG("unknown context: 0x%02"PRIx8, msg[1]);
-		return;
-	}
-
 	gprs_up_fail(cd);
 }
 =

@@ -312,8 +318,6 @@ static gboolean context_activate_cb(GIsiClient *client,
 	if (!check_resp(client, data, len, GPDS_CONTEXT_ACTIVATE_RESP, cd))
 		return gprs_up_fail(cd);
 =

-	/* TODO: Add timeout here in case indications never come */
-
 	return TRUE;
 }
 =

@@ -327,6 +331,15 @@ static void send_context_activate(GIsiClient *client, =
void *opaque)
 		0,		/* sub blocks */
 	};
 =

+
+	g_isi_add_subscription(client, PN_GPDS, GPDS_CONTEXT_ACTIVATE_IND,
+			activate_ind_cb, cd);
+	g_isi_add_subscription(client, PN_GPDS, GPDS_CONTEXT_ACTIVATE_FAIL_IND,
+			activate_fail_ind_cb, cd);
+	g_isi_add_subscription(client, PN_GPDS, GPDS_CONTEXT_DEACTIVATE_IND,
+			deactivate_ind_cb, cd);
+	g_isi_commit_subscriptions(client);
+
 	if (g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
 				context_activate_cb, cd))
 		g_isi_pipe_start(cd->pipe);
@@ -468,58 +481,30 @@ static gboolean create_context_cb(GIsiClient *client,
 static void create_pipe_cb(GIsiPipe *pipe)
 {
 	struct context_data *cd =3D g_isi_pipe_get_userdata(pipe);
-	struct ofono_gprs_context *gc =3D cd->driver;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

 	const unsigned char msg[] =3D {
 		GPDS_CONTEXT_ID_CREATE_REQ,
 	};
 =

-	if (!g_isi_request_make(gcd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+	if (!g_isi_request_make(cd->client, msg, sizeof(msg), GPDS_TIMEOUT,
 				create_context_cb, cd))
 		gprs_up_fail(cd);
 }
 =

-static void deactivate_ind_cb(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
-{
-	struct gprs_context_data *gcd =3D opaque;
-	struct context_data *cd;
-
-	const unsigned char *msg =3D data;
-
-	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_DEACTIVATE_IND)
-		return;
-
-	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
-	if (cd =3D=3D NULL) {
-		DBG("unknown context: 0x%02"PRIx8, msg[1]);
-		return;
-	}
-
-	DBG("context deactivated: %s (0x%02"PRIx8")",
-		gpds_isi_cause_name(msg[3]), msg[3]);
-
-	ofono_gprs_context_deactivated(cd->driver, cd->cid);
-
-	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
-	destroy_context(cd);
-}
-
 static void isi_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_up_cb_t cb, void *data)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct context_data *cd =3D g_try_new0(struct context_data, 1);
-	struct context_data *old =3D NULL;
+	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

-	if (!gcd || !cd)
+	if (!cd->gpds) {
+		/* GPDS is not reachable */
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL,
+					NULL, data);
 		return;
+	}
 =

 	cd->cid =3D ctx->cid;
-	cd->driver =3D gc;
 	cd->up_cb =3D cb;
 	cd->data =3D data;
 	cd->pep =3D NULL;
@@ -527,14 +512,6 @@ static void isi_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 	cd->handle =3D INVALID_ID;
 	cd->type =3D GPDS_PDP_TYPE_IPV4;
 =

-	old =3D find_context_by_cid(gcd->contexts, ctx->cid);
-	if (old) {
-		DBG("duplicate context: %u", ctx->cid);
-		goto error;
-	}
-
-	gcd->contexts =3D g_slist_append(gcd->contexts, cd);
-
 	if (strlen(ctx->apn) >=3D GPDS_MAX_APN_STRING_LENGTH
 		|| strlen(ctx->username) >=3D GPDS_MAX_USERNAME_LENGTH
 		|| strlen(ctx->password) >=3D GPDS_MAX_PASSWORD_LENGTH)
@@ -549,18 +526,20 @@ static void isi_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_LENGTH);
 	cd->username[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
 =

-	cd->pep =3D g_isi_pep_create(gcd->idx, NULL, NULL);
+	cd->pep =3D g_isi_pep_create(cd->idx, NULL, NULL);
 	if (cd->pep =3D=3D NULL)
 		goto error;
 =

-	cd->pipe =3D g_isi_pipe_create(gcd->idx, create_pipe_cb,
+	cd->pipe =3D g_isi_pipe_create(cd->idx, create_pipe_cb,
 					g_isi_pep_get_object(cd->pep),
-					gcd->gpds, PN_PEP_TYPE_GPRS,
+					cd->gpds, PN_PEP_TYPE_GPRS,
 					PN_PEP_TYPE_GPRS);
 	if (cd->pipe =3D=3D NULL)
 		goto error;
 =

 	g_isi_pipe_set_userdata(cd->pipe, cd);
+	cd->activate_timeout =3D g_timeout_add_seconds(ACTIVATE_TIMEOUT,
+							gprs_up_timeout, cd);
 	return;
 =

 error:
@@ -573,16 +552,12 @@ static gboolean context_deactivate_cb(GIsiClient *cli=
ent,
 					void *opaque)
 {
 	struct context_data *cd =3D opaque;
-	struct ofono_gprs_context *gc =3D cd->driver;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

 	if (!check_resp(client, data, len, GPDS_CONTEXT_DEACTIVATE_RESP, cd))
 		return gprs_down_fail(cd);
 =

-	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
-
 	CALLBACK_WITH_SUCCESS(cd->down_cb, cd->data);
-	destroy_context(cd);
+	reset_context(cd);
 =

 	return TRUE;
 }
@@ -591,39 +566,36 @@ static void isi_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 					unsigned int cid,
 					ofono_gprs_context_cb_t cb, void *data)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct context_data *cd;
+	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

 	unsigned char msg[] =3D {
 		GPDS_CONTEXT_DEACTIVATE_REQ,
 		0x00,	/* GPDS context ID, added later */
 	};
 =

-	if (!gcd)
-		return;
-
-	cd =3D find_context_by_cid(gcd->contexts, cid);
-	if (!cd) {
-		DBG("unknown context: %u", cid);
+	if (!cd)
 		return;
-	}
 =

 	cd->down_cb =3D cb;
 	cd->data =3D data;
 =

 	msg[1] =3D cd->handle;
 =

-	if (!g_isi_request_make(gcd->client, msg, sizeof(msg), GPDS_TIMEOUT,
-				context_deactivate_cb, cd))
+	if (!g_isi_request_make(cd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+					context_deactivate_cb, cd)) {
 		gprs_down_fail(cd);
+		return;
+	}
+
+	cd->deactivate_timeout =3D g_timeout_add_seconds(DEACTIVATE_TIMEOUT,
+							gprs_down_timeout, cd);
 }
 =

 static void gpds_ctx_reachable_cb(GIsiClient *client, gboolean alive,
 					uint16_t object,
 					void *opaque)
 {
-	struct ofono_gprs_context *gc =3D opaque;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct context_data *cd =3D opaque;
 	const char *debug;
 =

 	if (!alive) {
@@ -636,61 +608,51 @@ static void gpds_ctx_reachable_cb(GIsiClient *client,=
 gboolean alive,
 		g_isi_version_major(client),
 		g_isi_version_minor(client));
 =

-	gcd->gpds =3D object;
+	cd->gpds =3D object;
 =

 	debug =3D getenv("OFONO_ISI_DEBUG");
 	if (debug && (strcmp(debug, "all") =3D=3D 0 || strcmp(debug, "gpds") =3D=
=3D 0))
-		g_isi_client_set_debug(gcd->client, gpds_debug, NULL);
-
-	g_isi_subscribe(client, GPDS_CONTEXT_ACTIVATE_IND,
-			activate_ind_cb, gcd);
-	g_isi_subscribe(client, GPDS_CONTEXT_ACTIVATE_FAIL_IND,
-			activate_fail_ind_cb, gcd);
-	g_isi_subscribe(client, GPDS_CONTEXT_DEACTIVATE_IND,
-			deactivate_ind_cb, gcd);
+		g_isi_client_set_debug(cd->client, gpds_debug, NULL);
 }
 =

 static int isi_gprs_context_probe(struct ofono_gprs_context *gc,
 					unsigned int vendor, void *user)
 {
 	GIsiModem *idx =3D user;
-	struct gprs_context_data *gcd =3D g_try_new0(struct gprs_context_data, 1);
+	struct context_data *cd =3D g_try_new0(struct context_data, 1);
 =

-	if (!gcd)
+	if (!cd)
 		return -ENOMEM;
 =

-	gcd->client =3D g_isi_client_create(idx, PN_GPDS);
-	if (!gcd->client) {
-		g_free(gcd);
+	cd->client =3D g_isi_client_create(idx, PN_GPDS);
+	if (!cd->client) {
+		g_free(cd);
 		return -ENOMEM;
 	}
 =

-	ofono_gprs_context_set_data(gc, gcd);
-
-	gcd->idx =3D idx;
-	gcd->contexts =3D NULL;
+	cd->idx =3D idx;
+	cd->context =3D gc;
+	ofono_gprs_context_set_data(gc, cd);
 =

-	g_isi_verify(gcd->client, gpds_ctx_reachable_cb, gc);
+	g_isi_verify(cd->client, gpds_ctx_reachable_cb, cd);
 =

 	return 0;
 }
 =

 static void isi_gprs_context_remove(struct ofono_gprs_context *gc)
 {
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	GSList *m;
+	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

-	ofono_gprs_context_set_data(gc, NULL);
-
-	for (m =3D gcd->contexts; m; m =3D m->next)
-		destroy_context(m->data);
+	if (!cd)
+		return;
 =

-	g_slist_free(gcd->contexts);
+	ofono_gprs_context_set_data(gc, NULL);
+	reset_context(cd);
 =

-	if (gcd->client)
-		g_isi_client_destroy(gcd->client);
+	if (cd->client)
+		g_isi_client_destroy(cd->client);
 =

-	g_free(gcd);
+	g_free(cd);
 }
 =

 static struct ofono_gprs_context_driver driver =3D {
-- =

1.7.0.4


--===============5789345141705015335==--

