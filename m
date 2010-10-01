Content-Type: multipart/mixed; boundary="===============8946248133232624840=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2] sms: Implement text and datagram watch
Date: Fri, 01 Oct 2010 17:24:28 +0300
Message-ID: <1285943068-17414-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8946248133232624840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow setting a watch for incoming text and datagram messages on the
sms atom.
---
 src/ofono.h |   25 +++++++++
 src/sms.c   |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++---=
---
 2 files changed, 171 insertions(+), 17 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6c7f649..78e6be1 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -229,12 +229,37 @@ enum ofono_sms_submit_flag {
 };
 =

 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
+typedef void (*ofono_sms_text_notify_cb_t)(const char *from,
+						const struct tm *remote,
+						const struct tm *local,
+						const char *text,
+						void *data);
+typedef void (*ofono_sms_datagram_notify_cb_t)(const char *from,
+						const struct tm *remote,
+						const struct tm *local,
+						int dst, int src,
+						const unsigned char *buffer,
+						unsigned int len,
+						void *data);
 =

 int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
 				unsigned int flags, struct ofono_uuid *uuid,
 				ofono_sms_txq_submit_cb_t cb,
 				void *data, ofono_destroy_func destroy);
 =

+unsigned int __ofono_sms_text_watch_add(struct ofono_sms *sms,
+					ofono_sms_text_notify_cb_t cb,
+					void *data, ofono_destroy_func destroy);
+gboolean __ofono_sms_text_watch_remove(struct ofono_sms *sms,
+					unsigned int id);
+
+unsigned int __ofono_sms_datagram_watch_add(struct ofono_sms *sms,
+					ofono_sms_datagram_notify_cb_t cb,
+					int dst, int src, void *data,
+					ofono_destroy_func destroy);
+gboolean __ofono_sms_datagram_watch_remove(struct ofono_sms *sms,
+					unsigned int id);
+
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 =

diff --git a/src/sms.c b/src/sms.c
index b7051b9..bec0dfd 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -62,6 +62,12 @@ struct message {
 	enum message_state state;
 };
 =

+struct sms_handler {
+	struct ofono_watchlist_item item;
+	int dst;
+	int src;
+};
+
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -82,6 +88,8 @@ struct ofono_sms {
 	ofono_bool_t use_delivery_reports;
 	struct status_report_assembly *sr_assembly;
 	GHashTable *messages;
+	struct ofono_watchlist *text_handlers;
+	struct ofono_watchlist *datagram_handlers;
 };
 =

 struct pending_pdu {
@@ -108,6 +116,11 @@ static gboolean uuid_equal(gconstpointer v1, gconstpoi=
nter v2)
 	return memcmp(v1, v2, OFONO_SHA1_UUID_LEN) =3D=3D 0;
 }
 =

+static gboolean port_equal(int received, int expected)
+{
+	return expected =3D=3D -1 || received =3D=3D expected;
+}
+
 static guint uuid_hash(gconstpointer v)
 {
 	const struct ofono_uuid *uuid =3D v;
@@ -170,6 +183,77 @@ static void append_message_properties(struct message *=
m, DBusMessageIter *dict)
 	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &state);
 }
 =

+static unsigned int add_sms_handler(struct ofono_watchlist *watchlist,
+					int dst, int src, void *notify,
+					void *data, ofono_destroy_func destroy)
+{
+	struct sms_handler *handler;
+
+	if (!notify)
+		return 0;
+
+	handler =3D g_try_new0(struct sms_handler, 1);
+	if (!handler)
+		return 0;
+
+	handler->dst =3D dst;
+	handler->src =3D src;
+	handler->item.notify =3D notify;
+	handler->item.notify_data =3D data;
+	handler->item.destroy =3D destroy;
+
+	return __ofono_watchlist_add_item(watchlist,
+				(struct ofono_watchlist_item *)handler);
+}
+
+unsigned int __ofono_sms_text_watch_add(struct ofono_sms *sms,
+					ofono_sms_text_notify_cb_t cb,
+					void *data, ofono_destroy_func destroy)
+{
+	if (!sms)
+		return 0;
+
+	DBG("%p", sms);
+
+	return add_sms_handler(sms->text_handlers, -1, -1, cb, data, destroy);
+}
+
+gboolean __ofono_sms_text_watch_remove(struct ofono_sms *sms,
+					unsigned int id)
+{
+	if (!sms)
+		return FALSE;
+
+	DBG("%p", sms);
+
+	return __ofono_watchlist_remove_item(sms->text_handlers, id);
+}
+
+unsigned int __ofono_sms_datagram_watch_add(struct ofono_sms *sms,
+					ofono_sms_datagram_notify_cb_t cb,
+					int dst, int src, void *data,
+					ofono_destroy_func destroy)
+{
+	if (!sms)
+		return 0;
+
+	DBG("%p: dst %d, src %d", sms, dst, src);
+
+	return add_sms_handler(sms->datagram_handlers, dst, src, cb, data,
+				destroy);
+}
+
+gboolean __ofono_sms_datagram_watch_remove(struct ofono_sms *sms,
+					unsigned int id)
+{
+	if (!sms)
+		return FALSE;
+
+	DBG("%p", sms);
+
+	return __ofono_watchlist_remove_item(sms->datagram_handlers, id);
+}
+
 static DBusMessage *message_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -1064,12 +1148,35 @@ static gboolean compute_incoming_msgid(GSList *sms_=
list,
 	return TRUE;
 }
 =

-static void dispatch_app_datagram(struct ofono_sms *sms, int dst, int src,
-					unsigned char *buf, long len)
+static void dispatch_app_datagram(struct ofono_sms *sms,
+					const struct ofono_uuid *uuid,
+					int dst, int src,
+					unsigned char *buf, unsigned len,
+					const struct sms_address *addr,
+					const struct sms_scts *scts)
 {
-	DBG("Got app datagram for dst port: %d, src port: %d",
-			dst, src);
-	DBG("Contents-Len: %ld", len);
+	const char *sender =3D sms_address_to_string(addr);
+	time_t ts;
+	struct tm remote;
+	struct tm local;
+
+	ofono_sms_datagram_notify_cb_t notify;
+	struct sms_handler *h;
+	GSList *l;
+
+	ts =3D sms_scts_to_time(scts, &remote);
+	localtime_r(&ts, &local);
+
+	for (l =3D sms->datagram_handlers->items; l; l =3D l->next) {
+		h =3D l->data;
+		notify =3D h->item.notify;
+
+		if (!port_equal(dst, h->dst) || !port_equal(src, h->src))
+			continue;
+
+		notify(sender, &remote, &local, dst, src, buf, len,
+			h->item.notify_data);
+	}
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
@@ -1091,6 +1198,9 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	ofono_sms_text_notify_cb_t notify;
+	struct sms_handler *h;
+	GSList *l;
 =

 	if (!message)
 		return;
@@ -1132,15 +1242,25 @@ static void dispatch_text_message(struct ofono_sms =
*sms,
 =

 	g_dbus_send_message(conn, signal);
 =

-	if (cls !=3D SMS_CLASS_0)
-		__ofono_history_sms_received(modem, uuid, str,
-						&remote, &local, message);
+	if (cls =3D=3D SMS_CLASS_0)
+		return;
+
+	for (l =3D sms->text_handlers->items; l; l =3D l->next) {
+		h =3D l->data;
+		notify =3D h->item.notify;
+
+		notify(str, &remote, &local, message, h->item.notify_data);
+	}
+
+	__ofono_history_sms_received(modem, uuid, str, &remote, &local,
+					message);
 }
 =

 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
 {
 	GSList *l;
 	const struct sms *s;
+	struct ofono_uuid uuid;
 	enum sms_charset uninitialized_var(old_charset);
 	enum sms_class cls;
 	int srcport =3D -1;
@@ -1214,6 +1334,11 @@ static void sms_dispatch(struct ofono_sms *sms, GSLi=
st *sms_list)
 		}
 	}
 =

+	if (!compute_incoming_msgid(sms_list, &uuid))
+		return;
+
+	s =3D sms_list->data;
+
 	/* Handle datagram */
 	if (old_charset =3D=3D SMS_CHARSET_8BIT) {
 		unsigned char *buf;
@@ -1230,23 +1355,18 @@ static void sms_dispatch(struct ofono_sms *sms, GSL=
ist *sms_list)
 		if (!buf)
 			return;
 =

-		dispatch_app_datagram(sms, dstport, srcport, buf, len);
+		dispatch_app_datagram(sms, &uuid, dstport, srcport, buf, len,
+					&s->deliver.oaddr, &s->deliver.scts);
 =

 		g_free(buf);
 	} else {
-		struct ofono_uuid uuid;
 		char *message =3D sms_decode_text(sms_list);
 =

 		if (!message)
 			return;
 =

-		if (compute_incoming_msgid(sms_list, &uuid)) {
-			s =3D sms_list->data;
-
-			dispatch_text_message(sms, &uuid, message, cls,
-						&s->deliver.oaddr,
-						&s->deliver.scts);
-		}
+		dispatch_text_message(sms, &uuid, message, cls,
+					&s->deliver.oaddr, &s->deliver.scts);
 =

 		g_free(message);
 	}
@@ -1527,6 +1647,12 @@ static void sms_unregister(struct ofono_atom *atom)
 		g_hash_table_destroy(sms->messages);
 		sms->messages =3D NULL;
 	}
+
+	__ofono_watchlist_free(sms->text_handlers);
+	sms->text_handlers =3D NULL;
+
+	__ofono_watchlist_free(sms->datagram_handlers);
+	sms->datagram_handlers =3D NULL;
 }
 =

 static void sms_remove(struct ofono_atom *atom)
@@ -1741,6 +1867,9 @@ void ofono_sms_register(struct ofono_sms *sms)
 		sms->driver->bearer_set(sms, sms->bearer,
 						bearer_init_callback, sms);
 =

+	sms->text_handlers =3D __ofono_watchlist_new(g_free);
+	sms->datagram_handlers =3D __ofono_watchlist_new(g_free);
+
 	__ofono_atom_register(sms->atom, sms_unregister);
 }
 =

-- =

1.7.0.4


--===============8946248133232624840==--

