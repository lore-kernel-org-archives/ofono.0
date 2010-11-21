Content-Type: multipart/mixed; boundary="===============4300345288396232135=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 2/2] unit: Add unit tests for STE modem
Date: Sun, 21 Nov 2010 23:03:01 +0100
Message-ID: <1290376981-4248-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1290376981-4248-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4300345288396232135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Add unit tests for AT handling in stemodem/radio-settings.c and
stemodem/gprs-context.c. The tests integrates with gatchat
and verifies AT commands sent to modem and simulates modem
responses.
---
 Makefile.am     |   15 ++-
 unit/test-ste.c |  554 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 568 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-ste.c

diff --git a/Makefile.am b/Makefile.am
index e505a39..413e42f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -437,7 +437,7 @@ dist_man_MANS =3D doc/ofonod.8
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-ste
 =

 unit_objects =3D
 =

@@ -480,6 +480,19 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_=
sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_ste_SOURCES =3D unit/test-ste.c $(gatchat_sources) \
+					$(gdbus_sources) $(local_headers) \
+					drivers/stemodem/stemodem.h \
+					drivers/atmodem/atutil.h \
+					drivers/atmodem/atutil.c \
+					drivers/stemodem/radio-settings.c \
+					drivers/stemodem/gprs-context.c \
+					drivers/stemodem/caif_socket.h \
+					drivers/stemodem/if_caif.h
+
+unit_test_ste_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+unit_objects +=3D $(unit_test_ste_OBJECTS)
+
 noinst_PROGRAMS +=3D tools/huawei-audio
 =

 tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/huawei-audio.c
diff --git a/unit/test-ste.c b/unit/test-ste.c
new file mode 100644
index 0000000..408e592
--- /dev/null
+++ b/unit/test-ste.c
@@ -0,0 +1,554 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gatresult.h>
+#include <log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs-context.h>
+#include <drivers/stemodem/stemodem.h>
+#include <drivers/stemodem/caif_rtnl.h>
+
+/* Generic test code decls */
+static GAtChat *chat;
+static GMainLoop *event_loop;
+static int phone_fd;
+
+#define ASSERT_AT(s) g_assert(assert_at(s));
+
+/* Send a simulated AT response */
+static void at_response(char *resp)
+{
+	int r;
+
+	/* Send AT response to g_at_chat and give main look a kick to run
+	 * one iteration.
+	 */
+	r =3D write(phone_fd, resp, strlen(resp));
+	g_main_iteration(TRUE);
+}
+
+static gboolean assert_at(char *match)
+{
+	char req[256];
+	int r;
+
+	g_main_iteration(TRUE);
+
+	/* Read what g_at_chan has written to "modem" */
+	r =3D read(phone_fd, req, sizeof(req));
+
+	if (r > 1)
+		req[r-1] =3D 0;
+
+	if (strcmp(match, req) =3D=3D 0)
+		return TRUE;
+
+	g_print("AT request did not match:%s !=3D %s\n", match, req);
+	return FALSE;
+}
+
+/* stubs from src/radio-settings.c */
+struct ofono_radio_settings;
+const struct ofono_radio_settings_driver *radio_settings_driver;
+void *radio_settings_data;
+
+void ofono_radio_settings_register(struct ofono_radio_settings *rs)
+{
+}
+
+void ofono_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+}
+
+void ofono_radio_settings_set_data(struct ofono_radio_settings *rs, void *=
data)
+{
+	radio_settings_data =3D data;
+}
+
+void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs)
+{
+	return radio_settings_data;
+}
+
+int ofono_radio_settings_driver_register(
+				const struct ofono_radio_settings_driver *d)
+{
+	radio_settings_driver =3D d;
+	return 0;
+}
+
+void ofono_radio_settings_driver_unregister(
+				const struct ofono_radio_settings_driver *d)
+{
+}
+
+/* stubs from src/gprs-context.c */
+struct ofono_gprs_context;
+const struct ofono_gprs_context_driver *gprs_context_driver;
+void *gprs_context_data;
+
+int caif_rtnl_create_interface(int type, int connid,
+		gboolean loop, caif_rtnl_create_cb_t cb, void *user_data)
+{
+	cb(0, "caif0", user_data);
+	return 0;
+}
+int caif_rtnl_delete_interface(int ifid)
+{
+	return 0;
+}
+
+int caif_rtnl_init(void)
+{
+	return 0;
+}
+
+void caif_rtnl_exit(void)
+{
+}
+
+void ofono_gprs_context_remove(struct ofono_gprs_context *rs)
+{
+}
+
+void ofono_gprs_context_set_data(struct ofono_gprs_context *rs, void *data)
+{
+	gprs_context_data =3D data;
+}
+
+void *ofono_gprs_context_get_data(struct ofono_gprs_context *rs)
+{
+	return gprs_context_data;
+}
+
+int ofono_gprs_context_driver_register(
+				const struct ofono_gprs_context_driver *d)
+{
+	gprs_context_driver =3D d;
+	return 0;
+}
+
+void ofono_gprs_context_driver_unregister(
+				const struct ofono_gprs_context_driver *d)
+{
+}
+
+void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+}
+
+/* Test Fixture for context activation */
+static struct ofono_gprs_primary_context ctx =3D {
+	5, 1, "apn", "user", "pwd", OFONO_GPRS_PROTO_IP
+};
+
+/*
+ * These vars are used to validate test case and are
+ * checked in callback functions.
+ */
+static enum ofono_error_type expected_errtype;
+static int expected_error;
+
+static void gprs_context_up_cb(const struct ofono_error *error,
+				const char *interface, ofono_bool_t static_ip,
+				const char *address, const char *netmask,
+				const char *gw, const char **dns, void *data)
+{
+	g_assert_cmpint(expected_errtype, =3D=3D, error->type);
+}
+
+static void ofono_generic_cb(const struct ofono_error *error, void *data)
+{
+	g_assert_cmpint(expected_errtype, =3D=3D, error->type);
+	g_assert_cmpint(expected_error, =3D=3D, error->error);
+
+}
+
+static void gprs_activate_helper(void)
+{
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	gprs_context_driver->
+		activate_primary(0, &ctx,
+				 (ofono_gprs_context_up_cb_t)
+				 gprs_context_up_cb, 0);
+
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EPPSD=3D1,1,5");
+	at_response(
+			"\r\n"
+			"<?xml version=3D\"1.0\"?>\r\n"
+			"<connection_parameters>\r\n"
+			"<ip_address>10.64.151.14</ip_address>\r\n"
+			"<subnet_mask>255.255.255.255</subnet_mask>\r\n"
+			"<mtu>1500</mtu>\r\n"
+			"<dns_server>10.64.148.4</dns_server>\r\n"
+			"<dns_server>10.64.148.5</dns_server>\r\n"
+			"</connection_parameters>\r\n"
+			"\r\nOK\r\n");
+}
+
+static void test_gprs_normal(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+	gprs_activate_helper();
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deactivate(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+	gprs_activate_helper();
+	gprs_context_driver->
+		deactivate_primary(0, ctx.cid,
+				 (ofono_gprs_context_cb_t)
+				 ofono_generic_cb, 0);
+	ASSERT_AT("AT*EPPSD=3D0,1,5");
+	at_response("\r\nOK\r\n");
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_nw_deact(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+	gprs_activate_helper();
+	at_response("\r\n+CGEV: NW DEACT \r\n");
+
+	ASSERT_AT("AT+CGACT?");
+
+	at_response("\r\n+CGACT: 5,0\r\nOK\r\n");
+
+	ste_gprs_context_exit();
+}
+
+
+
+static void test_gprs_deactivate_fail(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+	gprs_activate_helper();
+	gprs_context_driver->
+		deactivate_primary(0, ctx.cid,
+				 (ofono_gprs_context_cb_t)
+				 ofono_generic_cb, 0);
+	ASSERT_AT("AT*EPPSD=3D0,1,5");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deactivate_err(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	gprs_context_driver->
+		deactivate_primary(0, ctx.cid,
+				 (ofono_gprs_context_cb_t)
+				 ofono_generic_cb, 0);
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deact_fail_then_ok(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+
+	gprs_activate_helper();
+	gprs_context_driver->
+		deactivate_primary(0, ctx.cid,
+				 (ofono_gprs_context_cb_t)
+				 ofono_generic_cb, 0);
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->
+		deactivate_primary(0, ctx.cid,
+				 (ofono_gprs_context_cb_t)
+				 ofono_generic_cb, 0);
+	ASSERT_AT("AT*EPPSD=3D0,1,5");
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	at_response("\r\nOK\r\n");
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_eppsd_err(void)
+{
+	ste_gprs_context_init();
+
+	gprs_context_driver->probe(NULL, 0, chat);
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	gprs_context_driver->
+		activate_primary(0, &ctx,
+				 (ofono_gprs_context_up_cb_t)
+				 gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EPPSD=3D1,1,5");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_cgdcont_err(void)
+{
+	ste_gprs_context_init();
+	gprs_context_driver->probe(NULL, 0, chat);
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	gprs_context_driver->
+		activate_primary(0, &ctx,
+				 (ofono_gprs_context_up_cb_t)
+				 gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_xmlerr(void)
+{
+	ste_gprs_context_init();
+	gprs_context_driver->probe(NULL, 0, chat);
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	gprs_context_driver->
+		activate_primary(0, &ctx,
+				 (ofono_gprs_context_up_cb_t)
+				 gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EPPSD=3D1,1,5");
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response(
+			"\r\n"
+			"<?xml version=3D\"1.0\"?>\r\n"
+			"<connection_parameters>\r\n"
+			"XML-ERROR"
+			"\r\nOK\r\n");
+	gprs_context_driver->remove(gprs_context_data);
+
+	ste_gprs_context_exit();
+}
+
+static enum ofono_radio_access_mode expected_mode;
+
+static void radio_rat_mode_query_callback(const struct ofono_error *error,
+					enum ofono_radio_access_mode mode,
+					void *data)
+{
+	g_assert_cmpint(expected_errtype, =3D=3D, error->type);
+	g_assert_cmpint(expected_mode, =3D=3D, mode);
+}
+
+
+#define QUERY_RAT()					\
+	do {						\
+		radio_settings_driver->		\
+			query_rat_mode(0,		\
+				(ofono_radio_settings_rat_mode_query_cb_t) \
+					radio_rat_mode_query_callback, 0); \
+		ASSERT_AT("AT+CFUN?");			\
+	} while (0)
+
+static void test_radiosettings_all(void)
+{
+	ste_radio_settings_init();
+
+	radio_settings_driver->probe(NULL, 0, chat);
+
+	/* Normal Cases */
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+	QUERY_RAT();
+	at_response("\r\n+CFUN: 1\r\n\r\nOK\r\n");
+
+	QUERY_RAT();
+	expected_mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+	at_response("\r\n+CFUN: 5\r\n\r\nOK\r\n");
+
+	QUERY_RAT();
+	expected_mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+	at_response("\r\n+CFUN: 6\r\n\r\nOK\r\n");
+
+	/* Unexpected values */
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_mode =3D -1;
+	QUERY_RAT();
+	at_response("\r\n+CFUN: 0\r\n\r\nOK\r\n");
+
+	QUERY_RAT();
+	at_response("\r\n+CFUN: 4\r\n\r\nOK\r\n");
+
+	QUERY_RAT();
+	at_response("\r\n+CFUN: 11\r\n\r\nOK\r\n");
+
+	/* Error cases */
+	QUERY_RAT();
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_mode =3D -1;
+	at_response("\r\nERROR\r\n");
+
+	QUERY_RAT();
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	ste_radio_settings_exit();
+}
+
+static void ste_test_add()
+{
+	g_test_add_func("/ste/gprs_nw_deact", test_gprs_nw_deact);
+	g_test_add_func("/ste/gprs_normal", test_gprs_normal);
+	g_test_add_func("/ste/gprs_cgdcont_err", test_gprs_cgdcont_err);
+	g_test_add_func("/ste/gprs_xmlerr", test_gprs_xmlerr);
+	g_test_add_func("/ste/gprs_deact", test_gprs_deactivate);
+	g_test_add_func("/ste/gprs_deact_err", test_gprs_deactivate_err);
+	g_test_add_func("/ste/gprs_deact_err_ok",
+			test_gprs_deact_fail_then_ok);
+	g_test_add_func("/ste/gprs_deact_fail", test_gprs_deactivate_fail);
+	g_test_add_func("/ste/gprs_eppsd_err", test_gprs_eppsd_err);
+	g_test_add_func("/ste/radiosettings_all", test_radiosettings_all);
+	return;
+}
+
+void ofono_debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	if (g_test_verbose())
+		vprintf(format, ap);
+	va_end(ap);
+}
+
+void ofono_error(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	vprintf(format, ap);
+	va_end(ap);
+}
+
+static void ste_debug(const char *str, void *user_data)
+{
+	if (g_test_verbose())
+		g_print("%s\n", str);
+}
+
+int main(int argc, char **argv)
+{
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	int pair[2];
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, PF_UNIX, pair) < 0)
+		goto err;
+
+	/*
+	 * Give one end of the socket pair, for simulating modem
+	 * responses.
+	 */
+	phone_fd =3D pair[1];
+
+
+	/* And the other end of the socket pair to at_chan */
+	channel =3D g_io_channel_unix_new(pair[0]);
+	if (!channel)
+		goto err;
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new_blocking(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+	g_at_chat_set_debug(chat, ste_debug, NULL);
+
+	event_loop =3D g_main_loop_new(NULL, FALSE);
+
+	g_test_init(&argc, &argv, NULL);
+	ste_test_add();
+	g_test_run();
+
+	return 0;
+
+err:
+	g_print("error\n");
+	return 10;
+}
-- =

1.7.0.4


--===============4300345288396232135==--

