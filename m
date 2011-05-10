Content-Type: multipart/mixed; boundary="===============6800909298632608637=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH v2] fix can't attach GPRS issue
Date: Tue, 10 May 2011 14:38:04 +0800
Message-ID: <1305009484-27363-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6800909298632608637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is to fix the issue that can't attach GPRS after detach it. =


Cause:
  When start detaching GPRS, driver_attched value is set to FALSE, if
device registered to GPRS network during GPRS detaching, driver_attched is =
set to TURE.
After that, GPRS attaching will always be ignored because driver_attched is=
 always TURE.
It seems the definition of driver_attched is confused.

Scenario:
  When device is unregistered(+CREG: 2), GPRS is detached. During GPRS deta=
ching, device
registered to network again(+CREG: 1, xxx, xxx).

Solution:
  variable attached represents the GPRS attach status, it only be TRUE, whe=
n CGATT=3D1 and =

CGREG is registered or roaming(roaming allowed). variable driver_attached r=
epresents CGATT
status of the driver. its value will only be changed after set_attached suc=
cessfully or =

GPRS detached notified. variable pending_attached represents the pending st=
atus of CGATT.


---
 src/gprs.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index deffeb8..e221741 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -74,8 +74,9 @@ enum packet_bearer {
 =

 struct ofono_gprs {
 	GSList *contexts;
-	ofono_bool_t attached;
+	ofono_bool_t attached; /*CGATT=3D1 and CGREG is registered or roaming*/
 	ofono_bool_t driver_attached;
+	ofono_bool_t pending_attached;
 	ofono_bool_t roaming_allowed;
 	ofono_bool_t powered;
 	ofono_bool_t suspended;
@@ -1499,8 +1500,8 @@ static void gprs_attach_callback(const struct ofono_e=
rror *error, void *data)
 =

 	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		gprs->driver_attached =3D !gprs->driver_attached;
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		gprs->driver_attached =3D gprs->pending_attached;
 =

 	if (gprs->driver->attached_status) {
 		gprs->driver->attached_status(gprs, registration_status_cb,
@@ -1539,18 +1540,23 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)
 =

 	attach =3D attach && gprs->powered;
 =

-	if (gprs->driver_attached =3D=3D attach)
-		return;
-
 	if (gprs->flags & GPRS_FLAG_ATTACHING) {
+		if (gprs->pending_attached =3D=3D attach) {
+			gprs->flags &=3D ~GPRS_FLAG_RECHECK;
+			return;
+		}
+
 		gprs->flags |=3D GPRS_FLAG_RECHECK;
 		return;
+	} else {
+		if (gprs->driver_attached =3D=3D attach)
+			return;
 	}
 =

 	gprs->flags |=3D GPRS_FLAG_ATTACHING;
 =

 	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
-	gprs->driver_attached =3D attach;
+	gprs->pending_attached =3D attach;
 }
 =

 static void netreg_status_changed(int status, int lac, int ci, int tech,
@@ -2103,7 +2109,6 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING)
 		goto detach;
 =

-	gprs->driver_attached =3D TRUE;
 	gprs_attached_update(gprs);
 =

 	return;
-- =

1.7.5


--===============6800909298632608637==--

