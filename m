Content-Type: multipart/mixed; boundary="===============0692636367710293523=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 2/2] [sim] Reset pin_type on card remove
Date: Thu, 18 Jun 2015 14:46:57 +0300
Message-ID: <1434628017-28441-3-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1434628017-28441-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0692636367710293523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes PinRequired not being emitted when a card is inserted
---
 src/sim.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 0bcafe0..997ac27 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2485,10 +2485,13 @@ void ofono_sim_inserted_notify(struct ofono_sim *si=
m, ofono_bool_t inserted)
 	sim_inserted_update(sim);
 	call_state_watches(sim);
 =

-	if (inserted)
+	if (inserted) {
 		sim_initialize(sim);
-	else
+	} else {
+		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
+
 		sim_free_state(sim);
+	}
 }
 =

 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
-- =

1.7.9.5


--===============0692636367710293523==--

