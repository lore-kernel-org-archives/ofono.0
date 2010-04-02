Content-Type: multipart/mixed; boundary="===============5192373118547859407=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: fix event generation on close
Date: Fri, 02 Apr 2010 10:28:18 -0700
Message-ID: <1270229298-5936-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5192373118547859407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prevents too early transition to PPP_DEAD
---
 gatchat/gatppp.c  |    4 +---
 gatchat/ppp.h     |    1 -
 gatchat/ppp_lcp.c |   17 ++++-------------
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 2b853f0..6d4950d 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -419,7 +419,6 @@ static void ppp_transition_phase(GAtPPP *ppp, enum ppp_=
phase phase)
 		/* otherwise we need to wait for the peer to send us a challenge */
 		break;
 	case PPP_TERMINATION:
-		/* signal DOWN event to LCP */
 		lcp_terminate(ppp->lcp);
 		break;
 	case PPP_DEAD:
@@ -570,8 +569,7 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char *fi=
lename)
 =

 void g_at_ppp_shutdown(GAtPPP *ppp)
 {
-	/* send a CLOSE event to the lcp layer */
-	lcp_close(ppp->lcp);
+	ppp_generate_event(ppp, PPP_CLOSING);
 }
 =

 void g_at_ppp_ref(GAtPPP *ppp)
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index ba17f41..8feb2bf 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -153,7 +153,6 @@ gboolean ppp_get_acfc(GAtPPP *ppp);
 struct pppcp_data * lcp_new(GAtPPP *ppp);
 void lcp_free(struct pppcp_data *lcp);
 void lcp_open(struct pppcp_data *data);
-void lcp_close(struct pppcp_data *data);
 void lcp_establish(struct pppcp_data *data);
 void lcp_terminate(struct pppcp_data *data);
 void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize len=
);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 1fcb40e..e09ed6b 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -71,7 +71,7 @@ static void lcp_up(struct pppcp_data *pppcp)
  */
 static void lcp_down(struct pppcp_data *pppcp)
 {
-	ppp_generate_event(pppcp->ppp, PPP_DOWN);
+	/* XXX should implement a way to signal NCP */
 }
 =

 /*
@@ -89,7 +89,7 @@ static void lcp_started(struct pppcp_data *pppcp)
  */
 static void lcp_finished(struct pppcp_data *pppcp)
 {
-	ppp_generate_event(pppcp->ppp, PPP_CLOSING);
+	ppp_generate_event(pppcp->ppp, PPP_DOWN);
 }
 =

 /*
@@ -193,15 +193,6 @@ void lcp_open(struct pppcp_data *data)
 	pppcp_generate_event(data, OPEN, NULL, 0);
 }
 =

-void lcp_close(struct pppcp_data *data)
-{
-	if (data =3D=3D NULL)
-		return;
-
-	/* send a CLOSE  event to the lcp layer */
-	pppcp_generate_event(data, CLOSE, NULL, 0);
-}
-
 void lcp_establish(struct pppcp_data *data)
 {
 	if (data =3D=3D NULL)
@@ -216,8 +207,8 @@ void lcp_terminate(struct pppcp_data *data)
 	if (data =3D=3D NULL)
 		return;
 =

-	/* send a DOWN event to the lcp layer */
-	pppcp_generate_event(data, DOWN, NULL, 0);
+	/* send a CLOSE event to the lcp layer */
+	pppcp_generate_event(data, CLOSE, NULL, 0);
 }
 =

 void lcp_free(struct pppcp_data *lcp)
-- =

1.6.6.1


--===============5192373118547859407==--

