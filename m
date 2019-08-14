Content-Type: multipart/mixed; boundary="===============4650787716021451589=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Wed, 14 Aug 2019 20:24:41 +0200
Message-ID: <20190814182444.13508-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4650787716021451589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Since we have a different condition for the attach state
when running on LTE, we should consider it in gprs_attached_update.
Previously it's done in some instances. But for instance if
the driver got detached from GPRS but now running on LTE with a
context up, we would be deattached.
---
 src/gprs.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index bba482cb..94d13f82 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1571,13 +1571,34 @@ static void release_active_contexts(struct ofono_gp=
rs *gprs)
 	}
 }
 =

+static gboolean on_lte(struct ofono_gprs *gprs)
+{
+	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
+			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
+		return TRUE;
+
+	return FALSE;
+}
+
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attached;
+	int status =3D gprs->status;
 =

-	attached =3D gprs->driver_attached &&
-		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
-			gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+	if (on_lte(gprs))
+		/*
+		 * For LTE we attached status reflects successful context
+		 * activation.
+		 * Since we in gprs_netreg_update not even try to attach
+		 * to GPRS if we are running on LTE, we can on some modems
+		 * expect the gprs status to be unknown. That must not
+		 * result in detaching...
+		 */
+		attached =3D have_active_contexts(gprs);
+	else
+		attached =3D gprs->driver_attached &&
+			(status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+				status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
 =

 	if (attached =3D=3D gprs->attached)
 		return;
@@ -1591,11 +1612,14 @@ static void gprs_attached_update(struct ofono_gprs =
*gprs)
 	if (attached =3D=3D FALSE) {
 		release_active_contexts(gprs);
 		gprs->bearer =3D -1;
-	} else if (have_active_contexts(gprs) =3D=3D TRUE) {
+	} else if (have_active_contexts(gprs) =3D=3D TRUE &&
+		!on_lte(gprs)) {
 		/*
 		 * Some times the context activates after a detach event and
 		 * right before an attach. We close it to avoid unexpected open
 		 * contexts.
+		 * Skip that for LTE since the condition to be attached on LTE
+		 * is that a context gets activated
 		 */
 		release_active_contexts(gprs);
 		gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
@@ -1660,15 +1684,6 @@ static void gprs_netreg_removed(struct ofono_gprs *g=
prs)
 	gprs_attached_update(gprs);
 }
 =

-static gboolean on_lte(struct ofono_gprs *gprs)
-{
-	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
-			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
-		return TRUE;
-
-	return FALSE;
-}
-
 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attach;
@@ -2573,16 +2588,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		/*
-		 * For LTE we attached status reflects successful context
-		 * activation.
-		 * Since we in gprs_netreg_update not even try to attach
-		 * to GPRS if we are running on LTE, we can on some modems
-		 * expect the gprs status to be unknown. That must not
-		 * result in detaching...
-		 */
-		if (!on_lte(gprs))
-			gprs_attached_update(gprs);
+		gprs_attached_update(gprs);
 		return;
 	}
 =

-- =

2.20.1


--===============4650787716021451589==--

