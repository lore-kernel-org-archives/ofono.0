Content-Type: multipart/mixed; boundary="===============0890894482810548594=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting issue
Date: Thu, 20 Jan 2011 13:45:52 +0800
Message-ID: <1295502354-19270-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0890894482810548594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

Tramsmit ACCM and receive ACCM is mixed up.
According to RFC1662 Section 7.1, ACCM Configuration Option is
used to inform the peer which control characters MUST remain
mapped when the peer sends them.
---
 gatchat/ppp_lcp.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3a80a62..cc3e231 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -149,7 +149,13 @@ static void lcp_rca(struct pppcp_data *pppcp, const st=
ruct pppcp_packet *packet)
 	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
 		switch (ppp_option_iter_get_type(&iter)) {
 		case ACCM:
-			ppp_set_xmit_accm(pppcp_get_ppp(pppcp), 0);
+			/*
+			 * RFC1662 Section 7.1
+			 * The Configuration Option is used to inform the peer
+			 * which control characters MUST remain mapped when
+			 * the peer sends them.
+			 */
+			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
 			break;
 		default:
 			break;
@@ -263,7 +269,13 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
 		switch (ppp_option_iter_get_type(&iter)) {
 		case ACCM:
-			ppp_set_recv_accm(ppp,
+			/*
+			 * RFC1662 Section 7.1
+			 * The Configuration Option is used to inform the peer
+			 * which control characters MUST remain mapped when
+			 * the peer sends them.
+			 */
+			ppp_set_xmit_accm(ppp,
 				get_host_long(ppp_option_iter_get_data(&iter)));
 			break;
 		case AUTH_PROTO:
-- =

1.6.1.3


--===============0890894482810548594==--

