Content-Type: multipart/mixed; boundary="===============5164920383089999451=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/5] ppp: send Protocol-Reject
Date: Fri, 26 Mar 2010 18:34:28 -0700
Message-ID: <1269653670-31352-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5164920383089999451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

change ppp_decode to store the length of the decoded frame, so that
if we have a packet with a protocol we don't understand, we can send
Protocol-Reject packets.  Modify ppp_cp code to add support for sending
Protocol-Reject packet.
---
 gatchat/ppp.c     |   29 +++++++++++++++++++----------
 gatchat/ppp.h     |    1 +
 gatchat/ppp_cp.c  |   42 ++++++++++++++++++++++++++++++++++++++++++
 gatchat/ppp_cp.h  |    2 ++
 gatchat/ppp_lcp.c |    5 +++++
 5 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/gatchat/ppp.c b/gatchat/ppp.c
index d771c3f..f93b52d 100644
--- a/gatchat/ppp.c
+++ b/gatchat/ppp.c
@@ -39,6 +39,11 @@
 #define PPPINITFCS16    0xffff  /* Initial FCS value */
 #define PPPGOODFCS16    0xf0b8  /* Good final FCS value */
 =

+struct frame_buffer {
+	gsize len;
+	guint8 bytes[0];
+};
+
 static GList *packet_handlers =3D NULL;
 =

 void ppp_register_packet_handler(struct ppp_packet_handler *handler)
@@ -185,12 +190,12 @@ static gint is_proto_handler(gconstpointer a, gconstp=
ointer b)
 static void ppp_recv(GAtPPP *ppp)
 {
 	GList *list;
-	guint8 *frame;
+	struct frame_buffer *frame;
 =

 	/* pop frames off of receive queue */
 	while ((frame =3D g_queue_pop_head(ppp->recv_queue))) {
-		guint protocol =3D ppp_proto(frame);
-		guint8 *packet =3D ppp_info(frame);
+		guint protocol =3D ppp_proto(frame->bytes);
+		guint8 *packet =3D ppp_info(frame->bytes);
 		struct ppp_packet_handler *h;
 =

 		/*
@@ -203,23 +208,26 @@ static void ppp_recv(GAtPPP *ppp)
 		if (list) {
 			h =3D list->data;
 			h->handler(h->priv, packet);
-		}
+		} else
+			lcp_protocol_reject(ppp->lcp, frame->bytes, frame->len);
 		g_free(frame);
 	}
 }
 =

 /* XXX - Implement PFC and ACFC */
-static guint8 *ppp_decode(GAtPPP *ppp, guint8 *frame)
+static struct frame_buffer *ppp_decode(GAtPPP *ppp, guint8 *frame)
 {
 	guint8 *data;
 	guint pos =3D 0;
 	int i =3D 0;
 	int len;
 	guint16 fcs;
+	struct frame_buffer *fb;
 =

-	data =3D g_try_malloc0(ppp->mru + 10);
-	if (!data)
+	fb =3D g_try_malloc0(sizeof(struct frame_buffer) + ppp->mru + 10);
+	if (!fb)
 		return NULL;
+	data =3D fb->bytes;
 =

 	/* skip the first flag char */
 	pos++;
@@ -237,6 +245,7 @@ static guint8 *ppp_decode(GAtPPP *ppp, guint8 *frame)
 	}
 =

 	len =3D i;
+	fb->len =3D len;
 =

 	/* see if we have a good FCS */
 	fcs =3D PPPINITFCS16;
@@ -244,16 +253,16 @@ static guint8 *ppp_decode(GAtPPP *ppp, guint8 *frame)
 		fcs =3D ppp_fcs(fcs, data[i]);
 =

 	if (fcs !=3D PPPGOODFCS16) {
-		g_free(data);
+		g_free(fb);
 		return NULL;
 	}
-	return data;
+	return fb;
 }
 =

 static void ppp_feed(GAtPPP *ppp, guint8 *data, gsize len)
 {
 	guint pos =3D 0;
-	guint8 *frame;
+	struct frame_buffer *frame;
 =

 	/* collect bytes until we detect we have received a complete frame */
 	/* examine the data.  If we are at the beginning of a new frame,
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 05cd50f..6797603 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -156,6 +156,7 @@ void lcp_open(struct pppcp_data *data);
 void lcp_close(struct pppcp_data *data);
 void lcp_establish(struct pppcp_data *data);
 void lcp_terminate(struct pppcp_data *data);
+void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize len=
);
 void auth_set_credentials(struct auth_data *data, const char *username,
 				const char *passwd);
 void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method);
diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index f83cfba..263fa8b 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -1442,6 +1442,48 @@ static guint8 pppcp_process_discard_request(struct p=
ppcp_data *data,
 	return 0;
 }
 =

+void pppcp_send_protocol_reject(struct pppcp_data *data,
+				guint8 *rejected_packet, gsize len)
+{
+	struct pppcp_packet *packet;
+	struct ppp_header *ppp_packet =3D (struct ppp_header *) rejected_packet;
+
+	pppcp_trace(data);
+
+	/*
+	 * Protocol-Reject can only be sent when we are in
+	 * the OPENED state.  If in any other state, silently discard.
+	 */
+	if (data->state !=3D OPENED) {
+		g_free(ppp_packet);
+		return;
+	}
+
+	/*
+	 * info should contain the old packet info, plus the 16bit
+	 * protocol number we are rejecting.
+	 */
+	packet =3D pppcp_packet_new(data, PROTOCOL_REJECT, len);
+
+	/*
+	 * Identifier must be changed for each Protocol-Reject sent
+	 */
+	packet->identifier =3D new_identity(data, data->reject_identifier);
+
+	/*
+	 * rejected packet should be copied in, but it should be
+	 * truncated if it needs to be to comply with mtu requirement
+	 */
+	memcpy(packet->data, rejected_packet,
+			(ntohs(packet->length) - CP_HEADER_SZ));
+
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
+			ntohs(packet->length));
+
+	pppcp_packet_free(packet);
+
+}
+
 /*
  * parse the packet and determine which event this packet caused
  */
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 69676cd..e326b5e 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -150,3 +150,5 @@ void pppcp_generate_event(struct pppcp_data *data,
 				enum pppcp_event_type event_type,
 				gpointer event_data, guint data_len);
 void pppcp_process_packet(gpointer priv, guint8 *new_packet);
+void pppcp_send_protocol_reject(struct pppcp_data *data,
+				guint8 *rejected_packet, gsize len);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 7206b4b..1ccc3cc 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -220,6 +220,11 @@ void lcp_free(struct pppcp_data *lcp)
 	pppcp_free(lcp);
 }
 =

+void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize len)
+{
+	pppcp_send_protocol_reject(lcp, packet, len);
+}
+
 struct pppcp_data *lcp_new(GAtPPP *ppp)
 {
 	struct pppcp_data *pppcp;
-- =

1.6.6.1


--===============5164920383089999451==--

