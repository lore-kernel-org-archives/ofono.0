Content-Type: multipart/mixed; boundary="===============0613317802580130636=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 5/6] gatchat: support for auth NONE
Date: Wed, 03 Oct 2018 05:32:15 +0200
Message-ID: <20181003033215.6283-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0613317802580130636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added authentication method G_AT_PPP_AUTH_METHOD_NONE and its handling.
---
 gatchat/gatppp.c  | 3 ++-
 gatchat/gatppp.h  | 1 +
 gatchat/ppp_lcp.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 4a80b4b3..141e2746 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -615,7 +615,8 @@ const char *g_at_ppp_get_password(GAtPPP *ppp)
 gboolean g_at_ppp_set_auth_method(GAtPPP *ppp, GAtPPPAuthMethod method)
 {
 	if (method !=3D G_AT_PPP_AUTH_METHOD_CHAP &&
-					method !=3D G_AT_PPP_AUTH_METHOD_PAP)
+					method !=3D G_AT_PPP_AUTH_METHOD_PAP &&
+					method !=3D G_AT_PPP_AUTH_METHOD_NONE)
 		return FALSE;
 =

 	ppp->auth_method =3D method;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 213f7e90..dd203c28 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -46,6 +46,7 @@ typedef enum _GAtPPPDisconnectReason {
 typedef enum _GAtPPPAuthMethod {
 	G_AT_PPP_AUTH_METHOD_CHAP,
 	G_AT_PPP_AUTH_METHOD_PAP,
+	G_AT_PPP_AUTH_METHOD_NONE,
 } GAtPPPAuthMethod;
 =

 typedef void (*GAtPPPConnectFunc)(const char *iface, const char *local,
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index df9cd0ef..3fe38217 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 				*new_len =3D 4;
 =

 				return RCR_NAK;
+
+			case G_AT_PPP_AUTH_METHOD_NONE:
+				return RCR_REJECT;
 			}
 			break;
 		}
-- =

2.17.1


--===============0613317802580130636==--

