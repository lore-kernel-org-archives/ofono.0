Content-Type: multipart/mixed; boundary="===============7049621549094628654=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH] ppp: Allow to set-up ppp connection without authentification
Date: Thu, 30 May 2019 19:26:28 +0300
Message-ID: <20190530162628.30041-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7049621549094628654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When using RCR_REJECT no ppp connection will be established. It used to wor=
k before, and
this was a side-effect of commit 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645

See also this thread: https://lists.ofono.org/pipermail/ofono/2019-January/=
019067.html
---
 gatchat/ppp_lcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3fe38217..252b3cdc 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -281,7 +281,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 				return RCR_NAK;
 =

 			case G_AT_PPP_AUTH_METHOD_NONE:
-				return RCR_REJECT;
+				break;
 			}
 			break;
 		}
-- =

2.20.1


--===============7049621549094628654==--

