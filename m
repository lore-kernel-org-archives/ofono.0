Content-Type: multipart/mixed; boundary="===============5939518374907984810=="
MIME-Version: 1.0
From: Marko =?unknown-8bit?b?xaB1bGVqacSH?= <marko.sulejic@hale.at>
Subject: [PATCH] gatchat/gatppp.c: Add timeout handler in ppp_enter_phase
Date: Wed, 23 Dec 2015 09:52:34 +0100
Message-ID: <1450860754-31695-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5939518374907984810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 * ppp_enter_phase calls ppp_dead if the PPP phase is PPP_PHASE_DEAD
   && ppp->sta_pending =3D=3D FALSE, but fails if sta_pending is never set
   to FALSE. So a timeout handler was added to handle this case too.
---
 gatchat/gatppp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 5144084..f84535a 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -361,8 +361,12 @@ static inline void ppp_enter_phase(GAtPPP *ppp, enum p=
pp_phase phase)
 	DBG(ppp, "%d", phase);
 	ppp->phase =3D phase;
 =

-	if (phase =3D=3D PPP_PHASE_DEAD && ppp->sta_pending =3D=3D FALSE)
-		ppp->ppp_dead_source =3D g_idle_add(ppp_dead, ppp);
+	if (phase =3D=3D PPP_PHASE_DEAD) {
+		if(ppp->sta_pending)
+			ppp->ppp_dead_source =3D g_timeout_add(5000, ppp_dead, ppp);
+		else
+			ppp->ppp_dead_source =3D g_idle_add(ppp_dead, ppp);
+	}
 }
 =

 void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
-- =

2.1.0


--===============5939518374907984810==--

