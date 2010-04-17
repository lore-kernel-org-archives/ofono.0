Content-Type: multipart/mixed; boundary="===============2180895162170649529=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] ppp: use GAtHDLC
Date: Sat, 17 Apr 2010 11:15:35 -0700
Message-ID: <1271528135-12337-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271528135-12337-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2180895162170649529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c   |  347 +++++++++---------------------------------------=
----
 gatchat/ppp.h      |   11 ++
 gatchat/ppp_auth.c |    2 +-
 gatchat/ppp_cp.c   |    6 +-
 gatchat/ppp_net.c  |    3 +-
 5 files changed, 75 insertions(+), 294 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index e1e49e6..5b6ba4e 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -34,6 +34,7 @@
 =

 #include <glib.h>
 =

+#include "gathdlc.h"
 #include "gatutil.h"
 #include "gatppp.h"
 #include "crc-ccitt.h"
@@ -41,10 +42,6 @@
 =

 #define DEFAULT_MRU	1500
 =

-#define BUFFERSZ	(DEFAULT_MRU * 2)
-
-#define PPP_ESC		0x7d
-#define PPP_FLAG_SEQ 	0x7e
 #define PPP_ADDR_FIELD	0xff
 #define PPP_CTRL	0x03
 =

@@ -55,24 +52,19 @@ struct _GAtPPP {
 	struct pppcp_data *ipcp;
 	struct ppp_net *net;
 	struct ppp_chap *chap;
-	guint8 buffer[BUFFERSZ];
-	int index;
 	gint mru;
 	char username[256];
 	char password[256];
 	guint32 xmit_accm[8];
 	guint32 recv_accm;
-	GIOChannel *modem;
 	GAtPPPConnectFunc connect_cb;
 	gpointer connect_data;
 	GAtDisconnectFunc disconnect_cb;
 	gpointer disconnect_data;
-	gint read_watch;
-	gint write_watch;
 	GAtDebugFunc debugf;
 	gpointer debug_data;
 	int record_fd;
-	GQueue *xmit_queue;
+	GAtHDLC *hdlc;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -91,81 +83,59 @@ struct frame_buffer {
 	guint8 bytes[0];
 };
 =

+static void ppp_record(GAtPPP *ppp, gboolean in, guint8 *data, guint16 len=
gth)
+{
+	guint16 len =3D htons(length);
+	guint32 ts;
+	struct timeval now;
+	unsigned char id;
+	int err;
+
+	if (ppp->record_fd < 0)
+		return;
+
+	gettimeofday(&now, NULL);
+	ts =3D htonl(now.tv_sec & 0xffffffff);
+
+	id =3D 0x07;
+	err =3D write(ppp->record_fd, &id, 1);
+	err =3D write(ppp->record_fd, &ts, 4);
+
+	id =3D in ? 0x02 : 0x01;
+	err =3D write(ppp->record_fd, &id, 1);
+	err =3D write(ppp->record_fd, &len, 2);
+	err =3D write(ppp->record_fd, data, length);
+}
+
 /*
  * escape any chars less than 0x20, and check the transmit accm table to
  * see if this character should be escaped.
  */
-static gboolean ppp_escape(GAtPPP *ppp, guint8 c, gboolean lcp)
+static gboolean ppp_escape(gpointer user_data, guint8 c, gboolean lcp)
 {
+	GAtPPP *ppp =3D user_data;
+
 	if ((lcp && c < 0x20) || (ppp->xmit_accm[c >> 5] & (1 << (c & 0x1f))))
 		return TRUE;
 	return FALSE;
 }
 =

-static void ppp_put(GAtPPP *ppp, guint8 *buf, int *pos,
-			guint8 c, gboolean lcp)
+static gboolean ppp_hdlc_scan(gpointer user_data, const unsigned char *dat=
a)
 {
-	int i =3D *pos;
-
-	/* escape characters if needed,  copy into buf, increment pos */
-	if (ppp_escape(ppp, c, lcp)) {
-		buf[i++] =3D PPP_ESC;
-		buf[i++] =3D c ^ 0x20;
-	} else
-		buf[i++] =3D c;
-	*pos =3D i;
-}
+	guint16 proto =3D ppp_proto(data);
 =

-static struct frame_buffer *ppp_encode(GAtPPP *ppp, guint8 *data, int len)
-{
-	int pos =3D 0;
-	int i =3D 0;
-	guint16 fcs =3D PPPINITFCS16;
-	guint16 proto =3D get_host_short(data);
-	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
-	guint8 *frame;
-	struct frame_buffer *fb =3D
-		g_try_malloc0(BUFFERSZ + sizeof(struct frame_buffer));
-
-	if (!fb)
-		return NULL;
-	frame =3D fb->bytes;
-
-	/* copy in the HDLC framing */
-	frame[pos++] =3D PPP_FLAG_SEQ;
-
-	/* from here till end flag, calculate FCS over each character */
-	fcs =3D crc_ccitt_byte(fcs, PPP_ADDR_FIELD);
-	ppp_put(ppp, frame, &pos, PPP_ADDR_FIELD, lcp);
-	fcs =3D crc_ccitt_byte(fcs, PPP_CTRL);
-	ppp_put(ppp, frame, &pos, PPP_CTRL, lcp);
-
-	/*
-	 * for each byte, first calculate FCS, then do escaping if
-	 * neccessary
-	 */
-	while (len--) {
-		fcs =3D crc_ccitt_byte(fcs, data[i]);
-		ppp_put(ppp, frame, &pos, data[i++], lcp);
-	}
-
-	/* add FCS */
-	fcs ^=3D 0xffff;		/* complement */
-	ppp_put(ppp, frame, &pos, (guint8)(fcs & 0x00ff), lcp);
-	ppp_put(ppp, frame, &pos, (guint8)((fcs >> 8) & 0x00ff), lcp);
-
-	/* add flag */
-	frame[pos++] =3D PPP_FLAG_SEQ;
-
-	fb->len =3D pos;
-	return fb;
+	if (proto =3D=3D LCP_PROTOCOL)
+		return TRUE;
+	return FALSE;
 }
 =

-/* called when we have received a complete ppp frame */
-static void ppp_recv(GAtPPP *ppp, struct frame_buffer *frame)
+static void ppp_hdlc_recv(const unsigned char *data, gsize size, gpointer =
user_data)
 {
-	guint16 protocol =3D ppp_proto(frame->bytes);
-	guint8 *packet =3D ppp_info(frame->bytes);
+	GAtPPP *ppp =3D user_data;
+	guint16 protocol =3D ppp_proto(data);
+	guint8 *packet =3D (guint8 *) ppp_info(data);
+
+	ppp_record(ppp, TRUE, (guint8 *) data, size);
 =

 	switch (protocol) {
 	case PPP_IP_PROTO:
@@ -186,144 +156,18 @@ static void ppp_recv(GAtPPP *ppp, struct frame_buffe=
r *frame)
 		}
 		/* fall through */
 	default:
-		pppcp_send_protocol_reject(ppp->lcp, frame->bytes, frame->len);
+		pppcp_send_protocol_reject(ppp->lcp, (guint8 *) data, size);
 		break;
 	};
 }
 =

-static struct frame_buffer *ppp_decode(GAtPPP *ppp, guint8 *frame)
+static gboolean ppp_recv_escape(gpointer user_data, guint8 c)
 {
-	guint8 *data;
-	guint pos;
-	int i;
-	guint16 fcs;
-	struct frame_buffer *fb;
-
-	fb =3D g_try_malloc0(sizeof(struct frame_buffer) + ppp->mru + 10);
-	if (!fb)
-		return NULL;
-	data =3D fb->bytes;
-
-	/* skip the first flag char */
-	pos =3D 1;
-
-	fcs =3D PPPINITFCS16;
-	i =3D 0;
-
-	while (frame[pos] !=3D PPP_FLAG_SEQ) {
-		/* Skip the characters in receive ACCM */
-		if (frame[pos] < 0x20 &&
-				(ppp->recv_accm & (1 << frame[pos])) !=3D 0) {
-			pos++;
-			continue;
-		}
-
-		/* scan for escape character */
-		if (frame[pos] =3D=3D PPP_ESC) {
-			/* skip that char */
-			pos++;
-			data[i] =3D frame[pos] ^ 0x20;
-		} else
-			data[i] =3D frame[pos];
-
-		fcs =3D crc_ccitt_byte(fcs, data[i]);
-
-		i++; pos++;
-	}
+	GAtPPP *ppp =3D user_data;
 =

-	fb->len =3D i;
-
-	/* see if we have a good FCS */
-	if (fcs !=3D PPPGOODFCS16) {
-		g_free(fb);
-		return NULL;
-	}
-
-	return fb;
-}
-
-static void ppp_feed(GAtPPP *ppp, guint8 *data, gsize len)
-{
-	guint pos =3D 0;
-	struct frame_buffer *frame;
-
-	/* collect bytes until we detect we have received a complete frame */
-	/* examine the data.  If we are at the beginning of a new frame,
-	 * allocate memory to buffer the frame.
-	 */
-
-	for (pos =3D 0; pos < len; pos++) {
-		if (data[pos] =3D=3D PPP_FLAG_SEQ) {
-			if (ppp->index !=3D 0) {
-				/* store last flag character & decode */
-				ppp->buffer[ppp->index++] =3D data[pos];
-				frame =3D ppp_decode(ppp, ppp->buffer);
-				if (frame) {
-					/* process receive frame */
-					ppp_recv(ppp, frame);
-					g_free(frame);
-				}
-
-				/* zero buffer */
-				memset(ppp->buffer, 0, BUFFERSZ);
-				ppp->index =3D 0;
-				continue;
-			}
-		}
-		/* copy byte to buffer */
-		if (ppp->index < BUFFERSZ)
-			ppp->buffer[ppp->index++] =3D data[pos];
-	}
-}
-
-static void ppp_record(GAtPPP *ppp, gboolean in, guint8 *data, guint16 len=
gth)
-{
-	guint16 len =3D htons(length);
-	guint32 ts;
-	struct timeval now;
-	unsigned char id;
-	int err;
-
-	if (ppp->record_fd < 0)
-		return;
-
-	gettimeofday(&now, NULL);
-	ts =3D htonl(now.tv_sec & 0xffffffff);
-
-	id =3D 0x07;
-	err =3D write(ppp->record_fd, &id, 1);
-	err =3D write(ppp->record_fd, &ts, 4);
-
-	id =3D in ? 0x02 : 0x01;
-	err =3D write(ppp->record_fd, &id, 1);
-	err =3D write(ppp->record_fd, &len, 2);
-	err =3D write(ppp->record_fd, data, length);
-}
-
-static gboolean ppp_read_cb(GIOChannel *channel, GIOCondition cond,
-								gpointer data)
-{
-	GAtPPP *ppp =3D data;
-	GIOStatus status;
-	gchar buf[256];
-	gsize bytes_read;
-	GError *error =3D NULL;
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
-		return FALSE;
-
-	if (cond & G_IO_IN) {
-		status =3D g_io_channel_read_chars(channel, buf, 256,
-				&bytes_read, &error);
-		if (bytes_read > 0) {
-			ppp_record(ppp, TRUE, (guint8 *) buf, bytes_read);
-			ppp_feed(ppp, (guint8 *) buf, bytes_read);
-		}
-		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
-			return FALSE;
-	}
-
-	return TRUE;
+	if (c < 0x20 && (ppp->recv_accm & (1 << c)) !=3D 0)
+		return TRUE;
+	return FALSE;
 }
 =

 static void ppp_dead(GAtPPP *ppp)
@@ -371,12 +215,6 @@ void ppp_enter_phase(GAtPPP *ppp, enum ppp_phase phase)
 	}
 }
 =

-static void read_watcher_destroy_notify(GAtPPP *ppp)
-{
-	ppp->read_watch =3D 0;
-	pppcp_signal_down(ppp->lcp);
-}
-
 void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
 {
 	guint16 proto =3D get_host_short(auth_data);
@@ -540,13 +378,7 @@ void g_at_ppp_unref(GAtPPP *ppp)
 	if (ppp->record_fd > fileno(stderr))
 		close(ppp->record_fd);
 =

-	/* cleanup queue */
-	g_queue_free(ppp->xmit_queue);
-
-	/* cleanup modem channel */
-	g_source_remove(ppp->read_watch);
-	g_source_remove(ppp->write_watch);
-	g_io_channel_unref(ppp->modem);
+	g_at_hdlc_unref(ppp->hdlc);
 =

 	lcp_free(ppp->lcp);
 	ppp_chap_free(ppp->chap);
@@ -566,11 +398,15 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 	if (!ppp)
 		return NULL;
 =

-	if (!g_at_util_setup_io(modem, G_IO_FLAG_NONBLOCK)) {
+	ppp->hdlc =3D g_at_hdlc_new(modem);
+	if (ppp->hdlc =3D=3D NULL) {
 		g_free(ppp);
 		return NULL;
 	}
-	g_io_channel_set_buffered(modem, FALSE);
+	g_at_hdlc_set_receive(ppp->hdlc, ppp_hdlc_recv, ppp);
+	g_at_hdlc_set_recv_escape(ppp->hdlc, ppp_recv_escape, ppp);
+	g_at_hdlc_set_send_escape(ppp->hdlc, ppp_escape, ppp);
+	g_at_hdlc_set_scan(ppp->hdlc, ppp_hdlc_scan, ppp);
 =

 	ppp->ref_count =3D 1;
 =

@@ -580,70 +416,16 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 	ppp->xmit_accm[0] =3D ~0U;
 	ppp->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
 =

-	ppp->index =3D 0;
-
-	/* intialize the queue */
-	ppp->xmit_queue =3D g_queue_new();
-
 	/* initialize the lcp state */
 	ppp->lcp =3D lcp_new(ppp);
 =

 	/* initialize IPCP state */
 	ppp->ipcp =3D ipcp_new(ppp);
-
-	/* start listening for packets from the modem */
-	ppp->read_watch =3D g_io_add_watch_full(modem, G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				ppp_read_cb, ppp,
-				(GDestroyNotify)read_watcher_destroy_notify);
-
-	ppp->modem =3D modem;
 	ppp->record_fd =3D -1;
 =

 	return ppp;
 }
 =

-static gboolean ppp_xmit_cb(GIOChannel *channel, GIOCondition cond,
-				gpointer data)
-{
-	GAtPPP *ppp =3D data;
-	struct frame_buffer *fb;
-	GError *error =3D NULL;
-	GIOStatus status;
-	gsize bytes_written;
-
-	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
-		return FALSE;
-
-	if (cond & G_IO_OUT) {
-		while ((fb =3D g_queue_peek_head(ppp->xmit_queue))) {
-			status =3D g_io_channel_write_chars(ppp->modem,
-					(gchar *) fb->bytes, fb->len,
-					&bytes_written, &error);
-			if (status !=3D G_IO_STATUS_NORMAL &&
-				status !=3D G_IO_STATUS_AGAIN)
-				return FALSE;
-
-			if (bytes_written < fb->len)
-				return TRUE;
-
-			ppp_record(ppp, FALSE, fb->bytes, bytes_written);
-			g_free(g_queue_pop_head(ppp->xmit_queue));
-		}
-	}
-	return FALSE;
-}
-
-static void ppp_xmit_destroy_notify(gpointer destroy_data)
-{
-	GAtPPP *ppp =3D destroy_data;
-
-	ppp->write_watch =3D 0;
-
-	if (ppp->phase =3D=3D PPP_PHASE_DEAD)
-		ppp_dead(ppp);
-}
-
 /*
  * transmit out through the lower layer interface
  *
@@ -651,22 +433,11 @@ static void ppp_xmit_destroy_notify(gpointer destroy_=
data)
  */
 void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
 {
-	struct frame_buffer *fb;
-
-	/*
-	 * do the octet stuffing.  Add 2 bytes to the infolen to
-	 * include the protocol field.
-	 */
-	fb =3D ppp_encode(ppp, packet, infolen + 2);
-	if (!fb) {
-		g_printerr("Failed to encode packet to transmit\n");
-		return;
-	}
-	/* push decoded frame onto xmit queue */
-	g_queue_push_tail(ppp->xmit_queue, fb);
+	struct ppp_header *header =3D (struct ppp_header *) packet;
+	gsize len =3D infolen + sizeof(struct ppp_header);
 =

-	/* transmit this whenever we can write without blocking */
-	ppp->write_watch =3D g_io_add_watch_full(ppp->modem, G_PRIORITY_DEFAULT,
-				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				ppp_xmit_cb, ppp, ppp_xmit_destroy_notify);
+	header->address =3D PPP_ADDR_FIELD;
+	header->control =3D PPP_CTRL;
+	g_at_hdlc_send(ppp->hdlc, packet, len);
+	ppp_record(ppp, FALSE, packet, len);
 }
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index a8a0486..c41bb05 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -39,6 +39,8 @@ struct ppp_chap;
 struct ppp_net;
 =

 struct ppp_header {
+	guint8 address;
+	guint8 control;
 	guint16 proto;
 	guint8 info[0];
 } __attribute__((packed));
@@ -84,6 +86,15 @@ static inline void __put_unaligned_short(void *p, guint1=
6 val)
 #define ppp_proto(packet) \
 	(get_host_short(packet + 2))
 =

+#define ppp_hdlc_proto(packet) \
+	(get_host_short(packet + 4))
+
+#define ppp_hdlc_info(packet) \
+	(packet + 6)
+
+#define ppp_hdlc_packet(packet) \
+	((guint8 *) packet + 2)
+
 /* LCP related functions */
 struct pppcp_data *lcp_new(GAtPPP *ppp);
 void lcp_free(struct pppcp_data *lcp);
diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index 57203ab..b8c0628 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -83,7 +83,7 @@ static void chap_process_challenge(struct ppp_chap *chap,=
 guint8 *packet)
 	 */
 	digest_len =3D g_checksum_type_get_length(chap->method);
 	response_length =3D digest_len + sizeof(*header) + 1;
-	ppp_packet =3D g_try_malloc0(response_length + 2);
+	ppp_packet =3D g_try_malloc0(response_length + sizeof(struct ppp_header));
 	if (!ppp_packet)
 		goto challenge_out;
 =

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 6cd3681..ce8c94a 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -61,10 +61,8 @@ static const char *pppcp_event_strings[] =3D {
 	g_free(str); \
 } while (0);
 =

-#define PPP_HEADROOM	2
-
 #define pppcp_to_ppp_packet(p) \
-	(((guint8 *) p) - PPP_HEADROOM)
+	(((guint8 *) p) - sizeof(struct ppp_header))
 =

 #define INITIAL_RESTART_TIMEOUT	3	/* restart interval in seconds */
 #define MAX_TERMINATE		2
@@ -206,7 +204,7 @@ static struct pppcp_packet *pppcp_packet_new(struct ppp=
cp_data *data,
 	struct ppp_header *ppp_packet;
 	guint16 packet_length =3D bufferlen + sizeof(*packet);
 =

-	ppp_packet =3D g_try_malloc0(packet_length + 2);
+	ppp_packet =3D g_try_malloc0(packet_length + sizeof(struct ppp_header));
 	if (!ppp_packet)
 		return NULL;
 =

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 325e859..9fbd1d7 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -80,7 +80,8 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 =

 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
-		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
+		status =3D g_io_channel_read_chars(channel,
+				buf + sizeof(struct ppp_header), MAX_PACKET,
 				&bytes_read, &error);
 		if (bytes_read > 0) {
 			ppp->proto =3D htons(PPP_IP_PROTO);
-- =

1.6.6.1


--===============2180895162170649529==--

