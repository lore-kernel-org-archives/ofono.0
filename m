Content-Type: multipart/mixed; boundary="===============5754419449852659164=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: remove locked_pin reset from sim_free_main_state
Date: Tue, 09 Aug 2016 07:11:10 +0530
Message-ID: <1470706870-28558-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5754419449852659164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 0bbd1ef..ab5f2c6 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2372,13 +2372,6 @@ static void sim_spn_close(struct ofono_sim *sim)
 =

 static void sim_free_main_state(struct ofono_sim *sim)
 {
-	int i;
-
-	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-		sim->pin_retries[i] =3D -1;
-
-	memset(sim->locked_pins, 0, sizeof(sim->locked_pins));
-
 	if (sim->imsi) {
 		g_free(sim->imsi);
 		sim->imsi =3D NULL;
@@ -2547,7 +2540,24 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim=
, ofono_bool_t inserted)
 			sim_initialize(sim);
 		}
 	} else {
-		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
+		switch (sim->pin_type) {
+		case OFONO_SIM_PASSWORD_SIM_PIN:
+		case OFONO_SIM_PASSWORD_SIM_PUK:
+		case OFONO_SIM_PASSWORD_SIM_PIN2:
+		case OFONO_SIM_PASSWORD_SIM_PUK2:
+			sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
+			break;
+		default:
+			break;
+		}
+
+		sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D FALSE;
+		sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN2] =3D FALSE;
+
+		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D -1;
+		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D -1;
+		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D -1;
+		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D -1;
 =

 		sim_free_state(sim);
 	}
-- =

1.9.1


--===============5754419449852659164==--

