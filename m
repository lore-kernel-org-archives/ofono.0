Content-Type: multipart/mixed; boundary="===============1981962624497171625=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/2 v2] unit: add new test rilmodem-cs
Date: Thu, 05 Nov 2015 14:50:22 -0500
Message-ID: <1446753023-23385-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1981962624497171625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit adds a new style of build-time/unit test to
rilmodem.  These tests setup a dummy server socket and
attach a gril instance to it.  This allows rilmodem
call-settings atom functions to be tested directly,
validating request parcels received by the server-side,
and callbacks that happen in response to canned responses
sent by the server-side.
---
 unit/test-rilmodem-cs.c | 707 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 707 insertions(+)
 create mode 100644 unit/test-rilmodem-cs.c

diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
new file mode 100644
index 0000000..959be4e
--- /dev/null
+++ b/unit/test-rilmodem-cs.c
@@ -0,0 +1,707 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2015 Canonical Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <glib.h>
+#include <stdio.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include <ofono/modem.h>
+#include <ofono/types.h>
+#include <ofono/call-settings.h>
+#include <gril.h>
+
+#include "common.h"
+#include "ril_constants.h"
+
+#define MAX_REQUEST_SIZE 4096
+
+static GMainLoop *mainloop;
+
+static const struct ofono_call_settings_driver *csdriver;
+
+struct rilmodemcs_data {
+	GRil *ril;
+	int sk;
+	gint server_watch;
+	GIOChannel *server_io;
+	struct ofono_modem *modem;
+	gconstpointer test_data;
+	struct ofono_call_settings *cs;
+};
+
+/* Warning: length is stored in network order */
+struct rsp_hdr {
+	uint32_t length;
+	uint32_t unsolicited;
+	uint32_t serial;
+	uint32_t error;
+};
+
+typedef gboolean (*StartFunc)(gpointer data);
+
+struct cs_data {
+	StartFunc start_func;
+	gint param_int1;
+	gint param_int2;
+
+	const guchar *parcel_data;
+
+	const gsize parcel_size;
+
+	uint32_t rsp_error;
+	const guchar *rsp_data;
+	const gsize rsp_size;
+	enum ofono_error_type error_type;
+	gint cb_int1;
+	gint cb_int2;
+};
+
+static gboolean trigger_clip_query(gpointer data);
+static gboolean trigger_cw_query(gpointer data);
+static gboolean trigger_cw_set(gpointer data);
+static gboolean trigger_clir_query(gpointer data);
+static gboolean trigger_clir_set(gpointer data);
+
+/* RIL_REQUEST_QUERY_CLIP */
+static const guchar req_clip_query_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x08, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/* reply data for QUErY_CLIP: 0x01 =3D 'CLIP provisioned' */
+static const guchar rsp_clip_query_data_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cs_data testdata_clip_query_valid_1 =3D {
+	.start_func =3D trigger_clip_query,
+	.parcel_data =3D req_clip_query_parcel_1,
+	.parcel_size =3D sizeof(req_clip_query_parcel_1),
+	.rsp_data =3D rsp_clip_query_data_1,
+	.rsp_size =3D sizeof(rsp_clip_query_data_1),
+	.rsp_error =3D RIL_E_SUCCESS,
+	.cb_int1 =3D 1,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* reply data for QUErY_CLIP: invalid num_params=3D0x02' */
+static const guchar rsp_clip_query_data_2[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+/* reply parse error causes status to be returned as -1 */
+static const struct cs_data testdata_clip_query_invalid_1 =3D {
+	.start_func =3D trigger_clip_query,
+	.parcel_data =3D req_clip_query_parcel_1,
+	.parcel_size =3D sizeof(req_clip_query_parcel_1),
+	.rsp_data =3D rsp_clip_query_data_2,
+	.rsp_size =3D sizeof(rsp_clip_query_data_2),
+	.cb_int1 =3D -1,
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* error triggered by RIL reply error */
+static const struct cs_data testdata_clip_query_invalid_2 =3D {
+	.start_func =3D trigger_clip_query,
+	.parcel_data =3D req_clip_query_parcel_1,
+	.parcel_size =3D sizeof(req_clip_query_parcel_1),
+	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_QUERY_CALL_WAITING */
+static const guchar req_cw_query_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x10, 0x23, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/* reply data for QUErY_CALL_WAITING: 1=3D'enabled' 3=3D'data|voice' */
+static const guchar rsp_cw_query_data_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x3, 0x00, 0x00, 0x00
+};
+
+static const struct cs_data testdata_cw_query_valid_1 =3D {
+	.start_func =3D trigger_cw_query,
+	.parcel_data =3D req_cw_query_parcel_1,
+	.parcel_size =3D sizeof(req_cw_query_parcel_1),
+	.rsp_data =3D rsp_cw_query_data_1,
+	.rsp_size =3D sizeof(rsp_cw_query_data_1),
+	.rsp_error =3D RIL_E_SUCCESS,
+	.cb_int1 =3D 3,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* reply data for QUErY_CALL_WAITING: invalid num_params=3D0x00' */
+static const guchar rsp_cw_query_data_2[] =3D {
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+/* reply parse error causes status to be returned as -1 */
+static const struct cs_data testdata_cw_query_invalid_1 =3D {
+	.start_func =3D trigger_cw_query,
+	.parcel_data =3D req_cw_query_parcel_1,
+	.parcel_size =3D sizeof(req_cw_query_parcel_1),
+	.rsp_data =3D rsp_cw_query_data_2,
+	.rsp_size =3D sizeof(rsp_cw_query_data_2),
+	.cb_int1 =3D -1,
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cs_data testdata_cw_query_invalid_2 =3D {
+	.start_func =3D trigger_cw_query,
+	.parcel_data =3D req_cw_query_parcel_1,
+	.parcel_size =3D sizeof(req_cw_query_parcel_1),
+	.rsp_data =3D rsp_cw_query_data_2,
+	.rsp_size =3D sizeof(rsp_cw_query_data_2),
+	.cb_int1 =3D -1,
+	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_SET_CALL_WAITING: enabled cls=3DBEARER_CLASS_DEFAULT (7) */
+/* Note - driver atom checks for cls=3D7, and changes to cls=3D1 */
+static const guchar req_cw_set_enabled_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x14, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cs_data testdata_cw_set_valid_1 =3D {
+	.start_func =3D trigger_cw_set,
+	.param_int1 =3D 1,
+	.param_int2 =3D BEARER_CLASS_DEFAULT,
+	.parcel_data =3D req_cw_set_enabled_parcel_1,
+	.parcel_size =3D sizeof(req_cw_set_enabled_parcel_1),
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* RIL_REQUEST_SET_CALL_WAITING: disabled cls=3D0 */
+static const guchar req_cw_set_disabled_parcel_2[] =3D {
+	0x00, 0x00, 0x00, 0x14, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cs_data testdata_cw_set_invalid_1 =3D {
+	.start_func =3D trigger_cw_set,
+	.param_int1 =3D 0,
+	.param_int2 =3D 0,
+	.parcel_data =3D req_cw_set_disabled_parcel_2,
+	.parcel_size =3D sizeof(req_cw_set_disabled_parcel_2),
+	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_GET_CLIR */
+static const guchar req_clir_query_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x08, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/* reply data for GET_CLIR: m=3D2 n=3D4; see TS 27.007 Section 7.7 */
+static const guchar rsp_clir_query_data_1[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
+};
+
+static const struct cs_data testdata_clir_query_valid_1 =3D {
+	.start_func =3D trigger_clir_query,
+	.parcel_data =3D req_clir_query_parcel_1,
+	.parcel_size =3D sizeof(req_clir_query_parcel_1),
+	.rsp_data =3D rsp_clir_query_data_1,
+	.rsp_size =3D sizeof(rsp_clir_query_data_1),
+	.cb_int1 =3D 2,
+	.cb_int2 =3D 4,
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* invalid reply data for GET_CLIR: num params is 3 instead of 2 */
+static const guchar rsp_clir_query_data_2[] =3D {
+	0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
+};
+static const struct cs_data testdata_clir_query_invalid_1 =3D {
+	.start_func =3D trigger_clir_query,
+	.parcel_data =3D req_clir_query_parcel_1,
+	.parcel_size =3D sizeof(req_clir_query_parcel_1),
+	.rsp_data =3D rsp_clir_query_data_2,
+	.rsp_size =3D sizeof(rsp_clir_query_data_2),
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_SET_CLIR: mode=3DDEFAULT */
+static const guchar req_clir_set_mode0_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct cs_data testdata_clir_set_valid_1 =3D {
+	.start_func =3D trigger_clir_set,
+	.param_int1 =3D OFONO_CLIR_OPTION_DEFAULT,
+	.parcel_data =3D req_clir_set_mode0_parcel_1,
+	.parcel_size =3D sizeof(req_clir_set_mode0_parcel_1),
+	.rsp_error =3D RIL_E_SUCCESS,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* RIL_REQUEST_SET_CLIR: mode=3DINVOCATION */
+static const guchar req_clir_set_mode0_parcel_2[] =3D {
+	0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cs_data testdata_clir_set_invalid_1 =3D {
+	.start_func =3D trigger_clir_set,
+	.param_int1 =3D OFONO_CLIR_OPTION_INVOCATION,
+	.parcel_data =3D req_clir_set_mode0_parcel_2,
+	.parcel_size =3D sizeof(req_clir_set_mode0_parcel_2),
+	.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* Declarations && Re-implementations of core functions. */
+void __ofono_exit(void);
+void ril_call_settings_exit(void);
+void ril_call_settings_init(void);
+
+struct ofono_call_settings {
+	void *driver_data;
+};
+
+/* Needed by: src/modem.c */
+void __ofono_exit(void)
+{
+	g_main_loop_quit(mainloop);
+
+}
+
+struct ofono_call_settings *ofono_call_settings_create(struct ofono_modem =
*modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	struct ofono_call_settings *cs =3D g_new0(struct ofono_call_settings, 1);
+	int retval;
+
+	retval =3D csdriver->probe(cs, OFONO_RIL_VENDOR_AOSP, rcsd->ril);
+	g_assert(retval =3D=3D 0);
+
+	return cs;
+}
+
+int ofono_call_settings_driver_register(const struct ofono_call_settings_d=
river *d)
+{
+	if (csdriver =3D=3D NULL)
+		csdriver =3D d;
+
+	return 0;
+}
+
+void ofono_call_settings_set_data(struct ofono_call_settings *cs, void *da=
ta)
+{
+	cs->driver_data =3D data;
+}
+
+void *ofono_call_settings_get_data(struct ofono_call_settings *cs)
+{
+	return cs->driver_data;
+}
+
+void ofono_call_settings_register(struct ofono_call_settings *cs)
+{
+	;
+}
+
+void ofono_call_settings_driver_unregister(const struct ofono_call_setting=
s_driver *d)
+{
+	;
+}
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+static void status_query_callback(const struct ofono_error *error, int sta=
tus,
+								 gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	g_assert(error->type =3D=3D csd->error_type);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		g_assert(status =3D=3D csd->cb_int1);
+
+	g_main_loop_quit(mainloop);
+}
+
+static void clir_query_callback(const struct ofono_error *error, int overr=
ide,
+						int network, gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	g_assert(error->type =3D=3D csd->error_type);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		g_assert(override =3D=3D csd->cb_int1);
+		g_assert(network =3D=3D csd->cb_int2);
+	}
+
+	g_main_loop_quit(mainloop);
+}
+
+static void set_callback(const struct ofono_error *error, gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	g_assert(error->type =3D=3D csd->error_type);
+
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean trigger_clip_query(gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+
+	g_assert(csdriver->clip_query !=3D NULL);
+	csdriver->clip_query(rcsd->cs, status_query_callback, rcsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_cw_query(gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+
+	g_assert(csdriver->cw_query !=3D NULL);
+
+	/* cls is explicitly ignored by rilmodem; just use 0 */
+	csdriver->cw_query(rcsd->cs, 0, status_query_callback, rcsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_cw_set(gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	g_assert(csdriver->cw_set !=3D NULL);
+
+	csdriver->cw_set(rcsd->cs, csd->param_int1, csd->param_int2,
+						set_callback, rcsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_clir_query(gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+
+	g_assert(csdriver->clir_query !=3D NULL);
+	csdriver->clir_query(rcsd->cs, clir_query_callback, rcsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_clir_set(gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	g_assert(csdriver->clir_set !=3D NULL);
+	csdriver->clir_set(rcsd->cs, csd->param_int1, set_callback, rcsd);
+
+	return FALSE;
+}
+
+static gboolean read_server(gpointer data)
+{
+	GIOStatus status;
+	struct rilmodemcs_data *rcsd =3D data;
+	gsize offset, rbytes, wbytes;
+	gchar *buf, *bufp;
+	uint32_t req_serial;
+	struct rsp_hdr rsp;
+
+	/*
+	 * FIXME: separate out verification from here, so read_server doesn't
+	 * need to know about cs_data.
+	 */
+	const struct cs_data *csd =3D rcsd->test_data;
+
+	buf =3D g_malloc0(MAX_REQUEST_SIZE);
+
+	status =3D g_io_channel_read_chars(rcsd->server_io, buf, MAX_REQUEST_SIZE,
+								&rbytes, NULL);
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+	g_assert(rbytes =3D=3D csd->parcel_size);
+
+	/* validate len, and request_id */
+	g_assert(!memcmp(buf, csd->parcel_data, (sizeof(uint32_t) * 2)));
+
+	/*
+	 * header: size (uint32), reqid (uin32), serial (uint32)
+	 * header size =3D=3D 16 ( excludes sizeof(size) )
+	 */
+
+	/* advance past request_no */
+	bufp =3D buf + (sizeof(uint32_t) * 2);
+
+	req_serial =3D (uint32_t) *bufp;
+
+	/* advance past serial_no */
+	bufp +=3D sizeof(uint32_t);
+
+	/* validate the rest of the parcel... */
+	offset =3D (sizeof(uint32_t) * 3);
+	g_assert(!memcmp(bufp, csd->parcel_data + offset,
+						csd->parcel_size - offset));
+
+	/* Length does not include the length field. Network order. */
+	rsp.length =3D htonl(sizeof(rsp) - sizeof(rsp.length) + csd->rsp_size);
+	rsp.unsolicited =3D 0;
+	rsp.serial =3D req_serial;
+	rsp.error =3D csd->rsp_error;
+
+	/* copy header */
+	memcpy(buf, &rsp, sizeof(rsp));
+
+	if (csd->rsp_size) {
+		bufp =3D buf + sizeof(rsp);
+
+		memcpy(bufp, csd->rsp_data, csd->rsp_size);
+	}
+
+
+	status =3D g_io_channel_write_chars(rcsd->server_io,
+					buf,
+					sizeof(rsp) + csd->rsp_size,
+					&wbytes, NULL);
+
+	/* FIXME: assert wbytes is correct */
+
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	g_free(buf);
+	g_io_channel_unref(rcsd->server_io);
+
+	return FALSE;
+}
+
+static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct rilmodemcs_data *rcsd =3D data;
+	const struct cs_data *csd =3D rcsd->test_data;
+	struct sockaddr saddr;
+	unsigned int len =3D sizeof(saddr);
+	int fd;
+	GIOChannel *server_io =3D NULL;
+	GIOStatus status;
+
+	g_assert(cond =3D=3D G_IO_IN);
+
+	fd =3D accept(rcsd->sk, &saddr, &len);
+	g_assert(fd !=3D -1);
+
+	server_io =3D g_io_channel_unix_new(fd);
+	g_assert(server_io !=3D NULL);
+
+	/* This causes local impl of _create() to call driver's probe func. */
+	rcsd->cs =3D ofono_call_settings_create(NULL, OFONO_RIL_VENDOR_AOSP,
+							"rilmodem", rcsd);
+
+	/* add_idle doesn't work, read blocks main loop!!! */
+	g_assert(csd->start_func(rcsd) =3D=3D FALSE);
+
+	status =3D g_io_channel_set_encoding(server_io, NULL, NULL);
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	g_io_channel_set_buffered(server_io, FALSE);
+	g_io_channel_set_close_on_unref(server_io, TRUE);
+
+	rcsd->server_io =3D server_io;
+
+	g_idle_add(read_server, rcsd);
+
+	/* single-shot callback */
+	return FALSE;
+}
+
+static void create_server_socket(const char *sock_path, struct rilmodemcs_=
data *rcsd)
+{
+	GIOChannel *io;
+	struct sockaddr_un addr;
+	int retval;
+
+	rcsd->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	g_assert(rcsd->sk);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);
+
+	/* Unlink any existing socket for this session */
+	unlink(addr.sun_path);
+
+	retval =3D bind(rcsd->sk, (struct sockaddr *) &addr, sizeof(addr));
+	g_assert(retval >=3D 0);
+
+	retval =3D listen(rcsd->sk, 0);
+	g_assert(retval >=3D 0);
+
+	io =3D g_io_channel_unix_new(rcsd->sk);
+	g_assert(io !=3D NULL);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	rcsd->server_watch =3D g_io_add_watch_full(io,
+				G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				on_socket_connected, rcsd, NULL);
+
+	g_io_channel_unref(io);
+}
+
+/*
+ * This unit test:
+ *  - does some test data setup
+ *  - configures a dummy server socket
+ *    - on_socket_connected: callback for
+ *      incoming socket connects
+ *  - creates a new gril client instance
+ *    - triggers a connect to the dummy
+ *      server socket
+ *  - starts a mainloop
+ */
+static void test_cs_func(gconstpointer data)
+{
+	const struct cs_data *csd =3D data;
+	struct rilmodemcs_data *rcsd;
+
+	ril_call_settings_init();
+
+	rcsd =3D g_new0(struct rilmodemcs_data, 1);
+
+	rcsd->test_data =3D csd;
+
+	create_server_socket("/tmp/unittestril", rcsd);
+
+	rcsd->ril =3D g_ril_new("/tmp/unittestril", OFONO_RIL_VENDOR_AOSP);
+	g_assert(rcsd->ril !=3D NULL);
+
+	mainloop =3D g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(mainloop);
+	g_main_loop_unref(mainloop);
+
+	csdriver->remove(rcsd->cs);
+	g_ril_unref(rcsd->ril);
+	g_free(rcsd);
+
+	ril_call_settings_exit();
+}
+
+#endif
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+/*
+ * As all our architectures are little-endian except for
+ * PowerPC, and the Binder wire-format differs slightly
+ * depending on endian-ness, the following guards against test
+ * failures when run on PowerPC.
+ */
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+	g_test_add_data_func("/testrilmodemcs/clip_query/valid/1",
+					&testdata_clip_query_valid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clip_query/invalid/1",
+					&testdata_clip_query_invalid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clip_query/invalid/2",
+					&testdata_clip_query_invalid_2,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/cw_query/valid/1",
+					&testdata_cw_query_valid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/cw_query/invalid/1",
+					&testdata_cw_query_invalid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/cw_query/invalid/2",
+					&testdata_cw_query_invalid_2,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/cw_set/valid/1",
+					&testdata_cw_set_valid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/cw_set/invalid/1",
+					&testdata_cw_set_invalid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clir_query/valid/1",
+					&testdata_clir_query_valid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clir_query/invalid/1",
+					&testdata_clir_query_invalid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clir_set/valid/1",
+					&testdata_clir_set_valid_1,
+					test_cs_func);
+
+	g_test_add_data_func("/testrilmodemcs/clir_set/invalid/1",
+					&testdata_clir_set_invalid_1,
+					test_cs_func);
+
+#endif
+	return g_test_run();
+}
-- =

2.1.4


--===============1981962624497171625==--

