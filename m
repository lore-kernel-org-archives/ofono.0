Content-Type: multipart/mixed; boundary="===============4502756655752453319=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] sim: fix minor issue in ofono_sim_get_phase
Date: Mon, 06 Dec 2010 10:39:16 -0800
Message-ID: <1291660757-6684-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291660757-6684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4502756655752453319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index c523982..6217a25 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1914,7 +1914,7 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-		return 0;
+		return OFONO_SIM_PHASE_UNKNOWN;
 =

 	return sim->phase;
 }
-- =

1.7.0.4


--===============4502756655752453319==--

