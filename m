Content-Type: multipart/mixed; boundary="===============3872689426547438821=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: set address and control field
Date: Mon, 10 May 2010 13:06:37 -0700
Message-ID: <1273521997-7356-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3872689426547438821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before sending to hdlc, set the address and control field.
Fix hardcode of ppp header size.
---
 gatchat/gatppp.c   |    9 +++++++--
 gatchat/ppp.h      |    4 ++++
 gatchat/ppp_auth.c |    2 +-
 gatchat/ppp_cp.c   |    6 ++----
 gatchat/ppp_net.c  |    3 ++-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 70669b0..c4f59f2 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -148,7 +148,8 @@ static void ppp_receive(const unsigned char *buf, gsize=
 len, void *data)
  */
 void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
 {
-	guint16 proto =3D get_host_short(packet);
+	struct ppp_header *header =3D (struct ppp_header *) packet;
+	guint16 proto =3D ppp_proto(packet);
 	guint8 code;
 	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
 	guint32 xmit_accm =3D 0;
@@ -167,7 +168,11 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint i=
nfolen)
 		g_at_hdlc_set_xmit_accm(ppp->hdlc, ~0U);
 	}
 =

-	if (g_at_hdlc_send(ppp->hdlc, packet, infolen + 2) =3D=3D FALSE)
+	header->address =3D PPP_ADDR_FIELD;
+	header->control =3D PPP_CTRL;
+
+	if (g_at_hdlc_send(ppp->hdlc, packet,
+			infolen + sizeof(*header)) =3D=3D FALSE)
 		g_print("Failed to send a frame\n");
 =

 	if (lcp)
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 41cf50a..e872496 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -26,11 +26,15 @@
 #define IPCP_PROTO	0x8021
 #define PPP_IP_PROTO	0x0021
 #define MD5		5
+#define PPP_ADDR_FIELD	0xff
+#define PPP_CTRL	0x03
 =

 struct ppp_chap;
 struct ppp_net;
 =

 struct ppp_header {
+	guint8 address;
+	guint8 control;
 	guint16 proto;
 	guint8 info[0];
 } __attribute__((packed));
diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index 6e55297..eae5d17 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -83,7 +83,7 @@ static void chap_process_challenge(struct ppp_chap *chap,=
 const guint8 *packet)
 	 */
 	digest_len =3D g_checksum_type_get_length(chap->method);
 	response_length =3D digest_len + sizeof(*header) + 1;
-	ppp_packet =3D g_try_malloc0(response_length + 2);
+	ppp_packet =3D g_try_malloc0(response_length + sizeof(struct ppp_header));
 	if (!ppp_packet)
 		goto challenge_out;
 =

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 00acb73..e152f6e 100644
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
+	ppp_packet =3D g_try_malloc0(packet_length + sizeof(*ppp_packet));
 	if (!ppp_packet)
 		return NULL;
 =

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index afebf58..4e45ef1 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -105,7 +105,8 @@ static gboolean ppp_net_callback(GIOChannel *channel, G=
IOCondition cond,
 =

 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
-		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
+		status =3D g_io_channel_read_chars(channel,
+				buf + sizeof(struct ppp_header), net->mtu,
 				&bytes_read, &error);
 		if (bytes_read > 0) {
 			ppp->proto =3D htons(PPP_IP_PROTO);
-- =

1.6.6.1


--===============3872689426547438821==--

