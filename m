Content-Type: multipart/mixed; boundary="===============6142062854641129774=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: transition to dead when lcp finished
Date: Mon, 10 May 2010 12:12:45 -0700
Message-ID: <1273518765-6177-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6142062854641129774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Transition to DEAD when lcp is finished and ignore any io
disconnects if we are already dead.
---
 gatchat/gatppp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 70669b0..cb2fef9 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -290,7 +290,7 @@ void ppp_lcp_down_notify(GAtPPP *ppp)
 =

 void ppp_lcp_finished_notify(GAtPPP *ppp)
 {
-	ppp_dead(ppp);
+	ppp_enter_phase(ppp, PPP_PHASE_DEAD);
 }
 =

 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm)
@@ -318,6 +318,9 @@ static void io_disconnect(gpointer user_data)
 {
 	GAtPPP *ppp =3D user_data;
 =

+	if (ppp->phase =3D=3D PPP_PHASE_DEAD)
+		return;
+
 	ppp->disconnect_reason =3D G_AT_PPP_REASON_LINK_DEAD;
 	pppcp_signal_down(ppp->lcp);
 	pppcp_signal_close(ppp->lcp);
-- =

1.6.6.1


--===============6142062854641129774==--

