Content-Type: multipart/mixed; boundary="===============6730085044317598132=="
MIME-Version: 1.0
From: caiwen.zhang@windriver.com
Subject: [PATCH] fix can't attach gprs issue
Date: Mon, 09 May 2011 16:22:16 +0800
Message-ID: <1304929336-14558-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6730085044317598132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@windriver.com>

This patch is to fix the issue that can't attach GPRS after detach it. =


Cause:
  When start detaching GPRS, driver_attched value is set to FALSE, if
device registered to GPRS network during GPRS detaching, driver_attched is =
set to TURE.
After that, GPRS attaching will always be ignored because driver_attched is=
 always TURE.

Scenario:
  When device is unregistered(+CREG: 2), GPRS is detached. During GPRS deta=
ching, device
registered to network again(+CREG: 1, xxx, xxx).

Log:
ofonod[619]: PCUI: < \r\n^SRVST:1\r\n\r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n\r\n^=
SRVST:2\r\n\r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n
ofonod[619]: src/network.c:current_operator_callback() 0xa046ea0, 0xa0476e8
ofonod[619]: src/gprs.c:netreg_status_changed() 2     //driver_attched =3D =
FALSE
ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
ofonod[619]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[619]: src/gprs.c:netreg_status_changed() 2
ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 2
ofonod[619]: src/gprs.c:netreg_status_changed() 1
ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (null=
)(null)
ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
ofonod[619]: PCUI: > AT+CSCB=3D0,"0,25,38,50,100,136,256,4352-4356"\r
ofonod[619]: PCUI: < \r\nOK\r\n
ofonod[619]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1, A807, A72=
B71\r\n
ofonod[619]: src/gprs.c:netreg_status_changed() 1
ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (null=
)(null)
ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1  //dri=
ver_attched =3D TRUE
ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[619]: PCUI: > AT+CGATT=3D0\r

---
 src/gprs.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index deffeb8..d80e7ab 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1429,17 +1429,12 @@ void ofono_gprs_resume_notify(struct ofono_gprs *gp=
rs)
 	update_suspended_property(gprs, FALSE);
 }
 =

-static void gprs_attached_update(struct ofono_gprs *gprs)
+static void gprs_attached_update(struct ofono_gprs *gprs, ofono_bool_t att=
ached)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path;
-	ofono_bool_t attached;
 	dbus_bool_t value;
 =

-	attached =3D gprs->driver_attached &&
-		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
-			gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
-
 	if (attached =3D=3D gprs->attached)
 		return;
 =

@@ -1508,7 +1503,7 @@ static void gprs_attach_callback(const struct ofono_e=
rror *error, void *data)
 		return;
 	}
 =

-	gprs_attached_update(gprs);
+	gprs_attached_update(gprs, gprs->driver_attached);
 =

 	if (gprs->flags & GPRS_FLAG_RECHECK) {
 		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
@@ -1525,7 +1520,7 @@ static void gprs_netreg_removed(struct ofono_gprs *gp=
rs)
 	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 	gprs->driver_attached =3D FALSE;
 =

-	gprs_attached_update(gprs);
+	gprs_attached_update(gprs, FALSE);
 }
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs)
@@ -2074,7 +2069,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 	DBG("%s", __ofono_atom_get_path(gprs->atom));
 =

 	gprs->driver_attached =3D FALSE;
-	gprs_attached_update(gprs);
+
+	gprs_attached_update(gprs, FALSE);
 =

 	/*
 	 * TODO: The network forced a detach, we should wait for some time
@@ -2091,7 +2087,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		gprs_attached_update(gprs);
+		gprs_attached_update(gprs, FALSE);
 		return;
 	}
 =

@@ -2103,8 +2099,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING)
 		goto detach;
 =

-	gprs->driver_attached =3D TRUE;
-	gprs_attached_update(gprs);
+	gprs_attached_update(gprs, TRUE);
 =

 	return;
 =

-- =

1.7.0.4


--===============6730085044317598132==--

