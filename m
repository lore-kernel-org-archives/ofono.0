Content-Type: multipart/mixed; boundary="===============8448550843734849379=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/9] gril: Library to communicate with rild
Date: Tue, 13 Oct 2015 18:07:52 +0200
Message-ID: <1444752478-18198-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8448550843734849379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tony Espy <espy@canonical.com>

gril is a library used to communicate with rild, the Android telephony
daemon. Communication happens using a named socket over which binder
parcels are transmitted.

Co-authored-by: Tony Espy <espy@canonical.com>
Co-authored-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Co-authored-by: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.co=
m>
Co-authored-by: Mikko Hurskainen <mikko.hurskainen@nomovok.com>
Co-authored-by: You-Sheng Yang <vicamo.yang@canonical.com>
Co-authored-by: Ratchanan Srirattanamet <peathot@hotmail.com>
---
 gril/gfunc.h         |   42 ++
 gril/gril.c          | 1295 ++++++++++++++++++++++++++++++++++++++++++++
 gril/gril.h          |  172 ++++++
 gril/grilio.c        |  399 ++++++++++++++
 gril/grilio.h        |   69 +++
 gril/grilreply.c     | 1450 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gril/grilreply.h     |  185 +++++++
 gril/grilrequest.c   | 1161 ++++++++++++++++++++++++++++++++++++++++
 gril/grilrequest.h   |  293 ++++++++++
 gril/grilunsol.c     |  638 ++++++++++++++++++++++
 gril/grilunsol.h     |   99 ++++
 gril/grilutil.c      |  830 +++++++++++++++++++++++++++++
 gril/grilutil.h      |   63 +++
 gril/parcel.c        |  293 ++++++++++
 gril/parcel.h        |   53 ++
 gril/ril_constants.h |  429 +++++++++++++++
 16 files changed, 7471 insertions(+)
 create mode 100644 gril/gfunc.h
 create mode 100644 gril/gril.c
 create mode 100644 gril/gril.h
 create mode 100644 gril/grilio.c
 create mode 100644 gril/grilio.h
 create mode 100644 gril/grilreply.c
 create mode 100644 gril/grilreply.h
 create mode 100644 gril/grilrequest.c
 create mode 100644 gril/grilrequest.h
 create mode 100644 gril/grilunsol.c
 create mode 100644 gril/grilunsol.h
 create mode 100644 gril/grilutil.c
 create mode 100644 gril/grilutil.h
 create mode 100644 gril/parcel.c
 create mode 100644 gril/parcel.h
 create mode 100644 gril/ril_constants.h

diff --git a/gril/gfunc.h b/gril/gfunc.h
new file mode 100644
index 0000000..5e13b7d
--- /dev/null
+++ b/gril/gfunc.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#ifndef __GFUNC_H
+#define __GFUNC_H
+
+#include <glib.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef void (*GRilDisconnectFunc)(gpointer user_data);
+typedef void (*GRilReceiveFunc)(const unsigned char *data, gsize size,
+							gpointer user_data);
+typedef void (*GRilDebugFunc)(const char *str, gpointer user_data);
+typedef void (*GRilSuspendFunc)(gpointer user_data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GFUNC_H */
diff --git a/gril/gril.c b/gril/gril.c
new file mode 100644
index 0000000..fb6c1a9
--- /dev/null
+++ b/gril/gril.c
@@ -0,0 +1,1295 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013 Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "log.h"
+#include "ringbuffer.h"
+#include "gril.h"
+#include "grilutil.h"
+
+#define RIL_TRACE(ril, fmt, arg...) do {	\
+	if (ril->trace =3D=3D TRUE)			\
+		ofono_debug(fmt, ## arg);	\
+} while (0)
+
+#define COMMAND_FLAG_EXPECT_PDU			0x1
+#define COMMAND_FLAG_EXPECT_SHORT_PROMPT	0x2
+
+#define	RADIO_GID 1001
+#define	RADIO_UID 1001
+
+struct ril_request {
+	gchar *data;
+	guint data_len;
+	gint req;
+	gint id;
+	guint gid;
+	GRilResponseFunc callback;
+	gpointer user_data;
+	GDestroyNotify notify;
+};
+
+struct ril_notify_node {
+	guint id;
+	guint gid;
+	GRilNotifyFunc callback;
+	gpointer user_data;
+	gboolean destroyed;
+};
+
+typedef gboolean (*node_remove_func)(struct ril_notify_node *node,
+					gpointer user_data);
+
+struct ril_notify {
+	GSList *nodes;
+};
+
+struct ril_s {
+	gint ref_count;				/* Ref count */
+	gint next_cmd_id;			/* Next command id */
+	guint next_notify_id;			/* Next notify id */
+	guint next_gid;				/* Next group id */
+	GRilIO *io;				/* GRil IO */
+	GQueue *command_queue;			/* Command queue */
+	GQueue *out_queue;			/* Commands sent/been sent */
+	guint req_bytes_written;		/* bytes written from req */
+	GHashTable *notify_list;		/* List of notification reg */
+	GRilDisconnectFunc user_disconnect;	/* user disconnect func */
+	gpointer user_disconnect_data;		/* user disconnect data */
+	guint read_so_far;			/* Number of bytes processed */
+	gboolean suspended;			/* Are we suspended? */
+	GRilDebugFunc debugf;			/* debugging output function */
+	gpointer debug_data;			/* Data to pass to debug func */
+	gboolean debug;
+	gboolean trace;
+	gint timeout_source;
+	gboolean destroyed;			/* Re-entrancy guard */
+	gboolean in_read_handler;		/* Re-entrancy guard */
+	gboolean in_notify;
+	enum ofono_ril_vendor vendor;
+	int slot;
+	GRilMsgIdToStrFunc req_to_string;
+	GRilMsgIdToStrFunc unsol_to_string;
+};
+
+struct _GRil {
+	gint ref_count;
+	struct ril_s *parent;
+	guint group;
+};
+
+struct req_hdr {
+	/* Warning: length is stored in network order */
+	uint32_t length;
+	uint32_t reqid;
+	uint32_t serial;
+};
+
+#define RIL_PRINT_BUF_SIZE 8096
+char print_buf[RIL_PRINT_BUF_SIZE] __attribute__((used));
+
+static void ril_wakeup_writer(struct ril_s *ril);
+
+static const char *request_id_to_string(struct ril_s *ril, int req)
+{
+	const char *str =3D NULL;
+
+	if (ril->req_to_string)
+		str =3D ril->req_to_string(req);
+
+	if (str =3D=3D NULL)
+		str =3D ril_request_id_to_string(req);
+
+	return str;
+}
+
+static const char *unsol_request_to_string(struct ril_s *ril, int req)
+{
+	const char *str =3D NULL;
+
+	if (ril->unsol_to_string)
+		str =3D ril->unsol_to_string(req);
+
+	if (str =3D=3D NULL)
+		str =3D ril_unsol_request_to_string(req);
+
+	return str;
+}
+
+static void ril_notify_node_destroy(gpointer data, gpointer user_data)
+{
+	struct ril_notify_node *node =3D data;
+	g_free(node);
+}
+
+static void ril_notify_destroy(gpointer user_data)
+{
+	struct ril_notify *notify =3D user_data;
+
+	g_slist_foreach(notify->nodes, ril_notify_node_destroy, NULL);
+	g_slist_free(notify->nodes);
+	g_free(notify);
+}
+
+static gint ril_notify_node_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct ril_notify_node *node =3D a;
+	guint id =3D GPOINTER_TO_UINT(b);
+
+	if (node->id < id)
+		return -1;
+
+	if (node->id > id)
+		return 1;
+
+	return 0;
+}
+
+static gboolean ril_unregister_all(struct ril_s *ril,
+					gboolean mark_only,
+					node_remove_func func,
+					gpointer userdata)
+{
+	GHashTableIter iter;
+	struct ril_notify *notify;
+	struct ril_notify_node *node;
+	gpointer key, value;
+	GSList *p;
+	GSList *c;
+	GSList *t;
+
+	if (ril->notify_list =3D=3D NULL)
+		return FALSE;
+
+	g_hash_table_iter_init(&iter, ril->notify_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		notify =3D value;
+
+		p =3D NULL;
+		c =3D notify->nodes;
+
+		while (c) {
+			node =3D c->data;
+
+			if (func(node, userdata) !=3D TRUE) {
+				p =3D c;
+				c =3D c->next;
+				continue;
+			}
+
+			if (mark_only) {
+				node->destroyed =3D TRUE;
+				p =3D c;
+				c =3D c->next;
+				continue;
+			}
+
+			if (p)
+				p->next =3D c->next;
+			else
+				notify->nodes =3D c->next;
+
+			ril_notify_node_destroy(node, NULL);
+
+			t =3D c;
+			c =3D c->next;
+			g_slist_free_1(t);
+		}
+
+		if (notify->nodes =3D=3D NULL)
+			g_hash_table_iter_remove(&iter);
+	}
+
+	return TRUE;
+}
+
+/*
+ * This function creates a RIL request.  For a good reference on
+ * the layout of RIL requests, responses, and unsolicited requests
+ * see:
+ *
+ * https://wiki.mozilla.org/B2G/RIL
+ */
+static struct ril_request *ril_request_create(struct ril_s *ril,
+						guint gid,
+						const gint req,
+						const gint id,
+						struct parcel *rilp,
+						GRilResponseFunc func,
+						gpointer user_data,
+						GDestroyNotify notify,
+						gboolean wakeup)
+{
+	struct ril_request *r;
+	struct req_hdr header;
+	guint data_len =3D 0;
+
+	if (rilp !=3D NULL)
+		data_len =3D rilp->size;
+
+	r =3D g_try_new0(struct ril_request, 1);
+	if (r =3D=3D NULL) {
+		ofono_error("%s Out of memory", __func__);
+		return NULL;
+	}
+
+	/* Full request size: header size plus buffer length */
+	r->data_len =3D data_len + sizeof(header);
+
+	r->data =3D g_try_new(char, r->data_len);
+	if (r->data =3D=3D NULL) {
+		ofono_error("ril_request: can't allocate new request.");
+		g_free(r);
+		return NULL;
+	}
+
+	/* Length does not include the length field. Network order. */
+	header.length =3D htonl(r->data_len - sizeof(header.length));
+	header.reqid =3D req;
+	header.serial =3D id;
+
+	/* copy header */
+	memcpy(r->data, &header, sizeof(header));
+	/* copy request data */
+	if (data_len)
+		memcpy(r->data + sizeof(header), rilp->data, data_len);
+
+	r->req =3D req;
+	r->gid =3D gid;
+	r->id =3D id;
+	r->callback =3D func;
+	r->user_data =3D user_data;
+	r->notify =3D notify;
+
+	return r;
+}
+
+static void ril_request_destroy(struct ril_request *req)
+{
+	if (req->notify)
+		req->notify(req->user_data);
+
+	g_free(req->data);
+	g_free(req);
+}
+
+static void ril_cleanup(struct ril_s *p)
+{
+	/* Cleanup pending commands */
+
+	if (p->command_queue) {
+		g_queue_free(p->command_queue);
+		p->command_queue =3D NULL;
+	}
+
+	if (p->out_queue) {
+		g_queue_free(p->out_queue);
+		p->out_queue =3D NULL;
+	}
+
+	/* Cleanup registered notifications */
+	if (p->notify_list) {
+		g_hash_table_destroy(p->notify_list);
+		p->notify_list =3D NULL;
+	}
+
+	if (p->timeout_source) {
+		g_source_remove(p->timeout_source);
+		p->timeout_source =3D 0;
+	}
+}
+
+void g_ril_set_disconnect_function(GRil *ril, GRilDisconnectFunc disconnec=
t,
+					gpointer user_data)
+{
+	ril->parent->user_disconnect =3D disconnect;
+	ril->parent->user_disconnect_data =3D user_data;
+}
+
+static void io_disconnect(gpointer user_data)
+{
+	struct ril_s *ril =3D user_data;
+
+	ofono_error("%s: disconnected from rild", __func__);
+
+	ril_cleanup(ril);
+	g_ril_io_unref(ril->io);
+	ril->io =3D NULL;
+
+	if (ril->user_disconnect)
+		ril->user_disconnect(ril->user_disconnect_data);
+}
+
+static void handle_response(struct ril_s *p, struct ril_msg *message)
+{
+	gsize count =3D g_queue_get_length(p->command_queue);
+	struct ril_request *req;
+	gboolean found =3D FALSE;
+	guint i, len;
+	gint id;
+
+	g_assert(count > 0);
+
+	for (i =3D 0; i < count; i++) {
+		req =3D g_queue_peek_nth(p->command_queue, i);
+
+		if (req->id =3D=3D message->serial_no) {
+			found =3D TRUE;
+			message->req =3D req->req;
+
+			if (message->error !=3D RIL_E_SUCCESS)
+				RIL_TRACE(p, "[%d,%04d]< %s failed %s",
+					p->slot, message->serial_no,
+					request_id_to_string(p, message->req),
+					ril_error_to_string(message->error));
+
+			req =3D g_queue_pop_nth(p->command_queue, i);
+			if (req->callback)
+				req->callback(message, req->user_data);
+
+			len =3D g_queue_get_length(p->out_queue);
+
+			for (i =3D 0; i < len; i++) {
+				id =3D GPOINTER_TO_INT(g_queue_peek_nth(
+							p->out_queue, i));
+				if (id =3D=3D req->id) {
+					g_queue_pop_nth(p->out_queue, i);
+					break;
+				}
+			}
+
+			ril_request_destroy(req);
+
+			if (g_queue_peek_head(p->command_queue))
+				ril_wakeup_writer(p);
+
+			break;
+		}
+	}
+
+	if (found =3D=3D FALSE)
+		ofono_error("No matching request for reply: %s serial_no: %d!",
+			request_id_to_string(p, message->req),
+			message->serial_no);
+
+}
+
+static gboolean node_check_destroyed(struct ril_notify_node *node,
+					gpointer userdata)
+{
+	gboolean val =3D GPOINTER_TO_UINT(userdata);
+
+	if (node->destroyed =3D=3D val)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void handle_unsol_req(struct ril_s *p, struct ril_msg *message)
+{
+	GHashTableIter iter;
+	struct ril_notify *notify;
+	int req_key;
+	gpointer key, value;
+	GList *list_item;
+	struct ril_notify_node *node;
+	gboolean found =3D FALSE;
+
+	if (p->notify_list =3D=3D NULL)
+		return;
+
+	p->in_notify =3D TRUE;
+
+	g_hash_table_iter_init(&iter, p->notify_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		req_key =3D *((int *)key);
+		notify =3D value;
+
+		if (req_key !=3D message->req)
+			continue;
+
+		list_item =3D (GList *) notify->nodes;
+
+		while (list_item !=3D NULL) {
+			node =3D list_item->data;
+
+			node->callback(message, node->user_data);
+			found =3D TRUE;
+			list_item =3D (GList *) g_slist_next(list_item);
+		}
+	}
+
+	/* Only log events not being listended for... */
+	if (!found)
+		DBG("RIL Event slot %d: %s\n",
+			p->slot, unsol_request_to_string(p, message->req));
+
+	p->in_notify =3D FALSE;
+
+	/* Now destroy nodes possibly removed by callbacks */
+	if (found)
+		ril_unregister_all(p, FALSE, node_check_destroyed,
+					GUINT_TO_POINTER(TRUE));
+}
+
+static void dispatch(struct ril_s *p, struct ril_msg *message)
+{
+	int32_t *unsolicited_field, *id_num_field;
+	gchar *bufp =3D message->buf;
+	gchar *datap;
+	gsize data_len;
+
+	/* This could be done with a struct/union... */
+	unsolicited_field =3D (int32_t *) (void *) bufp;
+	if (*unsolicited_field)
+		message->unsolicited =3D TRUE;
+	else
+		message->unsolicited =3D FALSE;
+
+	bufp +=3D 4;
+
+	id_num_field =3D (int32_t *) (void *) bufp;
+	if (message->unsolicited) {
+		message->req =3D (int) *id_num_field;
+
+		/*
+		 * A RIL Unsolicited Event is two UINT32 fields ( unsolicited,
+		 * and req/ev ), so subtract the length of the header from the
+		 * overall length to calculate the length of the Event Data.
+		 */
+		data_len =3D message->buf_len - 8;
+	} else {
+		message->serial_no =3D (int) *id_num_field;
+
+		bufp +=3D 4;
+		message->error =3D *((int32_t *) (void *) bufp);
+
+		/*
+		 * A RIL Solicited Response is three UINT32 fields ( unsolicied,
+		 * serial_no and error ), so subtract the length of the header
+		 * from the overall length to calculate the length of the Event
+		 * Data.
+		 */
+		data_len =3D message->buf_len - 12;
+	}
+
+	/* advance to start of data.. */
+	bufp +=3D 4;
+
+	/*
+	 * Now, use buffer for event data if present
+	 */
+	if (data_len) {
+		datap =3D g_try_malloc(data_len);
+		if (datap =3D=3D NULL)
+			goto error;
+
+		/* Copy event bytes from message->buf into new buffer */
+		memcpy(datap, bufp, data_len);
+
+		/* Free buffer that includes header */
+		g_free(message->buf);
+
+		/* ...and replace with new buffer */
+		message->buf =3D datap;
+		message->buf_len =3D data_len;
+	} else {
+		/* Free buffer that includes header */
+		g_free(message->buf);
+
+		/* To know if there was no data when parsing */
+		message->buf =3D NULL;
+		message->buf_len =3D 0;
+	}
+
+	if (message->unsolicited =3D=3D TRUE)
+		handle_unsol_req(p, message);
+	else
+		handle_response(p, message);
+
+error:
+	g_free(message->buf);
+	g_free(message);
+}
+
+static struct ril_msg *read_fixed_record(struct ril_s *p,
+						const guchar *bytes, gsize *len)
+{
+	struct ril_msg *message;
+	unsigned message_len, plen;
+
+	/* First four bytes are length in TCP byte order (Big Endian) */
+	plen =3D ntohl(*((uint32_t *) (void *) bytes));
+	bytes +=3D 4;
+
+	/*
+	 * TODO: Verify that 4k is the max message size from rild.
+	 *
+	 * These conditions shouldn't happen.  If it does
+	 * there are three options:
+	 *
+	 * 1) ASSERT; ofono will restart via DBus
+	 * 2) Consume the bytes & continue
+	 * 3) force a disconnect
+	 */
+	g_assert(plen >=3D 8 && plen <=3D 4092);
+
+	/*
+	 * If we don't have the whole fixed record in the ringbuffer
+	 * then return NULL & leave ringbuffer as is.
+	 */
+
+	message_len =3D *len - 4;
+	if (message_len < plen)
+		return NULL;
+
+	message =3D g_try_malloc(sizeof(struct ril_msg));
+	g_assert(message !=3D NULL);
+
+	/* allocate ril_msg->buffer */
+	message->buf_len =3D plen;
+	message->buf =3D g_try_malloc(plen);
+	g_assert(message->buf !=3D NULL);
+
+	/* Copy bytes into message buffer */
+	memmove(message->buf, (const void *) bytes, plen);
+
+	/* Indicate to caller size of record we extracted */
+	*len =3D plen + 4;
+	return message;
+}
+
+static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
+{
+	struct ril_msg *message;
+	struct ril_s *p =3D user_data;
+	unsigned int len =3D ring_buffer_len(rbuf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
+	guchar *buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
+
+	p->in_read_handler =3D TRUE;
+
+	while (p->suspended =3D=3D FALSE && (p->read_so_far < len)) {
+		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
+
+		if (rbytes < 4) {
+			DBG("Not enough bytes for header length: len: %d", len);
+			return;
+		}
+
+		/*
+		 * This function attempts to read the next full length
+		 * fixed message from the stream.  if not all bytes are
+		 * available, it returns NULL.  otherwise it allocates
+		 * and returns a ril_message with the copied bytes, and
+		 * drains those bytes from the ring_buffer
+		 */
+		message =3D read_fixed_record(p, buf, &rbytes);
+
+		/* wait for the rest of the record... */
+		if (message =3D=3D NULL)
+			break;
+
+		buf +=3D rbytes;
+		p->read_so_far +=3D rbytes;
+
+		/* TODO: need to better understand how wrap works! */
+		if (p->read_so_far =3D=3D wrap) {
+			buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
+			wrap =3D len;
+		}
+
+		dispatch(p, message);
+
+		ring_buffer_drain(rbuf, p->read_so_far);
+
+		len -=3D p->read_so_far;
+		wrap -=3D p->read_so_far;
+		p->read_so_far =3D 0;
+	}
+
+	p->in_read_handler =3D FALSE;
+
+	if (p->destroyed)
+		g_free(p);
+}
+
+/*
+ * This function is a GIOFunc and may be called directly or via an IO watc=
h.
+ * The return value controls whether the watch stays active ( TRUE ), or is
+ * removed ( FALSE ).
+ */
+static gboolean can_write_data(gpointer data)
+{
+	struct ril_s *ril =3D data;
+	struct ril_request *req;
+	gsize bytes_written, towrite, len;
+	guint qlen, oqlen;
+	gint id;
+	gboolean written =3D TRUE;
+	guint i, j;
+
+	qlen =3D g_queue_get_length(ril->command_queue);
+	if (qlen < 1)
+		return FALSE;
+
+	/* if the whole request was not written */
+	if (ril->req_bytes_written !=3D 0) {
+
+		for (i =3D 0; i < qlen; i++) {
+			req =3D g_queue_peek_nth(ril->command_queue, i);
+			if (req) {
+				id =3D GPOINTER_TO_INT(g_queue_peek_head(
+							ril->out_queue));
+				if (req->id =3D=3D id)
+					goto out;
+			} else {
+				return FALSE;
+			}
+		}
+	}
+	/* if no requests already sent */
+	oqlen =3D g_queue_get_length(ril->out_queue);
+	if (oqlen < 1) {
+		req =3D g_queue_peek_head(ril->command_queue);
+		if (req =3D=3D NULL)
+			return FALSE;
+
+		g_queue_push_head(ril->out_queue, GINT_TO_POINTER(req->id));
+
+		goto out;
+	}
+
+	for (i =3D 0; i < qlen; i++) {
+		req =3D g_queue_peek_nth(ril->command_queue, i);
+		if (req =3D=3D NULL)
+			return FALSE;
+
+		for (j =3D 0; j < oqlen; j++) {
+			id =3D GPOINTER_TO_INT(
+					g_queue_peek_nth(ril->out_queue, j));
+			if (req->id =3D=3D id) {
+				written =3D TRUE;
+				break;
+			} else {
+				written =3D FALSE;
+			}
+		}
+
+		if (written =3D=3D FALSE)
+			break;
+	}
+
+	/* watcher fired though requests already written */
+	if (written =3D=3D TRUE)
+		return FALSE;
+
+	g_queue_push_head(ril->out_queue, GINT_TO_POINTER(req->id));
+
+out:
+	len =3D req->data_len;
+
+	towrite =3D len - ril->req_bytes_written;
+
+#ifdef WRITE_SCHEDULER_DEBUG
+	if (towrite > 5)
+		towrite =3D 5;
+#endif
+
+	bytes_written =3D g_ril_io_write(ril->io,
+					req->data + ril->req_bytes_written,
+					towrite);
+
+	if (bytes_written =3D=3D 0)
+		return FALSE;
+
+	ril->req_bytes_written +=3D bytes_written;
+	if (bytes_written < towrite)
+		return TRUE;
+	else
+		ril->req_bytes_written =3D 0;
+
+	return FALSE;
+}
+
+static void ril_wakeup_writer(struct ril_s *ril)
+{
+	g_ril_io_set_write_handler(ril->io, can_write_data, ril);
+}
+
+static void ril_suspend(struct ril_s *ril)
+{
+	ril->suspended =3D TRUE;
+
+	g_ril_io_set_write_handler(ril->io, NULL, NULL);
+	g_ril_io_set_read_handler(ril->io, NULL, NULL);
+	g_ril_io_set_debug(ril->io, NULL, NULL);
+}
+
+static gboolean ril_set_debug(struct ril_s *ril,
+				GRilDebugFunc func, gpointer user_data)
+{
+
+	ril->debugf =3D func;
+	ril->debug_data =3D user_data;
+
+	if (ril->io)
+		g_ril_io_set_debug(ril->io, func, user_data);
+
+	return TRUE;
+}
+
+static void ril_unref(struct ril_s *ril)
+{
+	gboolean is_zero;
+
+	is_zero =3D g_atomic_int_dec_and_test(&ril->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	if (ril->io) {
+		ril_suspend(ril);
+		g_ril_io_unref(ril->io);
+		ril->io =3D NULL;
+		ril_cleanup(ril);
+	}
+
+	if (ril->in_read_handler)
+		ril->destroyed =3D TRUE;
+	else
+		g_free(ril);
+}
+
+static gboolean node_compare_by_group(struct ril_notify_node *node,
+					gpointer userdata)
+{
+	guint group =3D GPOINTER_TO_UINT(userdata);
+
+	if (node->gid =3D=3D group)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void set_process_id(gid_t gid, uid_t uid)
+{
+	if (setegid(gid) < 0)
+		ofono_error("%s: setegid(%d) failed: %s (%d)",
+				__func__, gid, strerror(errno), errno);
+
+	if (seteuid(uid) < 0)
+		ofono_error("%s: seteuid(%d) failed: %s (%d)",
+				__func__, uid, strerror(errno), errno);
+}
+
+static struct ril_s *create_ril(const char *sock_path)
+
+{
+	struct ril_s *ril;
+	struct sockaddr_un addr;
+	int sk;
+	GIOChannel *io;
+
+	ril =3D g_try_new0(struct ril_s, 1);
+	if (ril =3D=3D NULL)
+		return ril;
+
+	ril->ref_count =3D 1;
+	ril->next_cmd_id =3D 1;
+	ril->next_notify_id =3D 1;
+	ril->next_gid =3D 0;
+	ril->debugf =3D NULL;
+	ril->req_bytes_written =3D 0;
+	ril->trace =3D FALSE;
+
+	/* sock_path is allowed to be NULL for unit tests */
+	if (sock_path =3D=3D NULL)
+		return ril;
+
+	sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sk < 0) {
+		ofono_error("create_ril: can't create unix socket: %s (%d)\n",
+				strerror(errno), errno);
+		goto error;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);
+
+	/* RIL expects user radio to connect to the socket */
+	set_process_id(RADIO_GID, RADIO_UID);
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		ofono_error("create_ril: can't connect to RILD: %s (%d)\n",
+				strerror(errno), errno);
+		/* Switch back to root */
+		set_process_id(0, 0);
+		goto error;
+	}
+
+	/* Switch back to root */
+	set_process_id(0, 0);
+
+	io =3D g_io_channel_unix_new(sk);
+	if (io =3D=3D NULL) {
+		ofono_error("create_ril: can't open RILD io channel: %s (%d)\n",
+				strerror(errno), errno);
+		goto error;
+	}
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	ril->io =3D g_ril_io_new(io);
+	if (ril->io =3D=3D NULL) {
+		ofono_error("create_ril: can't create ril->io");
+		goto error;
+	}
+
+	g_ril_io_set_disconnect_function(ril->io, io_disconnect, ril);
+
+	ril->command_queue =3D g_queue_new();
+	if (ril->command_queue =3D=3D NULL) {
+		ofono_error("create_ril: Couldn't create command_queue.");
+		goto error;
+	}
+
+	ril->out_queue =3D g_queue_new();
+	if (ril->out_queue =3D=3D NULL) {
+		ofono_error("create_ril: Couldn't create out_queue.");
+		goto error;
+	}
+
+	ril->notify_list =3D g_hash_table_new_full(g_int_hash, g_int_equal,
+							g_free,
+							ril_notify_destroy);
+
+	g_ril_io_set_read_handler(ril->io, new_bytes, ril);
+
+	return ril;
+
+error:
+	ril_unref(ril);
+
+	return NULL;
+}
+
+static struct ril_notify *ril_notify_create(struct ril_s *ril,
+						const int req)
+{
+	struct ril_notify *notify;
+	int *key;
+
+	notify =3D g_try_new0(struct ril_notify, 1);
+	if (notify =3D=3D NULL)
+		return 0;
+
+	key =3D g_try_new0(int, 1);
+	if (key =3D=3D NULL)
+		return 0;
+
+	*key =3D req;
+
+	g_hash_table_insert(ril->notify_list, key, notify);
+
+	return notify;
+}
+
+static void ril_cancel_group(struct ril_s *ril, guint group)
+{
+	int n =3D 0;
+	guint len, i;
+	struct ril_request *req;
+	gboolean sent;
+
+	if (ril->command_queue =3D=3D NULL)
+		return;
+
+	while ((req =3D g_queue_peek_nth(ril->command_queue, n)) !=3D NULL) {
+		if (req->id =3D=3D 0 || req->gid !=3D group) {
+			n +=3D 1;
+			continue;
+		}
+
+		req->callback =3D NULL;
+		sent =3D FALSE;
+
+		len =3D g_queue_get_length(ril->out_queue);
+		for (i =3D 0; i < len; i++) {
+			if (GPOINTER_TO_INT(
+					g_queue_peek_nth(ril->out_queue, i))
+					=3D=3D req->id) {
+				n +=3D 1;
+				sent =3D TRUE;
+				break;
+			}
+		 }
+
+		if (sent)
+			continue;
+
+		g_queue_remove(ril->command_queue, req);
+		ril_request_destroy(req);
+	}
+}
+
+static guint ril_register(struct ril_s *ril, guint group,
+				const int req, GRilNotifyFunc func,
+				gpointer user_data)
+{
+	struct ril_notify *notify;
+	struct ril_notify_node *node;
+
+	if (ril->notify_list =3D=3D NULL)
+		return 0;
+
+	if (func =3D=3D NULL)
+		return 0;
+
+	notify =3D g_hash_table_lookup(ril->notify_list, &req);
+
+	if (notify =3D=3D NULL)
+		notify =3D ril_notify_create(ril, req);
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	node =3D g_try_new0(struct ril_notify_node, 1);
+	if (node =3D=3D NULL)
+		return 0;
+
+	node->id =3D ril->next_notify_id++;
+	node->gid =3D group;
+	node->callback =3D func;
+	node->user_data =3D user_data;
+
+	notify->nodes =3D g_slist_prepend(notify->nodes, node);
+
+	return node->id;
+}
+
+static gboolean ril_unregister(struct ril_s *ril, gboolean mark_only,
+					guint group, guint id)
+{
+	GHashTableIter iter;
+	struct ril_notify *notify;
+	struct ril_notify_node *node;
+	gpointer key, value;
+	GSList *l;
+
+	if (ril->notify_list =3D=3D NULL)
+		return FALSE;
+
+	g_hash_table_iter_init(&iter, ril->notify_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		notify =3D value;
+
+		l =3D g_slist_find_custom(notify->nodes, GUINT_TO_POINTER(id),
+					ril_notify_node_compare_by_id);
+
+		if (l =3D=3D NULL)
+			continue;
+
+		node =3D l->data;
+
+		if (node->gid !=3D group)
+			return FALSE;
+
+		if (mark_only) {
+			node->destroyed =3D TRUE;
+			return TRUE;
+		}
+
+		ril_notify_node_destroy(node, NULL);
+		notify->nodes =3D g_slist_remove(notify->nodes, node);
+
+		if (notify->nodes =3D=3D NULL)
+			g_hash_table_iter_remove(&iter);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+void g_ril_init_parcel(const struct ril_msg *message, struct parcel *rilp)
+{
+	/* Set up Parcel struct for proper parsing */
+	rilp->data =3D message->buf;
+	rilp->size =3D message->buf_len;
+	rilp->capacity =3D message->buf_len;
+	rilp->offset =3D 0;
+	rilp->malformed =3D 0;
+}
+
+GRil *g_ril_new(const char *sock_path, enum ofono_ril_vendor vendor)
+{
+	GRil *ril;
+
+	ril =3D g_try_new0(GRil, 1);
+	if (ril =3D=3D NULL)
+		return NULL;
+
+	ril->parent =3D create_ril(sock_path);
+	if (ril->parent =3D=3D NULL) {
+		g_free(ril);
+		return NULL;
+	}
+
+	ril->group =3D ril->parent->next_gid++;
+	ril->ref_count =3D 1;
+
+	ril->parent->vendor =3D vendor;
+
+	return ril;
+}
+
+GRil *g_ril_clone(GRil *clone)
+{
+	GRil *ril;
+
+	if (clone =3D=3D NULL)
+		return NULL;
+
+	ril =3D g_try_new0(GRil, 1);
+	if (ril =3D=3D NULL)
+		return NULL;
+
+	ril->parent =3D clone->parent;
+	ril->group =3D ril->parent->next_gid++;
+	ril->ref_count =3D 1;
+	g_atomic_int_inc(&ril->parent->ref_count);
+
+	return ril;
+}
+
+GIOChannel *g_ril_get_channel(GRil *ril)
+{
+	if (ril =3D=3D NULL || ril->parent->io =3D=3D NULL)
+		return NULL;
+
+	return g_ril_io_get_channel(ril->parent->io);
+
+}
+
+GRilIO *g_ril_get_io(GRil *ril)
+{
+	if (ril =3D=3D NULL)
+		return NULL;
+
+	return ril->parent->io;
+}
+
+GRil *g_ril_ref(GRil *ril)
+{
+	if (ril =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&ril->ref_count);
+
+	return ril;
+}
+
+gint g_ril_send(GRil *ril, const gint reqid, struct parcel *rilp,
+		GRilResponseFunc func, gpointer user_data,
+		GDestroyNotify notify)
+{
+	struct ril_request *r;
+	struct ril_s *p;
+
+	if (ril =3D=3D NULL
+		|| ril->parent =3D=3D NULL
+		|| ril->parent->command_queue =3D=3D NULL)
+			return 0;
+
+	p =3D ril->parent;
+
+	r =3D ril_request_create(p, ril->group, reqid, p->next_cmd_id, rilp,
+				func, user_data, notify, FALSE);
+
+	if (rilp !=3D NULL)
+		parcel_free(rilp);
+
+	if (r =3D=3D NULL)
+		return 0;
+
+	p->next_cmd_id++;
+
+	g_queue_push_tail(p->command_queue, r);
+
+	ril_wakeup_writer(p);
+
+	if (rilp =3D=3D NULL)
+		g_ril_print_request_no_args(ril, r->id, reqid);
+	else
+		g_ril_print_request(ril, r->id, reqid);
+
+	return r->id;
+}
+
+void g_ril_unref(GRil *ril)
+{
+	gboolean is_zero;
+
+	if (ril =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&ril->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	ril_cancel_group(ril->parent, ril->group);
+	g_ril_unregister_all(ril);
+	ril_unref(ril->parent);
+
+	g_free(ril);
+}
+
+gboolean g_ril_get_trace(GRil *ril)
+{
+
+	if (ril =3D=3D NULL || ril->parent =3D=3D NULL)
+		return FALSE;
+
+	return ril->parent->trace;
+}
+
+gboolean g_ril_set_trace(GRil *ril, gboolean trace)
+{
+
+	if (ril =3D=3D NULL || ril->parent =3D=3D NULL)
+		return FALSE;
+
+	return ril->parent->trace =3D trace;
+}
+
+gboolean g_ril_set_slot(GRil *ril, int slot)
+{
+	if (ril =3D=3D NULL || ril->parent =3D=3D NULL)
+		return FALSE;
+
+	ril->parent->slot =3D slot;
+	return TRUE;
+}
+
+int g_ril_get_slot(GRil *ril)
+{
+	if (ril =3D=3D NULL)
+		return 0;
+
+	return ril->parent->slot;
+}
+
+gboolean g_ril_set_debugf(GRil *ril,
+			GRilDebugFunc func, gpointer user_data)
+{
+
+	if (ril =3D=3D NULL || ril->group !=3D 0)
+		return FALSE;
+
+	return ril_set_debug(ril->parent, func, user_data);
+}
+
+gboolean g_ril_set_vendor_print_msg_id_funcs(GRil *ril,
+					GRilMsgIdToStrFunc req_to_string,
+					GRilMsgIdToStrFunc unsol_to_string)
+{
+	if (ril =3D=3D NULL || ril->parent =3D=3D NULL)
+		return FALSE;
+
+	ril->parent->req_to_string =3D req_to_string;
+	ril->parent->unsol_to_string =3D unsol_to_string;
+
+	return TRUE;
+}
+
+guint g_ril_register(GRil *ril, const int req,
+			GRilNotifyFunc func, gpointer user_data)
+{
+	if (ril =3D=3D NULL)
+		return 0;
+
+	return ril_register(ril->parent, ril->group, req,
+				func, user_data);
+}
+
+gboolean g_ril_unregister(GRil *ril, guint id)
+{
+	if (ril =3D=3D NULL)
+		return FALSE;
+
+	return ril_unregister(ril->parent, ril->parent->in_notify,
+					ril->group, id);
+}
+
+gboolean g_ril_unregister_all(GRil *ril)
+{
+	if (ril =3D=3D NULL)
+		return FALSE;
+
+	return ril_unregister_all(ril->parent,
+					ril->parent->in_notify,
+					node_compare_by_group,
+					GUINT_TO_POINTER(ril->group));
+}
+
+enum ofono_ril_vendor g_ril_vendor(GRil *ril)
+{
+	if (ril =3D=3D NULL)
+		return OFONO_RIL_VENDOR_AOSP;
+
+	return ril->parent->vendor;
+}
+
+const char *g_ril_request_id_to_string(GRil *ril, int req)
+{
+	return request_id_to_string(ril->parent, req);
+}
+
+const char *g_ril_unsol_request_to_string(GRil *ril, int req)
+{
+	return unsol_request_to_string(ril->parent, req);
+}
diff --git a/gril/gril.h b/gril/gril.h
new file mode 100644
index 0000000..7d64e7e
--- /dev/null
+++ b/gril/gril.h
@@ -0,0 +1,172 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012 Canonical Ltd.
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
+#ifndef __GRIL_H
+#define __GRIL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "grilio.h"
+#include "grilutil.h"
+#include "parcel.h"
+#include "ril_constants.h"
+#include "drivers/rilmodem/vendor.h"
+
+#define RIL_MAX_NUM_ACTIVE_DATA_CALLS 2
+
+struct _GRil;
+
+typedef struct _GRil GRil;
+
+/*
+ * This struct represents an entire RIL message read
+ * from the command socket.  It can hold responses or
+ * unsolicited requests from RILD.
+ */
+struct ril_msg {
+	gchar *buf;
+	gsize buf_len;
+	gboolean unsolicited;
+	int req;
+	int serial_no;
+	int error;
+};
+
+typedef void (*GRilResponseFunc)(struct ril_msg *message, gpointer user_da=
ta);
+
+typedef void (*GRilNotifyFunc)(struct ril_msg *message, gpointer user_data=
);
+
+typedef const char *(*GRilMsgIdToStrFunc)(int msg_id);
+
+/**
+ * TRACE:
+ * @fmt: format string
+ * @arg...: list of arguments
+ *
+ * Simple macro around ofono_debug() used for tracing RIL messages
+ * name it is called in.
+ */
+#define G_RIL_TRACE(gril, fmt, arg...) do {	\
+	if (gril && g_ril_get_trace(gril))	\
+		ofono_debug(fmt, ## arg);	\
+} while (0)
+
+extern char print_buf[];
+
+#define g_ril_print_request(gril, token, req)				\
+	G_RIL_TRACE(gril, "[%d,%04d]> %s %s",				\
+		g_ril_get_slot(gril), token,				\
+		g_ril_request_id_to_string(gril, req), print_buf)
+#define g_ril_print_request_no_args(gril, token, req)			\
+	G_RIL_TRACE(gril, "[%d,%04d]> %s",				\
+			g_ril_get_slot(gril), token,			\
+			g_ril_request_id_to_string(gril, req))
+#define g_ril_print_response(gril, message)				\
+	G_RIL_TRACE(gril, "[%d,%04d]< %s %s",				\
+			g_ril_get_slot(gril),				\
+			message->serial_no,				\
+			g_ril_request_id_to_string(gril, message->req), \
+							print_buf)
+#define g_ril_print_response_no_args(gril, message)			\
+	G_RIL_TRACE(gril, "[%d,%04d]< %s",				\
+		g_ril_get_slot(gril), message->serial_no,		\
+			g_ril_request_id_to_string(gril, message->req))
+
+#define g_ril_append_print_buf(gril, x...) do {	\
+	if (gril && g_ril_get_trace(gril))	\
+		sprintf(print_buf, x);		\
+} while (0)
+
+#define g_ril_print_unsol(gril, message)				\
+	G_RIL_TRACE(gril, "[%d,UNSOL]< %s %s",				\
+			g_ril_get_slot(gril),				\
+			g_ril_unsol_request_to_string(gril,		\
+							message->req),	\
+			print_buf)
+#define g_ril_print_unsol_no_args(gril, message)			\
+	G_RIL_TRACE(gril, "[%d,UNSOL]< %s", g_ril_get_slot(gril),	\
+			g_ril_unsol_request_to_string(gril, message->req))
+
+void g_ril_init_parcel(const struct ril_msg *message, struct parcel *rilp);
+
+GRil *g_ril_new(const char *sock_path, enum ofono_ril_vendor vendor);
+
+GIOChannel *g_ril_get_channel(GRil *ril);
+GRilIO *g_ril_get_io(GRil *ril);
+
+GRil *g_ril_ref(GRil *ril);
+void g_ril_unref(GRil *ril);
+
+GRil *g_ril_clone(GRil *ril);
+
+void g_ril_set_disconnect_function(GRil *ril, GRilDisconnectFunc disconnec=
t,
+					gpointer user_data);
+
+gboolean g_ril_get_trace(GRil *ril);
+gboolean g_ril_set_trace(GRil *ril, gboolean trace);
+
+int g_ril_get_slot(GRil *ril);
+gboolean g_ril_set_slot(GRil *ril, int slot);
+
+/*!
+ * If the function is not NULL, then on every read/write from the GIOChann=
el
+ * provided to GRil the logging function will be called with the
+ * input/output string and user data
+ */
+gboolean g_ril_set_debugf(GRil *ril, GRilDebugFunc func, gpointer user_dat=
a);
+
+gboolean g_ril_set_vendor_print_msg_id_funcs(GRil *ril,
+					GRilMsgIdToStrFunc req_to_string,
+					GRilMsgIdToStrFunc unsol_to_string);
+
+
+/*!
+ * Queue an RIL request for execution.  The request contents are given
+ * in data.  Once the command executes, the callback function given by
+ * func is called with user provided data in user_data.
+ *
+ * Returns an id of the queued command which can be canceled using
+ * g_ril_cancel.  If an error occurred, an id of 0 is returned.
+ *
+ */
+gint g_ril_send(GRil *ril, const gint reqid, struct parcel *rilp,
+		GRilResponseFunc func, gpointer user_data,
+		GDestroyNotify notify);
+
+guint g_ril_register(GRil *ril, const int req,
+			GRilNotifyFunc func, gpointer user_data);
+
+gboolean g_ril_unregister(GRil *ril, guint id);
+gboolean g_ril_unregister_all(GRil *ril);
+
+enum ofono_ril_vendor g_ril_vendor(GRil *ril);
+
+const char *g_ril_request_id_to_string(GRil *ril, int req);
+const char *g_ril_unsol_request_to_string(GRil *ril, int req);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRIL_H */
diff --git a/gril/grilio.c b/gril/grilio.c
new file mode 100644
index 0000000..14ae908
--- /dev/null
+++ b/gril/grilio.c
@@ -0,0 +1,399 @@
+/*
+ *
+ *  RIL chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "ringbuffer.h"
+#include "grilio.h"
+#include "grilutil.h"
+
+struct _GRilIO {
+	gint ref_count;				/* Ref count */
+	guint read_watch;			/* GSource read id, 0 if no */
+	guint write_watch;			/* GSource write id, 0 if no */
+	GIOChannel *channel;			/* comms channel */
+	GRilDisconnectFunc user_disconnect;	/* user disconnect func */
+	gpointer user_disconnect_data;		/* user disconnect data */
+	struct ring_buffer *buf;		/* Current read buffer */
+	guint max_read_attempts;		/* max reads / select */
+	GRilIOReadFunc read_handler;		/* Read callback */
+	gpointer read_data;			/* Read callback userdata */
+	gboolean use_write_watch;		/* Use write select */
+	GRilIOWriteFunc write_handler;		/* Write callback */
+	gpointer write_data;			/* Write callback userdata */
+	GRilDebugFunc debugf;			/* debugging output function */
+	gpointer debug_data;			/* Data to pass to debug func */
+	GRilDisconnectFunc write_done_func;	/* tx empty notifier */
+	gpointer write_done_data;		/* tx empty data */
+	gboolean destroyed;			/* Re-entrancy guard */
+};
+
+static void read_watcher_destroy_notify(gpointer user_data)
+{
+	GRilIO *io =3D user_data;
+
+	ring_buffer_free(io->buf);
+	io->buf =3D NULL;
+
+	io->debugf =3D NULL;
+	io->debug_data =3D NULL;
+
+	io->read_watch =3D 0;
+	io->read_handler =3D NULL;
+	io->read_data =3D NULL;
+
+	g_io_channel_unref(io->channel);
+	io->channel =3D NULL;
+
+	if (io->destroyed)
+		g_free(io);
+	else if (io->user_disconnect)
+		io->user_disconnect(io->user_disconnect_data);
+}
+
+static gboolean received_data(GIOChannel *channel, GIOCondition cond,
+				gpointer data)
+{
+	unsigned char *buf;
+	GRilIO *io =3D data;
+	GIOStatus status;
+	gsize rbytes;
+	gsize toread;
+	gsize total_read =3D 0;
+	guint read_count =3D 0;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	/* Regardless of condition, try to read all the data available */
+	do {
+		toread =3D ring_buffer_avail_no_wrap(io->buf);
+
+		if (toread =3D=3D 0)
+			break;
+
+		rbytes =3D 0;
+		buf =3D ring_buffer_write_ptr(io->buf, 0);
+
+		status =3D g_io_channel_read_chars(channel, (char *) buf,
+							toread, &rbytes, NULL);
+
+		g_ril_util_debug_hexdump(TRUE, (guchar *) buf, rbytes,
+						io->debugf, io->debug_data);
+
+		read_count++;
+
+		total_read +=3D rbytes;
+
+		if (rbytes > 0)
+			ring_buffer_write_advance(io->buf, rbytes);
+
+	} while (status =3D=3D G_IO_STATUS_NORMAL && rbytes > 0 &&
+					read_count < io->max_read_attempts);
+
+	if (total_read > 0 && io->read_handler)
+		io->read_handler(io->buf, io->read_data);
+
+	if (cond & (G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	if (read_count > 0 && rbytes =3D=3D 0 && status !=3D G_IO_STATUS_AGAIN)
+		return FALSE;
+
+	/* We're overflowing the buffer, shutdown the socket */
+	if (ring_buffer_avail(io->buf) =3D=3D 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+gsize g_ril_io_write(GRilIO *io, const gchar *data, gsize count)
+{
+	GIOStatus status;
+	gsize bytes_written;
+
+	status =3D g_io_channel_write_chars(io->channel, data,
+						count, &bytes_written, NULL);
+
+	if (status !=3D G_IO_STATUS_NORMAL) {
+		g_source_remove(io->read_watch);
+		return 0;
+	}
+
+	g_ril_util_debug_hexdump(FALSE, (guchar *) data, bytes_written,
+				io->debugf, io->debug_data);
+
+	return bytes_written;
+}
+
+static void write_watcher_destroy_notify(gpointer user_data)
+{
+	GRilIO *io =3D user_data;
+
+	io->write_watch =3D 0;
+	io->write_handler =3D NULL;
+	io->write_data =3D NULL;
+
+	if (io->write_done_func) {
+		io->write_done_func(io->write_done_data);
+		io->write_done_func =3D NULL;
+		io->write_done_data =3D NULL;
+	}
+}
+
+static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
+				gpointer data)
+{
+	GRilIO *io =3D data;
+
+	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	if (io->write_handler =3D=3D NULL)
+		return FALSE;
+
+	return io->write_handler(io->write_data);
+}
+
+static GRilIO *create_io(GIOChannel *channel, GIOFlags flags)
+{
+	GRilIO *io;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	io =3D g_try_new0(GRilIO, 1);
+	if (io =3D=3D NULL)
+		return io;
+
+	io->ref_count =3D 1;
+	io->debugf =3D NULL;
+
+	if (flags & G_IO_FLAG_NONBLOCK) {
+		io->max_read_attempts =3D 3;
+		io->use_write_watch =3D TRUE;
+	} else {
+		io->max_read_attempts =3D 1;
+		io->use_write_watch =3D FALSE;
+	}
+
+	io->buf =3D ring_buffer_new(8192);
+
+	if (!io->buf)
+		goto error;
+
+	if (!g_ril_util_setup_io(channel, flags))
+		goto error;
+
+	io->channel =3D channel;
+	io->read_watch =3D g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				received_data, io,
+				read_watcher_destroy_notify);
+
+	return io;
+
+error:
+	if (io->buf)
+		ring_buffer_free(io->buf);
+
+	g_free(io);
+
+	return NULL;
+}
+
+GRilIO *g_ril_io_new(GIOChannel *channel)
+{
+	return create_io(channel, G_IO_FLAG_NONBLOCK);
+}
+
+GRilIO *g_ril_io_new_blocking(GIOChannel *channel)
+{
+	return create_io(channel, 0);
+}
+
+GIOChannel *g_ril_io_get_channel(GRilIO *io)
+{
+	if (io =3D=3D NULL)
+		return NULL;
+
+	return io->channel;
+}
+
+gboolean g_ril_io_set_read_handler(GRilIO *io, GRilIOReadFunc read_handler,
+					gpointer user_data)
+{
+	if (io =3D=3D NULL)
+		return FALSE;
+
+	io->read_handler =3D read_handler;
+	io->read_data =3D user_data;
+
+	if (read_handler && ring_buffer_len(io->buf) > 0)
+		read_handler(io->buf, user_data);
+
+	return TRUE;
+}
+
+static gboolean call_blocking_read(gpointer user_data)
+{
+	GRilIO *io =3D user_data;
+
+	while (can_write_data(io->channel, G_IO_OUT, io) =3D=3D TRUE)
+		;
+
+	write_watcher_destroy_notify(io);
+
+	return FALSE;
+}
+
+gboolean g_ril_io_set_write_handler(GRilIO *io, GRilIOWriteFunc write_hand=
ler,
+					gpointer user_data)
+{
+	if (io =3D=3D NULL)
+		return FALSE;
+
+	if (io->write_watch > 0) {
+		if (write_handler =3D=3D NULL) {
+			g_source_remove(io->write_watch);
+			return TRUE;
+		}
+
+		return FALSE;
+	}
+
+	if (write_handler =3D=3D NULL)
+		return FALSE;
+
+	io->write_handler =3D write_handler;
+	io->write_data =3D user_data;
+
+	if (io->use_write_watch =3D=3D TRUE)
+		io->write_watch =3D g_io_add_watch_full(io->channel,
+				G_PRIORITY_HIGH,
+				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				can_write_data, io,
+				write_watcher_destroy_notify);
+	else
+		io->write_watch =3D g_idle_add(call_blocking_read, io);
+
+	return TRUE;
+}
+
+GRilIO *g_ril_io_ref(GRilIO *io)
+{
+	if (io =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&io->ref_count);
+
+	return io;
+}
+
+static gboolean io_shutdown(GRilIO *io)
+{
+	/* Don't trigger user disconnect on shutdown */
+	io->user_disconnect =3D NULL;
+	io->user_disconnect_data =3D NULL;
+
+	if (io->read_watch > 0)
+		g_source_remove(io->read_watch);
+
+	if (io->write_watch > 0)
+		g_source_remove(io->write_watch);
+
+	return TRUE;
+}
+
+void g_ril_io_unref(GRilIO *io)
+{
+	gboolean is_zero;
+
+	if (io =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&io->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	io_shutdown(io);
+
+	/* glib delays the destruction of the watcher until it exits, this
+	 * means we can't free the data just yet, even though we've been
+	 * destroyed already.  We have to wait until the read_watcher
+	 * destroy function gets called
+	 */
+	if (io->read_watch > 0)
+		io->destroyed =3D TRUE;
+	else
+		g_free(io);
+}
+
+gboolean g_ril_io_set_disconnect_function(GRilIO *io,
+			GRilDisconnectFunc disconnect, gpointer user_data)
+{
+	if (io =3D=3D NULL)
+		return FALSE;
+
+	io->user_disconnect =3D disconnect;
+	io->user_disconnect_data =3D user_data;
+
+	return TRUE;
+}
+
+gboolean g_ril_io_set_debug(GRilIO *io, GRilDebugFunc func, gpointer user_=
data)
+{
+	if (io =3D=3D NULL)
+		return FALSE;
+
+	io->debugf =3D func;
+	io->debug_data =3D user_data;
+
+	return TRUE;
+}
+
+void g_ril_io_set_write_done(GRilIO *io, GRilDisconnectFunc func,
+				gpointer user_data)
+{
+	if (io =3D=3D NULL)
+		return;
+
+	io->write_done_func =3D func;
+	io->write_done_data =3D user_data;
+}
+
+void g_ril_io_drain_ring_buffer(GRilIO *io, guint len)
+{
+	ring_buffer_drain(io->buf, len);
+}
diff --git a/gril/grilio.h b/gril/grilio.h
new file mode 100644
index 0000000..22fb60e
--- /dev/null
+++ b/gril/grilio.h
@@ -0,0 +1,69 @@
+/*
+ *
+ *  RIL chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#ifndef __GRILIO_H
+#define __GRILIO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gfunc.h"
+
+struct _GRilIO;
+
+typedef struct _GRilIO GRilIO;
+
+struct ring_buffer;
+
+typedef void (*GRilIOReadFunc)(struct ring_buffer *buffer, gpointer user_d=
ata);
+typedef gboolean (*GRilIOWriteFunc)(gpointer user_data);
+
+GRilIO *g_ril_io_new(GIOChannel *channel);
+GRilIO *g_ril_io_new_blocking(GIOChannel *channel);
+
+GIOChannel *g_ril_io_get_channel(GRilIO *io);
+
+GRilIO *g_ril_io_ref(GRilIO *io);
+void g_ril_io_unref(GRilIO *io);
+
+gboolean g_ril_io_set_read_handler(GRilIO *io, GRilIOReadFunc read_handler,
+					gpointer user_data);
+gboolean g_ril_io_set_write_handler(GRilIO *io, GRilIOWriteFunc write_hand=
ler,
+					gpointer user_data);
+void g_ril_io_set_write_done(GRilIO *io, GRilDisconnectFunc func,
+				gpointer user_data);
+
+void g_ril_io_drain_ring_buffer(GRilIO *io, guint len);
+
+gsize g_ril_io_write(GRilIO *io, const gchar *data, gsize count);
+
+gboolean g_ril_io_set_disconnect_function(GRilIO *io,
+			GRilDisconnectFunc disconnect, gpointer user_data);
+
+gboolean g_ril_io_set_debug(GRilIO *io, GRilDebugFunc func, gpointer user_=
data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRILIO_H */
diff --git a/gril/grilreply.c b/gril/grilreply.c
new file mode 100644
index 0000000..8792f47
--- /dev/null
+++ b/gril/grilreply.c
@@ -0,0 +1,1450 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Contact: Jussi Kangas <jussi.kangas@tieto.com>
+ *  Copyright (C) 2012-2014  Canonical Ltd.
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
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/gprs-context.h>
+
+#include "common.h"
+#include "util.h"
+#include "grilreply.h"
+#include "grilutil.h"
+
+#define OPERATOR_NUM_PARAMS 3
+
+/* Indexes for registration state replies */
+#define RST_IX_STATE 0
+#define RST_IX_LAC 1
+#define RST_IX_CID 2
+#define RST_IX_RAT 3
+#define RDST_IX_MAXDC 5
+
+#define MTK_MODEM_MAX_CIDS 3
+
+static void ril_reply_free_operator(gpointer data)
+{
+	struct reply_operator *reply =3D data;
+
+	if (reply) {
+		g_free(reply->lalpha);
+		g_free(reply->salpha);
+		g_free(reply->numeric);
+		g_free(reply->status);
+		g_free(reply);
+	}
+}
+
+void g_ril_reply_free_avail_ops(struct reply_avail_ops *reply)
+{
+	if (reply) {
+		g_slist_free_full(reply->list, ril_reply_free_operator);
+		g_free(reply);
+	}
+}
+
+struct reply_avail_ops *g_ril_reply_parse_avail_ops(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct reply_operator *operator;
+	struct reply_avail_ops *reply =3D NULL;
+	unsigned int num_ops, num_strings;
+	unsigned int i;
+	int strings_per_opt;
+
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		strings_per_opt =3D 5;
+	else
+		strings_per_opt =3D 4;
+
+	/*
+	 * Minimum message length is 4:
+	 * - array size
+	 */
+	if (message->buf_len < 4) {
+		ofono_error("%s: invalid QUERY_AVAIL_NETWORKS reply: "
+				"size too small (< 4): %d ",
+				__func__,
+				(int) message->buf_len);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+	g_ril_append_print_buf(gril, "{");
+
+	/* Number of operators at the list */
+	num_strings =3D (unsigned int) parcel_r_int32(&rilp);
+	if (num_strings % strings_per_opt) {
+		ofono_error("%s: invalid QUERY_AVAIL_NETWORKS reply: "
+				"num_strings (%d) MOD %d !=3D 0",
+				__func__,
+				num_strings, strings_per_opt);
+		goto error;
+	}
+
+	num_ops =3D num_strings / strings_per_opt;
+	DBG("noperators =3D %d", num_ops);
+
+	reply =3D g_try_new0(struct reply_avail_ops, 1);
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: can't allocate reply struct", __func__);
+		goto error;
+	}
+
+	reply->num_ops =3D num_ops;
+	for (i =3D 0; i < num_ops; i++) {
+		operator =3D g_try_new0(struct reply_operator, 1);
+		if (operator =3D=3D NULL) {
+			ofono_error("%s: can't allocate reply struct",
+					__func__);
+			goto error;
+		}
+
+		operator->lalpha =3D parcel_r_string(&rilp);
+		operator->salpha =3D parcel_r_string(&rilp);
+		operator->numeric =3D parcel_r_string(&rilp);
+		operator->status =3D parcel_r_string(&rilp);
+
+		/*
+		 * MTK: additional string with technology: 2G/3G are the only
+		 * valid values currently.
+		 */
+		if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+			char *tech =3D parcel_r_string(&rilp);
+			if (strcmp(tech, "3G") =3D=3D 0)
+				operator->tech =3D RADIO_TECH_UMTS;
+			else
+				operator->tech =3D RADIO_TECH_GSM;
+			g_free(tech);
+		} else {
+			operator->tech =3D RADIO_TECH_GSM;
+		}
+
+		if (operator->lalpha =3D=3D NULL && operator->salpha =3D=3D NULL) {
+			ofono_error("%s: operator (%s) doesn't specify names",
+					operator->numeric,
+					__func__);
+			g_ril_reply_free_operator(operator);
+			continue;
+		}
+
+		if (operator->numeric =3D=3D NULL) {
+			ofono_error("%s: operator (%s/%s) "
+					"doesn't specify numeric",
+					operator->lalpha,
+					operator->salpha,
+					__func__);
+			g_ril_reply_free_operator(operator);
+			continue;
+		}
+
+		if (operator->status =3D=3D NULL) {
+			ofono_error("%s: operator (%s/%s) "
+					"doesn't specify status",
+					operator->lalpha,
+					operator->salpha,
+					__func__);
+			g_ril_reply_free_operator(operator);
+			continue;
+		}
+
+		reply->list =3D g_slist_append(reply->list, operator);
+
+		g_ril_append_print_buf(gril, "%s [lalpha=3D%s, salpha=3D%s, "
+				" numeric=3D%s status=3D%s tech=3D%s]",
+				print_buf,
+				operator->lalpha,
+				operator->salpha,
+				operator->numeric,
+				operator->status,
+				ril_radio_tech_to_string(operator->tech));
+	}
+
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	return reply;
+
+error:
+	if (reply)
+		g_ril_reply_free_avail_ops(reply);
+
+	return NULL;
+}
+
+void g_ril_reply_free_operator(struct reply_operator *reply)
+{
+	ril_reply_free_operator(reply);
+}
+
+struct reply_operator *g_ril_reply_parse_operator(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int num_params;
+	struct reply_operator *reply =3D NULL;
+
+	/*
+	 * Minimum message length is 16:
+	 * - array size
+	 * - 3 NULL strings
+	 */
+	if (message->buf_len < 16) {
+		ofono_error("%s: invalid OPERATOR reply: "
+				"size too small (< 16): %d ",
+				__func__,
+				(int) message->buf_len);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	num_params =3D parcel_r_int32(&rilp);
+	if (num_params !=3D OPERATOR_NUM_PARAMS) {
+		ofono_error("%s: invalid OPERATOR reply: "
+				"number of params is %d; should be 3.",
+				__func__,
+				num_params);
+		goto error;
+	}
+
+	reply =3D	g_new0(struct reply_operator, 1);
+
+	reply->lalpha =3D parcel_r_string(&rilp);
+	reply->salpha =3D parcel_r_string(&rilp);
+	reply->numeric =3D parcel_r_string(&rilp);
+
+	if (reply->lalpha =3D=3D NULL && reply->salpha =3D=3D NULL) {
+		ofono_error("%s: invalid OPERATOR reply: "
+				" no names returned.",
+				__func__);
+
+		goto error;
+	}
+
+	if (reply->numeric =3D=3D NULL) {
+		ofono_error("%s: invalid OPERATOR reply: "
+				" no numeric returned.",
+				__func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril,
+				"(lalpha=3D%s, salpha=3D%s, numeric=3D%s)",
+				reply->lalpha, reply->salpha, reply->numeric);
+
+	g_ril_print_response(gril, message);
+
+	return reply;
+
+error:
+	if (reply)
+		g_ril_reply_free_operator(reply);
+
+	return NULL;
+}
+
+static void set_reg_state(GRil *gril, struct reply_reg_state *reply,
+				int i, const char *str)
+{
+	int val;
+	char *endp;
+	int base;
+	const char *strstate;
+
+	if (str =3D=3D NULL || *str =3D=3D '\0')
+		goto no_val;
+
+	if (i =3D=3D RST_IX_LAC || i =3D=3D RST_IX_CID)
+		base =3D 16;
+	else
+		base =3D 10;
+
+	val =3D (int) strtol(str, &endp, base);
+	if (*endp !=3D '\0')
+		goto no_val;
+
+	switch (i) {
+	case RST_IX_STATE:
+		switch (val) {
+		case RIL_REG_STATE_NOT_REGISTERED:
+		case RIL_REG_STATE_REGISTERED:
+		case RIL_REG_STATE_SEARCHING:
+		case RIL_REG_STATE_DENIED:
+		case RIL_REG_STATE_UNKNOWN:
+		case RIL_REG_STATE_ROAMING:
+			/* Only valid values for ofono */
+			strstate =3D registration_status_to_string(val);
+			break;
+		case RIL_REG_STATE_EMERGENCY_NOT_REGISTERED:
+		case RIL_REG_STATE_EMERGENCY_SEARCHING:
+		case RIL_REG_STATE_EMERGENCY_DENIED:
+		case RIL_REG_STATE_EMERGENCY_UNKNOWN:
+			/* Map to states valid for ofono core */
+			val -=3D RIL_REG_STATE_EMERGENCY_NOT_REGISTERED;
+			strstate =3D str;
+			break;
+		default:
+			val =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+			strstate =3D str;
+		}
+		reply->status =3D val;
+		g_ril_append_print_buf(gril, "%s%s", print_buf, strstate);
+		break;
+	case RST_IX_LAC:
+		reply->lac =3D val;
+		g_ril_append_print_buf(gril, "%s0x%x", print_buf, val);
+		break;
+	case RST_IX_CID:
+		reply->ci =3D val;
+		g_ril_append_print_buf(gril, "%s0x%x", print_buf, val);
+		break;
+	case RST_IX_RAT:
+		g_ril_append_print_buf(gril, "%s%s", print_buf,
+					ril_radio_tech_to_string(val));
+
+		if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+			switch (val) {
+			case MTK_RADIO_TECH_HSDPAP:
+			case MTK_RADIO_TECH_HSDPAP_UPA:
+			case MTK_RADIO_TECH_HSUPAP:
+			case MTK_RADIO_TECH_HSUPAP_DPA:
+				val =3D RADIO_TECH_HSPAP;
+				break;
+			case MTK_RADIO_TECH_DC_DPA:
+				val =3D RADIO_TECH_HSDPA;
+				break;
+			case MTK_RADIO_TECH_DC_UPA:
+				val =3D RADIO_TECH_HSUPA;
+				break;
+			case MTK_RADIO_TECH_DC_HSDPAP:
+			case MTK_RADIO_TECH_DC_HSDPAP_UPA:
+			case MTK_RADIO_TECH_DC_HSDPAP_DPA:
+			case MTK_RADIO_TECH_DC_HSPAP:
+				val =3D RADIO_TECH_HSPAP;
+				break;
+			}
+		}
+
+		reply->tech =3D val;
+		break;
+	default:
+		goto no_val;
+	}
+
+	return;
+
+no_val:
+	g_ril_append_print_buf(gril, "%s%s", print_buf, str ? str : "(null)");
+}
+
+struct reply_reg_state *g_ril_reply_parse_voice_reg_state(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct parcel_str_array *str_arr;
+	struct reply_reg_state *reply =3D NULL;
+	int i;
+
+	g_ril_init_parcel(message, &rilp);
+
+	str_arr =3D parcel_r_str_array(&rilp);
+	if (str_arr =3D=3D NULL) {
+		ofono_error("%s: parse error for %s", __func__,
+				ril_request_id_to_string(message->req));
+		goto out;
+	}
+
+	reply =3D	g_try_malloc0(sizeof(*reply));
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto out;
+	}
+
+	reply->status =3D -1;
+	reply->lac =3D -1;
+	reply->ci =3D -1;
+
+	g_ril_append_print_buf(gril, "{");
+
+	for (i =3D 0; i < str_arr->num_str; ++i) {
+		char *str =3D str_arr->str[i];
+
+		if (i > 0)
+			g_ril_append_print_buf(gril, "%s,", print_buf);
+
+		switch (i) {
+		case RST_IX_STATE: case RST_IX_LAC:
+		case RST_IX_CID:   case RST_IX_RAT:
+			set_reg_state(gril, reply, i, str);
+			break;
+		default:
+			g_ril_append_print_buf(gril, "%s%s", print_buf,
+						str ? str : "(null)");
+		}
+	}
+
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	/* As a minimum we require a valid status string */
+	if (reply->status =3D=3D -1) {
+		ofono_error("%s: invalid status", __func__);
+		g_free(reply);
+		reply =3D NULL;
+	}
+
+out:
+	parcel_free_str_array(str_arr);
+
+	return reply;
+}
+
+static void set_data_reg_state(GRil *gril, struct reply_data_reg_state *re=
ply,
+				int i, const char *str)
+{
+	unsigned val;
+	char *endp;
+
+	if (str =3D=3D NULL || *str =3D=3D '\0')
+		goto no_val;
+
+	val =3D (unsigned) strtoul(str, &endp, 10);
+	if (*endp !=3D '\0')
+		goto no_val;
+
+	switch (i) {
+	case RDST_IX_MAXDC:
+		/*
+		 * MTK modem does not return max_cids, string for this index
+		 * actually contains the maximum data bearer capability.
+		 */
+		if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+			reply->max_cids =3D MTK_MODEM_MAX_CIDS;
+		else
+			reply->max_cids =3D val;
+		g_ril_append_print_buf(gril, "%s%u", print_buf, val);
+		break;
+	default:
+		goto no_val;
+	}
+
+	return;
+
+no_val:
+	g_ril_append_print_buf(gril, "%s%s", print_buf, str ? str : "(null)");
+}
+
+struct reply_data_reg_state *g_ril_reply_parse_data_reg_state(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct parcel_str_array *str_arr;
+	struct reply_data_reg_state *reply =3D NULL;
+	int i;
+
+	g_ril_init_parcel(message, &rilp);
+
+	str_arr =3D parcel_r_str_array(&rilp);
+	if (str_arr =3D=3D NULL) {
+		ofono_error("%s: parse error for %s", __func__,
+				ril_request_id_to_string(message->req));
+		goto out;
+	}
+
+	reply =3D	g_try_malloc0(sizeof(*reply));
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto out;
+	}
+
+	reply->reg_state.status =3D -1;
+	reply->reg_state.lac =3D -1;
+	reply->reg_state.ci =3D -1;
+
+	g_ril_append_print_buf(gril, "{");
+
+	for (i =3D 0; i < str_arr->num_str; ++i) {
+		char *str =3D str_arr->str[i];
+
+		if (i > 0)
+			g_ril_append_print_buf(gril, "%s,", print_buf);
+
+		switch (i) {
+		case RST_IX_STATE: case RST_IX_LAC:
+		case RST_IX_CID:   case RST_IX_RAT:
+			set_reg_state(gril, &reply->reg_state, i, str);
+			break;
+		case RDST_IX_MAXDC:
+			set_data_reg_state(gril, reply, i, str);
+			break;
+		default:
+			g_ril_append_print_buf(gril, "%s%s", print_buf,
+						str ? str : "(null)");
+		}
+	}
+
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	/* As a minimum we require a valid status string */
+	if (reply->reg_state.status =3D=3D -1) {
+		ofono_error("%s: invalid status", __func__);
+		g_free(reply);
+		reply =3D NULL;
+	}
+
+out:
+	parcel_free_str_array(str_arr);
+
+	return reply;
+}
+
+void g_ril_reply_free_sim_io(struct reply_sim_io *reply)
+{
+	if (reply) {
+		g_free(reply->hex_response);
+		g_free(reply);
+	}
+}
+
+struct reply_sim_io *g_ril_reply_parse_sim_io(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	char *response =3D NULL;
+	struct reply_sim_io *reply;
+
+	/*
+	 * Minimum length of SIM_IO_Response is 12:
+	 * sw1 (int32)
+	 * sw2 (int32)
+	 * simResponse (string)
+	 */
+	if (message->buf_len < 12) {
+		ofono_error("Invalid SIM IO reply: size too small (< 12): %d ",
+			    (int) message->buf_len);
+		return NULL;
+	}
+
+	reply =3D	g_new0(struct reply_sim_io, 1);
+
+	g_ril_init_parcel(message, &rilp);
+	reply->sw1 =3D parcel_r_int32(&rilp);
+	reply->sw2 =3D parcel_r_int32(&rilp);
+
+	response =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril,
+				"(sw1=3D0x%.2X,sw2=3D0x%.2X,%s)",
+				reply->sw1,
+				reply->sw2,
+				response);
+	g_ril_print_response(gril, message);
+
+	if (rilp.malformed)
+		goto error;
+
+	if (response !=3D NULL) {
+		reply->hex_response =3D
+			decode_hex(response, strlen(response),
+					(long *) &reply->hex_len, -1);
+		g_free(response);
+
+		if (reply->hex_response =3D=3D NULL)
+			goto error;
+	}
+
+	return reply;
+
+error:
+	g_free(reply);
+
+	return NULL;
+}
+
+gchar *g_ril_reply_parse_imsi(GRil *gril, const struct ril_msg *message)
+{
+	struct parcel rilp;
+	gchar *imsi;
+
+	g_ril_init_parcel(message, &rilp);
+
+	imsi =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "{%s}", imsi ? imsi : "NULL");
+	g_ril_print_response(gril, message);
+
+	return imsi;
+}
+
+void g_ril_reply_free_sim_status(struct reply_sim_status *status)
+{
+	if (status) {
+		guint i;
+
+		for (i =3D 0; i < status->num_apps; i++) {
+			if (status->apps[i] !=3D NULL) {
+				g_free(status->apps[i]->aid_str);
+				g_free(status->apps[i]->app_str);
+				g_free(status->apps[i]);
+			}
+		}
+
+		g_free(status);
+	}
+}
+
+struct reply_sim_status *g_ril_reply_parse_sim_status(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	unsigned int i;
+	struct reply_sim_status *status;
+
+	g_ril_append_print_buf(gril, "[%d,%04d]< %s",
+			g_ril_get_slot(gril), message->serial_no,
+			ril_request_id_to_string(message->req));
+
+	g_ril_init_parcel(message, &rilp);
+
+	status =3D g_new0(struct reply_sim_status, 1);
+
+	status->card_state =3D parcel_r_int32(&rilp);
+
+	/*
+	 * NOTE:
+	 *
+	 * The global pin_status is used for multi-application
+	 * UICC cards.  For example, there are SIM cards that
+	 * can be used in both GSM and CDMA phones.  Instead
+	 * of managed PINs for both applications, a global PIN
+	 * is set instead.  It's not clear at this point if
+	 * such SIM cards are supported by ofono or RILD.
+	 */
+
+	status->pin_state =3D parcel_r_int32(&rilp);
+	status->gsm_umts_index =3D parcel_r_int32(&rilp);
+	status->cdma_index =3D parcel_r_int32(&rilp);
+	status->ims_index =3D parcel_r_int32(&rilp);
+	status->num_apps =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed)
+		goto error;
+
+	g_ril_append_print_buf(gril,
+				"(card_state=3D%d,universal_pin_state=3D%d,"
+				"gsm_umts_index=3D%d,cdma_index=3D%d,"
+				"ims_index=3D%d, ",
+				status->card_state,
+				status->pin_state,
+				status->gsm_umts_index,
+				status->cdma_index,
+				status->ims_index);
+
+	if (status->card_state !=3D RIL_CARDSTATE_PRESENT)
+		goto done;
+
+	if (status->num_apps > MAX_UICC_APPS) {
+		ofono_error("SIM error; too many apps: %d", status->num_apps);
+		status->num_apps =3D MAX_UICC_APPS;
+	}
+
+	for (i =3D 0; i < status->num_apps; i++) {
+		struct reply_sim_app *app;
+		DBG("processing app[%d]", i);
+		status->apps[i] =3D g_try_new0(struct reply_sim_app, 1);
+		app =3D status->apps[i];
+		if (app =3D=3D NULL) {
+			ofono_error("Can't allocate app_data");
+			goto error;
+		}
+
+		app->app_type =3D parcel_r_int32(&rilp);
+		app->app_state =3D parcel_r_int32(&rilp);
+		app->perso_substate =3D parcel_r_int32(&rilp);
+
+		/*
+		 * TODO: we need a way to instruct parcel to skip
+		 * a string, without allocating memory...
+		 */
+		/* application ID (AID) */
+		app->aid_str =3D parcel_r_string(&rilp);
+		/* application label */
+		app->app_str =3D parcel_r_string(&rilp);
+
+		app->pin_replaced =3D parcel_r_int32(&rilp);
+		app->pin1_state =3D parcel_r_int32(&rilp);
+		app->pin2_state =3D parcel_r_int32(&rilp);
+
+		g_ril_append_print_buf(gril,
+					"%s[app_type=3D%d,app_state=3D%d,"
+					"perso_substate=3D%d,aid_ptr=3D%s,"
+					"app_label_ptr=3D%s,pin1_replaced=3D%d,"
+					"pin1=3D%d,pin2=3D%d],",
+					print_buf,
+					app->app_type,
+					app->app_state,
+					app->perso_substate,
+					app->aid_str ? app->aid_str : "NULL",
+					app->app_str ? app->app_str : "NULL",
+					app->pin_replaced,
+					app->pin1_state,
+					app->pin2_state);
+	}
+
+	if (rilp.malformed)
+		goto error;
+
+done:
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	return status;
+
+error:
+	g_ril_reply_free_sim_status(status);
+
+	return NULL;
+}
+
+struct ofono_phone_number *g_ril_reply_parse_get_smsc_address(
+						GRil *gril,
+						const struct ril_msg *message)
+{
+	struct ofono_phone_number *sca;
+	struct parcel rilp;
+	char *number, *temp_buf;
+
+	sca =3D g_new0(struct ofono_phone_number, 1);
+	if (sca =3D=3D NULL) {
+		ofono_error("%s Out of memory", __func__);
+		goto err_alloc;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	temp_buf =3D parcel_r_string(&rilp);
+	if (temp_buf =3D=3D NULL) {
+		ofono_error("%s Cannot read SMSC address", __func__);
+		goto err_readsca;
+	}
+
+	/* RIL gives address in quotes */
+	number =3D strtok(temp_buf, "\"");
+	if (number =3D=3D NULL || *number =3D=3D '\0') {
+		ofono_error("%s Invalid SMSC address", __func__);
+		goto err_scaformat;
+	}
+
+	if (number[0] =3D=3D '+') {
+		number =3D number + 1;
+		sca->type =3D OFONO_NUMBER_TYPE_INTERNATIONAL;
+	} else {
+		sca->type =3D OFONO_NUMBER_TYPE_UNKNOWN;
+	}
+
+	strncpy(sca->number, number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+	sca->number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+
+	g_ril_append_print_buf(gril, "{type=3D%d,number=3D%s}",
+				sca->type, sca->number);
+	g_ril_print_response(gril, message);
+
+	g_free(temp_buf);
+
+	return sca;
+
+err_scaformat:
+	g_free(temp_buf);
+err_readsca:
+	g_free(sca);
+err_alloc:
+	return NULL;
+}
+
+int g_ril_reply_parse_sms_response(GRil *gril, const struct ril_msg *messa=
ge)
+{
+	struct parcel rilp;
+	int error, mr;
+	char *ack_pdu;
+
+	/* Set up Parcel struct for proper parsing */
+	g_ril_init_parcel(message, &rilp);
+
+	/*
+	 * TP-Message-Reference for GSM/
+	 * BearerData MessageId for CDMA
+	 */
+	mr =3D parcel_r_int32(&rilp);
+	ack_pdu =3D parcel_r_string(&rilp);
+	error =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(gril, "{%d,%s,%d}",
+				mr, ack_pdu, error);
+	g_ril_print_response(gril, message);
+
+	g_free(ack_pdu);
+
+	return mr;
+}
+
+static gint g_ril_call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *ca =3D a;
+	const struct ofono_call *cb =3D b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
+GSList *g_ril_reply_parse_get_calls(GRil *gril, const struct ril_msg *mess=
age)
+{
+	struct ofono_call *call;
+	struct parcel rilp;
+	GSList *l =3D NULL;
+	int num, i;
+	gchar *number, *name;
+
+	g_ril_init_parcel(message, &rilp);
+
+	g_ril_append_print_buf(gril, "{");
+
+	/* maguro signals no calls with empty event data */
+	if (rilp.size < sizeof(int32_t))
+		goto no_calls;
+
+	/* Number of RIL_Call structs */
+	num =3D parcel_r_int32(&rilp);
+	for (i =3D 0; i < num; i++) {
+		call =3D g_try_new(struct ofono_call, 1);
+		if (call =3D=3D NULL)
+			break;
+
+		ofono_call_init(call);
+		call->status =3D parcel_r_int32(&rilp);
+		call->id =3D parcel_r_int32(&rilp);
+		call->phone_number.type =3D parcel_r_int32(&rilp);
+		parcel_r_int32(&rilp); /* isMpty */
+		parcel_r_int32(&rilp); /* isMT */
+		parcel_r_int32(&rilp); /* als */
+		call->type =3D parcel_r_int32(&rilp); /* isVoice */
+		parcel_r_int32(&rilp); /* isVoicePrivacy */
+		number =3D parcel_r_string(&rilp);
+		if (number) {
+			strncpy(call->phone_number.number, number,
+				OFONO_MAX_PHONE_NUMBER_LENGTH);
+			g_free(number);
+		}
+
+		parcel_r_int32(&rilp); /* numberPresentation */
+		name =3D parcel_r_string(&rilp);
+		if (name) {
+			strncpy(call->name, name,
+				OFONO_MAX_CALLER_NAME_LENGTH);
+			g_free(name);
+		}
+
+		parcel_r_int32(&rilp); /* namePresentation */
+		parcel_r_int32(&rilp); /* uusInfo */
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity =3D 0;
+		else
+			call->clip_validity =3D 2;
+
+		g_ril_append_print_buf(gril,
+					"%s [id=3D%d,status=3D%d,type=3D%d,"
+					"number=3D%s,name=3D%s]",
+					print_buf,
+					call->id, call->status, call->type,
+					call->phone_number.number, call->name);
+
+		l =3D g_slist_insert_sorted(l, call, g_ril_call_compare);
+	}
+
+no_calls:
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	return l;
+}
+
+enum ofono_disconnect_reason g_ril_reply_parse_call_fail_cause(
+				GRil *gril, const struct ril_msg *message)
+{
+	enum ofono_disconnect_reason reason =3D OFONO_DISCONNECT_REASON_ERROR;
+	int last_cause =3D CALL_FAIL_ERROR_UNSPECIFIED;
+	struct parcel rilp;
+
+	g_ril_init_parcel(message, &rilp);
+
+	if (rilp.size < sizeof(int32_t))
+		ofono_error("%s: Parcel is too small", __func__);
+	else if (parcel_r_int32(&rilp) > 0)
+		last_cause =3D parcel_r_int32(&rilp);
+
+	if (last_cause =3D=3D CALL_FAIL_NORMAL || last_cause =3D=3D CALL_FAIL_BUS=
Y)
+		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+	g_ril_append_print_buf(gril, "{%d}", last_cause);
+	g_ril_print_response(gril, message);
+
+	return reason;
+}
+
+int g_ril_reply_parse_get_mute(GRil *gril, const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int muted;
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* skip length of int[] */
+	parcel_r_int32(&rilp);
+	muted =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(gril, "{%d}", muted);
+	g_ril_print_response(gril, message);
+
+	return muted;
+
+}
+
+char *g_ril_reply_parse_baseband_version(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	char *version;
+
+	g_ril_init_parcel(message, &rilp);
+
+	version =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "{%s}", version);
+	g_ril_print_response(gril, message);
+
+	return version;
+}
+
+char *g_ril_reply_parse_get_imei(GRil *gril,
+					const struct ril_msg *message)
+{
+	struct parcel rilp;
+	char *imei;
+
+	g_ril_init_parcel(message, &rilp);
+
+	imei =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "{%s}", imei);
+	g_ril_print_response(gril, message);
+
+	return imei;
+}
+
+int g_ril_reply_parse_query_call_waiting(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int numint, enabled, cls;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint < 1) {
+		ofono_error("%s Wrong format", __func__);
+		goto error;
+	}
+
+	enabled =3D parcel_r_int32(&rilp);
+
+	if (enabled > 0)
+		cls =3D parcel_r_int32(&rilp);
+	else
+		cls =3D 0;
+
+	g_ril_append_print_buf(gril, "{%d,0x%x}", enabled, cls);
+	g_ril_print_response(gril, message);
+
+	return cls;
+
+error:
+	return -1;
+}
+
+int g_ril_reply_parse_query_clip(GRil *gril,
+					const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int clip_status, numint;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 1) {
+		ofono_error("%s Wrong format", __func__);
+		goto error;
+	}
+
+	clip_status =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(gril, "{%d}", clip_status);
+	g_ril_print_response(gril, message);
+
+	return clip_status;
+
+error:
+	return -1;
+}
+
+void g_ril_reply_free_get_clir(struct reply_clir *rclir)
+{
+	g_free(rclir);
+}
+
+struct reply_clir *g_ril_reply_parse_get_clir(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct reply_clir *rclir;
+	int numint;
+
+	rclir =3D g_try_malloc0(sizeof(*rclir));
+	if (rclir =3D=3D NULL) {
+		ofono_error("%s Out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* Length */
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 2) {
+		ofono_error("%s Wrong format", __func__);
+		goto error;
+	}
+
+	/* Set HideCallerId property from network */
+	rclir->status =3D parcel_r_int32(&rilp);
+
+	/* State of the CLIR supplementary service in the network */
+	rclir->provisioned =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(gril, "{%d,%d}",
+				rclir->status, rclir->provisioned);
+	g_ril_print_response(gril, message);
+
+	return rclir;
+
+error:
+	g_free(rclir);
+	return NULL;
+}
+
+struct ofono_call_forwarding_condition
+	*g_ril_reply_parse_query_call_fwd(GRil *gril,
+						const struct ril_msg *message,
+						unsigned int *list_size)
+{
+	struct ofono_call_forwarding_condition *list;
+	struct parcel rilp;
+	unsigned int i;
+
+	if (list_size =3D=3D NULL) {
+		ofono_error("%s: list_size is NULL!", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	if (rilp.size < sizeof(int32_t)) {
+		ofono_error("%s: malformed parcel, can't read num params",
+				__func__);
+		goto error;
+	}
+
+	*list_size =3D parcel_r_int32(&rilp);
+	if (*list_size =3D=3D 0) {
+		/* not really an error; handled in caller */
+		goto error;
+	}
+
+	list =3D g_try_new0(struct ofono_call_forwarding_condition, *list_size);
+	if (list =3D=3D NULL) {
+		ofono_error("%s: Out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{");
+
+	for (i =3D 0; i < *list_size; i++) {
+		char *str;
+
+		list[i].status =3D  parcel_r_int32(&rilp);
+
+		parcel_r_int32(&rilp); /* skip reason */
+
+		list[i].cls =3D parcel_r_int32(&rilp);
+		list[i].phone_number.type =3D parcel_r_int32(&rilp);
+
+		str =3D parcel_r_string(&rilp);
+
+		if (str !=3D NULL) {
+			strncpy(list[i].phone_number.number, str,
+				OFONO_MAX_PHONE_NUMBER_LENGTH);
+			g_free(str);
+
+			list[i].phone_number.number[
+				OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+		}
+
+		list[i].time =3D parcel_r_int32(&rilp);
+
+		if (rilp.malformed) {
+			ofono_error("%s: malformed parcel", __func__);
+			g_free(list);
+			goto error;
+		}
+
+		g_ril_append_print_buf(gril, "%s [%d,%d,%d,%s,%d]",
+					print_buf,
+					list[i].status,
+					list[i].cls,
+					list[i].phone_number.type,
+					list[i].phone_number.number,
+					list[i].time);
+
+	}
+
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+	return list;
+
+error:
+	return NULL;
+}
+
+int g_ril_reply_parse_get_preferred_network_type(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int numint, parcel_net_type, net_type;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 1) {
+		ofono_error("%s: Wrong format", __func__);
+		goto error;
+	}
+
+	parcel_net_type =3D parcel_r_int32(&rilp);
+	net_type =3D parcel_net_type;
+
+	/* Try to translate special MTK settings */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+		switch (net_type) {
+		/* 4G preferred */
+		case MTK_PREF_NET_TYPE_LTE_GSM_WCDMA:
+		case MTK_PREF_NET_TYPE_LTE_GSM_WCDMA_MMDC:
+		case MTK_PREF_NET_TYPE_LTE_GSM_TYPE:
+		case MTK_PREF_NET_TYPE_LTE_GSM_MMDC_TYPE:
+			net_type =3D PREF_NET_TYPE_LTE_GSM_WCDMA;
+			break;
+		/* 3G or 2G preferred over LTE */
+		case MTK_PREF_NET_TYPE_GSM_WCDMA_LTE:
+		case MTK_PREF_NET_TYPE_GSM_WCDMA_LTE_MMDC:
+			net_type =3D PREF_NET_TYPE_GSM_WCDMA;
+			break;
+		}
+	}
+
+	if (net_type < 0 || net_type > PREF_NET_TYPE_LTE_ONLY) {
+		ofono_error("%s: unknown network type", __func__);
+		goto error;
+	}
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{%d}", parcel_net_type);
+	g_ril_print_response(gril, message);
+
+	return net_type;
+
+error:
+	return -1;
+}
+
+int g_ril_reply_parse_query_facility_lock(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int status, numint;
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* infineon returns two integers */
+	numint =3D parcel_r_int32(&rilp);
+	if (numint < 1) {
+		ofono_error("%s: wrong format", __func__);
+		goto error;
+	}
+
+	status =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{%d}", status);
+	g_ril_print_response(gril, message);
+
+	return status;
+
+error:
+	return -1;
+}
+
+int g_ril_reply_parse_set_facility_lock(GRil *gril,
+					const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int retries =3D -1, numint;
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* mako reply has no payload for call barring */
+	if (parcel_data_avail(&rilp) =3D=3D 0)
+		goto end;
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 1) {
+		ofono_error("%s: wrong format", __func__);
+		goto end;
+	}
+
+	retries =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto end;
+	}
+
+end:
+	g_ril_append_print_buf(gril, "{%d}", retries);
+	g_ril_print_response(gril, message);
+
+	return retries;
+}
+
+int *g_ril_reply_parse_retries(GRil *gril, const struct ril_msg *message,
+				enum ofono_sim_password_type passwd_type)
+{
+	struct parcel rilp;
+	int i, numint;
+	int *retries =3D g_try_malloc0(sizeof(int) * OFONO_SIM_PASSWORD_INVALID);
+
+	if (retries =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto no_data;
+	}
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; ++i)
+		retries[i] =3D -1;
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* maguro/infineon: no data is returned */
+	if (parcel_data_avail(&rilp) =3D=3D 0)
+		goto no_data;
+
+	numint =3D parcel_r_int32(&rilp);
+
+	switch (g_ril_vendor(gril)) {
+	case OFONO_RIL_VENDOR_AOSP:
+	case OFONO_RIL_VENDOR_QCOM_MSIM:
+		/*
+		 * The number of retries is valid only when a wrong password has
+		 * been introduced in Nexus 4. TODO: check Nexus 5 behaviour.
+		 */
+		if (message->error =3D=3D RIL_E_PASSWORD_INCORRECT)
+			retries[passwd_type] =3D parcel_r_int32(&rilp);
+
+		g_ril_append_print_buf(gril, "{%d}", retries[passwd_type]);
+		break;
+	case OFONO_RIL_VENDOR_MTK:
+		/*
+		 * Some versions of MTK modem return just the retries for the
+		 * password just entered while others return the retries for all
+		 * passwords.
+		 */
+		if (numint =3D=3D 1) {
+			retries[passwd_type] =3D parcel_r_int32(&rilp);
+
+			g_ril_append_print_buf(gril, "{%d}",
+							retries[passwd_type]);
+		} else if (numint =3D=3D 4) {
+			retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D
+							parcel_r_int32(&rilp);
+			retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D
+							parcel_r_int32(&rilp);
+			retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D
+							parcel_r_int32(&rilp);
+			retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D
+							parcel_r_int32(&rilp);
+
+			g_ril_append_print_buf(gril,
+					"{pin %d, pin2 %d, puk %d, puk2 %d}",
+					retries[OFONO_SIM_PASSWORD_SIM_PIN],
+					retries[OFONO_SIM_PASSWORD_SIM_PIN2],
+					retries[OFONO_SIM_PASSWORD_SIM_PUK],
+					retries[OFONO_SIM_PASSWORD_SIM_PUK2]);
+		} else {
+			ofono_error("%s: wrong format", __func__);
+			goto no_data;
+		}
+		break;
+	case OFONO_RIL_VENDOR_INFINEON:
+		ofono_error("%s: infineon type should not arrive here",
+				__func__);
+		g_assert(FALSE);
+		break;
+	}
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto no_data;
+	}
+
+	g_ril_print_response(gril, message);
+
+	return retries;
+
+no_data:
+	g_free(retries);
+
+	return NULL;
+}
+
+void g_ril_reply_free_oem_hook(struct reply_oem_hook *oem_hook)
+{
+	if (oem_hook) {
+		g_free(oem_hook->data);
+		g_free(oem_hook);
+	}
+}
+
+struct reply_oem_hook *g_ril_reply_oem_hook_raw(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct reply_oem_hook *reply =3D NULL;
+	struct parcel rilp;
+
+	reply =3D g_try_malloc0(sizeof(*reply));
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto end;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	reply->data =3D parcel_r_raw(&rilp, &(reply->length));
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		g_ril_reply_free_oem_hook(reply);
+		reply =3D NULL;
+		goto end;
+	}
+
+	g_ril_append_print_buf(gril, "{%d", reply->length);
+
+	if (reply->data !=3D NULL) {
+		char *hex_dump;
+		hex_dump =3D encode_hex(reply->data, reply->length, '\0');
+		g_ril_append_print_buf(gril, "%s,%s", print_buf, hex_dump);
+		g_free(hex_dump);
+	}
+
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+	g_ril_print_response(gril, message);
+
+end:
+	return reply;
+}
+
+struct parcel_str_array *g_ril_reply_oem_hook_strings(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct parcel_str_array *str_arr;
+	int i;
+
+	g_ril_init_parcel(message, &rilp);
+
+	str_arr =3D parcel_r_str_array(&rilp);
+	if (str_arr =3D=3D NULL) {
+		ofono_error("%s: no strings", __func__);
+		goto out;
+	}
+
+	g_ril_append_print_buf(gril, "{");
+
+	for (i =3D 0; i < str_arr->num_str; ++i) {
+		if (i + 1 =3D=3D str_arr->num_str)
+			g_ril_append_print_buf(gril, "%s%s}", print_buf,
+						str_arr->str[i]);
+		else
+			g_ril_append_print_buf(gril, "%s%s, ", print_buf,
+						str_arr->str[i]);
+	}
+
+	g_ril_print_response(gril, message);
+
+out:
+	return str_arr;
+}
diff --git a/gril/grilreply.h b/gril/grilreply.h
new file mode 100644
index 0000000..b419762
--- /dev/null
+++ b/gril/grilreply.h
@@ -0,0 +1,185 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2014  Canonical Ltd.
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
+#ifndef __GRILREPLY_H
+#define __GRILREPLY_H
+
+#include <ofono/types.h>
+#include <ofono/sim.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct reply_operator {
+	char *lalpha;
+	char *salpha;
+	char *numeric;
+	char *status;
+	int tech;
+};
+
+struct reply_avail_ops {
+	guint num_ops;
+	GSList *list;
+};
+
+struct reply_reg_state {
+	int status;
+	int lac;
+	int ci;
+	int tech;
+};
+
+struct reply_data_reg_state {
+	struct reply_reg_state reg_state;
+	unsigned int max_cids;
+};
+
+struct reply_sim_io {
+	int sw1;
+	int sw2;
+	int hex_len;
+	unsigned char *hex_response;
+};
+
+#define MAX_UICC_APPS 16
+
+struct reply_sim_app {
+	guint app_type;
+	guint app_state;
+	guint perso_substate;
+	char *aid_str;
+	char *app_str;
+	guint pin_replaced;
+	guint pin1_state;
+	guint pin2_state;
+};
+
+struct reply_sim_status {
+	guint card_state;
+	guint pin_state;
+	guint gsm_umts_index;
+	guint cdma_index;
+	guint ims_index;
+	guint num_apps;
+	struct reply_sim_app *apps[MAX_UICC_APPS];
+};
+
+struct reply_clir {
+	int status;
+	int provisioned;
+};
+
+struct reply_oem_hook {
+	int length;
+	void *data;
+};
+
+void g_ril_reply_free_avail_ops(struct reply_avail_ops *reply);
+
+struct reply_avail_ops *g_ril_reply_parse_avail_ops(GRil *gril,
+						const struct ril_msg *message);
+void g_ril_reply_free_operator(struct reply_operator *reply);
+
+struct reply_operator *g_ril_reply_parse_operator(GRil *gril,
+						const struct ril_msg *message);
+
+void g_ril_reply_free_sim_io(struct reply_sim_io *reply);
+
+struct reply_sim_io *g_ril_reply_parse_sim_io(GRil *gril,
+						const struct ril_msg *message);
+
+gchar *g_ril_reply_parse_imsi(GRil *gril, const struct ril_msg *message);
+
+struct reply_reg_state *g_ril_reply_parse_voice_reg_state(GRil *gril,
+						const struct ril_msg *message);
+struct reply_data_reg_state *g_ril_reply_parse_data_reg_state(GRil *gril,
+						const struct ril_msg *message);
+
+void g_ril_reply_free_sim_status(struct reply_sim_status *status);
+
+struct reply_sim_status *g_ril_reply_parse_sim_status(GRil *gril,
+						const struct ril_msg *message);
+
+struct ofono_phone_number *g_ril_reply_parse_get_smsc_address(
+						GRil *gril,
+						const struct ril_msg *message);
+
+int g_ril_reply_parse_sms_response(GRil *gril, const struct ril_msg *messa=
ge);
+
+GSList *g_ril_reply_parse_get_calls(GRil *gril, const struct ril_msg *mess=
age);
+
+enum ofono_disconnect_reason g_ril_reply_parse_call_fail_cause(
+				GRil *gril, const struct ril_msg *message);
+
+int g_ril_reply_parse_get_mute(GRil *gril, const struct ril_msg *message);
+
+char *g_ril_reply_parse_baseband_version(GRil *gril,
+						const struct ril_msg *message);
+
+char *g_ril_reply_parse_get_imei(GRil *gril,
+					const struct ril_msg *message);
+
+int g_ril_reply_parse_query_call_waiting(GRil *gril,
+						const struct ril_msg *message);
+
+int g_ril_reply_parse_query_clip(GRil *gril,
+					const struct ril_msg *message);
+
+void g_ril_reply_free_get_clir(struct reply_clir *rclir);
+
+struct reply_clir *g_ril_reply_parse_get_clir(GRil *gril,
+						const struct ril_msg *message);
+
+struct ofono_call_forwarding_condition
+	*g_ril_reply_parse_query_call_fwd(GRil *gril,
+						const struct ril_msg *message,
+						unsigned int *list_size);
+
+int g_ril_reply_parse_get_preferred_network_type(GRil *gril,
+						const struct ril_msg *message);
+
+int g_ril_reply_parse_query_facility_lock(GRil *gril,
+						const struct ril_msg *message);
+
+int g_ril_reply_parse_set_facility_lock(GRil *gril,
+					const struct ril_msg *message);
+
+int *g_ril_reply_parse_retries(GRil *gril, const struct ril_msg *message,
+				enum ofono_sim_password_type passwd_type);
+
+void g_ril_reply_free_oem_hook(struct reply_oem_hook *oem_hook);
+
+struct reply_oem_hook *g_ril_reply_oem_hook_raw(GRil *gril,
+						const struct ril_msg *message);
+
+struct parcel_str_array *g_ril_reply_oem_hook_strings(GRil *gril,
+						const struct ril_msg *message);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRILREPLY_H */
diff --git a/gril/grilrequest.c b/gril/grilrequest.c
new file mode 100644
index 0000000..3571c6b
--- /dev/null
+++ b/gril/grilrequest.c
@@ -0,0 +1,1161 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2014  Canonical Ltd.
+ *  Copyright (C) 2015 Ratchanan Srirattanamet.
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
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "grilrequest.h"
+#include "simutil.h"
+#include "util.h"
+#include "common.h"
+
+/* DEACTIVATE_DATA_CALL request parameters */
+#define DEACTIVATE_DATA_CALL_NUM_PARAMS 2
+
+/* POWER request parameters */
+#define POWER_PARAMS 1
+
+/* SETUP_DATA_CALL_PARAMS request parameters */
+#define SETUP_DATA_CALL_PARAMS 7
+#define DATA_PROFILE_DEFAULT_STR "0"
+#define DATA_PROFILE_TETHERED_STR "1"
+#define DATA_PROFILE_IMS_STR "2"
+#define DATA_PROFILE_FOTA_STR "3"
+#define DATA_PROFILE_CBS_STR "4"
+#define DATA_PROFILE_OEM_BASE_STR "1000"
+#define DATA_PROFILE_MTK_MMS_STR "1001"
+
+/* SETUP_DATA_CALL_PARAMS reply parameters */
+#define MIN_DATA_CALL_REPLY_SIZE 36
+
+/* Commands defined for TS 27.007 +CRSM */
+#define CMD_READ_BINARY   176 /* 0xB0   */
+#define CMD_READ_RECORD   178 /* 0xB2   */
+#define CMD_GET_RESPONSE  192 /* 0xC0   */
+#define CMD_UPDATE_BINARY 214 /* 0xD6   */
+#define CMD_UPDATE_RECORD 220 /* 0xDC   */
+#define CMD_STATUS        242 /* 0xF2   */
+#define CMD_RETRIEVE_DATA 203 /* 0xCB   */
+#define CMD_SET_DATA      219 /* 0xDB   */
+
+/* FID/path of SIM/USIM root directory */
+#define ROOTMF ((char[]) {'\x3F', '\x00'})
+#define ROOTMF_SZ sizeof(ROOTMF)
+
+/* RIL_Request* parameter counts */
+#define GET_IMSI_NUM_PARAMS 1
+#define ENTER_SIM_PIN_PARAMS 2
+#define SET_FACILITY_LOCK_PARAMS 5
+#define ENTER_SIM_PUK_PARAMS 3
+#define CHANGE_SIM_PIN_PARAMS 3
+
+/* RIL_FACILITY_LOCK parameters */
+#define RIL_FACILITY_UNLOCK "0"
+#define RIL_FACILITY_LOCK "1"
+
+/* Call ID should not really be a big number */
+#define MAX_CID_DIGITS 3
+
+#define OFONO_EINVAL(error) do {		\
+	error->type =3D OFONO_ERROR_TYPE_FAILURE;	\
+	error->error =3D -EINVAL;			\
+} while (0)
+
+#define OFONO_NO_ERROR(error) do {			\
+	error->type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
+	error->error =3D 0;				\
+} while (0)
+
+/*
+ * TODO:
+ *
+ * A potential future change here is to create a driver
+ * abstraction for each request/reply/event method, and a
+ * corresponding method to allow new per-message implementations
+ * to be registered.  This would allow PES to easily add code
+ * to quirk a particular RIL implementation.
+ *
+ * struct g_ril_messages_driver {
+ *	const char *name;
+ * };
+ *
+ */
+
+static gboolean set_path(GRil *ril, guint app_type,
+				struct parcel *rilp,
+				const int fileid, const guchar *path,
+				const guint path_len)
+{
+	unsigned char db_path[6] =3D { 0x00 };
+	unsigned char *comm_path =3D db_path;
+	char *hex_path =3D NULL;
+	int len =3D 0;
+
+	if (path_len > 0 && path_len < 7) {
+		memcpy(db_path, path, path_len);
+		len =3D path_len;
+	} else if (app_type =3D=3D RIL_APPTYPE_USIM) {
+		len =3D sim_ef_db_get_path_3g(fileid, db_path);
+	} else if (app_type =3D=3D RIL_APPTYPE_SIM) {
+		len =3D sim_ef_db_get_path_2g(fileid, db_path);
+	} else {
+		ofono_error("Unsupported app_type: 0%x", app_type);
+		return FALSE;
+	}
+
+	/*
+	 * db_path contains the ID of the MF, but MediaTek modems return an
+	 * error if we do not remove it. Other devices work the other way
+	 * around: they need the MF in the path. In fact MTK behaviour seem to
+	 * be the right one: to have the MF in the file is forbidden following
+	 * ETSI TS 102 221, section 8.4.2 (we are accessing the card in mode
+	 * "select by path from MF", see 3gpp 27.007, +CRSM).
+	 */
+	if (g_ril_vendor(ril) =3D=3D OFONO_RIL_VENDOR_MTK && len >=3D (int) ROOTM=
F_SZ
+			&& memcmp(db_path, ROOTMF, ROOTMF_SZ) =3D=3D 0) {
+		comm_path =3D db_path + ROOTMF_SZ;
+		len -=3D ROOTMF_SZ;
+	}
+
+	if (len > 0) {
+		hex_path =3D encode_hex(comm_path, len, 0);
+		parcel_w_string(rilp, hex_path);
+
+		g_ril_append_print_buf(ril,
+					"%spath=3D%s,",
+					print_buf,
+					hex_path);
+
+		g_free(hex_path);
+	} else {
+		/*
+		 * The only known case of this is EFPHASE_FILED (0x6FAE).
+		 * The ef_db table ( see /src/simutil.c ) entry for
+		 * EFPHASE contains a value of 0x0000 for it's
+		 * 'parent3g' member.  This causes a NULL path to
+		 * be returned.
+		 * (EF_PHASE does not exist for USIM)
+		 */
+		parcel_w_string(rilp, NULL);
+
+		g_ril_append_print_buf(ril,
+					"%spath=3D(null),",
+					print_buf);
+	}
+
+	return TRUE;
+}
+
+gboolean g_ril_request_deactivate_data_call(GRil *gril,
+				const struct req_deactivate_data_call *req,
+				struct parcel *rilp,
+				struct ofono_error *error)
+{
+	gchar *cid_str =3D NULL;
+	gchar *reason_str =3D NULL;
+
+	if (req->reason !=3D RIL_DEACTIVATE_DATA_CALL_NO_REASON &&
+		req->reason !=3D RIL_DEACTIVATE_DATA_CALL_RADIO_SHUTDOWN) {
+		goto error;
+	}
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, DEACTIVATE_DATA_CALL_NUM_PARAMS);
+
+	cid_str =3D g_strdup_printf("%d", req->cid);
+	parcel_w_string(rilp, cid_str);
+
+	/*
+	 * TODO: airplane-mode; change reason to '1',
+	 * which means "radio power off".
+	 */
+	reason_str =3D g_strdup_printf("%d", req->reason);
+	parcel_w_string(rilp, reason_str);
+
+	g_ril_append_print_buf(gril, "(%s,%s)", cid_str, reason_str);
+
+	g_free(cid_str);
+	g_free(reason_str);
+
+	OFONO_NO_ERROR(error);
+	return TRUE;
+
+error:
+	OFONO_EINVAL(error);
+	return FALSE;
+}
+
+void g_ril_request_power(GRil *gril,
+				const gboolean power,
+				struct parcel *rilp)
+{
+	DBG("");
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, POWER_PARAMS);
+	parcel_w_int32(rilp, (int32_t) power);
+
+	g_ril_append_print_buf(gril, "(%d)", power);
+}
+
+void g_ril_request_set_net_select_manual(GRil *gril,
+					const char *mccmnc,
+					struct parcel *rilp)
+{
+	DBG("");
+
+	parcel_init(rilp);
+	parcel_w_string(rilp, mccmnc);
+
+	g_ril_append_print_buf(gril, "(%s)", mccmnc);
+}
+
+gboolean g_ril_request_setup_data_call(GRil *gril,
+					const struct req_setup_data_call *req,
+					struct parcel *rilp,
+					struct ofono_error *error)
+{
+	const gchar *protocol_str;
+	gchar *tech_str;
+	gchar *auth_str;
+	gchar *profile_str;
+	int num_param =3D SETUP_DATA_CALL_PARAMS;
+
+	DBG("");
+
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		num_param =3D SETUP_DATA_CALL_PARAMS + 1;
+
+	/*
+	 * Radio technology to use: 0-CDMA, 1-GSM/UMTS, 2...
+	 * values > 2 are (RADIO_TECH + 2)
+	 */
+	if (req->tech < 1 || req->tech > (RADIO_TECH_GSM + 2)) {
+		ofono_error("%s: Invalid tech value: %d",
+				__func__,
+				req->tech);
+		goto error;
+	}
+
+	/*
+	 * TODO(OEM): This code doesn't currently support
+	 * OEM data profiles.  If a use case exist, then
+	 * this code will need to be modified.
+	 */
+	switch (req->data_profile) {
+	case RIL_DATA_PROFILE_DEFAULT:
+		profile_str =3D DATA_PROFILE_DEFAULT_STR;
+		break;
+	case RIL_DATA_PROFILE_TETHERED:
+		profile_str =3D DATA_PROFILE_TETHERED_STR;
+		break;
+	case RIL_DATA_PROFILE_IMS:
+		profile_str =3D DATA_PROFILE_IMS_STR;
+		break;
+	case RIL_DATA_PROFILE_FOTA:
+		profile_str =3D DATA_PROFILE_FOTA_STR;
+		break;
+	case RIL_DATA_PROFILE_CBS:
+		profile_str =3D DATA_PROFILE_CBS_STR;
+		break;
+	case RIL_DATA_PROFILE_MTK_MMS:
+		if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+			profile_str =3D DATA_PROFILE_MTK_MMS_STR;
+			break;
+		}
+	default:
+		ofono_error("%s, invalid data_profile value: %d",
+				__func__,
+				req->data_profile);
+		goto error;
+	}
+
+	if (req->apn =3D=3D NULL)
+		goto error;
+
+	if (req->auth_type > RIL_AUTH_BOTH) {
+		ofono_error("%s: Invalid auth type: %d",
+				__func__,
+				req->auth_type);
+		goto error;
+	}
+
+	protocol_str =3D ril_ofono_protocol_to_ril_string(req->protocol);
+	if (protocol_str =3D=3D NULL) {
+		ofono_error("%s: Invalid protocol: %d",
+				__func__,
+				req->protocol);
+		goto error;
+	}
+
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, num_param);
+
+	tech_str =3D g_strdup_printf("%d", req->tech);
+	parcel_w_string(rilp, tech_str);
+	parcel_w_string(rilp, profile_str);
+	parcel_w_string(rilp, req->apn);
+	parcel_w_string(rilp, req->username);
+	parcel_w_string(rilp, req->password);
+
+	auth_str =3D g_strdup_printf("%d", req->auth_type);
+	parcel_w_string(rilp, auth_str);
+	parcel_w_string(rilp, protocol_str);
+
+	g_ril_append_print_buf(gril,
+				"(%s,%s,%s,%s,%s,%s,%s",
+				tech_str,
+				profile_str,
+				req->apn,
+				req->username,
+				req->password,
+				auth_str,
+				protocol_str);
+
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+		/* MTK request_cid parameter */
+		char cid_str[MAX_CID_DIGITS + 1];
+
+		snprintf(cid_str, sizeof(cid_str), "%u", req->req_cid);
+		parcel_w_string(rilp, cid_str);
+		g_ril_append_print_buf(gril, "%s,%s", print_buf, cid_str);
+	}
+
+	g_ril_append_print_buf(gril, "%s)", print_buf);
+
+	g_free(tech_str);
+	g_free(auth_str);
+
+	OFONO_NO_ERROR(error);
+	return TRUE;
+
+error:
+	OFONO_EINVAL(error);
+	return FALSE;
+}
+
+gboolean g_ril_request_sim_read_info(GRil *gril,
+					const struct req_sim_read_info *req,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, CMD_GET_RESPONSE);
+	parcel_w_int32(rilp, req->fileid);
+
+	g_ril_append_print_buf(gril,
+				"(cmd=3D0x%.2X,efid=3D0x%.4X,",
+				CMD_GET_RESPONSE,
+				req->fileid);
+
+	if (set_path(gril, req->app_type, rilp, req->fileid,
+			req->path, req->path_len) =3D=3D FALSE)
+		goto error;
+
+	parcel_w_int32(rilp, 0);           /* P1 */
+	parcel_w_int32(rilp, 0);           /* P2 */
+
+	/*
+	 * TODO: review parameters values used by Android.
+	 * The values of P1-P3 in this code were based on
+	 * values used by the atmodem driver impl.
+	 *
+	 * NOTE:
+	 * GET_RESPONSE_EF_SIZE_BYTES =3D=3D 15; !255
+	 */
+	parcel_w_int32(rilp, 15);         /* P3 - max length */
+	parcel_w_string(rilp, NULL);       /* data; only req'd for writes */
+	parcel_w_string(rilp, NULL);       /* pin2; only req'd for writes */
+	parcel_w_string(rilp, req->aid_str); /* AID (Application ID) */
+
+	/*
+	 * sessionId, specific to latest MTK modems (harmless for older ones).
+	 * It looks like this field selects one or another SIM application, but
+	 * we use only one at a time so using zero here seems safe.
+	 */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		parcel_w_int32(rilp, 0);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+gboolean g_ril_request_sim_read_binary(GRil *gril,
+					const struct req_sim_read_binary *req,
+					struct parcel *rilp)
+{
+	g_ril_append_print_buf(gril,
+				"(cmd=3D0x%.2X,efid=3D0x%.4X,",
+				CMD_READ_BINARY,
+				req->fileid);
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, CMD_READ_BINARY);
+	parcel_w_int32(rilp, req->fileid);
+
+	if (set_path(gril, req->app_type, rilp, req->fileid,
+			req->path, req->path_len) =3D=3D FALSE)
+		goto error;
+
+	parcel_w_int32(rilp, (req->start >> 8));   /* P1 */
+	parcel_w_int32(rilp, (req->start & 0xff)); /* P2 */
+	parcel_w_int32(rilp, req->length);         /* P3 */
+	parcel_w_string(rilp, NULL);          /* data; only req'd for writes */
+	parcel_w_string(rilp, NULL);          /* pin2; only req'd for writes */
+	parcel_w_string(rilp, req->aid_str);
+
+	/* sessionId, specific to latest MTK modems (harmless for older ones) */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		parcel_w_int32(rilp, 0);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+gboolean g_ril_request_sim_read_record(GRil *gril,
+					const struct req_sim_read_record *req,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, CMD_READ_RECORD);
+	parcel_w_int32(rilp, req->fileid);
+
+	g_ril_append_print_buf(gril,
+				"(cmd=3D0x%.2X,efid=3D0x%.4X,",
+				CMD_READ_RECORD,
+				req->fileid);
+
+	if (set_path(gril, req->app_type, rilp, req->fileid,
+			req->path, req->path_len) =3D=3D FALSE)
+		goto error;
+
+	parcel_w_int32(rilp, req->record);      /* P1 */
+	parcel_w_int32(rilp, 4);           /* P2 */
+	parcel_w_int32(rilp, req->length);      /* P3 */
+	parcel_w_string(rilp, NULL);       /* data; only req'd for writes */
+	parcel_w_string(rilp, NULL);       /* pin2; only req'd for writes */
+	parcel_w_string(rilp, req->aid_str); /* AID (Application ID) */
+
+	/* sessionId, specific to latest MTK modems (harmless for older ones) */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		parcel_w_int32(rilp, 0);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+gboolean g_ril_request_sim_write_binary(GRil *gril,
+					const struct req_sim_write_binary *req,
+					struct parcel *rilp)
+{
+	char *hex_data;
+	int p1, p2;
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, CMD_UPDATE_BINARY);
+	parcel_w_int32(rilp, req->fileid);
+
+	g_ril_append_print_buf(gril, "(cmd=3D0x%02X,efid=3D0x%04X,",
+				CMD_UPDATE_BINARY, req->fileid);
+
+	if (set_path(gril, req->app_type, rilp, req->fileid,
+			req->path, req->path_len) =3D=3D FALSE)
+		goto error;
+
+	p1 =3D req->start >> 8;
+	p2 =3D req->start & 0xff;
+	hex_data =3D encode_hex(req->data, req->length, 0);
+
+	parcel_w_int32(rilp, p1);		/* P1 */
+	parcel_w_int32(rilp, p2);		/* P2 */
+	parcel_w_int32(rilp, req->length);	/* P3 (Lc) */
+	parcel_w_string(rilp, hex_data);	/* data */
+	parcel_w_string(rilp, NULL);		/* pin2; only for FDN/BDN */
+	parcel_w_string(rilp, req->aid_str);	/* AID (Application ID) */
+
+	/* sessionId, specific to latest MTK modems (harmless for older ones) */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		parcel_w_int32(rilp, 0);
+
+	g_ril_append_print_buf(gril,
+				"%s%d,%d,%d,%s,pin2=3D(null),aid=3D%s)",
+				print_buf,
+				p1,
+				p2,
+				req->length,
+				hex_data,
+				req->aid_str);
+
+	g_free(hex_data);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+static int get_sim_record_access_p2(enum req_record_access_mode mode)
+{
+	switch (mode) {
+	case GRIL_REC_ACCESS_MODE_CURRENT:
+		return 4;
+	case GRIL_REC_ACCESS_MODE_ABSOLUTE:
+		return 4;
+	case GRIL_REC_ACCESS_MODE_NEXT:
+		return 2;
+	case GRIL_REC_ACCESS_MODE_PREVIOUS:
+		return 3;
+	}
+
+	return -1;
+}
+
+gboolean g_ril_request_sim_write_record(GRil *gril,
+					const struct req_sim_write_record *req,
+					struct parcel *rilp)
+{
+	char *hex_data;
+	int p2;
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, CMD_UPDATE_RECORD);
+	parcel_w_int32(rilp, req->fileid);
+
+	g_ril_append_print_buf(gril, "(cmd=3D0x%02X,efid=3D0x%04X,",
+				CMD_UPDATE_RECORD, req->fileid);
+
+	if (set_path(gril, req->app_type, rilp, req->fileid,
+			req->path, req->path_len) =3D=3D FALSE)
+		goto error;
+
+	p2 =3D get_sim_record_access_p2(req->mode);
+	hex_data =3D encode_hex(req->data, req->length, 0);
+
+	parcel_w_int32(rilp, req->record);	/* P1 */
+	parcel_w_int32(rilp, p2);		/* P2 (access mode) */
+	parcel_w_int32(rilp, req->length);	/* P3 (Lc) */
+	parcel_w_string(rilp, hex_data);	/* data */
+	parcel_w_string(rilp, NULL);		/* pin2; only for FDN/BDN */
+	parcel_w_string(rilp, req->aid_str);	/* AID (Application ID) */
+
+	/* sessionId, specific to latest MTK modems (harmless for older ones) */
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK)
+		parcel_w_int32(rilp, 0);
+
+	g_ril_append_print_buf(gril,
+				"%s%d,%d,%d,%s,pin2=3D(null),aid=3D%s)",
+				print_buf,
+				req->record,
+				p2,
+				req->length,
+				hex_data,
+				req->aid_str);
+
+	g_free(hex_data);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+void g_ril_request_read_imsi(GRil *gril,
+				const gchar *aid_str,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, GET_IMSI_NUM_PARAMS);
+	parcel_w_string(rilp, aid_str);
+
+	g_ril_append_print_buf(gril, "(%d,%s)", GET_IMSI_NUM_PARAMS, aid_str);
+}
+
+void g_ril_request_pin_send(GRil *gril,
+				const char *passwd,
+				const gchar *aid_str,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, ENTER_SIM_PIN_PARAMS);
+	parcel_w_string(rilp, passwd);
+	parcel_w_string(rilp, aid_str);
+
+	g_ril_append_print_buf(gril, "(%s,aid=3D%s)", passwd, aid_str);
+}
+
+gboolean g_ril_request_pin_change_state(GRil *gril,
+					const struct req_pin_change_state *req,
+					struct parcel *rilp)
+{
+	const char *lock_type;
+
+	/*
+	 * TODO: clean up the use of string literals &
+	 * the multiple g_ril_append_print_buf() calls
+	 * by using a table lookup as does the core sim code
+	 */
+	switch (req->passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+		g_ril_append_print_buf(gril, "(SC,");
+		lock_type =3D "SC";
+		break;
+	case OFONO_SIM_PASSWORD_PHSIM_PIN:
+		g_ril_append_print_buf(gril, "(PS,");
+		lock_type =3D "PS";
+		break;
+	case OFONO_SIM_PASSWORD_PHFSIM_PIN:
+		g_ril_append_print_buf(gril, "(PF,");
+		lock_type =3D "PF";
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+		g_ril_append_print_buf(gril, "(P2,");
+		lock_type =3D "P2";
+		break;
+	case OFONO_SIM_PASSWORD_PHNET_PIN:
+		g_ril_append_print_buf(gril, "(PN,");
+		lock_type =3D "PN";
+		break;
+	case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
+		g_ril_append_print_buf(gril, "(PU,");
+		lock_type =3D "PU";
+		break;
+	case OFONO_SIM_PASSWORD_PHSP_PIN:
+		g_ril_append_print_buf(gril, "(PP,");
+		lock_type =3D "PP";
+		break;
+	case OFONO_SIM_PASSWORD_PHCORP_PIN:
+		g_ril_append_print_buf(gril, "(PC,");
+		lock_type =3D "PC";
+		break;
+	default:
+		ofono_error("%s: Invalid password type: %d",
+				__func__,
+				req->passwd_type);
+		goto error;
+	}
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, SET_FACILITY_LOCK_PARAMS);
+
+	parcel_w_string(rilp, lock_type);
+
+	if (req->enable)
+		parcel_w_string(rilp, RIL_FACILITY_LOCK);
+	else
+		parcel_w_string(rilp, RIL_FACILITY_UNLOCK);
+
+	parcel_w_string(rilp, req->passwd);
+
+	/* TODO: make this a constant... */
+	parcel_w_string(rilp, "0");		/* class */
+
+	parcel_w_string(rilp, req->aid_str);
+
+	g_ril_append_print_buf(gril, "(%s,%d,%s,0,aid=3D%s)",
+				print_buf,
+				req->enable,
+				req->passwd,
+				req->aid_str);
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+void g_ril_request_pin_send_puk(GRil *gril,
+				const char *puk,
+				const char *passwd,
+				const gchar *aid_str,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, ENTER_SIM_PUK_PARAMS);
+	parcel_w_string(rilp, puk);
+	parcel_w_string(rilp, passwd);
+	parcel_w_string(rilp, aid_str);
+
+	g_ril_append_print_buf(gril, "(puk=3D%s,pin=3D%s,aid=3D%s)",
+				puk, passwd, aid_str);
+}
+
+void g_ril_request_change_passwd(GRil *gril,
+					const char *old_passwd,
+					const char *new_passwd,
+					const gchar *aid_str,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, CHANGE_SIM_PIN_PARAMS);
+	parcel_w_string(rilp, old_passwd);
+	parcel_w_string(rilp, new_passwd);
+	parcel_w_string(rilp, aid_str);
+
+	g_ril_append_print_buf(gril, "(old=3D%s,new=3D%s,aid=3D%s)",
+				old_passwd, new_passwd, aid_str);
+}
+
+void g_ril_request_sms_cmgs(GRil *gril,
+				const struct req_sms_cmgs *req,
+				struct parcel *rilp)
+{
+	int smsc_len;
+	char *tpdu;
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 2);	/* Number of strings */
+
+	/*
+	 * SMSC address:
+	 *
+	 * smsc_len =3D=3D 1, then zero-length SMSC was spec'd
+	 * RILD expects a NULL string in this case instead
+	 * of a zero-length string.
+	 */
+	smsc_len =3D req->pdu_len - req->tpdu_len;
+	/* TODO: encode SMSC & write to parcel */
+	if (smsc_len > 1)
+		ofono_error("SMSC address specified (smsc_len %d); "
+				"NOT-IMPLEMENTED", smsc_len);
+
+	parcel_w_string(rilp, NULL); /* SMSC address; NULL =3D=3D default */
+
+	/*
+	 * TPDU:
+	 *
+	 * 'pdu' is a raw hexadecimal string
+	 *  encode_hex() turns it into an ASCII/hex UTF8 buffer
+	 *  parcel_w_string() encodes utf8 -> utf16
+	 */
+	tpdu =3D encode_hex(req->pdu + smsc_len, req->tpdu_len, 0);
+	parcel_w_string(rilp, tpdu);
+
+	g_ril_append_print_buf(gril, "(%s)", tpdu);
+
+	g_free(tpdu);
+}
+
+void g_ril_request_sms_acknowledge(GRil *gril,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 2); /* Number of int32 values in array */
+	parcel_w_int32(rilp, 1); /* Successful receipt */
+	parcel_w_int32(rilp, 0); /* error code */
+
+	g_ril_append_print_buf(gril, "(1,0)");
+}
+
+void g_ril_request_set_smsc_address(GRil *gril,
+					const struct ofono_phone_number *sca,
+					struct parcel *rilp)
+{
+	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 4];
+
+	if (sca->type =3D=3D OFONO_NUMBER_TYPE_INTERNATIONAL)
+		snprintf(number, sizeof(number), "\"+%s\"", sca->number);
+	else
+		snprintf(number, sizeof(number), "\"%s\"", sca->number);
+
+	parcel_init(rilp);
+	parcel_w_string(rilp, number);
+
+	g_ril_append_print_buf(gril, "(%s)", number);
+}
+
+void g_ril_request_dial(GRil *gril,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir,
+			struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	/* Number to dial */
+	parcel_w_string(rilp, phone_number_to_string(ph));
+	/* CLIR mode */
+	parcel_w_int32(rilp, clir);
+	/* USS, empty string */
+	/* TODO: Deal with USS properly */
+	parcel_w_int32(rilp, 0);
+	parcel_w_int32(rilp, 0);
+
+	g_ril_append_print_buf(gril, "(%s,%d,0,0)",
+				phone_number_to_string(ph),
+				clir);
+}
+
+void g_ril_request_hangup(GRil *gril,
+				unsigned call_id,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1); /* Always 1 - AT+CHLD=3D1x */
+	parcel_w_int32(rilp, call_id);
+
+	g_ril_append_print_buf(gril, "(%u)", call_id);
+}
+
+void g_ril_request_dtmf(GRil *gril,
+			char dtmf_char,
+			struct parcel *rilp)
+{
+	char ril_dtmf[2];
+
+	parcel_init(rilp);
+	/* Ril wants just one character, but we need to send as string */
+	ril_dtmf[0] =3D dtmf_char;
+	ril_dtmf[1] =3D '\0';
+	parcel_w_string(rilp, ril_dtmf);
+
+	g_ril_append_print_buf(gril, "(%s)", ril_dtmf);
+}
+
+void g_ril_request_separate_conn(GRil *gril,
+					int call_id,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	/* Payload is an array that holds just one element */
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, call_id);
+
+	g_ril_append_print_buf(gril, "(%d)", call_id);
+}
+
+void g_ril_request_set_supp_svc_notif(GRil *gril,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1); /* size of array */
+	parcel_w_int32(rilp, 1); /* notifications enabled */
+
+	g_ril_append_print_buf(gril, "(1)");
+}
+
+void g_ril_request_set_mute(GRil *gril, int muted, struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, muted);
+
+	g_ril_append_print_buf(gril, "(%d)", muted);
+}
+
+void g_ril_request_send_ussd(GRil *gril,
+				const char *ussd,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_string(rilp, ussd);
+
+	g_ril_append_print_buf(gril, "(%s)", ussd);
+}
+
+void g_ril_request_set_call_waiting(GRil *gril,
+					int enabled, int serviceclass,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 2);	/* Number of params */
+	parcel_w_int32(rilp, enabled);	/* on/off */
+
+	/*
+	 * Modem seems to respond with error to all queries
+	 * or settings made with bearer class
+	 * BEARER_CLASS_DEFAULT. Design decision: If given
+	 * class is BEARER_CLASS_DEFAULT let's map it to
+	 * SERVICE_CLASS_VOICE effectively making it the
+	 * default bearer.
+	 */
+	if (serviceclass =3D=3D BEARER_CLASS_DEFAULT)
+		serviceclass =3D BEARER_CLASS_VOICE;
+
+	parcel_w_int32(rilp, serviceclass);	/* Service class */
+
+	g_ril_append_print_buf(gril, "(%d, 0x%x)", enabled, serviceclass);
+}
+
+void g_ril_request_query_call_waiting(GRil *gril,
+					int serviceclass,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 1);	/* Number of params */
+	/*
+	 * RILD expects service class to be 0 as certain carriers can reject the
+	 * query with specific service class
+	 */
+	parcel_w_int32(rilp, 0);
+
+	g_ril_append_print_buf(gril, "(0)");
+}
+
+void g_ril_request_set_clir(GRil *gril,
+				int mode,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 1);	/* Number of params */
+	parcel_w_int32(rilp, mode);
+
+	g_ril_append_print_buf(gril, "(%d)", mode);
+}
+
+void g_ril_request_screen_state(GRil *gril,
+				int state,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);	/* Number of params */
+	parcel_w_int32(rilp, state);
+
+	g_ril_append_print_buf(gril, "(%d)", state);
+}
+
+void g_ril_request_call_fwd(GRil *gril,	const struct req_call_fwd *req,
+				struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, req->action);
+	parcel_w_int32(rilp, req->type);
+	parcel_w_int32(rilp, req->cls);
+
+	g_ril_append_print_buf(gril, "(type: %d cls: %d ", req->type, req->cls);
+
+	if (req->number !=3D NULL) {
+		parcel_w_int32(rilp, req->number->type);
+		parcel_w_string(rilp, (char *) req->number->number);
+
+		g_ril_append_print_buf(gril, "%s number type: %d number: "
+					"%s time: %d) ", print_buf,
+					req->number->type, req->number->number,
+					req->time);
+	} else {
+		/*
+		 * The following values have no real meaning for
+		 * activation/deactivation/erasure actions, but
+		 * apparently rild expects them, so fields need to
+		 * be filled. Otherwise there is no response.
+		 */
+
+		parcel_w_int32(rilp, 0x81);		/* TOA unknown */
+		parcel_w_string(rilp, "1234567890");
+		g_ril_append_print_buf(gril, "%s number type: %d number: "
+					"%s time: %d) ", print_buf,
+					0x81, "1234567890",
+					req->time);
+
+	}
+
+	parcel_w_int32(rilp, req->time);
+}
+
+void g_ril_request_set_preferred_network_type(GRil *gril, int net_type,
+						struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 1);	/* Number of params */
+	parcel_w_int32(rilp, net_type);
+
+	g_ril_append_print_buf(gril, "(%d)", net_type);
+}
+
+void g_ril_request_query_facility_lock(GRil *gril, const char *facility,
+					const char *password, int services,
+					struct parcel *rilp)
+{
+	char svcs_str[4];
+
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 4);	/* # of strings */
+	parcel_w_string(rilp, facility);
+	parcel_w_string(rilp, password);
+	snprintf(svcs_str, sizeof(svcs_str), "%d", services);
+	parcel_w_string(rilp, svcs_str);
+	parcel_w_string(rilp, NULL);	/* AID (for FDN, not yet supported) */
+
+	g_ril_append_print_buf(gril, "(%s,%s,%s,(null))",
+				facility, password, svcs_str);
+}
+
+void g_ril_request_set_facility_lock(GRil *gril, const char *facility,
+					int enable, const char *passwd,
+					int services, struct parcel *rilp)
+{
+	char svcs_str[4];
+	const char *enable_str;
+
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 5);	/* # of strings */
+	parcel_w_string(rilp, facility);
+	if (enable)
+		enable_str =3D "1";
+	else
+		enable_str =3D "0";
+	parcel_w_string(rilp, enable_str);
+	parcel_w_string(rilp, passwd);
+	snprintf(svcs_str, sizeof(svcs_str), "%d", services);
+	parcel_w_string(rilp, svcs_str);
+	parcel_w_string(rilp, NULL);	/* AID (for FDN, not yet supported) */
+
+	g_ril_append_print_buf(gril, "(%s,%s,%s,%s,(null))",
+				facility, enable_str, passwd, svcs_str);
+}
+
+void g_ril_request_change_barring_password(GRil *gril, const char *facilit=
y,
+						const char *old_passwd,
+						const char *new_passwd,
+						struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, 3);	/* # of strings */
+	parcel_w_string(rilp, facility);
+	parcel_w_string(rilp, old_passwd);
+	parcel_w_string(rilp, new_passwd);
+
+	g_ril_append_print_buf(gril, "(%s,%s,%s)",
+				facility, old_passwd, new_passwd);
+}
+
+void g_ril_request_oem_hook_raw(GRil *gril, const void *payload, size_t le=
ngth,
+					struct parcel *rilp)
+{
+	char *hex_dump =3D NULL;
+
+	parcel_init(rilp);
+	parcel_w_raw(rilp, payload, length);
+
+	if (payload !=3D NULL)
+		hex_dump =3D encode_hex(payload, length, '\0');
+
+	g_ril_append_print_buf(gril, "(%s)", hex_dump ? hex_dump : "(null)");
+	g_free(hex_dump);
+}
+
+void g_ril_request_oem_hook_strings(GRil *gril, const char **strs, int num=
_str,
+							struct parcel *rilp)
+{
+	int i;
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, num_str);
+
+	g_ril_append_print_buf(gril, "(");
+
+	for (i =3D 0; i < num_str; ++i) {
+		parcel_w_string(rilp, strs[i]);
+
+		if (i =3D=3D num_str - 1)
+			g_ril_append_print_buf(gril, "%s%s)",
+							print_buf, strs[i]);
+		else
+			g_ril_append_print_buf(gril, "%s%s, ",
+							print_buf, strs[i]);
+	}
+}
+
+void g_ril_request_set_initial_attach_apn(GRil *gril, const char *apn,
+						int proto,
+						const char *user,
+						const char *passwd,
+						const char *mccmnc,
+						struct parcel *rilp)
+{
+	const char *proto_str;
+	const int auth_type =3D RIL_AUTH_ANY;
+
+	parcel_init(rilp);
+
+	parcel_w_string(rilp, apn);
+
+	proto_str =3D ril_ofono_protocol_to_ril_string(proto);
+	parcel_w_string(rilp, proto_str);
+
+	parcel_w_int32(rilp, auth_type);
+	parcel_w_string(rilp, user);
+	parcel_w_string(rilp, passwd);
+
+	g_ril_append_print_buf(gril, "(%s,%s,%s,%s,%s", apn, proto_str,
+				ril_authtype_to_string(auth_type),
+				user, passwd);
+
+	if (g_ril_vendor(gril) =3D=3D OFONO_RIL_VENDOR_MTK) {
+		parcel_w_string(rilp, mccmnc);
+		g_ril_append_print_buf(gril, "%s,%s)", print_buf, mccmnc);
+	} else {
+		g_ril_append_print_buf(gril, "%s)", print_buf);
+	}
+}
+
+void g_ril_request_set_uicc_subscription(GRil *gril, int slot_id,
+					int app_index,
+					int sub_id,
+					int sub_status,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+
+	parcel_w_int32(rilp, slot_id);
+	parcel_w_int32(rilp, app_index);
+	parcel_w_int32(rilp, sub_id);
+	parcel_w_int32(rilp, sub_status);
+
+	g_ril_append_print_buf(gril, "(%d, %d, %d, %d(%s))",
+				slot_id,
+				app_index,
+				sub_id,
+				sub_status,
+				sub_status ? "ACTIVATE" : "DEACTIVATE");
+}
diff --git a/gril/grilrequest.h b/gril/grilrequest.h
new file mode 100644
index 0000000..a8ee38d
--- /dev/null
+++ b/gril/grilrequest.h
@@ -0,0 +1,293 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2014  Canonical Ltd.
+ *  Copyright (C) 2015 Ratchanan Srirattanamet.
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
+#ifndef __GRILREQUEST_H
+#define __GRILREQUEST_H
+
+#include <ofono/types.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct req_call_fwd {
+	int action;
+	int type;
+	int cls;
+	const struct ofono_phone_number *number;
+	int time;
+};
+
+struct req_deactivate_data_call {
+	gint cid;
+	guint reason;
+};
+
+struct req_setup_data_call {
+	guint tech;
+	guint data_profile;
+	gchar *apn;
+	gchar *username;
+	gchar *password;
+	guint auth_type;
+	guint protocol;
+	unsigned req_cid;
+};
+
+struct req_sim_read_info {
+	guint app_type;
+	gchar *aid_str;
+	int fileid;
+	const unsigned char *path;
+	unsigned int path_len;
+};
+
+
+struct req_sim_read_binary {
+	guint app_type;
+	gchar *aid_str;
+	int fileid;
+	const unsigned char *path;
+	unsigned int path_len;
+	int start;
+	int length;
+};
+
+
+struct req_sim_read_record {
+	guint app_type;
+	gchar *aid_str;
+	int fileid;
+	const unsigned char *path;
+	unsigned int path_len;
+	int record;
+	int length;
+};
+
+struct req_sim_write_binary {
+	guint app_type;
+	gchar *aid_str;
+	int fileid;
+	const unsigned char *path;
+	unsigned int path_len;
+	int start;
+	int length;
+	const unsigned char *data;
+};
+
+enum req_record_access_mode {
+	GRIL_REC_ACCESS_MODE_CURRENT,
+	GRIL_REC_ACCESS_MODE_ABSOLUTE,
+	GRIL_REC_ACCESS_MODE_NEXT,
+	GRIL_REC_ACCESS_MODE_PREVIOUS,
+};
+
+struct req_sim_write_record {
+	guint app_type;
+	gchar *aid_str;
+	int fileid;
+	const unsigned char *path;
+	unsigned int path_len;
+	enum req_record_access_mode mode;
+	int record;
+	int length;
+	const unsigned char *data;
+};
+
+struct req_pin_change_state {
+	const gchar *aid_str;
+	enum ofono_sim_password_type passwd_type;
+	int enable;
+	const char *passwd;
+};
+
+struct req_sms_cmgs {
+	const unsigned char *pdu;
+	int pdu_len;
+	int tpdu_len;
+};
+
+gboolean g_ril_request_deactivate_data_call(GRil *gril,
+				const struct req_deactivate_data_call *req,
+				struct parcel *rilp,
+				struct ofono_error *error);
+
+void g_ril_request_power(GRil *gril,
+				gboolean power,
+				struct parcel *rilp);
+
+void g_ril_request_set_net_select_manual(GRil *gril,
+					const char *mccmnc,
+					struct parcel *rilp);
+
+gboolean g_ril_request_setup_data_call(GRil *gril,
+					const struct req_setup_data_call *req,
+					struct parcel *rilp,
+					struct ofono_error *error);
+
+gboolean g_ril_request_sim_read_info(GRil *gril,
+					const struct req_sim_read_info *req,
+					struct parcel *rilp);
+
+gboolean g_ril_request_sim_read_binary(GRil *gril,
+					const struct req_sim_read_binary *req,
+					struct parcel *rilp);
+
+gboolean g_ril_request_sim_read_record(GRil *gril,
+					const struct req_sim_read_record *req,
+					struct parcel *rilp);
+
+gboolean g_ril_request_sim_write_binary(GRil *gril,
+					const struct req_sim_write_binary *req,
+					struct parcel *rilp);
+
+gboolean g_ril_request_sim_write_record(GRil *gril,
+					const struct req_sim_write_record *req,
+					struct parcel *rilp);
+
+void g_ril_request_read_imsi(GRil *gril,
+				const gchar *aid_str,
+				struct parcel *rilp);
+
+void g_ril_request_pin_send(GRil *gril,
+				const char *passwd,
+				const gchar *aid_str,
+				struct parcel *rilp);
+
+gboolean g_ril_request_pin_change_state(GRil *gril,
+					const struct req_pin_change_state *req,
+					struct parcel *rilp);
+
+void g_ril_request_pin_send_puk(GRil *gril,
+				const char *puk,
+				const char *passwd,
+				const gchar *aid_str,
+				struct parcel *rilp);
+
+void g_ril_request_change_passwd(GRil *gril,
+					const char *old_passwd,
+					const char *new_passwd,
+					const gchar *aid_str,
+					struct parcel *rilp);
+
+void g_ril_request_sms_cmgs(GRil *gril,
+				const struct req_sms_cmgs *req,
+				struct parcel *rilp);
+
+void g_ril_request_sms_acknowledge(GRil *gril, struct parcel *rilp);
+
+void g_ril_request_set_smsc_address(GRil *gril,
+					const struct ofono_phone_number *sca,
+					struct parcel *rilp);
+
+void g_ril_request_dial(GRil *gril,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir,
+			struct parcel *rilp);
+
+void g_ril_request_hangup(GRil *gril,
+				unsigned call_id,
+				struct parcel *rilp);
+
+void g_ril_request_dtmf(GRil *gril,
+			char dtmf_char,
+			struct parcel *rilp);
+
+void g_ril_request_separate_conn(GRil *gril,
+					int call_id,
+					struct parcel *rilp);
+
+void g_ril_request_set_supp_svc_notif(GRil *gril,
+					struct parcel *rilp);
+
+void g_ril_request_set_mute(GRil *gril,
+				int muted,
+				struct parcel *rilp);
+
+void g_ril_request_send_ussd(GRil *gril,
+				const char *ussd,
+				struct parcel *rilp);
+
+void g_ril_request_set_call_waiting(GRil *gril,
+					int enabled, int serviceclass,
+					struct parcel *rilp);
+
+void g_ril_request_query_call_waiting(GRil *gril,
+					int serviceclass,
+					struct parcel *rilp);
+
+void g_ril_request_set_clir(GRil *gril,
+				int mode,
+				struct parcel *rilp);
+
+void g_ril_request_screen_state(GRil *gril,
+				int state,
+				struct parcel *rilp);
+
+void g_ril_request_call_fwd(GRil *gril, const struct req_call_fwd *req,
+				struct parcel *rilp);
+
+void g_ril_request_set_preferred_network_type(GRil *gril, int net_type,
+						struct parcel *rilp);
+
+void g_ril_request_query_facility_lock(GRil *gril, const char *facility,
+					const char *password, int services,
+					struct parcel *rilp);
+
+void g_ril_request_set_facility_lock(GRil *gril, const char *facility,
+					int enable, const char *passwd,
+					int services, struct parcel *rilp);
+
+void g_ril_request_change_barring_password(GRil *gril, const char *facilit=
y,
+						const char *old_passwd,
+						const char *new_passwd,
+						struct parcel *rilp);
+
+void g_ril_request_oem_hook_raw(GRil *gril, const void *payload, size_t le=
ngth,
+					struct parcel *rilp);
+
+void g_ril_request_oem_hook_strings(GRil *gril, const char **strs, int num=
_str,
+							struct parcel *rilp);
+
+void g_ril_request_set_initial_attach_apn(GRil *gril, const char *apn,
+						int proto,
+						const char *user,
+						const char *passwd,
+						const char *mccmnc,
+						struct parcel *rilp);
+
+void g_ril_request_set_uicc_subscription(GRil *gril, int slot_id,
+						int app_index,
+						int sub_id,
+						int sub_status,
+						struct parcel *rilp);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRILREQUEST_H */
diff --git a/gril/grilunsol.c b/gril/grilunsol.c
new file mode 100644
index 0000000..9fd8900
--- /dev/null
+++ b/gril/grilunsol.c
@@ -0,0 +1,638 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013  Canonical Ltd.
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
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include "util.h"
+
+#include "common.h"
+#include "grilunsol.h"
+
+/* Minimum size is two int32s version/number of calls */
+#define MIN_DATA_CALL_LIST_SIZE 8
+
+/*
+ * Minimum NITZ is: 'yy/mm/dd,hh:mm:ss'
+ * TZ '(+/-)tz,dt' are optional
+ */
+#define MIN_NITZ_SIZE 17
+
+static gint data_call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ril_data_call *ca =3D a;
+	const struct ril_data_call *cb =3D b;
+
+	if (ca->cid < cb->cid)
+		return -1;
+
+	if (ca->cid > cb->cid)
+		return 1;
+
+	return 0;
+}
+
+static void free_data_call(gpointer data, gpointer user_data)
+{
+	struct ril_data_call *call =3D data;
+
+	if (call) {
+		g_free(call->ifname);
+		g_free(call->ip_addr);
+		g_free(call->dns_addrs);
+		g_free(call->gateways);
+		g_free(call);
+	}
+}
+
+void g_ril_unsol_free_data_call_list(struct ril_data_call_list *call_list)
+{
+	if (call_list) {
+		g_slist_foreach(call_list->calls, (GFunc) free_data_call, NULL);
+		g_slist_free(call_list->calls);
+		g_free(call_list);
+	}
+}
+
+static gboolean handle_settings(struct ril_data_call *call, char *type,
+				char *ifname, char *raw_ip_addrs,
+				char *raw_dns, char *raw_gws)
+{
+	gboolean result =3D FALSE;
+	int protocol;
+	char **dns_addrs =3D NULL, **gateways =3D NULL;
+	char **ip_addrs =3D NULL, **split_ip_addr =3D NULL;
+
+	protocol =3D ril_protocol_string_to_ofono_protocol(type);
+	if (protocol < 0) {
+		ofono_error("%s: invalid type(protocol) specified: %s",
+				__func__, type);
+		goto done;
+	}
+
+	if (ifname =3D=3D NULL || strlen(ifname) =3D=3D 0) {
+		ofono_error("%s: no interface specified: %s",
+				__func__, ifname);
+		goto done;
+	}
+
+	/* Split DNS addresses */
+	if (raw_dns)
+		dns_addrs =3D g_strsplit(raw_dns, " ", 3);
+
+	/*
+	 * RILD can return multiple addresses; oFono only supports
+	 * setting a single IPv4 gateway.
+	 */
+	if (raw_gws)
+		gateways =3D g_strsplit(raw_gws, " ", 3);
+
+	if (gateways =3D=3D NULL || g_strv_length(gateways) =3D=3D 0) {
+		ofono_error("%s: no gateways: %s", __func__, raw_gws);
+		goto done;
+	}
+
+	/* TODO:
+	 * RILD can return multiple addresses; oFono only supports
+	 * setting a single IPv4 address.  At this time, we only
+	 * use the first address.  It's possible that a RIL may
+	 * just specify the end-points of the point-to-point
+	 * connection, in which case this code will need to
+	 * changed to handle such a device.
+	 *
+	 * For now split into a maximum of three, and only use
+	 * the first address for the remaining operations.
+	 */
+	if (raw_ip_addrs)
+		ip_addrs =3D g_strsplit(raw_ip_addrs, " ", 3);
+
+	if (ip_addrs =3D=3D NULL || g_strv_length(ip_addrs) =3D=3D 0) {
+		ofono_error("%s: no IP address: %s", __func__, raw_ip_addrs);
+		goto done;
+	}
+
+	DBG("num ip addrs is: %d", g_strv_length(ip_addrs));
+
+	if (g_strv_length(ip_addrs) > 1)
+		ofono_warn("%s: more than one IP addr returned: %s", __func__,
+				raw_ip_addrs);
+	/*
+	 * Note - the address may optionally include a prefix size
+	 * ( Eg. "/30" ).  As this confuses NetworkManager, we
+	 * explicitly strip any prefix after calculating the netmask.
+	 */
+	split_ip_addr =3D g_strsplit(ip_addrs[0], "/", 2);
+
+	if (split_ip_addr =3D=3D NULL || g_strv_length(split_ip_addr) =3D=3D 0) {
+		ofono_error("%s: invalid IP address field returned: %s",
+				__func__, ip_addrs[0]);
+		goto done;
+	}
+
+	call->protocol =3D protocol;
+	call->ifname =3D g_strdup(ifname);
+	call->ip_addr =3D g_strdup(split_ip_addr[0]);
+	call->dns_addrs =3D g_strdupv(dns_addrs);
+	call->gateways =3D g_strdupv(gateways);
+
+	result =3D TRUE;
+
+done:
+	if (dns_addrs)
+		g_strfreev(dns_addrs);
+
+	if (gateways)
+		g_strfreev(gateways);
+
+	if (ip_addrs)
+		g_strfreev(ip_addrs);
+
+	if (split_ip_addr)
+		g_strfreev(split_ip_addr);
+
+
+	return result;
+}
+
+/*
+ * This function handles RIL_UNSOL_DATA_CALL_LIST_CHANGED messages,
+ * as well as RIL_REQUEST_DATA_CALL_LIST/SETUP_DATA_CALL replies, as
+ * all have the same payload.
+ */
+struct ril_data_call_list *g_ril_unsol_parse_data_call_list(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct ril_data_call *call;
+	struct parcel rilp;
+	struct ril_data_call_list *reply =3D NULL;
+	unsigned int active, cid, i, num_calls, retry, status;
+	char *type =3D NULL, *ifname =3D NULL, *raw_addrs =3D NULL;
+	char *raw_dns =3D NULL, *raw_gws =3D NULL;
+
+	DBG("");
+
+	/* Can happen for RIL_REQUEST_DATA_CALL_LIST replies */
+	if (message->buf_len < MIN_DATA_CALL_LIST_SIZE) {
+		if (message->req =3D=3D RIL_REQUEST_SETUP_DATA_CALL) {
+			ofono_error("%s: message too small: %d",
+					__func__,
+					(int) message->buf_len);
+			goto error;
+		} else {
+			g_ril_append_print_buf(gril, "{");
+			goto done;
+		}
+	}
+
+	reply =3D g_try_new0(struct ril_data_call_list, 1);
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	/*
+	 * ril.h documents the reply to a RIL_REQUEST_DATA_CALL_LIST
+	 * as being an array of  RIL_Data_Call_Response_v6 structs,
+	 * however in reality, the response also includes a version
+	 * to start.
+	 */
+	reply->version =3D parcel_r_int32(&rilp);
+	num_calls =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(gril,
+				"{version=3D%d,num=3D%d",
+				reply->version,
+				num_calls);
+
+	for (i =3D 0; i < num_calls; i++) {
+		status =3D parcel_r_int32(&rilp);
+		retry =3D parcel_r_int32(&rilp);          /* ignore */
+		cid =3D parcel_r_int32(&rilp);
+		active =3D parcel_r_int32(&rilp);
+		type =3D parcel_r_string(&rilp);
+		ifname =3D parcel_r_string(&rilp);
+		raw_addrs =3D parcel_r_string(&rilp);
+		raw_dns =3D parcel_r_string(&rilp);
+		raw_gws =3D parcel_r_string(&rilp);
+
+		/* malformed check */
+		if (rilp.malformed) {
+			ofono_error("%s: malformed parcel received", __func__);
+			goto error;
+		}
+
+		g_ril_append_print_buf(gril,
+					"%s [status=3D%d,retry=3D%d,cid=3D%d,"
+					"active=3D%d,type=3D%s,ifname=3D%s,"
+					"address=3D%s,dns=3D%s,gateways=3D%s]",
+					print_buf,
+					status,
+					retry,
+					cid,
+					active,
+					type,
+					ifname,
+					raw_addrs,
+					raw_dns,
+					raw_gws);
+
+		call =3D g_try_new0(struct ril_data_call, 1);
+		if (call =3D=3D NULL) {
+			ofono_error("%s: out of memory", __func__);
+			goto error;
+		}
+
+		call->status =3D status;
+		call->cid =3D cid;
+		call->active =3D active;
+
+		if (message->req =3D=3D RIL_REQUEST_SETUP_DATA_CALL &&
+			status =3D=3D PDP_FAIL_NONE &&
+			handle_settings(call, type, ifname, raw_addrs,
+					raw_dns, raw_gws) =3D=3D FALSE)
+			goto error;
+
+		g_free(type);
+		g_free(ifname);
+		g_free(raw_addrs);
+		g_free(raw_dns);
+		g_free(raw_gws);
+
+		reply->calls =3D
+			g_slist_insert_sorted(reply->calls, call,
+						data_call_compare);
+	}
+
+done:
+	g_ril_append_print_buf(gril, "%s}", print_buf);
+
+	if (message->unsolicited)
+		g_ril_print_unsol(gril, message);
+	else
+		g_ril_print_response(gril, message);
+
+	return reply;
+
+error:
+	g_free(type);
+	g_free(ifname);
+	g_free(raw_addrs);
+	g_free(raw_dns);
+	g_free(raw_gws);
+	g_ril_unsol_free_data_call_list(reply);
+
+	return NULL;
+}
+
+char *g_ril_unsol_parse_nitz(GRil *gril, const struct ril_msg *message)
+{
+	struct parcel rilp;
+	gchar *nitz =3D NULL;
+
+	DBG("");
+
+	if (message->buf_len < MIN_NITZ_SIZE) {
+		ofono_error("%s: NITZ too small: %d",
+				__func__,
+				(int) message->buf_len);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	nitz =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "(%s)", nitz);
+	g_ril_print_unsol(gril, message);
+
+error:
+	return nitz;
+}
+
+void g_ril_unsol_free_sms_data(struct unsol_sms_data *unsol)
+{
+	if (unsol !=3D NULL) {
+		g_free(unsol->data);
+		g_free(unsol);
+	}
+}
+
+struct unsol_sms_data *g_ril_unsol_parse_new_sms(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	char *ril_pdu;
+	size_t ril_pdu_len;
+	struct unsol_sms_data *sms_data;
+
+	sms_data =3D g_new0(struct unsol_sms_data, 1);
+	if (sms_data =3D=3D NULL) {
+		ofono_error("%s out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	ril_pdu =3D parcel_r_string(&rilp);
+	if (ril_pdu =3D=3D NULL) {
+		ofono_error("%s Unable to parse notification", __func__);
+		goto error;
+	}
+
+	ril_pdu_len =3D strlen(ril_pdu);
+
+	sms_data->data =3D decode_hex(ril_pdu, ril_pdu_len,
+					&sms_data->length, -1);
+	if (sms_data->data =3D=3D NULL) {
+		ofono_error("%s Unable to decode notification", __func__);
+		goto error_dec;
+	}
+
+	g_ril_append_print_buf(gril, "{%s}", ril_pdu);
+	g_ril_print_unsol(gril, message);
+
+	g_free(ril_pdu);
+
+	return sms_data;
+
+error_dec:
+	g_free(ril_pdu);
+error:
+	g_ril_unsol_free_sms_data(sms_data);
+	return NULL;
+}
+
+int g_ril_unsol_parse_radio_state_changed(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int radio_state;
+
+	g_ril_init_parcel(message, &rilp);
+
+	radio_state =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel received", __func__);
+		radio_state =3D -1;
+	}
+
+	g_ril_append_print_buf(gril, "(state: %s)",
+				ril_radio_state_to_string(radio_state));
+
+	g_ril_print_unsol(gril, message);
+
+	return radio_state;
+}
+
+/*
+ * This function makes a similar processing to was is done by validateInpu=
t()
+ * and getLteLevel() in $AOSP/frameworks/base/telephony/java/android/telep=
hony/
+ * SignalStrength.java. The main difference is that we linearly transform =
the
+ * ranges to ofono's one, while AOSP gives number of bars in a non-linear =
way
+ * (bins for each bar have different size). We rely on the indicator to ob=
tain
+ * a translation to bars that makes sense for humans.
+ */
+static int get_lte_strength(int signal, int rsrp, int rssnr)
+{
+	int s_rsrp =3D -1, s_rssnr =3D -1, s_signal =3D -1;
+
+	/*
+	 * The range of signal is specified to be [0, 31] by ril.h, but the code
+	 * in SignalStrength.java contradicts this: valid values are (0-63, 99)
+	 * as defined in TS 36.331 for E-UTRA rssi.
+	 */
+	signal =3D (signal >=3D 0 && signal <=3D 63) ? signal : INT_MAX;
+	rsrp =3D (rsrp >=3D 44 && rsrp <=3D 140) ? -rsrp : INT_MAX;
+	rssnr =3D (rssnr >=3D -200 && rssnr <=3D 300) ? rssnr : INT_MAX;
+
+	/* Linearly transform [-140, -44] to [0, 100] */
+	if (rsrp !=3D INT_MAX)
+		s_rsrp =3D (25 * rsrp + 3500) / 24;
+
+	/* Linearly transform [-200, 300] to [0, 100] */
+	if (rssnr !=3D INT_MAX)
+		s_rssnr =3D (rssnr + 200) / 5;
+
+	if (s_rsrp !=3D -1 && s_rssnr !=3D -1)
+		return s_rsrp < s_rssnr ? s_rsrp : s_rssnr;
+
+	if (s_rssnr !=3D -1)
+		return s_rssnr;
+
+	if (s_rsrp !=3D -1)
+		return s_rsrp;
+
+	/* Linearly transform [0, 63] to [0, 100] */
+	if (signal !=3D INT_MAX)
+		s_signal =3D (100 * signal) / 63;
+
+	return s_signal;
+}
+
+/*
+ * Comments to get_lte_strength() apply here also, changing getLteLevel() =
with
+ * getGsmLevel(). The atmodem driver does exactly the same transformation =
with
+ * the rssi from AT+CSQ command.
+ */
+static int get_gsm_strength(int signal)
+{
+	/* Checking the range contemplates also the case signal=3D99 (invalid) */
+	if (signal >=3D 0 && signal <=3D 31)
+		return (signal * 100) / 31;
+	else
+		return -1;
+}
+
+int g_ril_unsol_parse_signal_strength(GRil *gril, const struct ril_msg *me=
ssage,
+					int ril_tech)
+{
+	struct parcel rilp;
+	int gw_sigstr, gw_signal, cdma_dbm, evdo_dbm;
+	int lte_sigstr =3D -1, lte_rsrp =3D -1, lte_rssnr =3D -1;
+	int lte_signal;
+	int signal;
+
+	g_ril_init_parcel(message, &rilp);
+
+	/* RIL_SignalStrength_v5 */
+	/* GW_SignalStrength */
+	gw_sigstr =3D parcel_r_int32(&rilp);
+	gw_signal =3D get_gsm_strength(gw_sigstr);
+	parcel_r_int32(&rilp); /* bitErrorRate */
+
+	/*
+	 * CDMA/EVDO values are not processed as CDMA is not supported
+	 */
+
+	/* CDMA_SignalStrength */
+	cdma_dbm =3D parcel_r_int32(&rilp);
+	parcel_r_int32(&rilp); /* ecio */
+
+	/* EVDO_SignalStrength */
+	evdo_dbm =3D parcel_r_int32(&rilp);
+	parcel_r_int32(&rilp); /* ecio */
+	parcel_r_int32(&rilp); /* signalNoiseRatio */
+
+	/* Present only for RIL_SignalStrength_v6 or newer */
+	if (parcel_data_avail(&rilp) > 0) {
+		/* LTE_SignalStrength */
+		lte_sigstr =3D parcel_r_int32(&rilp);
+		lte_rsrp =3D parcel_r_int32(&rilp);
+		parcel_r_int32(&rilp); /* rsrq */
+		lte_rssnr =3D parcel_r_int32(&rilp);
+		parcel_r_int32(&rilp); /* cqi */
+		lte_signal =3D get_lte_strength(lte_sigstr, lte_rsrp, lte_rssnr);
+	} else {
+		lte_signal =3D -1;
+	}
+
+	g_ril_append_print_buf(gril,
+				"{gw: %d, cdma: %d, evdo: %d, lte: %d %d %d}",
+				gw_sigstr, cdma_dbm, evdo_dbm, lte_sigstr,
+				lte_rsrp, lte_rssnr);
+
+	if (message->unsolicited)
+		g_ril_print_unsol(gril, message);
+	else
+		g_ril_print_response(gril, message);
+
+	/* Return the first valid one */
+	if (gw_signal !=3D -1 && lte_signal !=3D -1)
+		if (ril_tech =3D=3D RADIO_TECH_LTE)
+			signal =3D lte_signal;
+		else
+			signal =3D gw_signal;
+	else if (gw_signal !=3D -1)
+		signal =3D gw_signal;
+	else if (lte_signal !=3D -1)
+		signal =3D lte_signal;
+	else
+		signal =3D -1;
+
+	return signal;
+}
+
+void g_ril_unsol_free_supp_svc_notif(struct unsol_supp_svc_notif *unsol)
+{
+	g_free(unsol);
+}
+
+struct unsol_supp_svc_notif *g_ril_unsol_parse_supp_svc_notif(GRil *gril,
+						struct ril_msg *message)
+{
+	struct parcel rilp;
+	char *tmp_number;
+	int type;
+	struct unsol_supp_svc_notif *unsol =3D
+		g_new0(struct unsol_supp_svc_notif, 1);
+
+	g_ril_init_parcel(message, &rilp);
+
+	unsol->notif_type =3D parcel_r_int32(&rilp);
+	unsol->code =3D parcel_r_int32(&rilp);
+	unsol->index =3D parcel_r_int32(&rilp);
+	type =3D parcel_r_int32(&rilp);
+	tmp_number =3D parcel_r_string(&rilp);
+
+	if (tmp_number !=3D NULL) {
+		strncpy(unsol->number.number, tmp_number,
+			OFONO_MAX_PHONE_NUMBER_LENGTH);
+		unsol->number.type =3D type;
+		g_free(tmp_number);
+	}
+
+	g_ril_append_print_buf(gril, "{%d,%d,%d,%d,%s}",
+				unsol->notif_type, unsol->code, unsol->index,
+				type, tmp_number);
+	g_ril_print_unsol(gril, message);
+
+	return unsol;
+}
+
+void g_ril_unsol_free_ussd(struct unsol_ussd *unsol)
+{
+	if (unsol !=3D NULL) {
+		g_free(unsol->message);
+		g_free(unsol);
+	}
+}
+
+struct unsol_ussd *g_ril_unsol_parse_ussd(GRil *gril, struct ril_msg *mess=
age)
+{
+	struct parcel rilp;
+	struct unsol_ussd *ussd;
+	char *typestr =3D NULL;
+	int numstr;
+
+	ussd =3D g_try_malloc0(sizeof(*ussd));
+	if (ussd =3D=3D NULL) {
+		ofono_error("%s out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	numstr =3D parcel_r_int32(&rilp);
+	if (numstr < 1) {
+		ofono_error("%s malformed parcel", __func__);
+		goto error;
+	}
+
+	typestr =3D parcel_r_string(&rilp);
+	if (typestr =3D=3D NULL || *typestr =3D=3D '\0') {
+		ofono_error("%s wrong type", __func__);
+		goto error;
+	}
+
+	ussd->type =3D *typestr - '0';
+
+	g_free(typestr);
+
+	if (numstr > 1)
+		ussd->message =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "{%d,%s}", ussd->type, ussd->message);
+
+	g_ril_print_unsol(gril, message);
+
+	return ussd;
+
+error:
+	g_free(typestr);
+	g_free(ussd);
+
+	return NULL;
+}
diff --git a/gril/grilunsol.h b/gril/grilunsol.h
new file mode 100644
index 0000000..a7ddfc9
--- /dev/null
+++ b/gril/grilunsol.h
@@ -0,0 +1,99 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013  Canonical Ltd.
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
+#ifndef __GRILUNSOL_H
+#define __GRILUNSOL_H
+
+#include <ofono/types.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ril_data_call {
+	guint status;
+	gint cid;
+	guint active;
+	guint protocol;
+	char *ifname;
+	gchar *ip_addr;
+	gchar **dns_addrs;
+	gchar **gateways;
+};
+
+struct ril_data_call_list {
+	guint version;
+	GSList *calls;
+};
+
+struct unsol_sms_data {
+	long length;
+	unsigned char *data;
+};
+
+struct unsol_supp_svc_notif {
+	int notif_type;
+	int code;
+	int index;
+	struct ofono_phone_number number;
+};
+
+struct unsol_ussd {
+	int type;
+	char *message;
+};
+
+void g_ril_unsol_free_data_call_list(struct ril_data_call_list *data_call_=
list);
+
+
+struct ril_data_call_list *g_ril_unsol_parse_data_call_list(GRil *gril,
+						const struct ril_msg *message);
+
+char *g_ril_unsol_parse_nitz(GRil *gril, const struct ril_msg *message);
+
+void g_ril_unsol_free_sms_data(struct unsol_sms_data *unsol);
+
+struct unsol_sms_data *g_ril_unsol_parse_new_sms(GRil *gril,
+						const struct ril_msg *message);
+
+int g_ril_unsol_parse_radio_state_changed(GRil *gril,
+					const struct ril_msg *message);
+
+int g_ril_unsol_parse_signal_strength(GRil *gril, const struct ril_msg *me=
ssage,
+					int ril_tech);
+
+void g_ril_unsol_free_supp_svc_notif(struct unsol_supp_svc_notif *unsol);
+
+struct unsol_supp_svc_notif *g_ril_unsol_parse_supp_svc_notif(GRil *gril,
+						struct ril_msg *message);
+
+void g_ril_unsol_free_ussd(struct unsol_ussd *unsol);
+
+struct unsol_ussd *g_ril_unsol_parse_ussd(GRil *gril, struct ril_msg *mess=
age);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRILUNSOL_H */
diff --git a/gril/grilutil.c b/gril/grilutil.c
new file mode 100644
index 0000000..ce51e0a
--- /dev/null
+++ b/gril/grilutil.c
@@ -0,0 +1,830 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#include <stdio.h>
+#include <ctype.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/types.h>
+
+#include "grilutil.h"
+#include "parcel.h"
+#include "ril_constants.h"
+
+/* Constants used by CALL_LIST, and SETUP_DATA_CALL RIL requests */
+#define PROTO_IP_STR "IP"
+#define PROTO_IPV6_STR "IPV6"
+#define PROTO_IPV4V6_STR "IPV4V6"
+
+static char temp_str[32];
+
+const char *ril_ofono_protocol_to_ril_string(guint protocol)
+{
+	char *result;
+
+	switch (protocol) {
+	case OFONO_GPRS_PROTO_IPV6:
+		result =3D PROTO_IPV6_STR;
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		result =3D PROTO_IPV4V6_STR;
+		break;
+	case OFONO_GPRS_PROTO_IP:
+		result =3D PROTO_IP_STR;
+		break;
+	default:
+		result =3D NULL;
+	}
+
+	return result;
+}
+
+int ril_protocol_string_to_ofono_protocol(gchar *protocol_str)
+{
+	int result;
+
+	if (g_strcmp0(protocol_str, PROTO_IPV6_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IPV6;
+	else if (g_strcmp0(protocol_str, PROTO_IPV4V6_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IPV4V6;
+	else if (g_strcmp0(protocol_str, PROTO_IP_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IP;
+	else
+		result =3D -1;
+
+	return result;
+}
+
+const char *ril_appstate_to_string(int app_state)
+{
+	switch (app_state) {
+	case RIL_APPSTATE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_APPSTATE_DETECTED:
+		return "DETECTED";
+	case RIL_APPSTATE_PIN:
+		return "PIN";
+	case RIL_APPSTATE_PUK:
+		return "PUK";
+	case RIL_APPSTATE_SUBSCRIPTION_PERSO:
+		return "";
+	case RIL_APPSTATE_READY:
+		return "READY";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_apptype_to_string(int app_type)
+{
+
+	switch (app_type) {
+	case RIL_APPTYPE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_APPTYPE_SIM:
+		return "SIM";
+	case RIL_APPTYPE_USIM:
+		return "USIM";
+	case RIL_APPTYPE_RUIM:
+		return "RUIM";
+	case RIL_APPTYPE_CSIM:
+		return "CSIM";
+	case RIL_APPTYPE_ISIM:
+		return "ISIM";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_authtype_to_string(int auth_type)
+{
+	switch (auth_type) {
+	case RIL_AUTH_NONE:
+		return "NONE";
+	case RIL_AUTH_PAP:
+		return "PAP";
+	case RIL_AUTH_CHAP:
+		return "CHAP";
+	case RIL_AUTH_BOTH:
+		return "BOTH";
+	case RIL_AUTH_ANY:
+		return "ANY";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_cardstate_to_string(int card_state)
+{
+	switch (card_state) {
+	case RIL_CARDSTATE_ABSENT:
+		return "ABSENT";
+	case RIL_CARDSTATE_PRESENT:
+		return "PRESENT";
+	case RIL_CARDSTATE_ERROR:
+		return "ERROR";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_error_to_string(int error)
+{
+	switch (error) {
+	case RIL_E_SUCCESS: return "SUCCESS";
+	case RIL_E_RADIO_NOT_AVAILABLE: return "RADIO_NOT_AVAILABLE";
+	case RIL_E_GENERIC_FAILURE: return "GENERIC_FAILURE";
+	case RIL_E_PASSWORD_INCORRECT: return "PASSWORD_INCORRECT";
+	case RIL_E_SIM_PIN2: return "SIM_PIN2";
+	case RIL_E_SIM_PUK2: return "SIM_PUK2";
+	case RIL_E_REQUEST_NOT_SUPPORTED: return "REQUEST_NOT_SUPPORTED";
+	case RIL_E_CANCELLED: return "CANCELLED";
+	case RIL_E_OP_NOT_ALLOWED_DURING_VOICE_CALL:
+		return "OP_NOT_ALLOWED_DURING_VOICE_CALL";
+	case RIL_E_OP_NOT_ALLOWED_BEFORE_REG_TO_NW:
+		return "OP_NOT_ALLOWED_BEFORE_REG_TO_NW";
+	case RIL_E_SMS_SEND_FAIL_RETRY: return "SMS_SEND_FAIL_RETRY";
+	case RIL_E_SIM_ABSENT: return "SIM_ABSENT";
+	case RIL_E_SUBSCRIPTION_NOT_AVAILABLE:
+		return "SUBSCRIPTION_NOT_AVAILABLE";
+	case RIL_E_MODE_NOT_SUPPORTED: return "MODE_NOT_SUPPORTED";
+	case RIL_E_FDN_CHECK_FAILURE: return "FDN_CHECK_FAILURE";
+	case RIL_E_ILLEGAL_SIM_OR_ME: return "ILLEGAL_SIM_OR_ME";
+	case RIL_E_DIAL_MODIFIED_TO_USSD: return "DIAL_MODIFIED_TO_USSD";
+	case RIL_E_DIAL_MODIFIED_TO_SS: return "DIAL_MODIFIED_TO_SS";
+	case RIL_E_DIAL_MODIFIED_TO_DIAL: return "DIAL_MODIFIED_TO_DIAL";
+	case RIL_E_USSD_MODIFIED_TO_DIAL: return "USSD_MODIFIED_TO_DIAL";
+	case RIL_E_USSD_MODIFIED_TO_SS: return "USSD_MODIFIED_TO_SS";
+	case RIL_E_USSD_MODIFIED_TO_USSD: return "USSD_MODIFIED_TO_USSD";
+	case RIL_E_SS_MODIFIED_TO_DIAL: return "SS_MODIFIED_TO_DIAL";
+	case RIL_E_SS_MODIFIED_TO_USSD: return "SS_MODIFIED_TO_USSD";
+	case RIL_E_SS_MODIFIED_TO_SS: return "SS_MODIFIED_TO_SS";
+	case RIL_E_SUBSCRIPTION_NOT_SUPPORTED:
+		return "SUBSCRIPTION_NOT_SUPPORTED";
+	default: return "<unknown errno>";
+	}
+}
+
+const char *ril_pinstate_to_string(int pin_state)
+{
+	switch (pin_state) {
+	case RIL_PINSTATE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_PINSTATE_ENABLED_NOT_VERIFIED:
+		return "ENABLED_NOT_VERIFIED";
+	case RIL_PINSTATE_ENABLED_VERIFIED:
+		return "ENABLED_VERIFIED";
+	case RIL_PINSTATE_DISABLED:
+		return "DISABLED";
+	case RIL_PINSTATE_ENABLED_BLOCKED:
+		return "ENABLED_BLOCKED";
+	case RIL_PINSTATE_ENABLED_PERM_BLOCKED:
+		return "ENABLED_PERM_BLOCKED";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_radio_state_to_string(int radio_state)
+{
+	switch (radio_state) {
+	case RADIO_STATE_OFF:
+		return "OFF";
+	case RADIO_STATE_UNAVAILABLE:
+		return "UNAVAILABLE";
+	case RADIO_STATE_SIM_NOT_READY:
+		return "SIM_NOT_READY";
+	case RADIO_STATE_SIM_LOCKED_OR_ABSENT:
+		return "SIM_LOCKED_OR_ABSENT";
+	case RADIO_STATE_SIM_READY:
+		return "SIM_READY";
+	case RADIO_STATE_ON:
+		return "ON";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_radio_tech_to_string(int radio_tech)
+{
+	switch (radio_tech) {
+	case RADIO_TECH_UNKNOWN:
+		return "UNKNOWN";
+	case RADIO_TECH_GPRS:
+		return "GPRS";
+	case RADIO_TECH_EDGE:
+		return	"EDGE";
+	case RADIO_TECH_UMTS:
+		return "UMTS";
+	case RADIO_TECH_IS95A:
+		return "IS95A";
+	case RADIO_TECH_IS95B:
+		return "IS95B";
+	case RADIO_TECH_1xRTT:
+		return "1xRTT";
+	case RADIO_TECH_EVDO_0:
+		return "EVDO_0";
+	case RADIO_TECH_EVDO_A:
+		return "EVDO_A";
+	case RADIO_TECH_HSDPA:
+		return "HSDPA";
+	case RADIO_TECH_HSUPA:
+		return "HSUPA";
+	case RADIO_TECH_HSPA:
+		return "HSPA";
+	case RADIO_TECH_EVDO_B:
+		return "EVDO_B";
+	case RADIO_TECH_EHRPD:
+		return "EHRPD";
+	case RADIO_TECH_LTE:
+		return "LTE";
+	case RADIO_TECH_HSPAP:
+		return "HSPAP";
+	case RADIO_TECH_GSM:
+		return "GSM";
+	case MTK_RADIO_TECH_HSDPAP:
+		return "MTK_HSDPAP";
+	case MTK_RADIO_TECH_HSDPAP_UPA:
+		return "MTK_HSDPAP_UPA";
+	case MTK_RADIO_TECH_HSUPAP:
+		return "MTK_HSUPAP";
+	case MTK_RADIO_TECH_HSUPAP_DPA:
+		return "MTK_HSUPAP_DPA";
+	case MTK_RADIO_TECH_DC_DPA:
+		return "MTK_DC_DPA";
+	case MTK_RADIO_TECH_DC_UPA:
+		return "MTK_DC_UPA";
+	case MTK_RADIO_TECH_DC_HSDPAP:
+		return "MTK_DC_HSDPAP";
+	case MTK_RADIO_TECH_DC_HSDPAP_UPA:
+		return "MTK_DC_HSDPAP_UPA";
+	case MTK_RADIO_TECH_DC_HSDPAP_DPA:
+		return "MTK_DC_HSDPAP_DPA";
+	case MTK_RADIO_TECH_DC_HSPAP:
+		return "MTK_DC_HSPAP";
+	default:
+		if (g_snprintf(temp_str, sizeof(temp_str),
+				"<INVALID (%d)>",
+				radio_tech))
+			return temp_str;
+		else
+			return "<INVALID>";
+	}
+}
+
+const char *ril_request_id_to_string(int req)
+{
+	switch (req) {
+	case RIL_REQUEST_GET_SIM_STATUS:
+		return "RIL_REQUEST_GET_SIM_STATUS";
+	case RIL_REQUEST_ENTER_SIM_PIN:
+		return "RIL_REQUEST_ENTER_SIM_PIN";
+	case RIL_REQUEST_ENTER_SIM_PUK:
+		return "RIL_REQUEST_ENTER_SIM_PUK";
+	case RIL_REQUEST_ENTER_SIM_PIN2:
+		return "RIL_REQUEST_ENTER_SIM_PIN2";
+	case RIL_REQUEST_ENTER_SIM_PUK2:
+		return "RIL_REQUEST_ENTER_SIM_PUK2";
+	case RIL_REQUEST_CHANGE_SIM_PIN:
+		return "RIL_REQUEST_CHANGE_SIM_PIN";
+	case RIL_REQUEST_CHANGE_SIM_PIN2:
+		return "RIL_REQUEST_CHANGE_SIM_PIN2";
+	case RIL_REQUEST_ENTER_NETWORK_DEPERSONALIZATION:
+		return "RIL_REQUEST_ENTER_NETWORK_DEPERSONALIZATION";
+	case RIL_REQUEST_GET_CURRENT_CALLS:
+		return "RIL_REQUEST_GET_CURRENT_CALLS";
+	case RIL_REQUEST_DIAL:
+		return "RIL_REQUEST_DIAL";
+	case RIL_REQUEST_GET_IMSI:
+		return "RIL_REQUEST_GET_IMSI";
+	case RIL_REQUEST_HANGUP:
+		return "RIL_REQUEST_HANGUP";
+	case RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND:
+		return "RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND";
+	case RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND:
+		return "RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND";
+	case RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE:
+		return "RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE";
+	case RIL_REQUEST_CONFERENCE:
+		return "RIL_REQUEST_CONFERENCE";
+	case RIL_REQUEST_UDUB:
+		return "RIL_REQUEST_UDUB";
+	case RIL_REQUEST_LAST_CALL_FAIL_CAUSE:
+		return "RIL_REQUEST_LAST_CALL_FAIL_CAUSE";
+	case RIL_REQUEST_SIGNAL_STRENGTH:
+		return "RIL_REQUEST_SIGNAL_STRENGTH";
+	case RIL_REQUEST_VOICE_REGISTRATION_STATE:
+		return "RIL_REQUEST_VOICE_REGISTRATION_STATE";
+	case RIL_REQUEST_DATA_REGISTRATION_STATE:
+		return "RIL_REQUEST_DATA_REGISTRATION_STATE";
+	case RIL_REQUEST_OPERATOR:
+		return "RIL_REQUEST_OPERATOR";
+	case RIL_REQUEST_RADIO_POWER:
+		return "RIL_REQUEST_RADIO_POWER";
+	case RIL_REQUEST_DTMF:
+		return "RIL_REQUEST_DTMF";
+	case RIL_REQUEST_SEND_SMS:
+		return "RIL_REQUEST_SEND_SMS";
+	case RIL_REQUEST_SEND_SMS_EXPECT_MORE:
+		return "RIL_REQUEST_SEND_SMS_EXPECT_MORE";
+	case RIL_REQUEST_SETUP_DATA_CALL:
+		return "RIL_REQUEST_SETUP_DATA_CALL";
+	case RIL_REQUEST_SIM_IO:
+		return "RIL_REQUEST_SIM_IO";
+	case RIL_REQUEST_SEND_USSD:
+		return "RIL_REQUEST_SEND_USSD";
+	case RIL_REQUEST_CANCEL_USSD:
+		return "RIL_REQUEST_CANCEL_USSD";
+	case RIL_REQUEST_GET_CLIR:
+		return "RIL_REQUEST_GET_CLIR";
+	case RIL_REQUEST_SET_CLIR:
+		return "RIL_REQUEST_SET_CLIR";
+	case RIL_REQUEST_QUERY_CALL_FORWARD_STATUS:
+		return "RIL_REQUEST_QUERY_CALL_FORWARD_STATUS";
+	case RIL_REQUEST_SET_CALL_FORWARD:
+		return "RIL_REQUEST_SET_CALL_FORWARD";
+	case RIL_REQUEST_QUERY_CALL_WAITING:
+		return "RIL_REQUEST_QUERY_CALL_WAITING";
+	case RIL_REQUEST_SET_CALL_WAITING:
+		return "RIL_REQUEST_SET_CALL_WAITING";
+	case RIL_REQUEST_SMS_ACKNOWLEDGE:
+		return "RIL_REQUEST_SMS_ACKNOWLEDGE ";
+	case RIL_REQUEST_GET_IMEI:
+		return "RIL_REQUEST_GET_IMEI";
+	case RIL_REQUEST_GET_IMEISV:
+		return "RIL_REQUEST_GET_IMEISV";
+	case RIL_REQUEST_ANSWER:
+		return "RIL_REQUEST_ANSWER";
+	case RIL_REQUEST_DEACTIVATE_DATA_CALL:
+		return "RIL_REQUEST_DEACTIVATE_DATA_CALL";
+	case RIL_REQUEST_QUERY_FACILITY_LOCK:
+		return "RIL_REQUEST_QUERY_FACILITY_LOCK";
+	case RIL_REQUEST_SET_FACILITY_LOCK:
+		return "RIL_REQUEST_SET_FACILITY_LOCK";
+	case RIL_REQUEST_CHANGE_BARRING_PASSWORD:
+		return "RIL_REQUEST_CHANGE_BARRING_PASSWORD";
+	case RIL_REQUEST_QUERY_NETWORK_SELECTION_MODE:
+		return "RIL_REQUEST_QUERY_NETWORK_SELECTION_MODE";
+	case RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC:
+		return "RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC";
+	case RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL:
+		return "RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL";
+	case RIL_REQUEST_QUERY_AVAILABLE_NETWORKS:
+		return "RIL_REQUEST_QUERY_AVAILABLE_NETWORKS";
+	case RIL_REQUEST_DTMF_START:
+		return "RIL_REQUEST_DTMF_START";
+	case RIL_REQUEST_DTMF_STOP:
+		return "RIL_REQUEST_DTMF_STOP";
+	case RIL_REQUEST_BASEBAND_VERSION:
+		return "RIL_REQUEST_BASEBAND_VERSION";
+	case RIL_REQUEST_SEPARATE_CONNECTION:
+		return "RIL_REQUEST_SEPARATE_CONNECTION";
+	case RIL_REQUEST_SET_MUTE:
+		return "RIL_REQUEST_SET_MUTE";
+	case RIL_REQUEST_GET_MUTE:
+		return "RIL_REQUEST_GET_MUTE";
+	case RIL_REQUEST_QUERY_CLIP:
+		return "RIL_REQUEST_QUERY_CLIP";
+	case RIL_REQUEST_LAST_DATA_CALL_FAIL_CAUSE:
+		return "RIL_REQUEST_LAST_DATA_CALL_FAIL_CAUSE";
+	case RIL_REQUEST_DATA_CALL_LIST:
+		return "RIL_REQUEST_DATA_CALL_LIST";
+	case RIL_REQUEST_RESET_RADIO:
+		return "RIL_REQUEST_RESET_RADIO";
+	case RIL_REQUEST_OEM_HOOK_RAW:
+		return "RIL_REQUEST_OEM_HOOK_RAW";
+	case RIL_REQUEST_OEM_HOOK_STRINGS:
+		return "RIL_REQUEST_OEM_HOOK_STRINGS";
+	case RIL_REQUEST_SCREEN_STATE:
+		return "RIL_REQUEST_SCREEN_STATE";
+	case RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION:
+		return "RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION";
+	case RIL_REQUEST_WRITE_SMS_TO_SIM:
+		return "RIL_REQUEST_WRITE_SMS_TO_SIM";
+	case RIL_REQUEST_DELETE_SMS_ON_SIM:
+		return "RIL_REQUEST_DELETE_SMS_ON_SIM";
+	case RIL_REQUEST_SET_BAND_MODE:
+		return "RIL_REQUEST_SET_BAND_MODE";
+	case RIL_REQUEST_QUERY_AVAILABLE_BAND_MODE:
+		return "RIL_REQUEST_QUERY_AVAILABLE_BAND_MODE";
+	case RIL_REQUEST_STK_GET_PROFILE:
+		return "RIL_REQUEST_STK_GET_PROFILE";
+	case RIL_REQUEST_STK_SET_PROFILE:
+		return "RIL_REQUEST_STK_SET_PROFILE";
+	case RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND:
+		return "RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND";
+	case RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE:
+		return "RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE";
+	case RIL_REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM:
+		return "RIL_REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM";
+	case RIL_REQUEST_EXPLICIT_CALL_TRANSFER:
+		return "RIL_REQUEST_EXPLICIT_CALL_TRANSFER";
+	case RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE:
+		return "RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE";
+	case RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE:
+		return "RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE";
+	case RIL_REQUEST_GET_NEIGHBORING_CELL_IDS:
+		return "RIL_REQUEST_GET_NEIGHBORING_CELL_IDS";
+	case RIL_REQUEST_SET_LOCATION_UPDATES:
+		return "RIL_REQUEST_SET_LOCATION_UPDATES";
+	case RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE:
+		return "RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE";
+	case RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE:
+		return "RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE";
+	case RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE:
+		return "RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE";
+	case RIL_REQUEST_SET_TTY_MODE:
+		return "RIL_REQUEST_SET_TTY_MODE";
+	case RIL_REQUEST_QUERY_TTY_MODE:
+		return "RIL_REQUEST_QUERY_TTY_MODE";
+	case RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE:
+		return "RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE";
+	case RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE:
+		return "RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE";
+	case RIL_REQUEST_CDMA_FLASH:
+		return "RIL_REQUEST_CDMA_FLASH";
+	case RIL_REQUEST_CDMA_BURST_DTMF:
+		return "RIL_REQUEST_CDMA_BURST_DTMF";
+	case RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY:
+		return "RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY";
+	case RIL_REQUEST_CDMA_SEND_SMS:
+		return "RIL_REQUEST_CDMA_SEND_SMS";
+	case RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE:
+		return "RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE";
+	case RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_GSM_SMS_BROADCAST_ACTIVATION:
+		return "RIL_REQUEST_GSM_SMS_BROADCAST_ACTIVATION";
+	case RIL_REQUEST_CDMA_GET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_CDMA_GET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_CDMA_SET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_CDMA_SET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_CDMA_SMS_BROADCAST_ACTIVATION:
+		return "RIL_REQUEST_CDMA_SMS_BROADCAST_ACTIVATION";
+	case RIL_REQUEST_CDMA_SUBSCRIPTION:
+		return "RIL_REQUEST_CDMA_SUBSCRIPTION";
+	case RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM:
+		return "RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM";
+	case RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM:
+		return "RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM";
+	case RIL_REQUEST_DEVICE_IDENTITY:
+		return "RIL_REQUEST_DEVICE_IDENTITY";
+	case RIL_REQUEST_EXIT_EMERGENCY_CALLBACK_MODE:
+		return "RIL_REQUEST_EXIT_EMERGENCY_CALLBACK_MODE";
+	case RIL_REQUEST_GET_SMSC_ADDRESS:
+		return "RIL_REQUEST_GET_SMSC_ADDRESS";
+	case RIL_REQUEST_SET_SMSC_ADDRESS:
+		return "RIL_REQUEST_SET_SMSC_ADDRESS";
+	case RIL_REQUEST_REPORT_SMS_MEMORY_STATUS:
+		return "RIL_REQUEST_REPORT_SMS_MEMORY_STATUS";
+	case RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING:
+		return "RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING";
+	case RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE:
+		return "RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE";
+	case RIL_REQUEST_ISIM_AUTHENTICATION:
+		return "RIL_REQUEST_ISIM_AUTHENTICATION";
+	case RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU:
+		return "RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU";
+	case RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS:
+		return "RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS";
+	case RIL_REQUEST_SET_INITIAL_ATTACH_APN:
+		return "RIL_REQUEST_SET_INITIAL_ATTACH_APN";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_unsol_request_to_string(int request)
+{
+	switch (request) {
+	case RIL_UNSOL_RESPONSE_RADIO_STATE_CHANGED:
+		return "UNSOL_RESPONSE_RADIO_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_CALL_STATE_CHANGED:
+		return "UNSOL_RESPONSE_CALL_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED:
+		return "UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_NEW_SMS:
+		return "UNSOL_RESPONSE_NEW_SMS";
+	case RIL_UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT:
+		return "UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT";
+	case RIL_UNSOL_RESPONSE_NEW_SMS_ON_SIM:
+		return "UNSOL_RESPONSE_NEW_SMS_ON_SIM";
+	case RIL_UNSOL_ON_USSD:
+		return "UNSOL_ON_USSD";
+	case RIL_UNSOL_ON_USSD_REQUEST:
+		return "UNSOL_ON_USSD_REQUEST(obsolete)";
+	case RIL_UNSOL_NITZ_TIME_RECEIVED:
+		return "UNSOL_NITZ_TIME_RECEIVED";
+	case RIL_UNSOL_SIGNAL_STRENGTH:
+		return "UNSOL_SIGNAL_STRENGTH";
+	case RIL_UNSOL_SUPP_SVC_NOTIFICATION:
+		return "UNSOL_SUPP_SVC_NOTIFICATION";
+	case RIL_UNSOL_STK_SESSION_END:
+		return "UNSOL_STK_SESSION_END";
+	case RIL_UNSOL_STK_PROACTIVE_COMMAND:
+		return "UNSOL_STK_PROACTIVE_COMMAND";
+	case RIL_UNSOL_STK_EVENT_NOTIFY:
+		return "UNSOL_STK_EVENT_NOTIFY";
+	case RIL_UNSOL_STK_CALL_SETUP:
+		return "UNSOL_STK_CALL_SETUP";
+	case RIL_UNSOL_SIM_SMS_STORAGE_FULL:
+		return "UNSOL_SIM_SMS_STORAGE_FUL";
+	case RIL_UNSOL_SIM_REFRESH:
+		return "UNSOL_SIM_REFRESH";
+	case RIL_UNSOL_DATA_CALL_LIST_CHANGED:
+		return "UNSOL_DATA_CALL_LIST_CHANGED";
+	case RIL_UNSOL_CALL_RING:
+		return "UNSOL_CALL_RING";
+	case RIL_UNSOL_RESPONSE_SIM_STATUS_CHANGED:
+		return "UNSOL_RESPONSE_SIM_STATUS_CHANGED";
+	case RIL_UNSOL_RESPONSE_CDMA_NEW_SMS:
+		return "UNSOL_NEW_CDMA_SMS";
+	case RIL_UNSOL_RESPONSE_NEW_BROADCAST_SMS:
+		return "UNSOL_NEW_BROADCAST_SMS";
+	case RIL_UNSOL_CDMA_RUIM_SMS_STORAGE_FULL:
+		return "UNSOL_CDMA_RUIM_SMS_STORAGE_FULL";
+	case RIL_UNSOL_RESTRICTED_STATE_CHANGED:
+		return "UNSOL_RESTRICTED_STATE_CHANGED";
+	case RIL_UNSOL_ENTER_EMERGENCY_CALLBACK_MODE:
+		return "UNSOL_ENTER_EMERGENCY_CALLBACK_MODE";
+	case RIL_UNSOL_CDMA_CALL_WAITING:
+		return "UNSOL_CDMA_CALL_WAITING";
+	case RIL_UNSOL_CDMA_OTA_PROVISION_STATUS:
+		return "UNSOL_CDMA_OTA_PROVISION_STATUS";
+	case RIL_UNSOL_CDMA_INFO_REC:
+		return "UNSOL_CDMA_INFO_REC";
+	case RIL_UNSOL_OEM_HOOK_RAW:
+		return "UNSOL_OEM_HOOK_RAW";
+	case RIL_UNSOL_RINGBACK_TONE:
+		return "UNSOL_RINGBACK_TONE";
+	case RIL_UNSOL_RESEND_INCALL_MUTE:
+		return "UNSOL_RESEND_INCALL_MUTE";
+	case RIL_UNSOL_CDMA_SUBSCRIPTION_SOURCE_CHANGED:
+		return "UNSOL_CDMA_SUBSCRIPTION_SOURCE_CHANGED";
+	case RIL_UNSOL_CDMA_PRL_CHANGED:
+		return "UNSOL_CDMA_PRL_CHANGED";
+	case RIL_UNSOL_EXIT_EMERGENCY_CALLBACK_MODE:
+		return "UNSOL_EXIT_EMERGENCY_CALLBACK_MODE";
+	case RIL_UNSOL_RIL_CONNECTED:
+		return "UNSOL_RIL_CONNECTED";
+	default:
+		return "<unknown request>";
+	}
+}
+
+const char *ril_pdp_fail_to_string(int status)
+{
+	switch (status) {
+	case PDP_FAIL_NONE:
+		return "NONE";
+	case PDP_FAIL_OPERATOR_BARRED:
+		return "OPERATOR_BARRED";
+	case PDP_FAIL_INSUFFICIENT_RESOURCES:
+		return "INSUFFICIENT_RESOURCES";
+	case PDP_FAIL_MISSING_UKNOWN_APN:
+		return "MISSING_UKNOWN_APN";
+	case PDP_FAIL_UNKNOWN_PDP_ADDRESS_TYPE:
+		return "UNKNOWN_PDP_ADDRESS_TYPE";
+	case PDP_FAIL_USER_AUTHENTICATION:
+		return "USER_AUTHENTICATION";
+	case PDP_FAIL_ACTIVATION_REJECT_GGSN:
+		return "ACTIVATION_REJECT_GGSN";
+	case PDP_FAIL_ACTIVATION_REJECT_UNSPECIFIED:
+		return "ACTIVATION_REJECT_UNSPECIFIED";
+	case PDP_FAIL_SERVICE_OPTION_NOT_SUPPORTED:
+		return "SERVICE_OPTION_NOT_SUPPORTED";
+	case PDP_FAIL_SERVICE_OPTION_NOT_SUBSCRIBED:
+		return "SERVICE_OPTION_NOT_SUBSCRIBED";
+	case PDP_FAIL_SERVICE_OPTION_OUT_OF_ORDER:
+		return "SERVICE_OPTION_OUT_OF_ORDER";
+	case PDP_FAIL_NSAPI_IN_USE:
+		return "NSAPI_IN_USE";
+	case PDP_FAIL_REGULAR_DEACTIVATION:
+		return "REGULAR_DEACTIVATION";
+	case PDP_FAIL_ONLY_IPV4_ALLOWED:
+		return "ONLY_IPV4_ALLOWED";
+	case PDP_FAIL_ONLY_IPV6_ALLOWED:
+		return "ONLY_IPV6_ALLOWED";
+	case PDP_FAIL_ONLY_SINGLE_BEARER_ALLOWED:
+		return "ONLY_SINGLE_BEARER_ALLOWED";
+	case PDP_FAIL_PROTOCOL_ERRORS:
+		return "PROTOCOL_ERRORS";
+	case PDP_FAIL_VOICE_REGISTRATION_FAIL:
+		return "VOICE_REGISTRATION_FAIL";
+	case PDP_FAIL_DATA_REGISTRATION_FAIL:
+		return "DATA_REGISTRATION_FAIL";
+	case PDP_FAIL_SIGNAL_LOST:
+		return "SIGNAL_LOST";
+	case PDP_FAIL_PREF_RADIO_TECH_CHANGED:
+		return "PREF_RADIO_TECH_CHANGED";
+	case PDP_FAIL_RADIO_POWER_OFF:
+		return "RADIO_POWER_OFF";
+	case PDP_FAIL_TETHERED_CALL_ACTIVE:
+		return "TETHERED_CALL_ACTIVE";
+	case PDP_FAIL_ERROR_UNSPECIFIED:
+		return "ERROR_UNSPECIFIED";
+	default:
+		if (g_snprintf(temp_str, sizeof(temp_str),
+				"<UNKNOWN (%d)>", status))
+			return temp_str;
+		else
+			return "<UNKNOWN>";
+	}
+}
+
+void g_ril_util_debug_chat(gboolean in, const char *str, gsize len,
+				GRilDebugFunc debugf, gpointer user_data)
+{
+	char type =3D in ? '<' : '>';
+	gsize escaped =3D 2; /* Enough for '<', ' ' */
+	char *escaped_str;
+	const char *esc =3D "<ESC>";
+	gsize esc_size =3D strlen(esc);
+	const char *ctrlz =3D "<CtrlZ>";
+	gsize ctrlz_size =3D strlen(ctrlz);
+	gsize i;
+
+	if (debugf =3D=3D NULL || !len)
+		return;
+
+	for (i =3D 0; i < len; i++) {
+		char c =3D str[i];
+
+		if (g_ascii_isprint(c))
+			escaped +=3D 1;
+		else if (c =3D=3D '\r' || c =3D=3D '\t' || c =3D=3D '\n')
+			escaped +=3D 2;
+		else if (c =3D=3D 26)
+			escaped +=3D ctrlz_size;
+		else if (c =3D=3D 25)
+			escaped +=3D esc_size;
+		else
+			escaped +=3D 4;
+	}
+
+	escaped_str =3D g_try_malloc(escaped + 1);
+	if (escaped_str =3D=3D NULL)
+		return;
+
+	escaped_str[0] =3D type;
+	escaped_str[1] =3D ' ';
+	escaped_str[2] =3D '\0';
+	escaped_str[escaped] =3D '\0';
+
+	for (escaped =3D 2, i =3D 0; i < len; i++) {
+		unsigned char c =3D str[i];
+
+		switch (c) {
+		case '\r':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 'r';
+			break;
+		case '\t':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 't';
+			break;
+		case '\n':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 'n';
+			break;
+		case 26:
+			strncpy(&escaped_str[escaped], ctrlz, ctrlz_size);
+			escaped +=3D ctrlz_size;
+			break;
+		case 25:
+			strncpy(&escaped_str[escaped], esc, esc_size);
+			escaped +=3D esc_size;
+			break;
+		default:
+			if (g_ascii_isprint(c))
+				escaped_str[escaped++] =3D c;
+			else {
+				escaped_str[escaped++] =3D '\\';
+				escaped_str[escaped++] =3D '0' + ((c >> 6) & 07);
+				escaped_str[escaped++] =3D '0' + ((c >> 3) & 07);
+				escaped_str[escaped++] =3D '0' + (c & 07);
+			}
+		}
+	}
+
+	debugf(escaped_str, user_data);
+	g_free(escaped_str);
+}
+
+void g_ril_util_debug_dump(gboolean in, const unsigned char *buf, gsize le=
n,
+				GRilDebugFunc debugf, gpointer user_data)
+{
+	char type =3D in ? '<' : '>';
+	GString *str;
+	gsize i;
+
+	if (debugf =3D=3D NULL || !len)
+		return;
+
+	str =3D g_string_sized_new(1 + (len * 2));
+	if (str =3D=3D NULL)
+		return;
+
+	g_string_append_c(str, type);
+
+	for (i =3D 0; i < len; i++)
+		g_string_append_printf(str, " %02x", buf[i]);
+
+	debugf(str->str, user_data);
+	g_string_free(str, TRUE);
+}
+
+void g_ril_util_debug_hexdump(gboolean in, const unsigned char *buf, gsize=
 len,
+				GRilDebugFunc debugf, gpointer user_data)
+{
+	static const char hexdigits[] =3D "0123456789abcdef";
+	char str[68];
+	gsize i;
+
+	if (debugf =3D=3D NULL || !len)
+		return;
+
+	str[0] =3D in ? '<' : '>';
+
+	for (i =3D 0; i < len; i++) {
+		str[((i % 16) * 3) + 1] =3D ' ';
+		str[((i % 16) * 3) + 2] =3D hexdigits[buf[i] >> 4];
+		str[((i % 16) * 3) + 3] =3D hexdigits[buf[i] & 0xf];
+		str[(i % 16) + 51] =3D g_ascii_isprint(buf[i]) ? buf[i] : '.';
+
+		if ((i + 1) % 16 =3D=3D 0) {
+			str[49] =3D ' ';
+			str[50] =3D ' ';
+			str[67] =3D '\0';
+			debugf(str, user_data);
+			str[0] =3D ' ';
+		}
+	}
+
+	if (i % 16 > 0) {
+		gsize j;
+		for (j =3D (i % 16); j < 16; j++) {
+			str[(j * 3) + 1] =3D ' ';
+			str[(j * 3) + 2] =3D ' ';
+			str[(j * 3) + 3] =3D ' ';
+			str[j + 51] =3D ' ';
+		}
+		str[49] =3D ' ';
+		str[50] =3D ' ';
+		str[67] =3D '\0';
+		debugf(str, user_data);
+	}
+}
+
+gboolean g_ril_util_setup_io(GIOChannel *io, GIOFlags flags)
+{
+	GIOFlags io_flags;
+
+	if (g_io_channel_set_encoding(io, NULL, NULL) !=3D G_IO_STATUS_NORMAL)
+		return FALSE;
+
+	g_io_channel_set_buffered(io, FALSE);
+
+	if (flags & G_IO_FLAG_SET_MASK) {
+		io_flags =3D g_io_channel_get_flags(io);
+
+		io_flags |=3D (flags & G_IO_FLAG_SET_MASK);
+
+		if (g_io_channel_set_flags(io, io_flags, NULL) !=3D
+							G_IO_STATUS_NORMAL)
+			return FALSE;
+	}
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	return TRUE;
+}
diff --git a/gril/grilutil.h b/gril/grilutil.h
new file mode 100644
index 0000000..be59366
--- /dev/null
+++ b/gril/grilutil.h
@@ -0,0 +1,63 @@
+/*
+ *
+ *  RIL library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#ifndef __GRILUTIL_H
+#define __GRILUTIL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gfunc.h"
+#include "parcel.h"
+#include "gril.h"
+
+const char *ril_ofono_protocol_to_ril_string(guint protocol);
+int ril_protocol_string_to_ofono_protocol(gchar *protocol_str);
+const char *ril_appstate_to_string(int app_state);
+const char *ril_apptype_to_string(int app_type);
+const char *ril_authtype_to_string(int auth_type);
+const char *ril_cardstate_to_string(int card_state);
+const char *ril_error_to_string(int error);
+const char *ril_pinstate_to_string(int pin_state);
+const char *ril_radio_state_to_string(int radio_state);
+const char *ril_radio_tech_to_string(int radio_tech);
+const char *ril_request_id_to_string(int req);
+const char *ril_unsol_request_to_string(int request);
+const char *ril_pdp_fail_to_string(int status);
+
+void g_ril_util_debug_chat(gboolean in, const char *str, gsize len,
+				GRilDebugFunc debugf, gpointer user_data);
+
+void g_ril_util_debug_dump(gboolean in, const unsigned char *buf, gsize le=
n,
+				GRilDebugFunc debugf, gpointer user_data);
+
+void g_ril_util_debug_hexdump(gboolean in, const unsigned char *buf, gsize=
 len,
+				GRilDebugFunc debugf, gpointer user_data);
+
+gboolean g_ril_util_setup_io(GIOChannel *io, GIOFlags flags);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GRILUTIL_H */
diff --git a/gril/parcel.c b/gril/parcel.c
new file mode 100644
index 0000000..1cd8c8e
--- /dev/null
+++ b/gril/parcel.c
@@ -0,0 +1,293 @@
+/*
+ * Copyright (C) 2011 Joel Armstrong <jcarmst@sandia.gov>
+ * Copyright (C) 2012 Canonical Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (`GPL') as publish=
ed by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based on parcel implementation from https://bitbucket.org/floren/inferno
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+
+/* Parcel-handling code */
+#include <sys/types.h>
+#include <string.h>
+#include <endian.h>
+#include <stdint.h>
+#include <limits.h>
+
+#include "parcel.h"
+
+#define PAD_SIZE(s) (((s)+3)&~3)
+
+typedef uint16_t char16_t;
+
+void parcel_init(struct parcel *p)
+{
+	p->data =3D g_malloc0(sizeof(int32_t));
+	p->size =3D 0;
+	p->capacity =3D sizeof(int32_t);
+	p->offset =3D 0;
+	p->malformed =3D 0;
+}
+
+void parcel_grow(struct parcel *p, size_t size)
+{
+	char *new =3D g_realloc(p->data, p->capacity + size);
+	p->data =3D new;
+	p->capacity +=3D size;
+}
+
+void parcel_free(struct parcel *p)
+{
+	g_free(p->data);
+	p->size =3D 0;
+	p->capacity =3D 0;
+	p->offset =3D 0;
+}
+
+int32_t parcel_r_int32(struct parcel *p)
+{
+	int32_t ret;
+
+	if (p->malformed)
+		return 0;
+
+	if (p->offset + sizeof(int32_t) > p->size) {
+		ofono_error("%s: parcel is too small", __func__);
+		p->malformed =3D 1;
+		return 0;
+	}
+
+	ret =3D *((int32_t *) (void *) (p->data + p->offset));
+	p->offset +=3D sizeof(int32_t);
+	return ret;
+}
+
+int parcel_w_int32(struct parcel *p, int32_t val)
+{
+	for (;;) {
+
+		if (p->offset + sizeof(int32_t) < p->capacity) {
+			/* There's enough space */
+			*((int32_t *) (void *) (p->data + p->offset)) =3D val;
+			p->offset +=3D sizeof(int32_t);
+			p->size +=3D sizeof(int32_t);
+			break;
+		} else {
+			/* Grow data and retry */
+			parcel_grow(p, sizeof(int32_t));
+		}
+	}
+	return 0;
+}
+
+int parcel_w_string(struct parcel *p, const char *str)
+{
+	gunichar2 *gs16;
+	glong gs16_len;
+	size_t len;
+	size_t gs16_size;
+
+	if (str =3D=3D NULL) {
+		parcel_w_int32(p, -1);
+		return 0;
+	}
+
+	gs16 =3D g_utf8_to_utf16(str, -1, NULL, &gs16_len, NULL);
+
+	if (parcel_w_int32(p, gs16_len) =3D=3D -1)
+		return -1;
+
+	gs16_size =3D gs16_len * sizeof(char16_t);
+	len =3D gs16_size + sizeof(char16_t);
+	for (;;) {
+		size_t padded =3D PAD_SIZE(len);
+
+		if (p->offset + len < p->capacity) {
+			/* There's enough space */
+			memcpy(p->data + p->offset, gs16, gs16_size);
+			*((char16_t *) (void *)
+				(p->data + p->offset + gs16_size)) =3D 0;
+			p->offset +=3D padded;
+			p->size +=3D padded;
+			if (padded !=3D len) {
+
+#if BYTE_ORDER =3D=3D BIG_ENDIAN
+				static const uint32_t mask[4] =3D {
+					0x00000000, 0xffffff00,
+					0xffff0000, 0xff000000
+				};
+#endif
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
+				static const uint32_t mask[4] =3D {
+					0x00000000, 0x00ffffff,
+					0x0000ffff, 0x000000ff
+				};
+#endif
+
+				*((uint32_t *) (void *)
+					(p->data + p->offset - 4)) &=3D
+							mask[padded - len];
+			}
+			break;
+
+		} else {
+			/* Grow data and retry */
+			parcel_grow(p, padded);
+		}
+	}
+
+	g_free(gs16);
+	return 0;
+}
+
+char *parcel_r_string(struct parcel *p)
+{
+	char *ret;
+	int len16 =3D parcel_r_int32(p);
+	int strbytes;
+
+	if (p->malformed)
+		return NULL;
+
+	/* This is how a null string is sent */
+	if (len16 < 0)
+		return NULL;
+
+	strbytes =3D PAD_SIZE((len16 + 1) * sizeof(char16_t));
+	if (p->offset + strbytes > p->size) {
+		ofono_error("%s: parcel is too small", __func__);
+		p->malformed =3D 1;
+		return NULL;
+	}
+
+	ret =3D g_utf16_to_utf8((gunichar2 *) (void *) (p->data + p->offset),
+				len16, NULL, NULL, NULL);
+	if (ret =3D=3D NULL) {
+		ofono_error("%s: wrong UTF16 coding", __func__);
+		p->malformed =3D 1;
+		return NULL;
+	}
+
+	p->offset +=3D strbytes;
+
+	return ret;
+}
+
+int parcel_w_raw(struct parcel *p, const void *data, size_t len)
+{
+	if (data =3D=3D NULL) {
+		parcel_w_int32(p, -1);
+		return 0;
+	}
+
+	parcel_w_int32(p, len);
+
+	for (;;) {
+
+		if (p->offset + len < p->capacity) {
+			/* There's enough space */
+			memcpy(p->data + p->offset, data, len);
+			p->offset +=3D len;
+			p->size +=3D len;
+			break;
+		} else {
+			/* Grow data and retry */
+			parcel_grow(p, len);
+		}
+	}
+	return 0;
+}
+
+void *parcel_r_raw(struct parcel *p, int *len)
+{
+	char *ret;
+
+	*len =3D parcel_r_int32(p);
+
+	if (p->malformed || *len <=3D 0)
+		return NULL;
+
+	if (p->offset + *len > p->size) {
+		ofono_error("%s: parcel is too small", __func__);
+		p->malformed =3D 1;
+		return NULL;
+	}
+
+	ret =3D g_try_malloc0(*len);
+	if (ret =3D=3D NULL) {
+		ofono_error("%s: out of memory (%d bytes)", __func__, *len);
+		return NULL;
+	}
+
+	memcpy(ret, p->data + p->offset, *len);
+	p->offset +=3D *len;
+
+	return ret;
+}
+
+size_t parcel_data_avail(struct parcel *p)
+{
+	return p->size - p->offset;
+}
+
+struct parcel_str_array *parcel_r_str_array(struct parcel *p)
+{
+	int i;
+	struct parcel_str_array *str_arr;
+	int num_str =3D parcel_r_int32(p);
+
+	if (p->malformed || num_str <=3D 0)
+		return NULL;
+
+	str_arr =3D g_try_malloc0(sizeof(*str_arr) + num_str * sizeof(char *));
+	if (str_arr =3D=3D NULL)
+		return NULL;
+
+	str_arr->num_str =3D num_str;
+	for (i =3D 0; i < num_str; ++i)
+		str_arr->str[i] =3D parcel_r_string(p);
+
+	if (p->malformed) {
+		parcel_free_str_array(str_arr);
+		return NULL;
+	}
+
+	return str_arr;
+}
+
+void parcel_free_str_array(struct parcel_str_array *str_arr)
+{
+	if (str_arr) {
+		int i;
+		for (i =3D 0; i < str_arr->num_str; ++i)
+			g_free(str_arr->str[i]);
+		g_free(str_arr);
+	}
+}
diff --git a/gril/parcel.h b/gril/parcel.h
new file mode 100644
index 0000000..fd44811
--- /dev/null
+++ b/gril/parcel.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright =C2=A9 2011 Joel Armstrong <jcarmst@sandia.gov>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (`GPL') as publish=
ed by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based on parcel implementation from https://bitbucket.org/floren/inferno
+ *
+ */
+
+#ifndef __PARCEL_H
+#define __PARCEL_H
+
+#include <stdlib.h>
+
+struct parcel {
+	char *data;
+	size_t offset;
+	size_t capacity;
+	size_t size;
+	int malformed;
+};
+
+struct parcel_str_array {
+	int num_str;
+	char *str[];
+};
+
+void parcel_init(struct parcel *p);
+void parcel_grow(struct parcel *p, size_t size);
+void parcel_free(struct parcel *p);
+int32_t parcel_r_int32(struct parcel *p);
+int parcel_w_int32(struct parcel *p, int32_t val);
+int parcel_w_string(struct parcel *p, const char *str);
+char *parcel_r_string(struct parcel *p);
+int parcel_w_raw(struct parcel *p, const void *data, size_t len);
+void *parcel_r_raw(struct parcel *p,  int *len);
+size_t parcel_data_avail(struct parcel *p);
+struct parcel_str_array *parcel_r_str_array(struct parcel *p);
+void parcel_free_str_array(struct parcel_str_array *str_arr);
+
+#endif
diff --git a/gril/ril_constants.h b/gril/ril_constants.h
new file mode 100644
index 0000000..f5b5cad
--- /dev/null
+++ b/gril/ril_constants.h
@@ -0,0 +1,429 @@
+/*
+ *
+ *  RIL constants adopted from AOSP's header:
+ *
+ *  /hardware/ril/reference_ril/ril.h
+ *
+ *  Copyright (C) 2013 Canonical Ltd.
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
+#ifndef __RIL_CONSTANTS_H
+#define __RIL_CONSTANTS_H 1
+#define RIL_VERSION 7
+
+/* Error Codes */
+#define RIL_E_SUCCESS 0
+#define RIL_E_RADIO_NOT_AVAILABLE 1
+#define RIL_E_GENERIC_FAILURE 2
+#define RIL_E_PASSWORD_INCORRECT 3
+#define RIL_E_SIM_PIN2 4
+#define RIL_E_SIM_PUK2 5
+#define RIL_E_REQUEST_NOT_SUPPORTED 6
+#define RIL_E_CANCELLED 7
+#define RIL_E_OP_NOT_ALLOWED_DURING_VOICE_CALL 8
+#define RIL_E_OP_NOT_ALLOWED_BEFORE_REG_TO_NW 9
+#define RIL_E_SMS_SEND_FAIL_RETRY 10
+#define RIL_E_SIM_ABSENT 11
+#define RIL_E_SUBSCRIPTION_NOT_AVAILABLE 12
+#define RIL_E_MODE_NOT_SUPPORTED 13
+#define RIL_E_FDN_CHECK_FAILURE 14
+#define RIL_E_ILLEGAL_SIM_OR_ME 15
+/*
+ * Following error codes are actually Qualcomm-specific, but as they are u=
sed by
+ * our reference platform, we consider them valid for vendor
+ * OFONO_RIL_VENDOR_AOSP. The definition comes from cyanogenmod ril.h, whi=
ch in
+ * turn copied it from codeaurora.
+ */
+#define RIL_E_DIAL_MODIFIED_TO_USSD 17
+#define RIL_E_DIAL_MODIFIED_TO_SS 18
+#define RIL_E_DIAL_MODIFIED_TO_DIAL 19
+#define RIL_E_USSD_MODIFIED_TO_DIAL 20
+#define RIL_E_USSD_MODIFIED_TO_SS 21
+#define RIL_E_USSD_MODIFIED_TO_USSD 22
+#define RIL_E_SS_MODIFIED_TO_DIAL 23
+#define RIL_E_SS_MODIFIED_TO_USSD 24
+#define RIL_E_SS_MODIFIED_TO_SS 25
+#define RIL_E_SUBSCRIPTION_NOT_SUPPORTED 26
+
+/* Preferred network types */
+#define PREF_NET_TYPE_GSM_WCDMA 0
+#define PREF_NET_TYPE_GSM_ONLY 1
+#define PREF_NET_TYPE_WCDMA 2
+#define PREF_NET_TYPE_GSM_WCDMA_AUTO 3
+#define PREF_NET_TYPE_CDMA_EVDO_AUTO 4
+#define PREF_NET_TYPE_CDMA_ONLY 5
+#define PREF_NET_TYPE_EVDO_ONLY 6
+#define PREF_NET_TYPE_GSM_WCDMA_CDMA_EVDO_AUTO 7
+#define PREF_NET_TYPE_LTE_CDMA_EVDO 8
+#define PREF_NET_TYPE_LTE_GSM_WCDMA 9
+#define PREF_NET_TYPE_LTE_CMDA_EVDO_GSM_WCDMA 10
+#define PREF_NET_TYPE_LTE_ONLY 11
+#define PREF_NET_TYPE_LTE_WCDMA 12
+/* MTK specific network types */
+#define MTK_PREF_NET_TYPE_BASE 30
+#define MTK_PREF_NET_TYPE_LTE_GSM_WCDMA (MTK_PREF_NET_TYPE_BASE + 1)
+#define MTK_PREF_NET_TYPE_LTE_GSM_WCDMA_MMDC (MTK_PREF_NET_TYPE_BASE + 2)
+#define MTK_PREF_NET_TYPE_GSM_WCDMA_LTE (MTK_PREF_NET_TYPE_BASE + 3)
+#define MTK_PREF_NET_TYPE_GSM_WCDMA_LTE_MMDC (MTK_PREF_NET_TYPE_BASE + 4)
+#define MTK_PREF_NET_TYPE_LTE_GSM_TYPE (MTK_PREF_NET_TYPE_BASE + 5)
+#define MTK_PREF_NET_TYPE_LTE_GSM_MMDC_TYPE (MTK_PREF_NET_TYPE_BASE + 6)
+
+/*
+ * Data Call Failure causes ( see TS 24.008 )
+ * section 6.1.3.1.3 or TS 24.301 Release 8+ Annex B.
+ */
+#define PDP_FAIL_NONE 0
+#define PDP_FAIL_OPERATOR_BARRED 0x08
+#define PDP_FAIL_INSUFFICIENT_RESOURCES 0x1A
+#define PDP_FAIL_MISSING_UKNOWN_APN 0x1B
+#define PDP_FAIL_UNKNOWN_PDP_ADDRESS_TYPE 0x1C
+#define PDP_FAIL_USER_AUTHENTICATION 0x1D
+#define PDP_FAIL_ACTIVATION_REJECT_GGSN 0x1E
+#define PDP_FAIL_ACTIVATION_REJECT_UNSPECIFIED 0x1F
+#define PDP_FAIL_SERVICE_OPTION_NOT_SUPPORTED 0x20
+#define PDP_FAIL_SERVICE_OPTION_NOT_SUBSCRIBED 0x21
+#define PDP_FAIL_SERVICE_OPTION_OUT_OF_ORDER 0x22
+#define PDP_FAIL_NSAPI_IN_USE 0x23
+#define PDP_FAIL_REGULAR_DEACTIVATION 0x24  /* restart radio */
+#define PDP_FAIL_ONLY_IPV4_ALLOWED 0x32
+#define PDP_FAIL_ONLY_IPV6_ALLOWED 0x33
+#define PDP_FAIL_ONLY_SINGLE_BEARER_ALLOWED 0x34
+#define PDP_FAIL_PROTOCOL_ERRORS 0x6F
+#define PDP_FAIL_VOICE_REGISTRATION_FAIL -1
+#define PDP_FAIL_DATA_REGISTRATION_FAIL -2
+#define PDP_FAIL_SIGNAL_LOST -3
+#define PDP_FAIL_PREF_RADIO_TECH_CHANGED -4
+#define PDP_FAIL_RADIO_POWER_OFF -5
+#define PDP_FAIL_TETHERED_CALL_ACTIVE -6
+#define PDP_FAIL_ERROR_UNSPECIFIED 0xffff
+
+/* Radio States */
+#define RADIO_STATE_OFF 0
+#define RADIO_STATE_UNAVAILABLE 1
+#define RADIO_STATE_ON 10
+
+/* Deprecated, but still used by some modems */
+#define RADIO_STATE_SIM_NOT_READY 2
+#define RADIO_STATE_SIM_LOCKED_OR_ABSENT 3
+#define RADIO_STATE_SIM_READY 4
+
+/* Radio technologies */
+#define RADIO_TECH_UNKNOWN 0
+#define RADIO_TECH_GPRS 1
+#define RADIO_TECH_EDGE 2
+#define RADIO_TECH_UMTS 3
+#define RADIO_TECH_IS95A 4
+#define RADIO_TECH_IS95B 5
+#define RADIO_TECH_1xRTT 6
+#define RADIO_TECH_EVDO_0 7
+#define RADIO_TECH_EVDO_A 8
+#define RADIO_TECH_HSDPA 9
+#define RADIO_TECH_HSUPA 10
+#define RADIO_TECH_HSPA 11
+#define RADIO_TECH_EVDO_B 12
+#define RADIO_TECH_EHRPD 13
+#define RADIO_TECH_LTE 14
+#define RADIO_TECH_HSPAP 15
+#define RADIO_TECH_GSM 16
+/* MTK specific values for radio technologies */
+#define MTK_RADIO_TECH_BASE 128
+#define MTK_RADIO_TECH_HSDPAP (MTK_RADIO_TECH_BASE + 1)
+#define MTK_RADIO_TECH_HSDPAP_UPA (MTK_RADIO_TECH_BASE + 2)
+#define MTK_RADIO_TECH_HSUPAP (MTK_RADIO_TECH_BASE + 3)
+#define MTK_RADIO_TECH_HSUPAP_DPA (MTK_RADIO_TECH_BASE + 4)
+#define MTK_RADIO_TECH_DC_DPA (MTK_RADIO_TECH_BASE + 5)
+#define MTK_RADIO_TECH_DC_UPA (MTK_RADIO_TECH_BASE + 6)
+#define MTK_RADIO_TECH_DC_HSDPAP (MTK_RADIO_TECH_BASE + 7)
+#define MTK_RADIO_TECH_DC_HSDPAP_UPA (MTK_RADIO_TECH_BASE + 8)
+#define MTK_RADIO_TECH_DC_HSDPAP_DPA (MTK_RADIO_TECH_BASE + 9)
+#define MTK_RADIO_TECH_DC_HSPAP (MTK_RADIO_TECH_BASE + 10)
+
+/* See RIL_REQUEST_LAST_CALL_FAIL_CAUSE */
+#define CALL_FAIL_UNOBTAINABLE_NUMBER 1
+#define CALL_FAIL_NORMAL 16
+#define CALL_FAIL_BUSY 17
+#define CALL_FAIL_CONGESTION 34
+#define CALL_FAIL_ACM_LIMIT_EXCEEDED 68
+#define CALL_FAIL_CALL_BARRED 240
+#define CALL_FAIL_FDN_BLOCKED 241
+#define CALL_FAIL_IMSI_UNKNOWN_IN_VLR 242
+#define CALL_FAIL_IMEI_NOT_ACCEPTED 243
+#define CALL_FAIL_DIAL_MODIFIED_TO_USSD 244
+#define CALL_FAIL_DIAL_MODIFIED_TO_SS 245
+#define CALL_FAIL_DIAL_MODIFIED_TO_DIAL 246
+#define CALL_FAIL_CDMA_LOCKED_UNTIL_POWER_CYCLE 1000
+#define CALL_FAIL_CDMA_DROP 1001
+#define CALL_FAIL_CDMA_INTERCEPT 1002
+#define CALL_FAIL_CDMA_REORDER 1003
+#define CALL_FAIL_CDMA_SO_REJECT 1004
+#define CALL_FAIL_CDMA_RETRY_ORDER 1005
+#define CALL_FAIL_CDMA_ACCESS_FAILURE 1006
+#define CALL_FAIL_CDMA_PREEMPTED 1007
+#define CALL_FAIL_CDMA_NOT_EMERGENCY 1008
+#define CALL_FAIL_CDMA_ACCESS_BLOCKED 1009
+#define CALL_FAIL_ERROR_UNSPECIFIED 0xffff
+
+/* see RIL_REQUEST_DEACTIVATE_DATA_CALL parameter*/
+#define RIL_DEACTIVATE_DATA_CALL_NO_REASON 0
+#define RIL_DEACTIVATE_DATA_CALL_RADIO_SHUTDOWN 1
+
+/* See RIL_REQUEST_SETUP_DATA_CALL */
+
+#define RIL_DATA_PROFILE_DEFAULT 0
+#define RIL_DATA_PROFILE_TETHERED 1
+#define RIL_DATA_PROFILE_IMS 2
+#define RIL_DATA_PROFILE_FOTA 3           /* FOTA =3D Firmware Over the Ai=
r */
+#define RIL_DATA_PROFILE_CBS 4
+#define RIL_DATA_PROFILE_OEM_BASE 1000    /* Start of OEM-specific profile=
s */
+/* MTK specific profile for MMS */
+#define RIL_DATA_PROFILE_MTK_MMS (RIL_DATA_PROFILE_OEM_BASE + 1)
+
+/*
+ * auth type -1 seems to mean 0 (RIL_AUTH_NONE) if no user/password is
+ * specified or 3 (RIL_AUTH_BOTH) otherwise. See $ANDROID/packages/
+ * providers/TelephonyProvider/src/com/android/providers/telephony/
+ * TelephonyProvider.java.
+ */
+#define RIL_AUTH_ANY -1
+#define RIL_AUTH_NONE 0
+#define RIL_AUTH_PAP 1
+#define RIL_AUTH_CHAP 2
+#define RIL_AUTH_BOTH 3
+
+/* SIM card states */
+#define RIL_CARDSTATE_ABSENT 0
+#define RIL_CARDSTATE_PRESENT 1
+#define RIL_CARDSTATE_ERROR 2
+
+/* SIM - App states */
+#define RIL_APPSTATE_UNKNOWN 0
+#define RIL_APPSTATE_DETECTED 1
+#define RIL_APPSTATE_PIN 2
+#define RIL_APPSTATE_PUK 3
+#define RIL_APPSTATE_SUBSCRIPTION_PERSO 4
+#define RIL_APPSTATE_READY 5
+
+/* SIM - PIN states */
+#define RIL_PINSTATE_UNKNOWN 0
+#define RIL_PINSTATE_ENABLED_NOT_VERIFIED 1
+#define RIL_PINSTATE_ENABLED_VERIFIED 2
+#define RIL_PINSTATE_DISABLED 3
+#define RIL_PINSTATE_ENABLED_BLOCKED 4
+#define RIL_PINSTATE_ENABLED_PERM_BLOCKED 5
+
+/* SIM - App types */
+#define RIL_APPTYPE_UNKNOWN 0
+#define RIL_APPTYPE_SIM 1
+#define RIL_APPTYPE_USIM 2
+#define RIL_APPTYPE_RUIM 3
+#define RIL_APPTYPE_CSIM 4
+#define RIL_APPTYPE_ISIM 5
+
+/* SIM - PersoSubstate */
+#define RIL_PERSOSUBSTATE_UNKNOWN 0
+#define RIL_PERSOSUBSTATE_IN_PROGRESS 1
+#define RIL_PERSOSUBSTATE_READY 2
+#define RIL_PERSOSUBSTATE_SIM_NETWORK 3
+#define RIL_PERSOSUBSTATE_SIM_NETWORK_SUBSET 4
+#define RIL_PERSOSUBSTATE_SIM_CORPORATE 5
+#define RIL_PERSOSUBSTATE_SIM_SERVICE_PROVIDER 6
+#define RIL_PERSOSUBSTATE_SIM_SIM 7
+#define RIL_PERSOSUBSTATE_SIM_NETWORK_PUK 8
+#define RIL_PERSOSUBSTATE_SIM_NETWORK_SUBSET_PUK 9
+#define RIL_PERSOSUBSTATE_SIM_CORPORATE_PUK 10
+#define RIL_PERSOSUBSTATE_SIM_SERVICE_PROVIDER_PUK 11
+#define RIL_PERSOSUBSTATE_SIM_SIM_PUK 12
+#define RIL_PERSOSUBSTATE_RUIM_NETWORK1 13
+#define RIL_PERSOSUBSTATE_RUIM_NETWORK2 14
+#define RIL_PERSOSUBSTATE_RUIM_HRPD 15
+#define RIL_PERSOSUBSTATE_RUIM_CORPORATE 16
+#define RIL_PERSOSUBSTATE_RUIM_SERVICE_PROVIDER 17
+#define RIL_PERSOSUBSTATE_RUIM_RUIM 18
+#define RIL_PERSOSUBSTATE_RUIM_NETWORK1_PUK 19
+#define RIL_PERSOSUBSTATE_RUIM_NETWORK2_PUK 20
+#define RIL_PERSOSUBSTATE_RUIM_HRPD_PUK 21
+#define RIL_PERSOSUBSTATE_RUIM_CORPORATE_PUK 22
+#define RIL_PERSOSUBSTATE_RUIM_SERVICE_PROVIDER_PUK 23
+#define RIL_PERSOSUBSTATE_RUIM_RUIM_PUK 24
+
+/* RIL Request Messages */
+#define RIL_REQUEST_GET_SIM_STATUS 1
+#define RIL_REQUEST_ENTER_SIM_PIN 2
+#define RIL_REQUEST_ENTER_SIM_PUK 3
+#define RIL_REQUEST_ENTER_SIM_PIN2 4
+#define RIL_REQUEST_ENTER_SIM_PUK2 5
+#define RIL_REQUEST_CHANGE_SIM_PIN 6
+#define RIL_REQUEST_CHANGE_SIM_PIN2 7
+#define RIL_REQUEST_ENTER_NETWORK_DEPERSONALIZATION 8
+#define RIL_REQUEST_GET_CURRENT_CALLS 9
+#define RIL_REQUEST_DIAL 10
+#define RIL_REQUEST_GET_IMSI 11
+#define RIL_REQUEST_HANGUP 12
+#define RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND 13
+#define RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND 14
+#define RIL_REQUEST_SWITCH_WAITING_OR_HOLDING_AND_ACTIVE 15
+#define RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE 15
+#define RIL_REQUEST_CONFERENCE 16
+#define RIL_REQUEST_UDUB 17
+#define RIL_REQUEST_LAST_CALL_FAIL_CAUSE 18
+#define RIL_REQUEST_SIGNAL_STRENGTH 19
+#define RIL_REQUEST_VOICE_REGISTRATION_STATE 20
+#define RIL_REQUEST_DATA_REGISTRATION_STATE 21
+#define RIL_REQUEST_OPERATOR 22
+#define RIL_REQUEST_RADIO_POWER 23
+#define RIL_REQUEST_DTMF 24
+#define RIL_REQUEST_SEND_SMS 25
+#define RIL_REQUEST_SEND_SMS_EXPECT_MORE 26
+#define RIL_REQUEST_SETUP_DATA_CALL 27
+#define RIL_REQUEST_SIM_IO 28
+#define RIL_REQUEST_SEND_USSD 29
+#define RIL_REQUEST_CANCEL_USSD 30
+#define RIL_REQUEST_GET_CLIR 31
+#define RIL_REQUEST_SET_CLIR 32
+#define RIL_REQUEST_QUERY_CALL_FORWARD_STATUS 33
+#define RIL_REQUEST_SET_CALL_FORWARD 34
+#define RIL_REQUEST_QUERY_CALL_WAITING 35
+#define RIL_REQUEST_SET_CALL_WAITING 36
+#define RIL_REQUEST_SMS_ACKNOWLEDGE  37
+#define RIL_REQUEST_GET_IMEI 38
+#define RIL_REQUEST_GET_IMEISV 39
+#define RIL_REQUEST_ANSWER 40
+#define RIL_REQUEST_DEACTIVATE_DATA_CALL 41
+#define RIL_REQUEST_QUERY_FACILITY_LOCK 42
+#define RIL_REQUEST_SET_FACILITY_LOCK 43
+#define RIL_REQUEST_CHANGE_BARRING_PASSWORD 44
+#define RIL_REQUEST_QUERY_NETWORK_SELECTION_MODE 45
+#define RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC 46
+#define RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL 47
+#define RIL_REQUEST_QUERY_AVAILABLE_NETWORKS 48
+#define RIL_REQUEST_DTMF_START 49
+#define RIL_REQUEST_DTMF_STOP 50
+#define RIL_REQUEST_BASEBAND_VERSION 51
+#define RIL_REQUEST_SEPARATE_CONNECTION 52
+#define RIL_REQUEST_SET_MUTE 53
+#define RIL_REQUEST_GET_MUTE 54
+#define RIL_REQUEST_QUERY_CLIP 55
+#define RIL_REQUEST_LAST_DATA_CALL_FAIL_CAUSE 56
+#define RIL_REQUEST_DATA_CALL_LIST 57
+#define RIL_REQUEST_RESET_RADIO 58
+#define RIL_REQUEST_OEM_HOOK_RAW 59
+#define RIL_REQUEST_OEM_HOOK_STRINGS 60
+#define RIL_REQUEST_SCREEN_STATE 61
+#define RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION 62
+#define RIL_REQUEST_WRITE_SMS_TO_SIM 63
+#define RIL_REQUEST_DELETE_SMS_ON_SIM 64
+#define RIL_REQUEST_SET_BAND_MODE 65
+#define RIL_REQUEST_QUERY_AVAILABLE_BAND_MODE 66
+#define RIL_REQUEST_STK_GET_PROFILE 67
+#define RIL_REQUEST_STK_SET_PROFILE 68
+#define RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND 69
+#define RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE 70
+#define RIL_REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM 71
+#define RIL_REQUEST_EXPLICIT_CALL_TRANSFER 72
+#define RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE 73
+#define RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE 74
+#define RIL_REQUEST_GET_NEIGHBORING_CELL_IDS 75
+#define RIL_REQUEST_SET_LOCATION_UPDATES 76
+#define RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE 77
+#define RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE 78
+#define RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE 79
+#define RIL_REQUEST_SET_TTY_MODE 80
+#define RIL_REQUEST_QUERY_TTY_MODE 81
+#define RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE 82
+#define RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE 83
+#define RIL_REQUEST_CDMA_FLASH 84
+#define RIL_REQUEST_CDMA_BURST_DTMF 85
+#define RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY 86
+#define RIL_REQUEST_CDMA_SEND_SMS 87
+#define RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE 88
+#define RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG 89
+#define RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG 90
+#define RIL_REQUEST_GSM_SMS_BROADCAST_ACTIVATION 91
+#define RIL_REQUEST_CDMA_GET_BROADCAST_SMS_CONFIG 92
+#define RIL_REQUEST_CDMA_SET_BROADCAST_SMS_CONFIG 93
+#define RIL_REQUEST_CDMA_SMS_BROADCAST_ACTIVATION 94
+#define RIL_REQUEST_CDMA_SUBSCRIPTION 95
+#define RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM 96
+#define RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM 97
+#define RIL_REQUEST_DEVICE_IDENTITY 98
+#define RIL_REQUEST_EXIT_EMERGENCY_CALLBACK_MODE 99
+#define RIL_REQUEST_GET_SMSC_ADDRESS 100
+#define RIL_REQUEST_SET_SMSC_ADDRESS 101
+#define RIL_REQUEST_REPORT_SMS_MEMORY_STATUS 102
+#define RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING 103
+#define RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE 104
+#define RIL_REQUEST_ISIM_AUTHENTICATION 105
+#define RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU 106
+#define RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS 107
+#define RIL_REQUEST_VOICE_RADIO_TECH 108
+#define RIL_REQUEST_SET_INITIAL_ATTACH_APN 111
+
+/* RIL Unsolicited Messages */
+#define RIL_UNSOL_RESPONSE_BASE 1000
+#define RIL_UNSOL_RESPONSE_RADIO_STATE_CHANGED 1000
+#define RIL_UNSOL_RESPONSE_CALL_STATE_CHANGED 1001
+#define RIL_UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED 1002
+#define RIL_UNSOL_RESPONSE_NEW_SMS 1003
+#define RIL_UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT 1004
+#define RIL_UNSOL_RESPONSE_NEW_SMS_ON_SIM 1005
+#define RIL_UNSOL_ON_USSD 1006
+#define RIL_UNSOL_ON_USSD_REQUEST 1007
+#define RIL_UNSOL_NITZ_TIME_RECEIVED  1008
+#define RIL_UNSOL_SIGNAL_STRENGTH  1009
+#define RIL_UNSOL_DATA_CALL_LIST_CHANGED 1010
+#define RIL_UNSOL_SUPP_SVC_NOTIFICATION 1011
+#define RIL_UNSOL_STK_SESSION_END 1012
+#define RIL_UNSOL_STK_PROACTIVE_COMMAND 1013
+#define RIL_UNSOL_STK_EVENT_NOTIFY 1014
+#define RIL_UNSOL_STK_CALL_SETUP 1015
+#define RIL_UNSOL_SIM_SMS_STORAGE_FULL 1016
+#define RIL_UNSOL_SIM_REFRESH 1017
+#define RIL_UNSOL_CALL_RING 1018
+#define RIL_UNSOL_RESPONSE_SIM_STATUS_CHANGED 1019
+#define RIL_UNSOL_RESPONSE_CDMA_NEW_SMS 1020
+#define RIL_UNSOL_RESPONSE_NEW_BROADCAST_SMS 1021
+#define RIL_UNSOL_CDMA_RUIM_SMS_STORAGE_FULL 1022
+#define RIL_UNSOL_RESTRICTED_STATE_CHANGED 1023
+#define RIL_UNSOL_ENTER_EMERGENCY_CALLBACK_MODE 1024
+#define RIL_UNSOL_CDMA_CALL_WAITING 1025
+#define RIL_UNSOL_CDMA_OTA_PROVISION_STATUS 1026
+#define RIL_UNSOL_CDMA_INFO_REC 1027
+#define RIL_UNSOL_OEM_HOOK_RAW 1028
+#define RIL_UNSOL_RINGBACK_TONE 1029
+#define RIL_UNSOL_RESEND_INCALL_MUTE 1030
+#define RIL_UNSOL_CDMA_SUBSCRIPTION_SOURCE_CHANGED 1031
+#define RIL_UNSOL_CDMA_PRL_CHANGED 1032
+#define RIL_UNSOL_EXIT_EMERGENCY_CALLBACK_MODE 1033
+#define RIL_UNSOL_RIL_CONNECTED 1034
+#define RIL_UNSOL_VOICE_RADIO_TECH_CHANGED 1035
+
+/* Suplementary services Service class*/
+#define SERVICE_CLASS_NONE 0
+
+/* Network registration states */
+#define RIL_REG_STATE_NOT_REGISTERED 0
+#define RIL_REG_STATE_REGISTERED 1
+#define RIL_REG_STATE_SEARCHING 2
+#define RIL_REG_STATE_DENIED 3
+#define RIL_REG_STATE_UNKNOWN 4
+#define RIL_REG_STATE_ROAMING 5
+#define RIL_REG_STATE_EMERGENCY_NOT_REGISTERED 10
+#define RIL_REG_STATE_EMERGENCY_SEARCHING 12
+#define RIL_REG_STATE_EMERGENCY_DENIED 13
+#define RIL_REG_STATE_EMERGENCY_UNKNOWN 14
+
+#endif /*__RIL_CONSTANTS_H*/
-- =

2.1.4


--===============8448550843734849379==--

