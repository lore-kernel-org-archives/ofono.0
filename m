Content-Type: multipart/mixed; boundary="===============8592119683474003808=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
Date: Thu, 20 Jan 2011 13:45:53 +0800
Message-ID: <1295502354-19270-2-git-send-email-martin.xu@intel.com>
In-Reply-To: <1295502354-19270-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8592119683474003808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
event breaks PPP link, after IP package transmit for a while.
Using default ACCM, the issue can be fixed.
I tested it at China Unicom networks.
---
 gatchat/ppp_lcp.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index cc3e231..2264731 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -105,8 +105,7 @@ static void lcp_generate_config_options(struct lcp_data=
 *lcp)
 =

 static void lcp_reset_config_options(struct lcp_data *lcp)
 {
-	lcp->req_options =3D REQ_OPTION_ACCM;
-	lcp->accm =3D 0;
+	/* Using the default ACCM */
 =

 	lcp_generate_config_options(lcp);
 }
@@ -155,7 +154,11 @@ static void lcp_rca(struct pppcp_data *pppcp, const st=
ruct pppcp_packet *packet)
 			 * which control characters MUST remain mapped when
 			 * the peer sends them.
 			 */
-			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
+
+			/*
+			 * Using the default ACCM
+			 * ppp_set_recv_accm(pppcp_get_ppp(pppcp), ~0U);
+			 */
 			break;
 		default:
 			break;
-- =

1.6.1.3


--===============8592119683474003808==--

