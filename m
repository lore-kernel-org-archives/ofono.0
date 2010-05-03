Content-Type: multipart/mixed; boundary="===============6199886368441291835=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: transition phase to DEAD when lcp finishes
Date: Mon, 03 May 2010 15:23:43 -0700
Message-ID: <1272925423-3584-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6199886368441291835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

change the state to DEAD when lcp finishes.  This prevents us from
calling our disconnect function again if we are already dead.
---
 gatchat/gatppp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 70669b0..dd6d84d 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -186,9 +186,6 @@ static inline void ppp_enter_phase(GAtPPP *ppp, enum pp=
p_phase phase)
 {
 	g_print("Entering new phase: %d\n", phase);
 	ppp->phase =3D phase;
-
-	if (phase =3D=3D PPP_PHASE_DEAD)
-		ppp_dead(ppp);
 }
 =

 void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
@@ -290,6 +287,10 @@ void ppp_lcp_down_notify(GAtPPP *ppp)
 =

 void ppp_lcp_finished_notify(GAtPPP *ppp)
 {
+	if (ppp->phase =3D=3D PPP_PHASE_DEAD)
+		return;
+
+	ppp_enter_phase(ppp, PPP_PHASE_DEAD);
 	ppp_dead(ppp);
 }
 =

-- =

1.6.6.1


--===============6199886368441291835==--

