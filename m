Content-Type: multipart/mixed; boundary="===============7837942860483763662=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 4/4] sim: Get IMSI if sim state is OFONO_SIM_STATE_INSERTED
Date: Mon, 21 Nov 2011 11:54:05 +0100
Message-ID: <1321872845-24754-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321872845-24754-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7837942860483763662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of CDAM modem sim can be embedded so that at AT+CPIN? query
answer is +CME ERROR: 10 sim not inserted.
We have to ignore this error and try to initialize the sim to
retrieve the IMSI.
---
 src/sim.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d1d55c5..2c6fbe2 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2406,6 +2406,8 @@ checkdone:
 		sim_initialize_after_pin(sim);
 		break;
 	default:
+		if (sim->state =3D=3D OFONO_SIM_STATE_INSERTED)
+			sim_initialize_after_pin(sim);
 		break;
 	}
 }
-- =

1.7.1


--===============7837942860483763662==--

