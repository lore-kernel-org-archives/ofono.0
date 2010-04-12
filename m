Content-Type: multipart/mixed; boundary="===============4211319246187927983=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3] ppp: remove pfc and acfc
Date: Mon, 12 Apr 2010 07:38:52 -0700
Message-ID: <1271083133-13760-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271083133-13760-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4211319246187927983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We will not support pfc or acfc
---
 gatchat/gatppp.c  |   26 --------------------------
 gatchat/ppp.h     |    4 ----
 gatchat/ppp_lcp.c |    6 +-----
 3 files changed, 1 insertions(+), 35 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index b98ab14..d9506c6 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -69,8 +69,6 @@ struct _GAtPPP {
 	gint mru;
 	char user_name[256];
 	char passwd[256];
-	gboolean pfc;
-	gboolean acfc;
 	guint32 xmit_accm[8];
 	guint32 recv_accm;
 	GIOChannel *modem;
@@ -137,7 +135,6 @@ static void ppp_put(GAtPPP *ppp, guint8 *buf, int *pos,
 	*pos =3D i;
 }
 =

-/* XXX implement PFC and ACFC */
 static struct frame_buffer *ppp_encode(GAtPPP *ppp, guint8 *data, int len)
 {
 	int pos =3D 0;
@@ -212,7 +209,6 @@ static void ppp_recv(GAtPPP *ppp, struct frame_buffer *=
frame)
 	};
 }
 =

-/* XXX - Implement PFC and ACFC */
 static struct frame_buffer *ppp_decode(GAtPPP *ppp, guint8 *frame)
 {
 	guint8 *data;
@@ -469,26 +465,6 @@ void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm)
 	ppp->xmit_accm[0] =3D accm;
 }
 =

-void ppp_set_pfc(GAtPPP *ppp, gboolean pfc)
-{
-	ppp->pfc =3D pfc;
-}
-
-gboolean ppp_get_pfc(GAtPPP *ppp)
-{
-	return ppp->pfc;
-}
-
-void ppp_set_acfc(GAtPPP *ppp, gboolean acfc)
-{
-	ppp->acfc =3D acfc;
-}
-
-gboolean ppp_get_acfc(GAtPPP *ppp)
-{
-	return ppp->acfc;
-}
-
 /* Administrative Open */
 void g_at_ppp_open(GAtPPP *ppp)
 {
@@ -593,8 +569,6 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 	ppp->recv_accm =3D ~0U;
 	ppp->xmit_accm[0] =3D ~0U;
 	ppp->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
-	ppp->pfc =3D FALSE;
-	ppp->acfc =3D FALSE;
 =

 	ppp->index =3D 0;
 =

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 0354050..87541c9 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -95,10 +95,6 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint inf=
olen);
 void ppp_set_auth(GAtPPP *ppp, const guint8 *auth_data);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
-void ppp_set_pfc(GAtPPP *ppp, gboolean pfc);
-gboolean ppp_get_pfc(GAtPPP *ppp);
-void ppp_set_acfc(GAtPPP *ppp, gboolean acfc);
-gboolean ppp_get_acfc(GAtPPP *ppp);
 struct pppcp_data * lcp_new(GAtPPP *ppp);
 void lcp_free(struct pppcp_data *lcp);
 void lcp_open(struct pppcp_data *data);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 5dfe4aa..429fa49 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -198,13 +198,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 			ppp_set_auth(ppp, ppp_option_iter_get_data(&iter));
 			break;
 		case MAGIC_NUMBER:
-			/* don't care */
-			break;
 		case PFC:
-			ppp_set_pfc(ppp, TRUE);
-			break;
 		case ACFC:
-			ppp_set_acfc(ppp, TRUE);
+			/* don't care */
 			break;
 		}
 	}
-- =

1.6.6.1


--===============4211319246187927983==--

