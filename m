Content-Type: multipart/mixed; boundary="===============4731288320704445208=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: query facility during initialization in chain manner
Date: Sat, 06 Aug 2016 09:53:46 +0530
Message-ID: <1470457426-10949-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4731288320704445208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

query facility during initialization is modified from back
to back invocation to chain manner to keep it inline with
RIL design. All vendor RIL does not support back to back
handling since RIL telephony framework sends the request
synchronously.
---
 src/sim.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 6d9ed5d..0bbd1ef 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2468,31 +2468,48 @@ static void sim_set_locked_pin(struct ofono_sim *si=
m,
 	g_strfreev(locked_pins);
 }
 =

-static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
+static void sim_query_fac_pinlock_cb(const struct ofono_error *error,
 				ofono_bool_t status, void *data)
 {
+	struct ofono_sim *sim =3D data;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		return;
+		goto done;
 =

-	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHSIM_PIN, status);
+	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_SIM_PIN, status);
+
+done:
+	sim_initialize(sim);
 }
 =

 static void sim_query_fac_networklock_cb(const struct ofono_error *error,
 				ofono_bool_t status, void *data)
 {
+	struct ofono_sim *sim =3D data;
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		return;
+		goto done;
 =

 	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHNET_PIN, status);
+
+done:
+	sim->driver->query_facility_lock(sim,
+					OFONO_SIM_PASSWORD_SIM_PIN,
+					sim_query_fac_pinlock_cb, sim);
 }
 =

-static void sim_query_fac_pinlock_cb(const struct ofono_error *error,
+static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
 				ofono_bool_t status, void *data)
 {
+	struct ofono_sim *sim =3D data;
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		return;
+		goto done;
 =

-	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_SIM_PIN, status);
+	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHSIM_PIN, status);
+
+done:
+	sim->driver->query_facility_lock(sim,
+					OFONO_SIM_PASSWORD_PHNET_PIN,
+					sim_query_fac_networklock_cb, sim);
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
@@ -2526,16 +2543,9 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim=
, ofono_bool_t inserted)
 					OFONO_SIM_PASSWORD_PHSIM_PIN,
 					sim_query_fac_imsilock_cb, sim);
 =

-			sim->driver->query_facility_lock(sim,
-					OFONO_SIM_PASSWORD_PHNET_PIN,
-					sim_query_fac_networklock_cb, sim);
-
-			sim->driver->query_facility_lock(sim,
-					OFONO_SIM_PASSWORD_SIM_PIN,
-					sim_query_fac_pinlock_cb, sim);
+		} else {
+			sim_initialize(sim);
 		}
-
-		sim_initialize(sim);
 	} else {
 		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
 =

-- =

1.9.1


--===============4731288320704445208==--

