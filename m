Content-Type: multipart/mixed; boundary="===============9138625273235083297=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/4 v2] unit: add new test-rilmodem-sms
Date: Thu, 19 Nov 2015 17:21:28 -0500
Message-ID: <1447971691-22662-2-git-send-email-espy@canonical.com>
In-Reply-To: <1447971691-22662-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9138625273235083297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/rilmodem-test-server.c | 196 +++++++++++++++++++++++++++++++++
 unit/rilmodem-test-server.h |  40 +++++++
 unit/test-rilmodem-sms.c    | 261 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 497 insertions(+)
 create mode 100644 unit/rilmodem-test-server.c
 create mode 100644 unit/rilmodem-test-server.h
 create mode 100644 unit/test-rilmodem-sms.c

diff --git a/unit/rilmodem-test-server.c b/unit/rilmodem-test-server.c
new file mode 100644
index 0000000..52a3c74
--- /dev/null
+++ b/unit/rilmodem-test-server.c
@@ -0,0 +1,196 @@
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
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include <ofono/types.h>
+
+#include <gril.h>
+
+#include "rilmodem-test-server.h"
+
+#define MAX_REQUEST_SIZE 4096
+
+static int server_sk;
+static ConnectFunc connect_func;
+static GIOChannel *server_io;
+static const struct rilmodem_test_data *rtd;
+
+/* Warning: length is stored in network order */
+struct rsp_hdr {
+	uint32_t length;
+	uint32_t unsolicited;
+	uint32_t serial;
+	uint32_t error;
+};
+
+static gboolean read_server(gpointer data)
+{
+	GIOStatus status;
+	gsize offset, rbytes, wbytes;
+	gchar *buf, *bufp;
+	uint32_t req_serial;
+	struct rsp_hdr rsp;
+
+	buf =3D g_malloc0(MAX_REQUEST_SIZE);
+
+	status =3D g_io_channel_read_chars(server_io, buf, MAX_REQUEST_SIZE,
+								&rbytes, NULL);
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	g_assert(rbytes =3D=3D rtd->req_size);
+
+	/* validate len, and request_id */
+	g_assert(!memcmp(buf, rtd->req_data, (sizeof(uint32_t) * 2)));
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
+	g_assert(!memcmp(bufp, rtd->req_data + offset,
+						rtd->req_size - offset));
+
+	/* Length does not include the length field. Network order. */
+	rsp.length =3D htonl(sizeof(rsp) - sizeof(rsp.length) + rtd->rsp_size);
+	rsp.unsolicited =3D 0;
+	rsp.serial =3D req_serial;
+	rsp.error =3D rtd->rsp_error;
+
+	/* copy header */
+	memcpy(buf, &rsp, sizeof(rsp));
+
+	if (rtd->rsp_size) {
+		bufp =3D buf + sizeof(rsp);
+
+		memcpy(bufp, rtd->rsp_data, rtd->rsp_size);
+	}
+
+
+	status =3D g_io_channel_write_chars(server_io,
+					buf,
+					sizeof(rsp) + rtd->rsp_size,
+					&wbytes, NULL);
+
+	/* FIXME: assert wbytes is correct */
+
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	g_free(buf);
+	g_io_channel_unref(server_io);
+
+	return FALSE;
+}
+
+static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct sockaddr saddr;
+	unsigned int len =3D sizeof(saddr);
+	int fd;
+	GIOStatus status;
+
+	g_assert(cond =3D=3D G_IO_IN);
+
+	fd =3D accept(server_sk, &saddr, &len);
+	g_assert(fd !=3D -1);
+
+	server_io =3D g_io_channel_unix_new(fd);
+	g_assert(server_io !=3D NULL);
+
+	if (connect_func)
+		connect_func(data);
+
+	status =3D g_io_channel_set_encoding(server_io, NULL, NULL);
+	g_assert(status =3D=3D G_IO_STATUS_NORMAL);
+
+	g_io_channel_set_buffered(server_io, FALSE);
+	g_io_channel_set_close_on_unref(server_io, TRUE);
+
+	g_idle_add(read_server, data);
+
+	return FALSE;
+}
+
+void rilmodem_test_server_close(void)
+{
+	g_assert(server_sk);
+	close(server_sk);
+	server_sk =3D 0;
+}
+
+void rilmodem_test_server_create(ConnectFunc connect,
+				const struct rilmodem_test_data *test_data,
+				void *data)
+{
+	GIOChannel *io;
+	struct sockaddr_un addr;
+	int retval;
+
+	g_assert(server_sk =3D=3D 0);
+
+	connect_func =3D connect;
+	rtd =3D test_data;
+
+	server_sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	g_assert(server_sk);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, RIL_SERVER_SOCK_PATH, sizeof(addr.sun_path) - 1);
+
+	/* Unlink any existing socket for this session */
+	unlink(addr.sun_path);
+
+	retval =3D bind(server_sk, (struct sockaddr *) &addr, sizeof(addr));
+	g_assert(retval >=3D 0);
+
+	retval =3D listen(server_sk, 0);
+	g_assert(retval >=3D 0);
+
+	io =3D g_io_channel_unix_new(server_sk);
+	g_assert(io !=3D NULL);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_add_watch_full(io,	G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				on_socket_connected, data, NULL);
+
+	g_io_channel_unref(io);
+}
diff --git a/unit/rilmodem-test-server.h b/unit/rilmodem-test-server.h
new file mode 100644
index 0000000..ba8b43c
--- /dev/null
+++ b/unit/rilmodem-test-server.h
@@ -0,0 +1,40 @@
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
+#define RIL_SERVER_SOCK_PATH    "/tmp/unittestril"
+
+struct rilmodem_test_data {
+	const unsigned char *req_data;
+
+	const size_t req_size;
+
+	uint32_t rsp_error;
+	const unsigned char *rsp_data;
+	const size_t rsp_size;
+};
+
+typedef void (*ConnectFunc)(void *data);
+
+void rilmodem_test_server_close(void);
+
+void rilmodem_test_server_create(ConnectFunc connect,
+				const struct rilmodem_test_data *test_data,
+				void *data);
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
new file mode 100644
index 0000000..34b6737
--- /dev/null
+++ b/unit/test-rilmodem-sms.c
@@ -0,0 +1,261 @@
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
+#include <ofono/sms.h>
+#include <gril.h>
+
+#include "common.h"
+#include "ril_constants.h"
+#include "rilmodem-test-server.h"
+
+static GMainLoop *mainloop;
+
+static const struct ofono_sms_driver *smsdriver;
+
+struct rilmodem_sms_data {
+	GRil *ril;
+	struct ofono_modem *modem;
+	gconstpointer test_data;
+	struct ofono_sms *sms;
+};
+
+typedef gboolean (*StartFunc)(gpointer data);
+
+struct sms_data {
+	StartFunc start_func;
+	const struct ofono_phone_number ph;
+	gint param_int1;
+	gint param_int2;
+
+	struct rilmodem_test_data rtd;
+	enum ofono_error_type error_type;
+	gint cb_int1;
+	gint cb_int2;
+};
+
+static void sca_query_callback(const struct ofono_error *error,
+					const struct ofono_phone_number *ph,
+					gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D sd->error_type);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		g_assert(ph->type =3D=3D sd->ph.type);
+		g_assert(strcmp(ph->number, sd->ph.number) =3D=3D 0);
+	}
+
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean trigger_sca_query(gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+
+	g_assert(smsdriver->sca_query !=3D NULL);
+	smsdriver->sca_query(rsd->sms, sca_query_callback, rsd);
+
+	return FALSE;
+}
+
+/* RIL_REQUEST_GET_SMSC_ADDRESS */
+static const guchar req_get_smsc_address_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x08, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+
+/*
+ * RIL_REQUEST_GET_SMSC_ADDRESS reply with the following data:
+ *
+ * {type=3D145,number=3D34607003110}
+ */
+static const guchar rsp_get_smsc_address_data_1[] =3D {
+	0x12, 0x00, 0x00, 0x00, 0x22, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00,
+	0x36, 0x00, 0x30, 0x00, 0x37, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x22, 0x00, 0x2c, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x35, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct sms_data testdata_sca_query_valid_1 =3D {
+	.start_func =3D trigger_sca_query,
+	.ph =3D { .number =3D "34607003110", .type =3D 145 },
+	.rtd =3D {
+		.req_data =3D req_get_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_get_smsc_address_parcel_1),
+		.rsp_data =3D rsp_get_smsc_address_data_1,
+		.rsp_size =3D sizeof(rsp_get_smsc_address_data_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
+	.cb_int1 =3D 1,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* Declarations && Re-implementations of core functions. */
+void ril_sms_exit(void);
+void ril_sms_init(void);
+
+struct ofono_sms {
+	void *driver_data;
+};
+
+struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	struct ofono_sms *sms =3D g_new0(struct ofono_sms, 1);
+	int retval;
+
+	retval =3D smsdriver->probe(sms, OFONO_RIL_VENDOR_AOSP, rsd->ril);
+	g_assert(retval =3D=3D 0);
+
+	return sms;
+}
+
+int ofono_sms_driver_register(const struct ofono_sms_driver *d)
+{
+	if (smsdriver =3D=3D NULL)
+		smsdriver =3D d;
+
+	return 0;
+}
+
+void ofono_sms_set_data(struct ofono_sms *sms, void *data)
+{
+	sms->driver_data =3D data;
+}
+
+void *ofono_sms_get_data(struct ofono_sms *sms)
+{
+	return sms->driver_data;
+}
+
+void ofono_sms_register(struct ofono_sms *sms)
+{
+}
+
+void ofono_sms_driver_unregister(const struct ofono_sms_driver *d)
+{
+}
+
+void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char *=
pdu,
+							int len, int tpdu_len)
+{
+}
+
+void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char *p=
du,
+							int len, int tpdu_len)
+{
+}
+
+static void server_connect_cb(gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	/* This causes local impl of _create() to call driver's probe func. */
+	rsd->sms =3D ofono_sms_create(NULL, OFONO_RIL_VENDOR_AOSP,
+							"rilmodem", rsd);
+
+	/* add_idle doesn't work, read blocks main loop!!! */
+	g_assert(sd->start_func(rsd) =3D=3D FALSE);
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
+static void test_sms_func(gconstpointer data)
+{
+	const struct sms_data *sd =3D data;
+	struct rilmodem_sms_data *rsd;
+
+	ril_sms_init();
+
+	rsd =3D g_new0(struct rilmodem_sms_data, 1);
+
+	rsd->test_data =3D sd;
+
+	rilmodem_test_server_create(&server_connect_cb, &sd->rtd, rsd);
+
+	rsd->ril =3D g_ril_new(RIL_SERVER_SOCK_PATH, OFONO_RIL_VENDOR_AOSP);
+	g_assert(rsd->ril !=3D NULL);
+
+	mainloop =3D g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(mainloop);
+	g_main_loop_unref(mainloop);
+
+	smsdriver->remove(rsd->sms);
+	g_ril_unref(rsd->ril);
+	g_free(rsd);
+
+	rilmodem_test_server_close();
+
+	ril_sms_exit();
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
+	g_test_add_data_func("/testrilmodemsms/sca_query/valid/1",
+					&testdata_sca_query_valid_1,
+					test_sms_func);
+
+#endif
+	return g_test_run();
+}
-- =

2.1.4


--===============9138625273235083297==--

