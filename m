Content-Type: multipart/mixed; boundary="===============6210052102703081371=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: use queue to transmit
Date: Fri, 02 Apr 2010 11:13:20 -0700
Message-ID: <1270232000-7858-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6210052102703081371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since we are using non buffered I/O, use a queue to transmit when we will n=
ot
block.
---
 gatchat/gatppp.c |  133 ++++++++++++++++++++++++++++++++++++--------------=
---
 gatchat/ppp.h    |    4 +-
 gatchat/ppp_cp.c |    1 +
 3 files changed, 94 insertions(+), 44 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 2b853f0..e1eb89b 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -135,17 +135,20 @@ static void ppp_put(GAtPPP *ppp, guint8 *buf, int *po=
s,
 }
 =

 /* XXX implement PFC and ACFC */
-static guint8 *ppp_encode(GAtPPP *ppp, guint8 *data, int len,
-				guint *newlen)
+static struct frame_buffer *ppp_encode(GAtPPP *ppp, guint8 *data, int len)
 {
 	int pos =3D 0;
 	int i =3D 0;
 	guint16 fcs =3D PPPINITFCS16;
 	guint16 proto =3D get_host_short(data);
 	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
-	guint8 *frame =3D g_try_malloc0(BUFFERSZ);
-	if (!frame)
+	guint8 *frame;
+	struct frame_buffer *fb =3D
+		g_try_malloc0(BUFFERSZ + sizeof(struct frame_buffer));
+
+	if (!fb)
 		return NULL;
+	frame =3D fb->bytes;
 =

 	/* copy in the HDLC framing */
 	frame[pos++] =3D PPP_FLAG_SEQ;
@@ -173,8 +176,8 @@ static guint8 *ppp_encode(GAtPPP *ppp, guint8 *data, in=
t len,
 	/* add flag */
 	frame[pos++] =3D PPP_FLAG_SEQ;
 =

-	*newlen =3D pos;
-	return frame;
+	fb->len =3D pos;
+	return fb;
 }
 =

 static gint is_proto_handler(gconstpointer a, gconstpointer b)
@@ -316,41 +319,6 @@ static void ppp_record(GAtPPP *ppp, gboolean in, guint=
8 *data, guint16 length)
 	err =3D write(ppp->record_fd, data, length);
 }
 =

-/*
- * transmit out through the lower layer interface
- *
- * infolen - length of the information part of the packet
- */
-void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
-{
-	guint8 *frame;
-	guint framelen;
-	GError *error =3D NULL;
-	GIOStatus status;
-	gsize bytes_written;
-
-	/*
-	 * do the octet stuffing.  Add 2 bytes to the infolen to
-	 * include the protocol field.
-	 */
-	frame =3D ppp_encode(ppp, packet, infolen + 2, &framelen);
-	if (!frame) {
-		g_printerr("Failed to encode packet to transmit\n");
-		return;
-	}
-
-	/* transmit through the lower layer interface */
-	/*
-	 * TBD - should we just put this on a queue and transmit when
-	 * we won't block, or allow ourselves to block here?
-	 */
-	status =3D g_io_channel_write_chars(ppp->modem, (gchar *) frame,
-					framelen, &bytes_written, &error);
-	ppp_record(ppp, FALSE, frame, bytes_written);
-
-	g_free(frame);
-}
-
 static gboolean ppp_cb(GIOChannel *channel, GIOCondition cond, gpointer da=
ta)
 {
 	GAtPPP *ppp =3D data;
@@ -378,6 +346,9 @@ static gboolean ppp_cb(GIOChannel *channel, GIOConditio=
n cond, gpointer data)
 =

 static void ppp_dead(GAtPPP *ppp)
 {
+	if (ppp->write_watch)
+		return;
+
 	/* notify interested parties */
 	if (ppp->disconnect_cb)
 		ppp->disconnect_cb(ppp->disconnect_data);
@@ -385,8 +356,12 @@ static void ppp_dead(GAtPPP *ppp)
 	if (g_atomic_int_get(&ppp->ref_count))
 		return;
 =

+	/* cleanup queue */
+	g_queue_free(ppp->xmit_queue);
+
 	/* cleanup modem channel */
-	g_source_remove(ppp->modem_watch);
+	g_source_remove(ppp->read_watch);
+	g_source_remove(ppp->write_watch);
 	g_io_channel_unref(ppp->modem);
 =

 	/* remove lcp */
@@ -621,6 +596,9 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 =

 	ppp->index =3D 0;
 =

+	/* intialize the queue */
+	ppp->xmit_queue =3D g_queue_new();
+
 	/* initialize the lcp state */
 	ppp->lcp =3D lcp_new(ppp);
 =

@@ -631,7 +609,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 	ppp->net =3D ppp_net_new(ppp);
 =

 	/* start listening for packets from the modem */
-	ppp->modem_watch =3D g_io_add_watch(modem,
+	ppp->read_watch =3D g_io_add_watch(modem,
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			ppp_cb, ppp);
 =

@@ -639,3 +617,72 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 =

 	return ppp;
 }
+
+static gboolean ppp_xmit_cb(GIOChannel *channel, GIOCondition cond,
+				gpointer data)
+{
+	GAtPPP *ppp =3D data;
+	struct frame_buffer *fb;
+	GError *error =3D NULL;
+	GIOStatus status;
+	gsize bytes_written;
+
+	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	if (cond & G_IO_OUT) {
+		while ((fb =3D g_queue_peek_head(ppp->xmit_queue))) {
+			status =3D g_io_channel_write_chars(ppp->modem,
+					(gchar *) fb->bytes, fb->len,
+                                        &bytes_written, &error);
+			if (status !=3D G_IO_STATUS_NORMAL &&
+				status !=3D G_IO_STATUS_AGAIN)
+				return FALSE;
+
+			if (bytes_written < fb->len)
+				return TRUE;
+
+			ppp_record(ppp, FALSE, fb->bytes, bytes_written);
+			g_free(g_queue_pop_head(ppp->xmit_queue));
+		}
+	}
+	return FALSE;
+}
+
+static void ppp_xmit_destroy_notify(gpointer destroy_data)
+{
+	GAtPPP *ppp =3D destroy_data;
+
+	g_print("%s\n", __FUNCTION__);
+
+	ppp->write_watch =3D 0;
+	if (ppp->phase =3D=3D PPP_DEAD)
+		ppp_dead(ppp);
+}
+
+/*
+ * transmit out through the lower layer interface
+ *
+ * infolen - length of the information part of the packet
+ */
+void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
+{
+	struct frame_buffer *fb;
+
+	/*
+	 * do the octet stuffing.  Add 2 bytes to the infolen to
+	 * include the protocol field.
+	 */
+	fb =3D ppp_encode(ppp, packet, infolen + 2);
+	if (!fb) {
+		g_printerr("Failed to encode packet to transmit\n");
+		return;
+	}
+	/* push decoded frame onto xmit queue */
+	g_queue_push_tail(ppp->xmit_queue, fb);
+
+	/* transmit this whenever we can write without blocking */
+	ppp->write_watch =3D g_io_add_watch_full(ppp->modem, G_PRIORITY_DEFAULT,
+				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				ppp_xmit_cb, ppp, ppp_xmit_destroy_notify);
+}
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index ba17f41..111a1e6 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -134,10 +134,12 @@ struct _GAtPPP {
 	gpointer connect_data;
 	GAtDisconnectFunc disconnect_cb;
 	gpointer disconnect_data;
-	gint modem_watch;
+	gint read_watch;
+	gint write_watch;
 	GAtDebugFunc debugf;
 	gpointer debug_data;
 	int record_fd;
+	GQueue *xmit_queue;
 };
 =

 void ppp_generate_event(GAtPPP *ppp, enum ppp_event event);
diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index d74a07b..16c0603 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -164,6 +164,7 @@ static void pppcp_this_layer_finished(struct pppcp_data=
 *data)
 {
 	struct pppcp_action *action =3D data->action;
 =

+	pppcp_trace(data);
 	if (action->this_layer_finished)
 		action->this_layer_finished(data);
 }
-- =

1.6.6.1


--===============6210052102703081371==--

