Content-Type: multipart/mixed; boundary="===============1055283564520340630=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 2/2] Inform Huawei modem using ACCM 0xffffffff to trasmit
 package. Using my Huawei modem (EM770W) if set ACCM as 0x00000000,
 the RXJ- event will happend, and PPP link down,
 when IP package transmit for a while. After I set ACCM as 0xffffffff,
 the RXJ- event never happen,
 and the modem can work quite stable. I tested the modem at China Unicom
 networks.
Date: Mon, 10 Jan 2011 18:40:17 +0800
Message-ID: <1294656017-825-3-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1055283564520340630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

---
 gatchat/ppp_lcp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index bc97257..181bc14 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -106,7 +106,7 @@ static void lcp_generate_config_options(struct lcp_data=
 *lcp)
 static void lcp_reset_config_options(struct lcp_data *lcp)
 {
 	lcp->req_options =3D REQ_OPTION_ACCM;
-	lcp->accm =3D 0;
+	lcp->accm =3D ~0U;
 =

 	lcp_generate_config_options(lcp);
 }
@@ -153,7 +153,7 @@ static void lcp_rca(struct pppcp_data *pppcp, const str=
uct pppcp_packet *packet)
 		 * The Configuration Option is used to inform the peer which control
 		 * characters MUST remain mapped when the peer sends them.
 		 */
-			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
+			ppp_set_recv_accm(pppcp_get_ppp(pppcp), ~0U);
 			break;
 		default:
 			break;
-- =

1.7.2.2


--===============1055283564520340630==--

