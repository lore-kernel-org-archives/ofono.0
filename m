Content-Type: multipart/mixed; boundary="===============4612068477753295130=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH] unit: Add unit test for stemodem driver
Date: Mon, 14 Mar 2011 13:27:51 +0200
Message-ID: <1300102071-19076-1-git-send-email-lasse.kunnasluoto@tieto.com>
In-Reply-To: <1297759781-3113-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4612068477753295130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
Hi,

Here is an updated version of STE unit test, originally done by Marit (sent=
 on 15th of Feb).
This one should apply smoothly =


BR,
Lasse

 Makefile.am     |   17 +-
 unit/test-ste.c | 1165 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 1181 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-ste.c

diff --git a/Makefile.am b/Makefile.am
index a784636..65a5e67 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -515,7 +515,7 @@ dist_man_MANS =3D doc/ofonod.8
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-ste
 =

 unit_objects =3D
 =

@@ -556,6 +556,21 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_=
sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_ste_SOURCES =3D unit/test-ste.c $(gatchat_sources) \
+                                       $(gdbus_sources) $(local_headers) \
+                                       src/common.c src/util.c \
+                                       drivers/stemodem/stemodem.h \
+                                       drivers/atmodem/atutil.h \
+                                       drivers/atmodem/atutil.c \
+                                       drivers/stemodem/radio-settings.c \
+                                       drivers/stemodem/gprs-context.c \
+                                       drivers/stemodem/voicecall.c \
+                                       drivers/stemodem/caif_socket.h \
+                                       drivers/stemodem/if_caif.h
+
+unit_test_ste_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+unit_objects +=3D $(unit_test_ste_OBJECTS)
+
 if TOOLS
 noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable tools/get-locati=
on
 =

diff --git a/unit/test-ste.c b/unit/test-ste.c
new file mode 100644
index 0000000..20434b4
--- /dev/null
+++ b/unit/test-ste.c
@@ -0,0 +1,1165 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+#include <ofono/voicecall.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs-context.h>
+#include <drivers/stemodem/stemodem.h>
+#include <drivers/stemodem/caif_rtnl.h>
+#include "common.h"
+
+/* Generic test code decls */
+static GAtChat *chat;
+static GMainLoop *event_loop;
+static int phone_fd;
+
+#define ASSERT_AT(s) g_assert(assert_at(s));
+#define QUERY_RAT()							\
+	do {								\
+		radio_settings_driver->					\
+			query_rat_mode(0,				\
+				(ofono_radio_settings_rat_mode_query_cb_t)\
+				radio_rat_mode_query_callback, 0);	\
+		ASSERT_AT("AT+CFUN?");					\
+	} while (0)
+
+/* Send a simulated AT response */
+static void at_response(char *resp)
+{
+	int r;
+
+	/*
+	 * Send AT response to g_at_chat and give main look a kick to run
+	 * one iteration.
+	 */
+	r =3D write(phone_fd, resp, strlen(resp));
+	g_assert(r > 0);
+	(void)g_main_context_iteration(NULL, TRUE);
+}
+
+static gboolean assert_at(char *match)
+{
+	char req[256];
+	int r;
+
+	if (g_main_context_iteration(NULL, TRUE) =3D=3D TRUE) {
+
+		/* Read what g_at_chan has written to "modem" */
+		r =3D read(phone_fd, req, sizeof(req));
+
+		if (r > 1)
+			req[r-1] =3D 0;
+
+		if (strcmp(match, req) =3D=3D 0)
+			return TRUE;
+	}
+
+	g_print("AT request did not match:%s !=3D %s\n", match, req);
+	return FALSE;
+}
+
+/* Stubs from src/voicecall.c */
+struct ofono_voicecall;
+const struct ofono_voicecall_driver *voicecall_driver;
+void *voicecall_data;
+static unsigned int expected_id;
+static int expected_status;
+static char expected_number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
+static int expected_reason;
+
+void ofono_voicecall_register(struct ofono_voicecall *vc)
+{
+}
+
+void ofono_voicecall_remove(struct ofono_voicecall *vc)
+{
+}
+
+int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
+{
+	voicecall_driver =3D d;
+	return 0;
+}
+
+void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d)
+{
+}
+
+void ofono_voicecall_set_data(struct ofono_voicecall *vc, void *data)
+{
+	voicecall_data =3D data;
+}
+
+void *ofono_voicecall_get_data(struct ofono_voicecall *vc)
+{
+	return voicecall_data;
+}
+
+void ofono_voicecall_notify(struct ofono_voicecall *vc,
+				const struct ofono_call *call)
+{
+	g_assert_cmpint(expected_id, =3D=3D, call->id);
+	g_assert_cmpint(expected_status, =3D=3D, call->status);
+	g_assert_cmpstr(expected_number, =3D=3D, call->phone_number.number);
+}
+
+void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
+					enum ofono_disconnect_reason reason,
+					const struct ofono_error *error)
+{
+	g_assert_cmpint(expected_id, =3D=3D, id);
+	g_assert_cmpint(expected_reason, =3D=3D, reason);
+	g_assert(error =3D=3D NULL);
+}
+
+/* Stubs from src/radio-settings.c */
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
+		const struct ofono_radio_settings_driver *d)
+{
+	radio_settings_driver =3D d;
+	return 0;
+}
+
+void ofono_radio_settings_driver_unregister(
+		const struct ofono_radio_settings_driver *d)
+{
+}
+/* Stubs from src/gprs-context.c */
+struct ofono_gprs_context {
+	struct ofono_gprs *gprs;
+	enum ofono_gprs_context_type type;
+	ofono_bool_t inuse;
+	const struct ofono_gprs_context_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+struct ofono_gprs_context *gc;
+const struct ofono_gprs_context_driver *gprs_context_driver;
+void *gprs_context_data;
+
+int caif_rtnl_create_interface(int type, int connid, int loop,
+				caif_rtnl_create_cb_t cb, void *user_data)
+{
+	cb(0, "caif0", user_data);
+	return 0;
+}
+
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
+		const struct ofono_gprs_context_driver *d)
+{
+	gprs_context_driver =3D d;
+	return 0;
+}
+
+void ofono_gprs_context_driver_unregister(
+		const struct ofono_gprs_context_driver *d)
+{
+}
+
+struct ofono_gprs_context *ofono_gprs_context_create(struct ofono_modem *m=
odem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_gprs_context *gc;
+
+	gc =3D g_try_new0(struct ofono_gprs_context, 1);
+	if (gc =3D=3D NULL)
+		return NULL;
+
+	return gc;
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
+static int expected_error, expected_cid;
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
+}
+
+void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	g_assert_cmpint(expected_cid, =3D=3D, cid);
+}
+
+static void gprs_activate_helper()
+{
+	char buf[128];
+
+	ste_gprs_context_init();
+	gc =3D ofono_gprs_context_create(NULL, 0, NULL, NULL);
+	gprs_context_driver->probe(gc, 0, chat);
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	gprs_context_driver->activate_primary(0, &ctx,
+						(ofono_gprs_context_up_cb_t)
+						gprs_context_up_cb, 0);
+
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%x,5", (unsigned int)gc);
+
+	ASSERT_AT(buf);
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
+	gprs_activate_helper();
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deactivate(void)
+{
+	char buf[128];
+
+	gprs_activate_helper();
+	gprs_context_driver->deactivate_primary(0, ctx.cid,
+						(ofono_gprs_context_cb_t)
+						ofono_generic_cb, 0);
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	at_response("\r\nOK\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_nw_deact(void)
+{
+	expected_cid =3D 5;
+
+	gprs_activate_helper();
+
+	at_response("\r\n+CGEV: NW DEACT \"IP\", \"10.252.66.34\", 5\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deactivate_fail(void)
+{
+	char buf[128];
+	gprs_activate_helper();
+
+	gprs_context_driver->deactivate_primary(0, ctx.cid,
+						(ofono_gprs_context_cb_t)
+						ofono_generic_cb, 0);
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deactivate_err(void)
+{
+	char buf[128];
+
+	gprs_activate_helper();
+	gprs_context_driver->deactivate_primary(0, ctx.cid,
+						(ofono_gprs_context_cb_t)
+						ofono_generic_cb, 0);
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response("\r\nERROR\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_deact_fail_then_ok(void)
+{
+	char buf[128];
+	gprs_activate_helper();
+
+	gprs_context_driver->deactivate_primary(0, ctx.cid,
+						(ofono_gprs_context_cb_t)
+						ofono_generic_cb, 0);
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->deactivate_primary(0, ctx.cid,
+						(ofono_gprs_context_cb_t)
+						ofono_generic_cb, 0);
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	at_response("\r\nOK\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_eppsd_err(void)
+{
+	char buf[128];
+
+	gprs_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	gprs_context_driver->activate_primary(0, &ctx,
+						(ofono_gprs_context_up_cb_t)
+						gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_cgdcont_err(void)
+{
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	gprs_activate_helper();
+	gprs_context_driver->activate_primary(0, &ctx,
+						(ofono_gprs_context_up_cb_t)
+						gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
+	ste_gprs_context_exit();
+}
+
+static void test_gprs_xmlerr(void)
+{
+	char buf[128];
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	gprs_activate_helper();
+	gprs_context_driver->activate_primary(0, &ctx,
+						(ofono_gprs_context_up_cb_t)
+						gprs_context_up_cb, 0);
+	ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
+	at_response("\r\nOK\r\n");
+
+	ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
+	at_response("\r\nOK\r\n");
+
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%x,5", (unsigned int)gc);
+	ASSERT_AT(buf);
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response(
+			"\r\n"
+			"<?xml version=3D\"1.0\"?>\r\n"
+			"<connection_parameters>\r\n"
+			"XML-ERROR"
+			"\r\nOK\r\n");
+
+	gprs_context_driver->remove(gprs_context_data);
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
+	radio_settings_driver->remove(radio_settings_data);
+	ste_radio_settings_exit();
+}
+
+/* Test Phone number */
+static struct ofono_phone_number ph =3D {"4425993003739", 145 };
+
+static void voicecall_activate_helper(void)
+{
+	ste_voicecall_init();
+	voicecall_driver->probe(NULL, 0, chat);
+
+	ASSERT_AT("AT*ECAM=3D2");
+	at_response("\r\nOK\r\n");
+}
+
+static void test_voicecall_dial(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_dial_colp(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993003739");
+	at_response("\r\n+COLP: \"+4425993003739\",129\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_dial_erroneous_colp(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993003739");
+	at_response("\r\n+COLP:\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_dial_fail(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 423; /* Network problem */
+	at_response("\r\n+CME ERROR:423\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_dial_busy(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response("\r\nBUSY\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_dial_no_dialtone(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	voicecall_driver->dial(0, &ph, 0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATD+4425993003739;");
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response("\r\nNO DIALTONE\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_hangup(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Hangup */
+	voicecall_driver->hangup_active(0,
+					(ofono_voicecall_cb_t)ofono_generic_cb,
+					0);
+	ASSERT_AT("AT+CHUP");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_hangup_fail(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	/* Hangup */
+	voicecall_driver->hangup_active(0,
+					(ofono_voicecall_cb_t)ofono_generic_cb,
+					0);
+	ASSERT_AT("AT+CHUP");
+	expected_errtype =3D OFONO_ERROR_TYPE_CME;
+	expected_error =3D 100;
+	at_response("\r\n+CME ERROR:100\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_hold(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Hold Call */
+	voicecall_driver->hold_all_active(0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D2");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_release_all_held(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Release Call */
+	voicecall_driver->release_all_held(0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D0");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_release_all_active(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Release Call */
+	voicecall_driver->release_all_active(0,
+				(ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D1");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_answer(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	/* Answer Call */
+	voicecall_driver->answer(0, (ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATA");
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_answer_error(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	/* Answer Call */
+	voicecall_driver->answer(0, (ofono_voicecall_cb_t)ofono_generic_cb, 0);
+	ASSERT_AT("ATA");
+	expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
+	expected_error =3D 0;
+	at_response("\r\nNO CARRIER\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_multiparty(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Multiparty */
+	voicecall_driver->create_multiparty(0,
+				(ofono_voicecall_cb_t) ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D3");
+	at_response("\r\nOK\r\n");
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_transfer(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Transfer */
+	voicecall_driver->transfer(0,
+				(ofono_voicecall_cb_t) ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D4");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_deflect(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Transfer */
+	voicecall_driver->deflect(0, &ph,
+				(ofono_voicecall_cb_t) ofono_generic_cb, 0);
+	ASSERT_AT("AT+CTFR=3D\"4425993003739\",145");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_send_tones(void)
+{
+	const char *test =3D "8,9";
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+	/* Send DTMF tone */
+	voicecall_driver->send_tones(0, test,
+				(ofono_voicecall_cb_t) ofono_generic_cb, 0);
+	ASSERT_AT("AT+VTS=3D8,9");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_release_specific(void)
+{
+	/* Voice call initialisation */
+	voicecall_activate_helper();
+
+	expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
+	expected_error =3D 0;
+
+	/* Release Call */
+	voicecall_driver->release_specific(0, 3,
+				(ofono_voicecall_cb_t) ofono_generic_cb, 0);
+	ASSERT_AT("AT+CHLD=3D13");
+	at_response("\r\nOK\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+
+static void test_voicecall_ecav_alerting(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_INCOMING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,6,1,,,\"+4425993005133\",145\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_alerting_number_withheld(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_INCOMING;
+	strcpy(expected_number, "");
+	at_response("\r\n*ECAV: 1,6,1\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_waiting(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_WAITING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,5,1,,,\"+4425993005133\",145\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_waiting_number_withheld(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_WAITING;
+	strcpy(expected_number, "");
+	at_response("\r\n*ECAV: 1,5,1\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_calling(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_idle(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	expected_reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+	at_response("\r\n*ECAV: 1,0,1,08,016\r\n");
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_connecting(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	expected_status =3D CALL_STATUS_ALERTING;
+	at_response("\r\n*ECAV: 1,2,1\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_active(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	expected_status =3D CALL_STATUS_ACTIVE;
+	at_response("\r\n*ECAV: 1,3,1\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_held(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	expected_status =3D CALL_STATUS_HELD;
+	at_response("\r\n*ECAV: 1,4,1\r\n");
+
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
+}
+
+static void test_voicecall_ecav_busy(void)
+{
+	voicecall_activate_helper();
+
+	expected_id =3D 1;
+	expected_status =3D CALL_STATUS_DIALING;
+	sprintf(expected_number, "+4425993005133");
+	at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
+
+	expected_reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+	at_response("\r\n*ECAV: 1,7,1\r\n");
+	voicecall_driver->remove(voicecall_data);
+	ste_voicecall_exit();
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
+	g_test_add_func("/ste/test_voicecall_dial", test_voicecall_dial);
+	g_test_add_func("/ste/test_voicecall_dial_colp",
+			test_voicecall_dial_colp);
+	g_test_add_func("/ste/test_voicecall_dial_erroneous_colp",
+			test_voicecall_dial_erroneous_colp);
+	g_test_add_func("/ste/test_voicecall_dial_fail",
+			test_voicecall_dial_fail);
+	g_test_add_func("/ste/test_voicecall_dial_busy",
+			test_voicecall_dial_busy);
+	g_test_add_func("/ste/test_voicecall_hangup", test_voicecall_hangup);
+	g_test_add_func("/ste/test_voicecall_hangup_fail",
+			test_voicecall_hangup_fail);
+	g_test_add_func("/ste/test_voicecall_hold", test_voicecall_hold);
+	g_test_add_func("/ste/test_voicecall_release_all_held",
+			test_voicecall_release_all_held);
+	g_test_add_func("/ste/test_voicecall_release_all_active",
+			test_voicecall_release_all_active);
+	g_test_add_func("/ste/test_voicecall_answer", test_voicecall_answer);
+	g_test_add_func("/ste/test_voicecall_dial_no_dialtone",
+			test_voicecall_dial_no_dialtone);
+	g_test_add_func("/ste/test_voicecall_answer_error",
+			test_voicecall_answer_error);
+	g_test_add_func("/ste/test_voicecall_multiparty",
+			test_voicecall_multiparty);
+	g_test_add_func("/ste/test_voicecall_transfer",
+			test_voicecall_transfer);
+	g_test_add_func("/ste/test_voicecall_deflect", test_voicecall_deflect);
+	g_test_add_func("/ste/test_voicecall_send_tones",
+			test_voicecall_send_tones);
+	g_test_add_func("/ste/test_voicecall_release_specific",
+			test_voicecall_release_specific);
+	g_test_add_func("/ste/test_voicecall_ecav_alerting",
+			test_voicecall_ecav_alerting);
+	g_test_add_func("/ste/test_voicecall_ecav_alerting_number_withheld",
+			test_voicecall_ecav_alerting_number_withheld);
+	g_test_add_func("/ste/test_voicecall_ecav_waiting",
+			test_voicecall_ecav_waiting);
+	g_test_add_func("/ste/test_voicecall_ecav_waiting_number_withheld",
+			test_voicecall_ecav_waiting_number_withheld);
+	g_test_add_func("/ste/test_voicecall_ecav_calling",
+			test_voicecall_ecav_calling);
+	g_test_add_func("/ste/test_voicecall_ecav_held",
+			test_voicecall_ecav_held);
+	g_test_add_func("/ste/test_voicecall_ecav_busy",
+			test_voicecall_ecav_busy);
+	g_test_add_func("/ste/test_voicecall_ecav_idle",
+			test_voicecall_ecav_idle);
+	g_test_add_func("/ste/test_voicecall_ecav_connecting",
+			test_voicecall_ecav_connecting);
+	g_test_add_func("/ste/test_voicecall_ecav_active",
+			test_voicecall_ecav_active);
+	return;
+}
+
+void ofono_debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	if (g_test_verbose())
+		vprintf(format, ap);
+
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
+	GIOChannel *channel =3D NULL;
+	GAtSyntax *syntax =3D NULL;
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
+	/* And the other end of the socket pair to at_chan */
+	channel =3D g_io_channel_unix_new(pair[0]);
+	if (channel =3D=3D NULL)
+		goto err;
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	if (syntax =3D=3D NULL)
+		goto err;
+
+	chat =3D g_at_chat_new_blocking(channel, syntax);
+	if (chat =3D=3D NULL)
+		goto err;
+
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
+	g_main_loop_unref(event_loop);
+	g_at_chat_unref(chat);
+
+	return 0;
+
+err:
+	if (syntax !=3D NULL)
+		g_at_syntax_unref(syntax);
+
+	if (channel !=3D NULL)
+		g_io_channel_unref(channel);
+
+	g_print("error\n");
+	return 10;
+}
-- =

1.7.0.4


--===============4612068477753295130==--

