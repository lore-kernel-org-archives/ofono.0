Content-Type: multipart/mixed; boundary="===============2994876900807190513=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/2] unit: re-factor test-rilmodem-cs server logic
Date: Wed, 18 Nov 2015 19:17:42 -0500
Message-ID: <1447892263-18947-2-git-send-email-espy@canonical.com>
In-Reply-To: <1447892263-18947-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2994876900807190513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new rilmodem-test-server functions.
---
 unit/test-rilmodem-cs.c | 377 ++++++++++++++++----------------------------=
----
 1 file changed, 123 insertions(+), 254 deletions(-)

diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index 6d16286..3614c88 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -40,31 +40,19 @@
 =

 #include "common.h"
 #include "ril_constants.h"
-
-#define MAX_REQUEST_SIZE 4096
+#include "rilmodem-test-server.h"
 =

 static GMainLoop *mainloop;
 =

 static const struct ofono_call_settings_driver *csdriver;
 =

-struct rilmodemcs_data {
+struct rilmodem_cs_data {
 	GRil *ril;
-	int sk;
-	gint server_watch;
-	GIOChannel *server_io;
 	struct ofono_modem *modem;
 	gconstpointer test_data;
 	struct ofono_call_settings *cs;
 };
 =

-/* Warning: length is stored in network order */
-struct rsp_hdr {
-	uint32_t length;
-	uint32_t unsolicited;
-	uint32_t serial;
-	uint32_t error;
-};
-
 typedef gboolean (*StartFunc)(gpointer data);
 =

 struct cs_data {
@@ -72,13 +60,7 @@ struct cs_data {
 	gint param_int1;
 	gint param_int2;
 =

-	const guchar *parcel_data;
-
-	const gsize parcel_size;
-
-	uint32_t rsp_error;
-	const guchar *rsp_data;
-	const gsize rsp_size;
+	struct rilmodem_test_data rtd;
 	enum ofono_error_type error_type;
 	gint cb_int1;
 	gint cb_int2;
@@ -87,8 +69,8 @@ struct cs_data {
 static void status_query_callback(const struct ofono_error *error, int sta=
tus,
 								 gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	g_assert(error->type =3D=3D csd->error_type);
 =

@@ -101,8 +83,8 @@ static void status_query_callback(const struct ofono_err=
or *error, int status,
 static void clir_query_callback(const struct ofono_error *error, int overr=
ide,
 						int network, gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	g_assert(error->type =3D=3D csd->error_type);
 =

@@ -116,8 +98,8 @@ static void clir_query_callback(const struct ofono_error=
 *error, int override,
 =

 static void set_callback(const struct ofono_error *error, gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	g_assert(error->type =3D=3D csd->error_type);
 =

@@ -126,56 +108,56 @@ static void set_callback(const struct ofono_error *er=
ror, gpointer data)
 =

 static gboolean trigger_clip_query(gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
+	struct rilmodem_cs_data *rcd =3D data;
 =

 	g_assert(csdriver->clip_query !=3D NULL);
-	csdriver->clip_query(rcsd->cs, status_query_callback, rcsd);
+	csdriver->clip_query(rcd->cs, status_query_callback, rcd);
 =

 	return FALSE;
 }
 =

 static gboolean trigger_cw_query(gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
+	struct rilmodem_cs_data *rcd =3D data;
 =

 	g_assert(csdriver->cw_query !=3D NULL);
 =

 	/* cls is explicitly ignored by rilmodem; just use 0 */
-	csdriver->cw_query(rcsd->cs, 0, status_query_callback, rcsd);
+	csdriver->cw_query(rcd->cs, 0, status_query_callback, rcd);
 =

 	return FALSE;
 }
 =

 static gboolean trigger_cw_set(gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	g_assert(csdriver->cw_set !=3D NULL);
 =

-	csdriver->cw_set(rcsd->cs, csd->param_int1, csd->param_int2,
-						set_callback, rcsd);
+	csdriver->cw_set(rcd->cs, csd->param_int1, csd->param_int2,
+						set_callback, rcd);
 =

 	return FALSE;
 }
 =

 static gboolean trigger_clir_query(gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
+	struct rilmodem_cs_data *rcd =3D data;
 =

 	g_assert(csdriver->clir_query !=3D NULL);
-	csdriver->clir_query(rcsd->cs, clir_query_callback, rcsd);
+	csdriver->clir_query(rcd->cs, clir_query_callback, rcd);
 =

 	return FALSE;
 }
 =

 static gboolean trigger_clir_set(gpointer data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	g_assert(csdriver->clir_set !=3D NULL);
-	csdriver->clir_set(rcsd->cs, csd->param_int1, set_callback, rcsd);
+	csdriver->clir_set(rcd->cs, csd->param_int1, set_callback, rcd);
 =

 	return FALSE;
 }
@@ -192,11 +174,13 @@ static const guchar rsp_clip_query_data_1[] =3D {
 =

 static const struct cs_data testdata_clip_query_valid_1 =3D {
 	.start_func =3D trigger_clip_query,
-	.parcel_data =3D req_clip_query_parcel_1,
-	.parcel_size =3D sizeof(req_clip_query_parcel_1),
-	.rsp_data =3D rsp_clip_query_data_1,
-	.rsp_size =3D sizeof(rsp_clip_query_data_1),
-	.rsp_error =3D RIL_E_SUCCESS,
+	.rtd =3D {
+		.req_data =3D req_clip_query_parcel_1,
+		.req_size =3D sizeof(req_clip_query_parcel_1),
+		.rsp_data =3D rsp_clip_query_data_1,
+		.rsp_size =3D sizeof(rsp_clip_query_data_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.cb_int1 =3D 1,
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
@@ -209,21 +193,25 @@ static const guchar rsp_clip_query_data_2[] =3D {
 /* reply parse error causes status to be returned as -1 */
 static const struct cs_data testdata_clip_query_invalid_1 =3D {
 	.start_func =3D trigger_clip_query,
-	.parcel_data =3D req_clip_query_parcel_1,
-	.parcel_size =3D sizeof(req_clip_query_parcel_1),
-	.rsp_data =3D rsp_clip_query_data_2,
-	.rsp_size =3D sizeof(rsp_clip_query_data_2),
+	.rtd =3D {
+		.req_data =3D req_clip_query_parcel_1,
+		.req_size =3D sizeof(req_clip_query_parcel_1),
+		.rsp_data =3D rsp_clip_query_data_2,
+		.rsp_size =3D sizeof(rsp_clip_query_data_2),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.cb_int1 =3D -1,
-	.rsp_error =3D RIL_E_SUCCESS,
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

 /* error triggered by RIL reply error */
 static const struct cs_data testdata_clip_query_invalid_2 =3D {
 	.start_func =3D trigger_clip_query,
-	.parcel_data =3D req_clip_query_parcel_1,
-	.parcel_size =3D sizeof(req_clip_query_parcel_1),
-	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.rtd =3D {
+		.req_data =3D req_clip_query_parcel_1,
+		.req_size =3D sizeof(req_clip_query_parcel_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

@@ -240,11 +228,13 @@ static const guchar rsp_cw_query_data_1[] =3D {
 =

 static const struct cs_data testdata_cw_query_valid_1 =3D {
 	.start_func =3D trigger_cw_query,
-	.parcel_data =3D req_cw_query_parcel_1,
-	.parcel_size =3D sizeof(req_cw_query_parcel_1),
-	.rsp_data =3D rsp_cw_query_data_1,
-	.rsp_size =3D sizeof(rsp_cw_query_data_1),
-	.rsp_error =3D RIL_E_SUCCESS,
+	.rtd =3D {
+		.req_data =3D req_cw_query_parcel_1,
+		.req_size =3D sizeof(req_cw_query_parcel_1),
+		.rsp_data =3D rsp_cw_query_data_1,
+		.rsp_size =3D sizeof(rsp_cw_query_data_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.cb_int1 =3D 3,
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
@@ -257,24 +247,28 @@ static const guchar rsp_cw_query_data_2[] =3D {
 /* reply parse error causes status to be returned as -1 */
 static const struct cs_data testdata_cw_query_invalid_1 =3D {
 	.start_func =3D trigger_cw_query,
-	.parcel_data =3D req_cw_query_parcel_1,
-	.parcel_size =3D sizeof(req_cw_query_parcel_1),
-	.rsp_data =3D rsp_cw_query_data_2,
-	.rsp_size =3D sizeof(rsp_cw_query_data_2),
+	.rtd =3D {
+		.req_data =3D req_cw_query_parcel_1,
+		.req_size =3D sizeof(req_cw_query_parcel_1),
+		.rsp_data =3D rsp_cw_query_data_2,
+		.rsp_size =3D sizeof(rsp_cw_query_data_2),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.cb_int1 =3D -1,
-	.rsp_error =3D RIL_E_SUCCESS,
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

 /* GENERIC_FAILURE returned in RIL reply */
 static const struct cs_data testdata_cw_query_invalid_2 =3D {
 	.start_func =3D trigger_cw_query,
-	.parcel_data =3D req_cw_query_parcel_1,
-	.parcel_size =3D sizeof(req_cw_query_parcel_1),
-	.rsp_data =3D rsp_cw_query_data_2,
-	.rsp_size =3D sizeof(rsp_cw_query_data_2),
+	.rtd =3D {
+		.req_data =3D req_cw_query_parcel_1,
+		.req_size =3D sizeof(req_cw_query_parcel_1),
+		.rsp_data =3D rsp_cw_query_data_2,
+		.rsp_size =3D sizeof(rsp_cw_query_data_2),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
 	.cb_int1 =3D -1,
-	.rsp_error =3D RIL_E_GENERIC_FAILURE,
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

@@ -289,9 +283,11 @@ static const struct cs_data testdata_cw_set_valid_1 =
=3D {
 	.start_func =3D trigger_cw_set,
 	.param_int1 =3D 1,
 	.param_int2 =3D BEARER_CLASS_DEFAULT,
-	.parcel_data =3D req_cw_set_enabled_parcel_1,
-	.parcel_size =3D sizeof(req_cw_set_enabled_parcel_1),
-	.rsp_error =3D RIL_E_SUCCESS,
+	.rtd =3D {
+		.req_data =3D req_cw_set_enabled_parcel_1,
+		.req_size =3D sizeof(req_cw_set_enabled_parcel_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
 =

@@ -306,9 +302,11 @@ static const struct cs_data testdata_cw_set_invalid_1 =
=3D {
 	.start_func =3D trigger_cw_set,
 	.param_int1 =3D 0,
 	.param_int2 =3D 0,
-	.parcel_data =3D req_cw_set_disabled_parcel_2,
-	.parcel_size =3D sizeof(req_cw_set_disabled_parcel_2),
-	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.rtd =3D {
+		.req_data =3D req_cw_set_disabled_parcel_2,
+		.req_size =3D sizeof(req_cw_set_disabled_parcel_2),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

@@ -324,13 +322,15 @@ static const guchar rsp_clir_query_data_1[] =3D {
 =

 static const struct cs_data testdata_clir_query_valid_1 =3D {
 	.start_func =3D trigger_clir_query,
-	.parcel_data =3D req_clir_query_parcel_1,
-	.parcel_size =3D sizeof(req_clir_query_parcel_1),
-	.rsp_data =3D rsp_clir_query_data_1,
-	.rsp_size =3D sizeof(rsp_clir_query_data_1),
+	.rtd =3D {
+		.req_data =3D req_clir_query_parcel_1,
+		.req_size =3D sizeof(req_clir_query_parcel_1),
+		.rsp_data =3D rsp_clir_query_data_1,
+		.rsp_size =3D sizeof(rsp_clir_query_data_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.cb_int1 =3D 2,
 	.cb_int2 =3D 4,
-	.rsp_error =3D RIL_E_SUCCESS,
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
 =

@@ -340,11 +340,13 @@ static const guchar rsp_clir_query_data_2[] =3D {
 };
 static const struct cs_data testdata_clir_query_invalid_1 =3D {
 	.start_func =3D trigger_clir_query,
-	.parcel_data =3D req_clir_query_parcel_1,
-	.parcel_size =3D sizeof(req_clir_query_parcel_1),
-	.rsp_data =3D rsp_clir_query_data_2,
-	.rsp_size =3D sizeof(rsp_clir_query_data_2),
-	.rsp_error =3D RIL_E_SUCCESS,
+	.rtd =3D {
+		.req_data =3D req_clir_query_parcel_1,
+		.req_size =3D sizeof(req_clir_query_parcel_1),
+		.rsp_data =3D rsp_clir_query_data_2,
+		.rsp_size =3D sizeof(rsp_clir_query_data_2),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

@@ -357,9 +359,11 @@ static const guchar req_clir_set_mode0_parcel_1[] =3D {
 static const struct cs_data testdata_clir_set_valid_1 =3D {
 	.start_func =3D trigger_clir_set,
 	.param_int1 =3D OFONO_CLIR_OPTION_DEFAULT,
-	.parcel_data =3D req_clir_set_mode0_parcel_1,
-	.parcel_size =3D sizeof(req_clir_set_mode0_parcel_1),
-	.rsp_error =3D RIL_E_SUCCESS,
+	.rtd =3D {
+		.req_data =3D req_clir_set_mode0_parcel_1,
+		.req_size =3D sizeof(req_clir_set_mode0_parcel_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
 =

@@ -373,9 +377,12 @@ static const guchar req_clir_set_mode0_parcel_2[] =3D {
 static const struct cs_data testdata_clir_set_invalid_1 =3D {
 	.start_func =3D trigger_clir_set,
 	.param_int1 =3D OFONO_CLIR_OPTION_INVOCATION,
-	.parcel_data =3D req_clir_set_mode0_parcel_2,
-	.parcel_size =3D sizeof(req_clir_set_mode0_parcel_2),
-	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+
+	.rtd =3D {
+		.req_data =3D req_clir_set_mode0_parcel_2,
+		.req_size =3D sizeof(req_clir_set_mode0_parcel_2),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

@@ -392,11 +399,11 @@ struct ofono_call_settings *ofono_call_settings_creat=
e(struct ofono_modem *modem
 							const char *driver,
 							void *data)
 {
-	struct rilmodemcs_data *rcsd =3D data;
+	struct rilmodem_cs_data *rcd =3D data;
 	struct ofono_call_settings *cs =3D g_new0(struct ofono_call_settings, 1);
 	int retval;
 =

-	retval =3D csdriver->probe(cs, OFONO_RIL_VENDOR_AOSP, rcsd->ril);
+	retval =3D csdriver->probe(cs, OFONO_RIL_VENDOR_AOSP, rcd->ril);
 	g_assert(retval =3D=3D 0);
 =

 	return cs;
@@ -430,171 +437,31 @@ void ofono_call_settings_driver_unregister(const str=
uct ofono_call_settings_driv
 	;
 }
 =

-/*
- * As all our architectures are little-endian except for
- * PowerPC, and the Binder wire-format differs slightly
- * depending on endian-ness, the following guards against test
- * failures when run on PowerPC.
- */
-#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
-
-static gboolean read_server(gpointer data)
+static void server_connect_cb(gpointer data)
 {
-	GIOStatus status;
-	struct rilmodemcs_data *rcsd =3D data;
-	gsize offset, rbytes, wbytes;
-	gchar *buf, *bufp;
-	uint32_t req_serial;
-	struct rsp_hdr rsp;
-
-	/*
-	 * FIXME: separate out verification from here, so read_server doesn't
-	 * need to know about cs_data.
-	 */
-	const struct cs_data *csd =3D rcsd->test_data;
-
-	buf =3D g_malloc0(MAX_REQUEST_SIZE);
-
-	status =3D g_io_channel_read_chars(rcsd->server_io, buf, MAX_REQUEST_SIZE,
-								&rbytes, NULL);
-	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
-	g_assert(rbytes =3D=3D csd->parcel_size);
-
-	/* validate len, and request_id */
-	g_assert(!memcmp(buf, csd->parcel_data, (sizeof(uint32_t) * 2)));
-
-	/*
-	 * header: size (uint32), reqid (uin32), serial (uint32)
-	 * header size =3D=3D 16 ( excludes sizeof(size) )
-	 */
-
-	/* advance past request_no */
-	bufp =3D buf + (sizeof(uint32_t) * 2);
-
-	req_serial =3D (uint32_t) *bufp;
-
-	/* advance past serial_no */
-	bufp +=3D sizeof(uint32_t);
-
-	/* validate the rest of the parcel... */
-	offset =3D (sizeof(uint32_t) * 3);
-	g_assert(!memcmp(bufp, csd->parcel_data + offset,
-						csd->parcel_size - offset));
-
-	/* Length does not include the length field. Network order. */
-	rsp.length =3D htonl(sizeof(rsp) - sizeof(rsp.length) + csd->rsp_size);
-	rsp.unsolicited =3D 0;
-	rsp.serial =3D req_serial;
-	rsp.error =3D csd->rsp_error;
-
-	/* copy header */
-	memcpy(buf, &rsp, sizeof(rsp));
-
-	if (csd->rsp_size) {
-		bufp =3D buf + sizeof(rsp);
-
-		memcpy(bufp, csd->rsp_data, csd->rsp_size);
-	}
-
-
-	status =3D g_io_channel_write_chars(rcsd->server_io,
-					buf,
-					sizeof(rsp) + csd->rsp_size,
-					&wbytes, NULL);
-
-	/* FIXME: assert wbytes is correct */
-
-	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
-
-	g_free(buf);
-	g_io_channel_unref(rcsd->server_io);
-
-	return FALSE;
-}
-
-static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
-								gpointer data)
-{
-	struct rilmodemcs_data *rcsd =3D data;
-	const struct cs_data *csd =3D rcsd->test_data;
-	struct sockaddr saddr;
-	unsigned int len =3D sizeof(saddr);
-	int fd;
-	GIOChannel *server_io =3D NULL;
-	GIOStatus status;
-
-	g_assert(cond =3D=3D G_IO_IN);
-
-	fd =3D accept(rcsd->sk, &saddr, &len);
-	g_assert(fd !=3D -1);
-
-	server_io =3D g_io_channel_unix_new(fd);
-	g_assert(server_io !=3D NULL);
+	struct rilmodem_cs_data *rcd =3D data;
+	const struct cs_data *csd =3D rcd->test_data;
 =

 	/* This causes local impl of _create() to call driver's probe func. */
-	rcsd->cs =3D ofono_call_settings_create(NULL, OFONO_RIL_VENDOR_AOSP,
-							"rilmodem", rcsd);
+	rcd->cs =3D ofono_call_settings_create(NULL, OFONO_RIL_VENDOR_AOSP,
+							"rilmodem", rcd);
 =

 	/* add_idle doesn't work, read blocks main loop!!! */
-	g_assert(csd->start_func(rcsd) =3D=3D FALSE);
-
-	status =3D g_io_channel_set_encoding(server_io, NULL, NULL);
-	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
-
-	g_io_channel_set_buffered(server_io, FALSE);
-	g_io_channel_set_close_on_unref(server_io, TRUE);
-
-	rcsd->server_io =3D server_io;
-
-	g_idle_add(read_server, rcsd);
-
-	/* single-shot callback */
-	return FALSE;
+	g_assert(csd->start_func(rcd) =3D=3D FALSE);
 }
 =

-static void create_server_socket(const char *sock_path,
-					struct rilmodemcs_data *rcsd)
-{
-	GIOChannel *io;
-	struct sockaddr_un addr;
-	int retval;
-
-	rcsd->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
-	g_assert(rcsd->sk);
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family =3D AF_UNIX;
-	strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);
-
-	/* Unlink any existing socket for this session */
-	unlink(addr.sun_path);
-
-	retval =3D bind(rcsd->sk, (struct sockaddr *) &addr, sizeof(addr));
-	g_assert(retval >=3D 0);
-
-	retval =3D listen(rcsd->sk, 0);
-	g_assert(retval >=3D 0);
-
-	io =3D g_io_channel_unix_new(rcsd->sk);
-	g_assert(io !=3D NULL);
-
-	g_io_channel_set_close_on_unref(io, TRUE);
-	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
-
-	rcsd->server_watch =3D g_io_add_watch_full(io,
-				G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				on_socket_connected, rcsd, NULL);
-
-	g_io_channel_unref(io);
-}
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
 =

 /*
  * This unit test:
  *  - does some test data setup
  *  - configures a dummy server socket
- *    - on_socket_connected: callback for
- *      incoming socket connects
  *  - creates a new gril client instance
  *    - triggers a connect to the dummy
  *      server socket
@@ -603,27 +470,29 @@ static void create_server_socket(const char *sock_pat=
h,
 static void test_cs_func(gconstpointer data)
 {
 	const struct cs_data *csd =3D data;
-	struct rilmodemcs_data *rcsd;
+	struct rilmodem_cs_data *rcd;
 =

 	ril_call_settings_init();
 =

-	rcsd =3D g_new0(struct rilmodemcs_data, 1);
+	rcd =3D g_new0(struct rilmodem_cs_data, 1);
 =

-	rcsd->test_data =3D csd;
+	rcd->test_data =3D csd;
 =

-	create_server_socket("/tmp/unittestril", rcsd);
+	rilmodem_test_server_create(&server_connect_cb, &csd->rtd, rcd);
 =

-	rcsd->ril =3D g_ril_new("/tmp/unittestril", OFONO_RIL_VENDOR_AOSP);
-	g_assert(rcsd->ril !=3D NULL);
+	rcd->ril =3D g_ril_new("/tmp/unittestril", OFONO_RIL_VENDOR_AOSP);
+	g_assert(rcd->ril !=3D NULL);
 =

 	mainloop =3D g_main_loop_new(NULL, FALSE);
 =

 	g_main_loop_run(mainloop);
 	g_main_loop_unref(mainloop);
 =

-	csdriver->remove(rcsd->cs);
-	g_ril_unref(rcsd->ril);
-	g_free(rcsd);
+	csdriver->remove(rcd->cs);
+	g_ril_unref(rcd->ril);
+	g_free(rcd);
+
+	rilmodem_test_server_close();
 =

 	ril_call_settings_exit();
 }
-- =

2.1.4


--===============2994876900807190513==--

