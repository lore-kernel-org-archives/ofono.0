Content-Type: multipart/mixed; boundary="===============1638319752769777502=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: implement ppp_packet_new
Date: Thu, 13 May 2010 10:31:32 -0700
Message-ID: <1273771892-6050-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1638319752769777502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c   |   15 +++++++++++++++
 gatchat/ppp.h      |    1 +
 gatchat/ppp_auth.c |    4 +---
 gatchat/ppp_cp.c   |    5 +----
 gatchat/ppp_net.c  |   26 +++++++++++++++++---------
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 82d1eca..8d62b07 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -84,6 +84,21 @@ void ppp_debug(GAtPPP *ppp, const char *str)
 	ppp->debugf(str, ppp->debug_data);
 }
 =

+struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol)
+{
+	struct ppp_header *ppp_packet;
+
+	ppp_packet =3D g_try_malloc0(infolen + sizeof(*ppp_packet));
+	if (ppp_packet =3D=3D NULL)
+		return NULL;
+
+	ppp_packet->proto =3D htons(protocol);
+	ppp_packet->address =3D PPP_ADDR_FIELD;
+	ppp_packet->control =3D PPP_CTRL;
+
+	return ppp_packet;
+}
+
 /*
  * Silently discard packets which are received when they shouldn't be
  */
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 7f6c950..b6c5f4a 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -114,3 +114,4 @@ void ppp_lcp_finished_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
+struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index eae5d17..d26b764 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -83,12 +83,10 @@ static void chap_process_challenge(struct ppp_chap *cha=
p, const guint8 *packet)
 	 */
 	digest_len =3D g_checksum_type_get_length(chap->method);
 	response_length =3D digest_len + sizeof(*header) + 1;
-	ppp_packet =3D g_try_malloc0(response_length + sizeof(struct ppp_header));
+	ppp_packet =3D ppp_packet_new(response_length, CHAP_PROTOCOL);
 	if (!ppp_packet)
 		goto challenge_out;
 =

-	/* add our protocol information */
-	ppp_packet->proto =3D htons(CHAP_PROTOCOL);
 	response =3D (struct chap_header *) &ppp_packet->info;
 	if (response) {
 		response->code =3D RESPONSE;
diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index e152f6e..bade6bb 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -204,13 +204,10 @@ static struct pppcp_packet *pppcp_packet_new(struct p=
ppcp_data *data,
 	struct ppp_header *ppp_packet;
 	guint16 packet_length =3D bufferlen + sizeof(*packet);
 =

-	ppp_packet =3D g_try_malloc0(packet_length + sizeof(*ppp_packet));
+	ppp_packet =3D ppp_packet_new(packet_length, data->driver->proto);
 	if (!ppp_packet)
 		return NULL;
 =

-	/* add our protocol information */
-	ppp_packet->proto =3D htons(data->driver->proto);
-
 	/* advance past protocol to add CP header information */
 	packet =3D (struct pppcp_packet *) (ppp_packet->info);
 =

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index bd1a60e..a74c06c 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -46,6 +46,7 @@ struct ppp_net {
 	GIOChannel *channel;
 	gint watch;
 	gint mtu;
+	struct ppp_header *ppp_packet;
 };
 =

 gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
@@ -95,23 +96,21 @@ static gboolean ppp_net_callback(GIOChannel *channel, G=
IOCondition cond,
 {
 	struct ppp_net *net =3D (struct ppp_net *) userdata;
 	GIOStatus status;
-	gchar buf[MAX_PACKET + sizeof(struct ppp_header)];
 	gsize bytes_read;
 	GError *error =3D NULL;
-	struct ppp_header *ppp =3D (struct ppp_header *) buf;
+	gchar *buf =3D (gchar *) net->ppp_packet->info;
 =

 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
 		return FALSE;
 =

 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
-		status =3D g_io_channel_read_chars(channel,
-				buf + sizeof(struct ppp_header), net->mtu,
-				&bytes_read, &error);
-		if (bytes_read > 0) {
-			ppp->proto =3D htons(PPP_IP_PROTO);
-			ppp_transmit(net->ppp, (guint8 *) buf, bytes_read);
-		}
+		status =3D g_io_channel_read_chars(channel, buf, net->mtu,
+						 &bytes_read, &error);
+		if (bytes_read > 0)
+			ppp_transmit(net->ppp, (guint8 *) net->ppp_packet,
+					bytes_read);
+
 		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
 			return FALSE;
 	}
@@ -135,6 +134,12 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp)
 	if (net =3D=3D NULL)
 		return NULL;
 =

+	net->ppp_packet =3D ppp_packet_new(MAX_PACKET, PPP_IP_PROTO);
+	if (net->ppp_packet =3D=3D NULL) {
+		g_free(net);
+		return NULL;
+	}
+
 	/* open a tun interface */
 	fd =3D open("/dev/net/tun", O_RDWR);
 	if (fd < 0)
@@ -176,6 +181,8 @@ error:
 	if (fd >=3D 0)
 		close(fd);
 =

+	g_free(net->if_name);
+	g_free(net->ppp_packet);
 	g_free(net);
 	return NULL;
 }
@@ -185,6 +192,7 @@ void ppp_net_free(struct ppp_net *net)
 	g_source_remove(net->watch);
 	g_io_channel_unref(net->channel);
 =

+	g_free(net->ppp_packet);
 	g_free(net->if_name);
 	g_free(net);
 }
-- =

1.6.6.1


--===============1638319752769777502==--

