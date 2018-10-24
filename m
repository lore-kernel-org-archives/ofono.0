Content-Type: multipart/mixed; boundary="===============8085865404056425428=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] gprs: detach from PS domain only if needed
Date: Wed, 24 Oct 2018 17:09:14 +0200
Message-ID: <1540393754-9419-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1540393754-9419-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8085865404056425428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With some huawei USB keys (E3372, MS2372h), when switching from WCDMA to
LTE network, a network attachment loss is reported during a short time.
Forcing data detach in this case is a bad idea. Consequences can be a loop
like that:
t0) Attached to WCDMA network
t1) Switch to LTE network
t1+xs) Attachment loss reported
t1+(x+2)s) Attached to WCDMA network
t2) Switch to LTE network
t2) Attachment loss reported
t2+2s) Attached to WCDMA network

With this patch we force gprs detach only if unpowered or roaming while
roaming is not allowed. We don't force gprs detach if we loose network.
---
 src/gprs.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index edd17f2..320505a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1676,15 +1676,24 @@ static void gprs_netreg_removed(struct ofono_gprs *=
gprs)
 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attach;
+	ofono_bool_t force_detach;
+
+	DBG("netreg:%u, powered:%u, roaming_allowed:%u, driver_attached:%u",
+				gprs->netreg_status, gprs->powered,
+				gprs->roaming_allowed, gprs->driver_attached);
 =

 	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED;
+	attach |=3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMIN=
G;
 =

-	attach =3D attach || (gprs->roaming_allowed &&
-		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+	if (!attach)
+		return;
 =

-	attach =3D attach && gprs->powered;
+	force_detach =3D !gprs->powered || (!gprs->roaming_allowed &&
+		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
 =

-	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
+	if ((force_detach && !gprs->driver_attached) ||
+				(!force_detach && gprs->driver_attached))
+		return;
 =

 	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
 			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
@@ -1692,9 +1701,6 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 		 * For LTE we set attached status only on successful
 		 * context activation.
 		 */
-                return;
-
-	if (gprs->driver_attached =3D=3D attach)
 		return;
 =

 	if (gprs->flags & GPRS_FLAG_ATTACHING) {
@@ -1703,9 +1709,9 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 	}
 =

 	gprs->flags |=3D GPRS_FLAG_ATTACHING;
-
-	gprs->driver_attached =3D attach;
-	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
+	gprs->driver_attached =3D !gprs->driver_attached;
+	gprs->driver->set_attached(gprs, gprs->driver_attached,
+						gprs_attach_callback, gprs);
 }
 =

 static void netreg_status_changed(int status, int lac, int ci, int tech,
-- =

2.7.4


--===============8085865404056425428==--

