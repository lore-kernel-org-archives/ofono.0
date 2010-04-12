Content-Type: multipart/mixed; boundary="===============0682884111701607656=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] ppp: remove references to magic number
Date: Mon, 12 Apr 2010 07:38:51 -0700
Message-ID: <1271083133-13760-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271083133-13760-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0682884111701607656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We will not support loopback detection.
---
 gatchat/ppp_cp.c  |    8 +++++++-
 gatchat/ppp_lcp.c |    6 +-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 5ac0196..83f5052 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -574,7 +574,7 @@ static void pppcp_send_echo_reply(struct pppcp_data *da=
ta,
 	 */
 	packet->identifier =3D header->identifier;
 =

-	/* magic number? */
+	/* magic number will always be zero */
 	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
 =

@@ -855,6 +855,12 @@ static guint8 pppcp_process_protocol_reject(struct ppp=
cp_data *data,
 	return RXJ_MINUS;
 }
 =

+/*
+ * For Echo-Request, Echo-Reply, and Discard-Request, we will not
+ * bother checking the magic number of the packet, because we will
+ * never send an echo or discard request.  We can't reliably detect
+ * loop back anyway, since we don't negotiate a magic number.
+ */
 static guint8 pppcp_process_echo_request(struct pppcp_data *data,
 					struct pppcp_packet *packet)
 {
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index a384a0d..5dfe4aa 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -64,7 +64,6 @@ enum lcp_options {
 #define REQ_OPTION_ACCM 0x1
 =

 struct lcp_data {
-	guint32 magic_number;
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
 	guint16 options_len;
 	guint8 req_options;
@@ -157,7 +156,6 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 					const struct pppcp_packet *packet,
 					guint8 **new_options, guint16 *new_len)
 {
-	struct lcp_data *lcp =3D pppcp_get_data(pppcp);
 	GAtPPP *ppp =3D pppcp_get_ppp(pppcp);
 	struct ppp_option_iter iter;
 =

@@ -180,7 +178,6 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 			if (magic =3D=3D 0)
 				return RCR_REJECT;
 =

-			/* TODO: Handle loopback */
 			break;
 		}
 		default:
@@ -201,8 +198,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 			ppp_set_auth(ppp, ppp_option_iter_get_data(&iter));
 			break;
 		case MAGIC_NUMBER:
-			lcp->magic_number =3D
-				get_host_long(ppp_option_iter_get_data(&iter));
+			/* don't care */
 			break;
 		case PFC:
 			ppp_set_pfc(ppp, TRUE);
-- =

1.6.6.1


--===============0682884111701607656==--

