Content-Type: multipart/mixed; boundary="===============4942051492300537044=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCHv2] network: query signal strength
Date: Fri, 17 Dec 2010 10:46:04 +0100
Message-ID: <1292579164-24372-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4942051492300537044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

Signal strength is set to -1 whenever registration status changes
and differs from registered or roaming. When registration status
changes again to registered or roaming, the signal strength needs to
be updated, added query towards driver to get it.
---
 src/network.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/src/network.c b/src/network.c
index d203bee..50539a2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1296,6 +1296,19 @@ emit:
 	notify_status_watches(netreg);
 }
 =

+static void signal_strength_callback(const struct ofono_error *error,
+					int strength, void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during signal strength query");
+		return;
+	}
+
+	ofono_netreg_strength_notify(netreg, strength);
+}
+
 void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 			int lac, int ci, int tech)
 {
@@ -1319,6 +1332,9 @@ void ofono_netreg_status_notify(struct ofono_netreg *=
netreg, int status,
 		if (netreg->driver->current_operator)
 			netreg->driver->current_operator(netreg,
 					current_operator_callback, netreg);
+		if (netreg->driver->strength)
+			netreg->driver->strength(netreg,
+					signal_strength_callback, netreg);
 	} else {
 		struct ofono_error error;
 =

@@ -1345,18 +1361,6 @@ void ofono_netreg_time_notify(struct ofono_netreg *n=
etreg,
 	__ofono_nettime_info_received(modem, info);
 }
 =

-static void signal_strength_callback(const struct ofono_error *error,
-					int strength, void *data)
-{
-	struct ofono_netreg *netreg =3D data;
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error during signal strength query");
-		return;
-	}
-
-	ofono_netreg_strength_notify(netreg, strength);
-}
 =

 static void init_registration_status(const struct ofono_error *error,
 					int status, int lac, int ci, int tech,
-- =

1.7.1


--===============4942051492300537044==--

