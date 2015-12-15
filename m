Content-Type: multipart/mixed; boundary="===============8607021855290023220=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/3] unit: add new test-rilmodem-cb
Date: Tue, 15 Dec 2015 11:34:33 -0500
Message-ID: <1450197275-5463-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8607021855290023220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-rilmodem-cb.c | 598 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 598 insertions(+)
 create mode 100644 unit/test-rilmodem-cb.c

diff --git a/unit/test-rilmodem-cb.c b/unit/test-rilmodem-cb.c
new file mode 100644
index 0000000..d5b1d07
--- /dev/null
+++ b/unit/test-rilmodem-cb.c
@@ -0,0 +1,598 @@
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
+#include <ofono/call-barring.h>
+#include <gril.h>
+
+#include "common.h"
+#include "ril_constants.h"
+#include "rilmodem-test-server.h"
+
+static GMainLoop *mainloop;
+
+static const struct ofono_call_barring_driver *cbdriver;
+
+struct rilmodem_cb_data {
+	GRil *ril;
+	struct ofono_modem *modem;
+	gconstpointer test_data;
+	struct ofono_call_barring *cb;
+	struct server_data *serverd;
+};
+
+typedef gboolean (*StartFunc)(gpointer data);
+
+struct cb_data {
+	StartFunc start_func;
+
+	const char *lock;
+	int enable;
+	const char *passwd;
+	const char *new_passwd;
+	int cls;
+
+	struct rilmodem_test_data rtd;
+	enum ofono_error_type error_type;
+
+	int status;
+};
+
+static void query_callback(const struct ofono_error *error, int status,
+								gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D cbd->error_type);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		g_assert(status =3D=3D cbd->status);
+
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean trigger_query(gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(cbdriver->query !=3D NULL);
+	cbdriver->query(rsd->cb, cbd->lock, cbd->cls, query_callback, rsd);
+
+	return FALSE;
+}
+
+static void set_callback(const struct ofono_error *error, gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D cbd->error_type);
+
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean trigger_set(gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(cbdriver->set !=3D NULL);
+	cbdriver->set(rsd->cb, cbd->lock, cbd->enable, cbd->passwd, cbd->cls,
+							set_callback, rsd);
+
+	return FALSE;
+}
+
+static void set_passwd_callback(const struct ofono_error *error, gpointer =
data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D cbd->error_type);
+
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean trigger_set_passwd(gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	g_assert(cbdriver->set_passwd !=3D NULL);
+	cbdriver->set_passwd(rsd->cb, cbd->lock, cbd->passwd, cbd->new_passwd,
+						set_passwd_callback, rsd);
+
+	return FALSE;
+}
+
+/* RIL_REQUEST_GET_FACILITY_LOCK witht the following parameters:
+ *
+ * facility=3D"OI" (outgoing international calls)
+ * service class=3D1 ( VOICE )
+ */
+static const guchar req_get_facility_lock_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x2c, 0x2a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x49, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_GET_FACILITY_LOCK reply with parameter {1}
+ * which indicates that call-barring is activated for the
+ * previously specified facility for the VOICE class.
+ */
+static const guchar reply_get_facility_lock_data_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cb_data testdata_query_valid_1 =3D {
+	.start_func =3D trigger_query,
+	.lock =3D "OI",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_get_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
+		.rsp_data =3D reply_get_facility_lock_data_valid_1,
+		.rsp_size =3D sizeof(reply_get_facility_lock_data_valid_1),
+	},
+	.status =3D BEARER_CLASS_VOICE,
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cb_data testdata_query_invalid_1 =3D {
+	.start_func =3D trigger_query,
+	.lock =3D "OI",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_get_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
+		.rsp_data =3D reply_get_facility_lock_data_valid_1,
+		.rsp_size =3D sizeof(reply_get_facility_lock_data_valid_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_GET_FACILITY_LOCK reply with invalid number
+ * of parameters {0} specified.
+ */
+static const guchar reply_get_facility_lock_data_invalid_2[] =3D {
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cb_data testdata_query_invalid_2 =3D {
+	.start_func =3D trigger_query,
+	.lock =3D "OI",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_get_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
+		.rsp_data =3D reply_get_facility_lock_data_invalid_2,
+		.rsp_size =3D sizeof(reply_get_facility_lock_data_invalid_2),
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * The following structure contains test data for an invalid
+ * RIL_REQUEST_GET_FACILITY_LOCK reply with an invalid class
+ * mask (-255).
+ */
+static const guchar reply_get_facility_lock_data_invalid_3[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0xff, 0xff, 0xff
+};
+
+static const struct cb_data testdata_query_invalid_3 =3D {
+	.start_func =3D trigger_query,
+	.lock =3D "OI",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_get_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
+		.rsp_data =3D reply_get_facility_lock_data_invalid_3,
+		.rsp_size =3D sizeof(reply_get_facility_lock_data_invalid_3),
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * The following structure contains test data for a
+ * RIL_REQUEST_GET_FACILITY_LOCK reply with an incomplete
+ * integer parameter, which will trigger a malformed parcel
+ * error.
+ */
+static const guchar reply_get_facility_lock_data_invalid_4[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
+};
+
+static const struct cb_data testdata_query_invalid_4 =3D {
+	.start_func =3D trigger_query,
+	.lock =3D "OI",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_get_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
+		.rsp_data =3D reply_get_facility_lock_data_invalid_4,
+		.rsp_size =3D sizeof(reply_get_facility_lock_data_invalid_4),
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_SET_FACILITY_LOCK witht the following parameters:
+ *
+ * facility=3D"OI" (outgoing international calls)
+ * unlock (0)
+ * passwd=3D"0000"
+ * service class=3D1 ( VOICE )
+ */
+static const guchar req_set_facility_lock_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x3c, 0x2b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x49, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff
+};
+
+/*
+ * This test doesn't specify any data for RIL_REQUEST_SET_FACILITY_LOCK re=
ply
+ * to simulate a reply generated by mako.
+ */
+static const struct cb_data testdata_set_valid_1 =3D {
+	.start_func =3D trigger_set,
+	.lock =3D "OI",
+	.passwd =3D "0000",
+	.cls =3D BEARER_CLASS_VOICE,
+	.rtd =3D {
+		.req_data =3D req_set_facility_lock_parcel_1,
+		.req_size =3D sizeof(req_set_facility_lock_parcel_1),
+	},
+};
+
+/* RIL_REQUEST_SET_FACILITY_LOCK witht the following parameters:
+ *
+ * facility=3D"OI" (outgoing international calls)
+ * unlock (1)
+ * passwd=3D"0000"
+ * service class=3D0 ( NONE )
+ */
+static const guchar req_set_facility_lock_parcel_2[] =3D {
+	0x00, 0x00, 0x00, 0x3c, 0x2b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x49, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00,
+	0x04, 0x00, 0x00, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff
+};
+
+/*
+ * The following structure contains test data for a valid
+ * RIL_REQUEST_SET_FACILITY_LOCK reply with parameter {1}
+ */
+static const guchar reply_set_facility_lock_data_valid_2[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cb_data testdata_set_valid_2 =3D {
+	.start_func =3D trigger_set,
+	.lock =3D "OI",
+	.enable =3D 1,
+	.passwd =3D "0000",
+	.cls =3D BEARER_CLASS_DEFAULT,  /* updated to NONE in outgoing parcel */
+	.rtd =3D {
+		.req_data =3D req_set_facility_lock_parcel_2,
+		.req_size =3D sizeof(req_set_facility_lock_parcel_2),
+		.rsp_data =3D reply_set_facility_lock_data_valid_2,
+		.rsp_size =3D sizeof(reply_set_facility_lock_data_valid_2),
+	},
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cb_data testdata_set_invalid_1 =3D {
+	.start_func =3D trigger_set,
+	.lock =3D "OI",
+	.enable =3D 1,
+	.passwd =3D "0000",
+	.cls =3D BEARER_CLASS_DEFAULT,
+	.rtd =3D {
+		.req_data =3D req_set_facility_lock_parcel_2,
+		.req_size =3D sizeof(req_set_facility_lock_parcel_2),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+
+/*
+ * The following structure contains test data for a
+ * RIL_REQUEST_SET_FACILITY_LOCK reply with an invalid
+ * number of parameters {2}
+ */
+static const guchar reply_set_facility_lock_data_invalid_2[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+
+static const struct cb_data testdata_set_invalid_2 =3D {
+	.start_func =3D trigger_set,
+	.lock =3D "OI",
+	.enable =3D 1,
+	.passwd =3D "0000",
+	.cls =3D BEARER_CLASS_DEFAULT,
+	.rtd =3D {
+		.req_data =3D req_set_facility_lock_parcel_2,
+		.req_size =3D sizeof(req_set_facility_lock_parcel_2),
+		.rsp_data =3D reply_set_facility_lock_data_invalid_2,
+		.rsp_size =3D sizeof(reply_set_facility_lock_data_invalid_2),
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * The following structure contains test data for a
+ * RIL_REQUEST_SET_FACILITY_LOCK reply with an incomplete
+ * integer parameter, which will trigger a malformed parcel
+ * error.
+ */
+static const guchar reply_set_facility_lock_data_invalid_3[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
+};
+
+static const struct cb_data testdata_set_invalid_3 =3D {
+	.start_func =3D trigger_set,
+	.lock =3D "OI",
+	.enable =3D 1,
+	.passwd =3D "0000",
+	.cls =3D BEARER_CLASS_DEFAULT,
+	.rtd =3D {
+		.req_data =3D req_set_facility_lock_parcel_2,
+		.req_size =3D sizeof(req_set_facility_lock_parcel_2),
+		.rsp_data =3D reply_set_facility_lock_data_invalid_3,
+		.rsp_size =3D sizeof(reply_set_facility_lock_data_invalid_3),
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* RIL_REQUEST_CHANGE_BARRING_PASSWORD with the following parameters:
+ *
+ * facility=3D"OI" (outgoing international calls)
+ * old passwd=3D"1111"
+ * new_passwd=3D"0000"
+ */
+static const guchar req_change_barring_passwd_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x38, 0x2c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x49, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x31, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+	0x30, 0x00, 0x30, 0x00,	0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * This test doesn't specify any data for RIL_REQUEST_SET_FACILITY_LOCK re=
ply
+ * to simulate a reply generated by mako.
+ */
+static const struct cb_data testdata_set_passwd_valid_1 =3D {
+	.start_func =3D trigger_set_passwd,
+	.lock =3D "OI",
+	.passwd =3D "1111",
+	.new_passwd =3D "0000",
+	.rtd =3D {
+		.req_data =3D req_change_barring_passwd_parcel_1,
+		.req_size =3D sizeof(req_change_barring_passwd_parcel_1),
+	},
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct cb_data testdata_set_passwd_invalid_1 =3D {
+	.start_func =3D trigger_set_passwd,
+	.lock =3D "OI",
+	.passwd =3D "1111",
+	.new_passwd =3D "0000",
+	.rtd =3D {
+		.req_data =3D req_change_barring_passwd_parcel_1,
+		.req_size =3D sizeof(req_change_barring_passwd_parcel_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* Declarations && Re-implementations of core functions. */
+void ril_call_barring_exit(void);
+void ril_call_barring_init(void);
+
+struct ofono_call_barring {
+	void *driver_data;
+	const struct cb_data *cbd;
+};
+
+struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *m=
odem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	struct ofono_call_barring *cb =3D g_new0(struct ofono_call_barring, 1);
+	int retval;
+
+	retval =3D cbdriver->probe(cb, OFONO_RIL_VENDOR_AOSP, rsd->ril);
+	g_assert(retval =3D=3D 0);
+
+	return cb;
+}
+
+int ofono_call_barring_driver_register(const struct ofono_call_barring_dri=
ver *d)
+{
+	if (cbdriver =3D=3D NULL)
+		cbdriver =3D d;
+
+	return 0;
+}
+
+void ofono_call_barring_set_data(struct ofono_call_barring *cb, void *data)
+{
+	cb->driver_data =3D data;
+}
+
+void *ofono_call_barring_get_data(struct ofono_call_barring *cb)
+{
+	return cb->driver_data;
+}
+
+void ofono_call_barring_register(struct ofono_call_barring *cb)
+{
+}
+
+void ofono_call_barring_driver_unregister(const struct ofono_call_barring_=
driver *d)
+{
+}
+
+static void server_connect_cb(gpointer data)
+{
+	struct rilmodem_cb_data *rsd =3D data;
+	const struct cb_data *cbd =3D rsd->test_data;
+
+	/* This causes local impl of _create() to call driver's probe func. */
+	rsd->cb =3D ofono_call_barring_create(NULL, OFONO_RIL_VENDOR_AOSP,
+							"rilmodem", rsd);
+	rsd->cb->cbd =3D cbd;
+
+	/* add_idle doesn't work, read blocks main loop!!! */
+
+	if (cbd->rtd.unsol_test)
+		g_idle_add(cbd->start_func, (void *) rsd);
+	else
+		g_assert(cbd->start_func(rsd) =3D=3D FALSE);
+}
+
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+
+/*
+ * This unit test:
+ *  - does some test data setup
+ *  - configures a dummy server socket
+ *  - creates a new gril client instance
+ *    - triggers a connect to the dummy
+ *      server socket
+ *  - starts a mainloop
+ */
+static void test_call_barring_func(gconstpointer data)
+{
+	const struct cb_data *sd =3D data;
+	struct rilmodem_cb_data *rsd;
+
+	ril_call_barring_init();
+
+	rsd =3D g_new0(struct rilmodem_cb_data, 1);
+
+	rsd->test_data =3D sd;
+
+	rsd->serverd =3D rilmodem_test_server_create(&server_connect_cb,
+								&sd->rtd, rsd);
+
+	rsd->ril =3D g_ril_new(RIL_SERVER_SOCK_PATH, OFONO_RIL_VENDOR_AOSP);
+	g_assert(rsd->ril !=3D NULL);
+
+	mainloop =3D g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(mainloop);
+	g_main_loop_unref(mainloop);
+
+	cbdriver->remove(rsd->cb);
+	g_ril_unref(rsd->ril);
+	g_free(rsd);
+
+	rilmodem_test_server_close(rsd->serverd);
+
+	ril_call_barring_exit();
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
+	g_test_add_data_func("/testrilmodemcallbarring/query/valid/1",
+					&testdata_query_valid_1,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/query/invalid/1",
+					&testdata_query_invalid_1,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/query/invalid/2",
+					&testdata_query_invalid_2,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/query/invalid/3",
+					&testdata_query_invalid_3,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/query/invalid/4",
+					&testdata_query_invalid_3,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set/valid/4",
+					&testdata_set_valid_1,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set/valid/2",
+					&testdata_set_valid_2,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set/invalid/1",
+					&testdata_set_invalid_1,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set/invalid/2",
+					&testdata_set_invalid_2,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set/invalid/3",
+					&testdata_set_invalid_3,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set_passwd/valid/1",
+					&testdata_set_passwd_valid_1,
+					test_call_barring_func);
+	g_test_add_data_func("/testrilmodemcallbarring/set_passwd/invalid/1",
+					&testdata_set_passwd_invalid_1,
+					test_call_barring_func);
+#endif
+	return g_test_run();
+}
-- =

2.1.4


--===============8607021855290023220==--

