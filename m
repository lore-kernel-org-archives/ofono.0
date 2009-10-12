Content-Type: multipart/mixed; boundary="===============1840708683042669149=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Mon, 12 Oct 2009 23:35:59 +0200
Message-ID: <1255383359-31470-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1840708683042669149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
here's a one-big-patch that adds the DataConnectionManager interface
according to doc/dataconnectionmanager-api.txt without any glue for
the multiplexer or PPP setup.  Only AT backend is implemented.

One issue with the AT implementation of the api is that "Powered" (a
read-write property) can be set independently of "Attached" (read-only
property) and remain set when "Attached" is clear.  The semantics would
be that the network doesn't have resources to let the modem attach,
but the modem waits for the resources to become available and then
attaches.  On AT the modem is in this state only when executing +CGATT,
so currently the code will rerun +CGATT as soon as the previous one
returns with error, probably starving other commands.  A possible
workaround would be for "Powered" to flip back to False after the modem
fails to attach once, or give up on having separate properties.
Alternatively we could re-try to attach periodically but on one modem
I've tried +CGATT fails after about 1 minute (that's the Calypso) and
on another only about 0.5s (Nokia phones with AT emulation).

When "Powered"  is set and "RoamingAllowed" is clear and we manage to
attach and find that we're roaming, ofono resets "Powered".

We may want to catch the user trying to dial *99***1# which is the
backwards compatibility quirk for old modems (same way ofono parses
USSD strings).
---
 Makefile.am                       |   12 +-
 doc/dataconnectionmanager-api.txt |    2 +-
 drivers/atmodem/atmodem.c         |    2 +
 drivers/atmodem/atmodem.h         |    3 +
 drivers/atmodem/data-connection.c |  649 ++++++++++++++++++++++
 include/data-connection.h         |   89 +++
 include/types.h                   |   10 +
 plugins/phonesim.c                |    3 +
 src/data-connection.c             | 1074 +++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                       |    2 +
 10 files changed, 1841 insertions(+), 5 deletions(-)
 create mode 100644 drivers/atmodem/data-connection.c
 create mode 100644 include/data-connection.h
 create mode 100644 src/data-connection.c

diff --git a/Makefile.am b/Makefile.am
index cf84bf7..600dd08 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -10,7 +10,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/phonebook.h include/ssn.h include/ussd.h \
 			include/sms.h include/sim.h include/message-waiting.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
-			include/cbs.h include/call-volume.h
+			include/cbs.h include/call-volume.h \
+			include/data-connection.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -108,7 +109,8 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/call-volume.c \
 				drivers/atmodem/vendor.h \
 				drivers/atmodem/atutil.h \
-				drivers/atmodem/atutil.c
+				drivers/atmodem/atutil.c \
+				drivers/atmodem/data-connection.c
 =

 builtin_modules +=3D calypsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
@@ -165,7 +167,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/ssn.c src/call-barring.c src/sim.c \
 			src/phonebook.c src/history.c src/message-waiting.c \
 			src/simutil.h src/simutil.c src/storage.h \
-			src/storage.c src/cbs.c src/watch.c src/call-volume.c
+			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
+			src/data-connection.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) \
 			@GLIB_LIBS@ @GTHREAD_LIBS@ @DBUS_LIBS@ -ldl
@@ -197,7 +200,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt \
 		doc/manager-api.txt doc/modem-api.txt doc/network-api.txt \
 			doc/voicecallmanager-api.txt doc/voicecall-api.txt \
 			doc/call-forwarding-api.txt doc/call-settings-api.txt \
-			doc/call-meter-api.txt
+			doc/call-meter-api.txt \
+			doc/dataconnectionmanager-api.txt
 =

 test_files =3D test/test-manager test/test-modem test/test-voicecall \
 		test/test-network-registration test/test-phonebook \
diff --git a/doc/dataconnectionmanager-api.txt b/doc/dataconnectionmanager-=
api.txt
index e2bcf7c..982005e 100644
--- a/doc/dataconnectionmanager-api.txt
+++ b/doc/dataconnectionmanager-api.txt
@@ -42,7 +42,7 @@ Signals		PropertyChanged(string property, variant value)
 =

 Properties	array{object} PrimaryContexts [readonly]
 =

-			List of all primary contexts objects.
+			List of all primary context objects.
 =

 		boolean Attached [readonly]
 =

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index 7cfcf6a..026d8e0 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -48,6 +48,7 @@ static int atmodem_init(void)
 	at_netreg_init();
 	at_cbs_init();
 	at_call_volume_init();
+	at_data_connection_init();
 =

 	return 0;
 }
@@ -68,6 +69,7 @@ static void atmodem_exit(void)
 	at_voicecall_exit();
 	at_cbs_exit();
 	at_call_volume_exit();
+	at_data_connection_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(atmodem, "AT modem driver", VERSION,
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 8c61073..46c3780 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -62,3 +62,6 @@ extern void at_cbs_exit();
 =

 extern void at_call_volume_init();
 extern void at_call_volume_exit();
+
+extern void at_data_connection_init();
+extern void at_data_connection_exit();
diff --git a/drivers/atmodem/data-connection.c b/drivers/atmodem/data-conne=
ction.c
new file mode 100644
index 0000000..77e9fa2
--- /dev/null
+++ b/drivers/atmodem/data-connection.c
@@ -0,0 +1,649 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/data-connection.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "atmodem.h"
+
+static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+struct data_connection_data {
+	GSList *primary_id_range;
+	GSList *contexts;
+	GSList *new_contexts; /* Not yet defined contexts */
+	GAtChat *chat;
+};
+
+struct set_attached_req {
+	struct ofono_data_connection *dc;
+	int attached;
+	ofono_data_connection_cb_t cb;
+	void *data;
+};
+
+struct set_active_req {
+	struct ofono_data_connection *dc;
+	struct ofono_data_context *ctx;
+	int active;
+	ofono_data_connection_cb_t cb;
+	void *data;
+};
+
+static gint context_id_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_data_context *ctxa =3D a;
+	const gint *id =3D b;
+
+	return ctxa->id - *id;
+}
+
+static gint context_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_data_context *ctxa =3D a;
+	const struct ofono_data_context *ctxb =3D a;
+
+	return ctxa->id - ctxb->id;
+}
+
+static void context_free(struct ofono_data_context *ctx)
+{
+	if (ctx->apn)
+		g_free(ctx->apn);
+
+	if (ctx->username) {
+		memset(ctx->username, 0, strlen(ctx->username));
+		g_free(ctx->username);
+	}
+
+	if (ctx->password) {
+		memset(ctx->password, 0, strlen(ctx->password));
+		g_free(ctx->password);
+	}
+
+	g_free(ctx);
+}
+
+static unsigned int find_next_primary_id(struct data_connection_data *d)
+{
+	GSList *l;
+	gint i, *range;
+
+	for (l =3D d->primary_id_range; l; l =3D l->next)
+		for (range =3D l->data, i =3D range[0]; i <=3D range[1]; i++)
+			if (!g_slist_find_custom(d->contexts, &i,
+							context_id_compare))
+				return i;
+
+	return 0;
+}
+
+static void detached(struct ofono_data_connection *dc)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	GSList *l;
+	struct ofono_data_context *ctx;
+
+	for (l =3D dcd->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+		if (ctx->active) {
+			ctx->active =3D 0;
+
+			ofono_data_connection_deactivated(dc, ctx->id);
+		}
+	}
+}
+
+static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct set_attached_req *req =3D user_data;
+	struct ofono_error error;
+
+	dump_response("cgatt_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok && !req->attached)
+		detached(req->dc);
+
+	req->cb(&error, req->data);
+}
+
+static void at_ps_set_attached(struct ofono_data_connection *dc,
+				int attached, ofono_data_connection_cb_t cb,
+				void *data)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	struct set_attached_req *req;
+	char buf[64];
+
+	req =3D g_new0(struct set_attached_req, 1);
+	if (!req)
+		goto error;
+
+	req->dc =3D dc;
+	req->attached =3D attached;
+	req->cb =3D cb;
+	req->data =3D data;
+
+	sprintf(buf, "AT+CGATT=3D%i", attached ? 1 : 0);
+
+	if (g_at_chat_send(dcd->chat, buf, none_prefix,
+				at_cgatt_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_cgact_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct set_active_req *req =3D user_data;
+	struct data_connection_data *dcd =3D
+		ofono_data_connection_get_data(req->dc);
+	struct ofono_error error;
+	GSList *l;
+	struct ofono_data_context *ctx;
+
+	dump_response("cgact_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok) {
+		if (req->ctx) {
+			req->ctx->active =3D req->active;
+
+			if (!req->active)
+				ofono_data_connection_deactivated(req->dc,
+								req->ctx->id);
+		} else
+			for (l =3D dcd->contexts; l; l =3D l->next) {
+				ctx =3D l->data;
+
+				if (g_slist_find(dcd->new_contexts, ctx))
+					continue;
+
+				ctx->active =3D req->active;
+
+				if (!req->active)
+					ofono_data_connection_deactivated(
+							req->dc, ctx->id);
+			}
+	}
+
+	req->cb(&error, req->data);
+}
+
+static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct set_active_req *req =3D user_data;
+	struct data_connection_data *dcd =3D
+		ofono_data_connection_get_data(req->dc);
+	struct ofono_error error;
+	char buf[64];
+
+	dump_response("cgdcont_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		req->cb(&error, req->data);
+
+		g_free(req);
+		return;
+	}
+
+	/* Context is no longer undefined */
+	dcd->new_contexts =3D g_slist_remove(dcd->new_contexts, req->ctx);
+
+	sprintf(buf, "AT+CGACT=3D1,%u", req->ctx->id);
+
+	if (g_at_chat_send(dcd->chat, buf, none_prefix,
+				at_cgact_cb, req, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(req->cb, req->data);
+
+	g_free(req);
+}
+
+static void at_pdp_set_active(struct ofono_data_connection *dc, unsigned i=
d,
+				int active, ofono_data_connection_cb_t cb,
+				void *data)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	struct set_active_req *req =3D NULL;
+	char buf[64];
+	struct ofono_data_context *ctx;
+	gint cid =3D id;
+	int len;
+	GSList *l;
+
+	l =3D g_slist_find_custom(dcd->contexts, &cid, context_id_compare);
+	if (!l)
+		goto error;
+
+	ctx =3D l->data;
+
+	req =3D g_new0(struct set_active_req, 1);
+	if (!req)
+		goto error;
+
+	req->dc =3D dc;
+	req->ctx =3D ctx;
+	req->active =3D active;
+	req->cb =3D cb;
+	req->data =3D data;
+
+	if (active) {
+		len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", id);
+		if (ctx->apn)
+			snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+					ctx->apn);
+
+		if (g_at_chat_send(dcd->chat, buf, none_prefix,
+					at_cgdcont_cb, req, NULL) > 0)
+			return;
+	} else {
+		sprintf(buf, "AT+CGACT=3D0,%u", id);
+
+		if (g_at_chat_send(dcd->chat, buf, none_prefix,
+					at_cgact_cb, req, g_free) > 0)
+			return;
+	}
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_pdp_set_active_all(struct ofono_data_connection *dc,
+				int active, ofono_data_connection_cb_t cb,
+				void *data)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	struct set_active_req *req;
+	char buf[64];
+
+	req =3D g_new0(struct set_active_req, 1);
+	if (!req)
+		goto error;
+
+	req->dc =3D dc;
+	req->active =3D active;
+	req->cb =3D cb;
+	req->data =3D data;
+
+	sprintf(buf, "AT+CGACT=3D%i", active ? 1 : 0);
+
+	if (g_at_chat_send(dcd->chat, buf, none_prefix,
+				at_cgact_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_pdp_alloc(struct ofono_data_connection *dc,
+				ofono_data_connection_alloc_cb_t cb,
+				void *data)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	struct ofono_data_context *ctx;
+	struct ofono_error e;
+	unsigned id =3D find_next_primary_id(dcd);
+
+	if (!id) {
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+
+		return;
+	}
+
+	ctx =3D g_try_new0(struct ofono_data_context, 1);
+	if (!ctx) {
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+
+		return;
+	}
+
+	ctx->id =3D id;
+	ctx->apn =3D g_strdup("");
+	ctx->username =3D g_strdup("");
+	ctx->password =3D g_strdup("");
+
+	dcd->new_contexts =3D g_slist_insert_sorted(dcd->new_contexts,
+						ctx, context_compare);
+	dcd->contexts =3D g_slist_insert_sorted(dcd->contexts,
+						ctx, context_compare);
+
+	/* The context will be defined (+CGDCONT) lazily, once it's needed
+	 * and the parameters are already set in ctx.  Right now just call
+	 * back */
+	e.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	e.error =3D 0;
+	cb(&e, ctx, data);
+
+	ofono_data_connection_notify(dc, ctx);
+}
+
+static void at_pdp_undefine_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	dump_response("undefine_cb", ok, result);
+
+	if (!ok)
+		ofono_error("Undefining primary context failed");
+}
+
+static void at_pdp_free(struct ofono_data_connection *dc, unsigned id,
+			ofono_data_connection_cb_t cb, void *data)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	struct ofono_error e;
+	char buf[64];
+	struct ofono_data_context *ctx;
+	GSList *l;
+	gint cid =3D id;
+
+	l =3D g_slist_find_custom(dcd->contexts, &cid, context_id_compare);
+	if (!l) {
+		CALLBACK_WITH_FAILURE(cb, data);
+
+		return;
+	}
+
+	ctx =3D l->data;
+	if (ctx->active) {
+		CALLBACK_WITH_FAILURE(cb, data);
+
+		return;
+	}
+
+	/* We can call back already -- even if the request to undefine
+	 * the context fails, the ID can be re-used.  */
+	e.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	e.error =3D 0;
+	cb(&e, data);
+
+	context_free(ctx);
+	dcd->contexts =3D g_slist_remove(dcd->contexts, ctx);
+
+	if (g_slist_find(dcd->new_contexts, ctx)) {
+		dcd->new_contexts =3D g_slist_remove(dcd->new_contexts, ctx);
+		return;
+	}
+
+	sprintf(buf, "AT+CGDCONT=3D%u", id);
+
+	g_at_chat_send(dcd->chat, buf, none_prefix,
+			at_pdp_undefine_cb, NULL, NULL);
+}
+
+static void at_cgact_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_data_connection *dc =3D user_data;
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	gint cid, state;
+	GAtResultIter iter;
+	struct ofono_data_context *ctx;
+	GSList *l;
+
+	dump_response("cgact_read_cb", ok, result);
+
+	if (!ok)
+		return;
+
+	while (g_at_result_iter_next(&iter, "+CGACT:")) {
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &state))
+			continue;
+
+		l =3D g_slist_find_custom(dcd->contexts, &cid,
+					context_id_compare);
+		if (!l)
+			continue;
+
+		ctx =3D l->data;
+		if (ctx->active !=3D state) {
+			ctx->active =3D state;
+
+			if (state)
+				continue;
+
+			ofono_data_connection_deactivated(dc, ctx->id);
+		}
+	}
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_data_connection *dc =3D user_data;
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	GAtResultIter iter;
+	const char *event;
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (g_str_has_prefix(event, "REJECT "))
+		return;
+
+	if (g_str_has_prefix(event, "NW REACT ") ||
+			g_str_has_prefix(event, "NW DEACT ") ||
+			g_str_has_prefix(event, "ME DEACT ")) {
+		/* Ask what primary contexts are active now */
+		g_at_chat_send(dcd->chat, "AT+CGACT?", cgact_prefix,
+				at_cgact_read_cb, dc, NULL);
+
+		return;
+	}
+
+	if (g_str_has_prefix(event, "NW DETACH ") ||
+			g_str_has_prefix(event, "ME DETACH ")) {
+		detached(dc);
+
+		ofono_data_connection_detached(dc);
+
+		return;
+	}
+
+	if (g_str_has_prefix(event, "NW CLASS ") ||
+			g_str_has_prefix(event, "ME CLASS "))
+		return;
+}
+
+static void cgreg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_data_connection *dc =3D user_data;
+	GAtResultIter iter;
+	gint status, tech =3D -1;
+	int lac =3D -1, ci =3D -1;
+	const char *str;
+
+	dump_response("cgreg_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGREG:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	if (g_at_result_iter_next_string(&iter, &str))
+		lac =3D strtol(str, NULL, 16);
+	else
+		goto out;
+
+	if (g_at_result_iter_next_string(&iter, &str))
+		ci =3D strtol(str, NULL, 16);
+	else
+		goto out;
+
+	g_at_result_iter_next_number(&iter, &tech);
+
+out:
+	ofono_debug("cgreg_notify: %d, %d, %d, %d", status, lac, ci, tech);
+
+	if (status !=3D 1 && status !=3D 5)
+		detached(dc);
+
+	ofono_data_netreg_status_notify(dc, status, lac, ci, tech);
+}
+
+static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_data_connection *dc =3D user_data;
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+	GAtResultIter iter;
+	gint range[2];
+	GSList *ranges =3D NULL;
+	const char *pdp_type;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		if (!g_at_result_iter_open_list(&iter))
+			goto next;
+
+		while (g_at_result_iter_next_range(&iter, &range[0],
+							&range[1]))
+			ranges =3D g_slist_prepend(ranges,
+					g_memdup(range, sizeof(range)));
+
+		if (!g_at_result_iter_close_list(&iter))
+			goto next;
+
+		if (!ranges || range[1] < range[0])
+			goto next;
+
+		if (!g_at_result_iter_next_string(&iter, &pdp_type))
+			goto next;
+
+		/* We look for IP PDPs */
+		if (!strcmp(pdp_type, "IP"))
+			break;
+
+next:
+		if (ranges) {
+			g_slist_foreach(ranges, (GFunc) g_free, NULL);
+			g_slist_free(ranges);
+			ranges =3D NULL;
+		}
+	}
+	if (!ranges)
+		goto error;
+
+	dcd->primary_id_range =3D g_slist_reverse(ranges);
+
+	ofono_debug("data_connection_init: registering to notifications");
+
+	g_at_chat_register(dcd->chat, "+CGEV:", cgev_notify, FALSE, dc, NULL);
+	g_at_chat_register(dcd->chat, "+CGREG:", cgreg_notify, FALSE, dc, NULL);
+
+	ofono_data_connection_register(dc);
+
+	return;
+
+error:
+	ofono_data_connection_remove(dc);
+}
+
+static int at_data_connection_probe(struct ofono_data_connection *dc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct data_connection_data *dcd;
+
+	dcd =3D g_new0(struct data_connection_data, 1);
+	dcd->chat =3D chat;
+
+	ofono_data_connection_set_data(dc, dcd);
+
+	g_at_chat_send(chat, "AT+CGREG=3D2", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGAUTO=3D0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGEREP=3D2,1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+			at_cgdcont_test_cb, dc, NULL);
+	return 0;
+}
+
+static void at_data_connection_remove(struct ofono_data_connection *dc)
+{
+	struct data_connection_data *dcd =3D ofono_data_connection_get_data(dc);
+
+	g_slist_foreach(dcd->contexts, (GFunc) context_free, NULL);
+	g_slist_free(dcd->contexts);
+	g_slist_free(dcd->new_contexts);
+	g_free(dcd);
+}
+
+static struct ofono_data_connection_driver driver =3D {
+	.name			=3D "atmodem",
+	.probe			=3D at_data_connection_probe,
+	.remove			=3D at_data_connection_remove,
+	.set_attached		=3D at_ps_set_attached,
+	.set_active		=3D at_pdp_set_active,
+	.set_active_all		=3D at_pdp_set_active_all,
+	.create_context		=3D at_pdp_alloc,
+	.remove_context		=3D at_pdp_free,
+};
+
+void at_data_connection_init()
+{
+	ofono_data_connection_driver_register(&driver);
+}
+
+void at_data_connection_exit()
+{
+	ofono_data_connection_driver_unregister(&driver);
+}
diff --git a/include/data-connection.h b/include/data-connection.h
new file mode 100644
index 0000000..24b68a8
--- /dev/null
+++ b/include/data-connection.h
@@ -0,0 +1,89 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_DATA_CONNECTION_H
+#define __OFONO_DATA_CONNECTION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_data_connection;
+
+typedef void (*ofono_data_connection_cb_t)(const struct ofono_error *error,
+						void *data);
+
+typedef void (*ofono_data_connection_alloc_cb_t)(
+						const struct ofono_error *error,
+						struct ofono_data_context *ctx,
+						void *data);
+
+struct ofono_data_connection_driver {
+	const char *name;
+	int (*probe)(struct ofono_data_connection *dc, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_data_connection *dc);
+	void (*set_attached)(struct ofono_data_connection *dc,
+				int attached, ofono_data_connection_cb_t cb,
+				void *data);
+	void (*set_active)(struct ofono_data_connection *dc, unsigned id,
+				int active, ofono_data_connection_cb_t cb,
+				void *data);
+	void (*set_active_all)(struct ofono_data_connection *dc,
+				int active, ofono_data_connection_cb_t cb,
+				void *data);
+	void (*create_context)(struct ofono_data_connection *dc,
+				ofono_data_connection_alloc_cb_t cb,
+				void *data);
+	void (*remove_context)(struct ofono_data_connection *dc, unsigned id,
+				ofono_data_connection_cb_t cb, void *data);
+};
+
+void ofono_data_connection_notify(struct ofono_data_connection *dc,
+					struct ofono_data_context *ctx);
+void ofono_data_connection_deactivated(struct ofono_data_connection *dc,
+					unsigned id);
+void ofono_data_connection_detached(struct ofono_data_connection *dc);
+void ofono_data_netreg_status_notify(struct ofono_data_connection *dc,
+					int status, int lac, int ci, int tech);
+
+int ofono_data_connection_driver_register(
+				const struct ofono_data_connection_driver *d);
+void ofono_data_connection_driver_unregister(
+				const struct ofono_data_connection_driver *d);
+
+struct ofono_data_connection *ofono_data_connection_create(
+		struct ofono_modem *modem, unsigned int vendor,
+		const char *driver, void *data);
+void ofono_data_connection_register(struct ofono_data_connection *dc);
+void ofono_data_connection_remove(struct ofono_data_connection *dc);
+
+void ofono_data_connection_set_data(struct ofono_data_connection *dc,
+					void *data);
+void *ofono_data_connection_get_data(struct ofono_data_connection *dc);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_DATA_CONNECTION_H */
diff --git a/include/types.h b/include/types.h
index 6a9681d..44428fb 100644
--- a/include/types.h
+++ b/include/types.h
@@ -91,6 +91,16 @@ struct ofono_call {
 	int clip_validity;
 };
 =

+struct ofono_data_context {
+	unsigned id;
+	int type;
+	int direction;
+	int active;
+	char *apn;
+	char *username;
+	char *password;
+};
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 02ce443..26e170c 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -54,6 +54,7 @@
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
+#include <ofono/data-connection.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -285,6 +286,8 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 		ofono_cbs_create(modem, 0, "atmodem", data->chat);
 	}
 =

+	ofono_data_connection_create(modem, 0, "atmodem", data->chat);
+
 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
diff --git a/src/data-connection.c b/src/data-connection.c
new file mode 100644
index 0000000..eab36c7
--- /dev/null
+++ b/src/data-connection.c
@@ -0,0 +1,1074 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+
+#define DATA_CONNECTION_MANAGER_INTERFACE "org.ofono.DataConnectionManager"
+#define DATA_CONTEXT_INTERFACE "org.ofono.PrimaryDataContext"
+
+#define DATA_CONNECTION_FLAG_ATTACHING 0x1
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_data_connection {
+	GSList *contexts;
+	int attached;
+	int roaming_allowed;
+	int powered;
+	int status;
+	int location;
+	int cellid;
+	int technology;
+
+	int flags;
+	struct context *current_context;
+	DBusMessage *pending;
+	const struct ofono_data_connection_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+struct context {
+	struct ofono_data_context *context;
+	struct ofono_data_connection *dc;
+};
+
+static void dc_netreg_update(struct ofono_data_connection *dc);
+
+static gint context_compare(gconstpointer a, gconstpointer b)
+{
+	const struct context *ctxa =3D a;
+	const struct context *ctxb =3D a;
+
+	return ctxa->context->id - ctxb->context->id;
+}
+
+enum {
+	DATA_CONTEXT_TYPE_INTERNET,
+	DATA_CONTEXT_TYPE_MMS,
+	DATA_CONTEXT_TYPE_WAP,
+};
+
+static inline const char *data_context_type_to_string(int type)
+{
+	switch (type) {
+	case DATA_CONTEXT_TYPE_INTERNET:
+		return "internet";
+	case DATA_CONTEXT_TYPE_MMS:
+		return "mms";
+	case DATA_CONTEXT_TYPE_WAP:
+		return "wap";
+	}
+
+	return NULL;
+}
+
+static const char *dc_build_context_path(struct ofono_data_connection *dc,
+					const struct ofono_data_context *ctx)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/primarycontext%02u",
+			__ofono_atom_get_path(dc->atom), ctx->id);
+
+	return path;
+}
+
+static struct context *dc_context_by_path(
+		struct ofono_data_connection *dc, const char *ctx_path)
+{
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+	GSList *l;
+	unsigned id;
+
+	if (!g_str_has_prefix(ctx_path, path))
+		return NULL;
+
+	if (sscanf(ctx_path + strlen(path), "/primarycontext%2u", &id) !=3D 1)
+		return NULL;
+
+	for (l =3D dc->contexts; l; l =3D l->next) {
+		struct context *ctx =3D l->data;
+
+		if (ctx->context->id =3D=3D id)
+			return ctx;
+	}
+
+	return NULL;
+}
+
+static DBusMessage *dc_get_context_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct context *ctx =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+	const char *type =3D data_context_type_to_string(ctx->context->type);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D ctx->context->active;
+	ofono_dbus_dict_append(&dict, "Active", DBUS_TYPE_BOOLEAN, &value);
+
+	ofono_dbus_dict_append(&dict, "AccessPointName",
+				DBUS_TYPE_STRING, &ctx->context->apn);
+
+	ofono_dbus_dict_append(&dict, "Type",
+				DBUS_TYPE_STRING, &type);
+
+	ofono_dbus_dict_append(&dict, "Username",
+				DBUS_TYPE_STRING, &ctx->context->username);
+
+	ofono_dbus_dict_append(&dict, "Passwod",
+				DBUS_TYPE_STRING, &ctx->context->password);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void context_set_active_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct context *ctx =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *reply;
+	const char *path;
+	dbus_bool_t value;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Activating context failed with error: %s",
+				telephony_error_to_str(error));
+
+		reply =3D __ofono_error_failed(ctx->dc->pending);
+		goto reply;
+	}
+
+	reply =3D dbus_message_new_method_return(ctx->dc->pending);
+
+	if (!ctx->context->active) /* Signal emitted elsewhere */
+		goto reply;
+
+	path =3D dc_build_context_path(ctx->dc, ctx->context);
+	value =3D ctx->context->active;
+	ofono_dbus_signal_property_changed(conn, path, DATA_CONTEXT_INTERFACE,
+						"Active", DBUS_TYPE_BOOLEAN,
+						&value);
+
+reply:
+	__ofono_dbus_pending_reply(&ctx->dc->pending, reply);
+}
+
+static DBusMessage *dc_set_context_property(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct context *ctx =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+	const char *str;
+	const char *path;
+
+	if (ctx->dc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "Active")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if ((dbus_bool_t) ctx->context->active =3D=3D value)
+			return dbus_message_new_method_return(msg);
+		if (ctx->dc->flags & DATA_CONNECTION_FLAG_ATTACHING)
+			return __ofono_error_busy(msg);
+		if (value && !ctx->dc->attached)
+			return __ofono_error_failed(msg);
+		if (!ctx->dc->driver->set_active)
+			return __ofono_error_not_implemented(msg);
+
+		ctx->dc->pending =3D dbus_message_ref(msg);
+
+		ctx->dc->driver->set_active(ctx->dc, ctx->context->id,
+						value,
+						context_set_active_callback,
+						ctx);
+
+		return NULL;
+	}
+
+	/* All other properties are read-only when context is active */
+	if (ctx->context->active)
+		return __ofono_error_invalid_args(msg);
+
+	if (!strcmp(property, "AccessPointName")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (ctx->context->apn)
+			g_free(ctx->context->apn);
+		ctx->context->apn =3D g_strdup(str);
+	} else if (!strcmp(property, "Type")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (!strcmp(str, "internet"))
+			ctx->context->type =3D DATA_CONTEXT_TYPE_INTERNET;
+		else
+			return __ofono_error_invalid_args(msg);
+	} else if (!strcmp(property, "Username")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (ctx->context->username)
+			g_free(ctx->context->username);
+		ctx->context->username =3D g_strdup(str);
+	} else if (!strcmp(property, "Password")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (ctx->context->password)
+			g_free(ctx->context->password);
+		ctx->context->password =3D g_strdup(str);
+	} else
+		return __ofono_error_invalid_args(msg);
+
+	path =3D dc_build_context_path(ctx->dc, ctx->context);
+	ofono_dbus_signal_property_changed(conn, path, DATA_CONTEXT_INTERFACE,
+						property, DBUS_TYPE_STRING,
+						&str);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable context_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	dc_get_context_properties },
+	{ "SetProperty",	"sv",	"",		dc_set_context_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable context_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static struct context *context_create(struct ofono_data_connection *dc,
+					struct ofono_data_context *ctx)
+{
+	struct context *context =3D g_try_new0(struct context, 1);
+
+	if (!context)
+		return NULL;
+
+	context->context =3D ctx;
+	context->dc =3D dc;
+
+	return context;
+}
+
+static void context_destroy(gpointer userdata)
+{
+	struct context *ctx =3D userdata;
+
+	g_free(ctx);
+}
+
+static gboolean context_dbus_register(struct ofono_data_connection *dc,
+					struct context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D dc_build_context_path(dc, ctx->context);
+
+	if (!g_dbus_register_interface(conn, path, DATA_CONTEXT_INTERFACE,
+					context_methods, context_signals,
+					NULL, ctx, context_destroy)) {
+		ofono_error("Could not register PrimaryContext %s", path);
+		context_destroy(ctx);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean context_dbus_unregister(struct ofono_data_connection *dc,
+					struct ofono_data_context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D dc_build_context_path(dc, ctx);
+
+	return g_dbus_unregister_interface(conn, path, DATA_CONTEXT_INTERFACE);
+}
+
+static char **dc_contexts_path_list(struct ofono_data_connection *dc,
+					GSList *context_list)
+{
+	GSList *l;
+	char **i;
+	struct context *ctx;
+	char **objlist =3D g_new0(char *, g_slist_length(context_list) + 1);
+
+	if (!objlist)
+		return NULL;
+
+	for (i =3D objlist, l =3D context_list; l; l =3D l->next) {
+		ctx =3D l->data;
+		*i++ =3D g_strdup(dc_build_context_path(dc, ctx->context));
+	}
+
+	return objlist;
+}
+
+static void dc_generic_callback(const struct ofono_error *error, void *dat=
a)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_debug("command failed with error: %s",
+				telephony_error_to_str(error));
+
+	if (!dc->pending)
+		return;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D dbus_message_new_method_return(dc->pending);
+	else
+		reply =3D __ofono_error_failed(dc->pending);
+
+	__ofono_dbus_pending_reply(&dc->pending, reply);
+}
+
+static void dc_attach_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	dbus_bool_t value;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			(dc->flags & DATA_CONNECTION_FLAG_ATTACHING)) {
+		dc->attached =3D !dc->attached;
+
+		path =3D __ofono_atom_get_path(dc->atom);
+		value =3D dc->attached;
+		ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"Attached", DBUS_TYPE_BOOLEAN, &value);
+	}
+
+	dc->flags &=3D ~DATA_CONNECTION_FLAG_ATTACHING;
+
+	dc_netreg_update(dc);
+}
+
+static void dc_netreg_update(struct ofono_data_connection *dc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	int attach;
+	int operator_ok;
+	const char *path;
+	dbus_bool_t value =3D 0;
+
+	operator_ok =3D dc->roaming_allowed ||
+		(dc->status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+
+	attach =3D dc->powered && operator_ok;
+
+	if (dc->attached !=3D attach &&
+			!(dc->flags & DATA_CONNECTION_FLAG_ATTACHING)) {
+		dc->flags |=3D DATA_CONNECTION_FLAG_ATTACHING;
+
+		dc->driver->set_attached(dc, attach, dc_attach_callback, dc);
+
+		/* Prevent further attempts to attach */
+		if (!attach && dc->powered) {
+			dc->powered =3D 0;
+
+			path =3D __ofono_atom_get_path(dc->atom);
+			ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"Powered", DBUS_TYPE_BOOLEAN, &value);
+		}
+	}
+}
+
+static DBusMessage *dc_get_manager_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char **objpath_list;
+	dbus_bool_t value;
+	const char *status =3D registration_status_to_string(dc->status);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	objpath_list =3D dc_contexts_path_list(dc, dc->contexts);
+	if (!objpath_list)
+		return NULL;
+
+	ofono_dbus_dict_append_array(&dict, "PrimaryContexts",
+					DBUS_TYPE_OBJECT_PATH, &objpath_list);
+
+	g_strfreev(objpath_list);
+
+	value =3D dc->attached;
+	ofono_dbus_dict_append(&dict, "Attached", DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D dc->roaming_allowed;
+	ofono_dbus_dict_append(&dict, "RoamingAllowed",
+				DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D dc->powered;
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+
+	ofono_dbus_dict_append(&dict, "Status", DBUS_TYPE_STRING, &status);
+
+	if (dc->location !=3D -1) {
+		dbus_uint16_t location =3D dc->location;
+		ofono_dbus_dict_append(&dict, "LocationAreaCode",
+					DBUS_TYPE_UINT16, &location);
+	}
+
+	if (dc->cellid !=3D -1) {
+		dbus_uint32_t cellid =3D dc->cellid;
+		ofono_dbus_dict_append(&dict, "CellId",
+					DBUS_TYPE_UINT32, &cellid);
+	}
+
+	if (dc->technology !=3D -1) {
+		const char *technology =3D
+			registration_tech_to_string(dc->technology);
+
+		ofono_dbus_dict_append(&dict, "Technology", DBUS_TYPE_STRING,
+					&technology);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *dc_set_manager_property(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+	const char *path;
+
+	if (dc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "RoamingAllowed")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		dc->roaming_allowed =3D value;
+		dc_netreg_update(dc);
+	} else if (!strcmp(property, "Powered")) {
+		if (!dc->driver->set_attached)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		dc->powered =3D value;
+		dc_netreg_update(dc);
+	} else
+		return __ofono_error_invalid_args(msg);
+
+	path =3D __ofono_atom_get_path(dc->atom);
+	ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					property, DBUS_TYPE_BOOLEAN, &value);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static void dc_create_context_callback(const struct ofono_error *error,
+					struct ofono_data_context *ctx,
+					void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusMessage *reply;
+	const char *path;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Creating new context failed with error: %s",
+				telephony_error_to_str(error));
+
+		reply =3D __ofono_error_failed(dc->pending);
+		goto error;
+	}
+
+	reply =3D dbus_message_new_method_return(dc->pending);
+
+	path =3D dc_build_context_path(dc, ctx);
+	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+error:
+	__ofono_dbus_pending_reply(&dc->pending, reply);
+}
+
+static DBusMessage *dc_create_context(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+
+	if (dc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dc->driver->create_context)
+		return __ofono_error_not_implemented(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	dc->pending =3D dbus_message_ref(msg);
+
+	dc->driver->create_context(dc, dc_create_context_callback, dc);
+
+	return NULL;
+}
+
+static void dc_remove_context_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	DBusMessage *reply;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	char **objpath_list;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Removing context failed with error: %s",
+				telephony_error_to_str(error));
+
+		reply =3D __ofono_error_failed(dc->pending);
+		goto error;
+	}
+
+	context_dbus_unregister(dc, dc->current_context->context);
+	dc->contexts =3D g_slist_remove(dc->contexts, dc->current_context);
+	dc->current_context =3D NULL;
+
+	objpath_list =3D dc_contexts_path_list(dc, dc->contexts);
+	if (!objpath_list) {
+		ofono_error("Could not allocate PrimaryContext objects list");
+		return;
+	}
+
+	path =3D __ofono_atom_get_path(dc->atom);
+	ofono_dbus_signal_array_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"PrimaryContexts",
+					DBUS_TYPE_OBJECT_PATH, &objpath_list);
+
+	g_strfreev(objpath_list);
+
+	reply =3D dbus_message_new_method_return(dc->pending);
+
+error:
+	__ofono_dbus_pending_reply(&dc->pending, reply);
+}
+
+static void dc_deactivate_context_callback(const struct ofono_error *error,
+						void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Removing context failed with error: %s",
+				telephony_error_to_str(error));
+
+		dc->current_context =3D NULL;
+		__ofono_dbus_pending_reply(&dc->pending, __ofono_error_failed(
+						dc->pending));
+		return;
+	}
+
+	dc->driver->remove_context(dc, dc->current_context->context->id,
+					dc_remove_context_callback, dc);
+}
+
+static DBusMessage *dc_remove_context(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+	struct context *ctx;
+	const char *path;
+
+	if (dc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dc->driver->remove_context)
+		return __ofono_error_not_implemented(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (path[0] =3D=3D '\0')
+		return __ofono_error_invalid_format(msg);
+
+	ctx =3D dc_context_by_path(dc, path);
+	if (!ctx)
+		return __ofono_error_not_found(msg);
+
+	dc->pending =3D dbus_message_ref(msg);
+	dc->current_context =3D ctx;
+
+	if (ctx->context->active && dc->driver->set_active) {
+		dc->driver->set_active(dc, ctx->context->id, 0,
+					dc_deactivate_context_callback, dc);
+
+		return NULL;
+	}
+
+	dc->driver->remove_context(dc, ctx->context->id,
+					dc_remove_context_callback, dc);
+
+	return NULL;
+}
+
+static DBusMessage *dc_deactivate_all(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_data_connection *dc =3D data;
+
+	if (dc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dc->driver->set_active_all)
+		return __ofono_error_not_implemented(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	dc->pending =3D dbus_message_ref(msg);
+
+	dc->driver->set_active_all(dc, 0, dc_generic_callback, dc);
+
+	return NULL;
+}
+
+static GDBusMethodTable manager_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	dc_get_manager_properties },
+	{ "SetProperty",	"sv",	"",		dc_set_manager_property },
+	{ "CreateContext",	"",	"o",		dc_create_context,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RemoveContext",	"o",	"",		dc_remove_context,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "DeactivateAll",	"",	"",		dc_deactivate_all,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable manager_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+void ofono_data_connection_notify(struct ofono_data_connection *dc,
+					struct ofono_data_context *ctx)
+{
+	struct context *context =3D context_create(dc, ctx);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	char **objpath_list;
+
+	if (!context) {
+		ofono_error("Unable to allocate context struct");
+		return;
+	}
+
+	ofono_debug("Registering new context: %i", ctx->id);
+	if (!context_dbus_register(dc, context))
+		return;
+
+	dc->contexts =3D g_slist_insert_sorted(dc->contexts,
+						context, context_compare);
+
+	objpath_list =3D dc_contexts_path_list(dc, dc->contexts);
+	if (!objpath_list) {
+		ofono_error("Unable to allocate PrimaryContext objects list");
+		return;
+	}
+
+	path =3D __ofono_atom_get_path(dc->atom);
+	ofono_dbus_signal_array_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"PrimaryContexts",
+					DBUS_TYPE_OBJECT_PATH, &objpath_list);
+
+	g_strfreev(objpath_list);
+}
+
+void ofono_data_connection_deactivated(struct ofono_data_connection *dc,
+					unsigned id)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D NULL; /* Suppress warning */
+	dbus_bool_t value =3D 0;
+	GSList *l;
+	struct context *ctx;
+
+	for (l =3D dc->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		if (ctx->context->id =3D=3D id) {
+			path =3D dc_build_context_path(dc, ctx->context);
+			break;
+		}
+	}
+
+	ofono_dbus_signal_property_changed(conn, path, DATA_CONTEXT_INTERFACE,
+						"Active", DBUS_TYPE_BOOLEAN,
+						&value);
+
+}
+
+void ofono_data_connection_detached(struct ofono_data_connection *dc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	dbus_bool_t value =3D 0;
+
+	if (dc->attached && !(dc->flags & DATA_CONNECTION_FLAG_ATTACHING)) {
+		dc->attached =3D 0;
+
+		path =3D __ofono_atom_get_path(dc->atom);
+		ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"Attached", DBUS_TYPE_BOOLEAN, &value);
+
+		dc_netreg_update(dc);
+	}
+}
+
+static void set_registration_status(struct ofono_data_connection *dc,
+					int status)
+{
+	const char *str_status =3D registration_status_to_string(status);
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t attached;
+
+	dc->status =3D status;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"Status", DBUS_TYPE_STRING,
+					&str_status);
+
+	attached =3D (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+	if (dc->attached !=3D (int) attached &&
+			!(dc->flags & DATA_CONNECTION_FLAG_ATTACHING)) {
+		dc->attached =3D (int) attached;
+
+		ofono_dbus_signal_property_changed(conn, path,
+				DATA_CONNECTION_MANAGER_INTERFACE,
+				"Attached", DBUS_TYPE_BOOLEAN,
+				&attached);
+
+		dc_netreg_update(dc);
+	}
+}
+
+static void set_registration_location(struct ofono_data_connection *dc,
+					int lac)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+	dbus_uint16_t dbus_lac =3D lac;
+
+	if (lac > 0xffff)
+		return;
+
+	dc->location =3D lac;
+
+	if (dc->location =3D=3D -1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"LocationAreaCode",
+					DBUS_TYPE_UINT16, &dbus_lac);
+}
+
+static void set_registration_cellid(struct ofono_data_connection *dc, int =
ci)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+	dbus_uint32_t dbus_ci =3D ci;
+
+	dc->cellid =3D ci;
+
+	if (dc->cellid =3D=3D -1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"CellId", DBUS_TYPE_UINT32,
+					&dbus_ci);
+}
+
+static void set_registration_technology(struct ofono_data_connection *dc,
+					int tech)
+{
+	const char *tech_str =3D registration_tech_to_string(tech);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+
+	dc->technology =3D tech;
+
+	if (dc->technology =3D=3D -1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					"Technology", DBUS_TYPE_STRING,
+					&tech_str);
+}
+
+void ofono_data_netreg_status_notify(struct ofono_data_connection *dc,
+					int status, int lac, int ci, int tech)
+{
+	if (dc->status !=3D status)
+		set_registration_status(dc, status);
+
+	if (dc->location !=3D lac)
+		set_registration_location(dc, lac);
+
+	if (dc->cellid !=3D ci)
+		set_registration_cellid(dc, ci);
+
+	if (dc->technology !=3D tech)
+		set_registration_technology(dc, tech);
+}
+
+int ofono_data_connection_driver_register(
+		const struct ofono_data_connection_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_data_connection_driver_unregister(
+		const struct ofono_data_connection_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void data_connection_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_data_connection *dc =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	g_slist_free(dc->contexts);
+
+	ofono_modem_remove_interface(modem, DATA_CONNECTION_MANAGER_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE);
+}
+
+static void data_connection_remove(struct ofono_atom *atom)
+{
+	struct ofono_data_connection *dc =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (dc =3D=3D NULL)
+		return;
+
+	if (dc->driver && dc->driver->remove)
+		dc->driver->remove(dc);
+
+	g_free(dc);
+}
+
+struct ofono_data_connection *ofono_data_connection_create(
+		struct ofono_modem *modem, unsigned int vendor,
+		const char *driver, void *data)
+{
+	struct ofono_data_connection *dc;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	dc =3D g_try_new0(struct ofono_data_connection, 1);
+
+	if (dc =3D=3D NULL)
+		return NULL;
+
+	dc->atom =3D __ofono_modem_add_atom(modem,
+			OFONO_ATOM_TYPE_DATA_CONNECTION,
+			data_connection_remove, dc);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_data_connection_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(dc, vendor, data) < 0)
+			continue;
+
+		dc->driver =3D drv;
+		break;
+	}
+
+	dc->technology =3D -1;
+	dc->cellid =3D -1;
+	dc->location =3D -1;
+
+	return dc;
+}
+
+void ofono_data_connection_register(struct ofono_data_connection *dc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(dc->atom);
+	const char *path =3D __ofono_atom_get_path(dc->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					DATA_CONNECTION_MANAGER_INTERFACE,
+					manager_methods, manager_signals, NULL,
+					dc, NULL)) {
+		ofono_error("Could not create %s interface",
+				DATA_CONNECTION_MANAGER_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, DATA_CONNECTION_MANAGER_INTERFACE);
+
+	__ofono_atom_register(dc->atom, data_connection_unregister);
+}
+
+void ofono_data_connection_remove(struct ofono_data_connection *dc)
+{
+	__ofono_atom_free(dc->atom);
+}
+
+void ofono_data_connection_set_data(struct ofono_data_connection *dc,
+					void *data)
+{
+	dc->driver_data =3D data;
+}
+
+void *ofono_data_connection_get_data(struct ofono_data_connection *dc)
+{
+	return dc->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 409a9e2..177e1fd 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -106,6 +106,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_MESSAGE_WAITING =3D 13,
 	OFONO_ATOM_TYPE_CBS =3D 14,
 	OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
+	OFONO_ATOM_TYPE_DATA_CONNECTION =3D 16,
 };
 =

 enum ofono_atom_watch_condition {
@@ -160,6 +161,7 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/sms.h>
 #include <ofono/sim.h>
 #include <ofono/voicecall.h>
+#include <ofono/data-connection.h>
 =

 #include <ofono/ssn.h>
 =

-- =

1.6.1


--===============1840708683042669149==--

