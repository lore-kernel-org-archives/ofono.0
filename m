Content-Type: multipart/mixed; boundary="===============5429148927506668911=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 1/2] PPP: Fix Transmit ACCM and Receive ACCM setting error
Date: Mon, 10 Jan 2011 18:40:16 +0800
Message-ID: <1294656017-825-2-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5429148927506668911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

---
 gatchat/ppp_lcp.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3a80a62..bc97257 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -149,7 +149,11 @@ static void lcp_rca(struct pppcp_data *pppcp, const st=
ruct pppcp_packet *packet)
 	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
 		switch (ppp_option_iter_get_type(&iter)) {
 		case ACCM:
-			ppp_set_xmit_accm(pppcp_get_ppp(pppcp), 0);
+		/* RFC1662 Section 7.1
+		 * The Configuration Option is used to inform the peer which control
+		 * characters MUST remain mapped when the peer sends them.
+		 */
+			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
 			break;
 		default:
 			break;
@@ -263,7 +267,12 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
 		switch (ppp_option_iter_get_type(&iter)) {
 		case ACCM:
-			ppp_set_recv_accm(ppp,
+		/* RFC1662 Section 7.1
+		 * The Configuration Option is used to inform the peer which control
+		 * characters MUST remain mapped when the peer sends them.
+		 */
+
+			ppp_set_xmit_accm(ppp,
 				get_host_long(ppp_option_iter_get_data(&iter)));
 			break;
 		case AUTH_PROTO:
-- =

1.7.2.2


--===============5429148927506668911==--

