Content-Type: multipart/mixed; boundary="===============2450737365632729076=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Use -1 as netreg status during init.
Date: Mon, 05 Aug 2019 22:40:09 +0000
Message-ID: <20190805224009.9942-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2450737365632729076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Previously the valid "unknown" netreg status was set
during startup, but its a bit problematic for gprs.
There might be cases where a LTE context is activated
before netreg is finished updating its status.
Resulting in gprs taking faulty actions.
Instead we set the status to -1 until we are updated
with a known value.
During the time the status is -1, gprs postpones actions until
the status is valid (>=3D 0).
---
 src/gprs.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index bdb8c8a2..fd28c585 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1661,6 +1661,15 @@ static void gprs_netreg_update(struct ofono_gprs *gp=
rs)
 {
 	ofono_bool_t attach;
 =

+	/*
+	 * This function can get called by other reasons than netreg
+	 * updating its status. So check if we have a valid netreg status yet.
+	 * The only reason for not having a valid status is basically during
+	 * startup while the netreg atom is fetching the status.
+	 */
+	if (gprs->netreg_status < 0)
+		return;
+
 	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED;
 =

 	attach =3D attach || (gprs->roaming_allowed &&
@@ -3084,7 +3093,7 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mod=
em *modem,
 	}
 =

 	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
-	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	gprs->netreg_status =3D -1;
 	gprs->used_pids =3D l_uintset_new(MAX_CONTEXTS);
 =

 	return gprs;
@@ -3095,6 +3104,7 @@ static void netreg_watch(struct ofono_atom *atom,
 				void *data)
 {
 	struct ofono_gprs *gprs =3D data;
+	int status;
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
 		gprs_netreg_removed(gprs);
@@ -3102,7 +3112,16 @@ static void netreg_watch(struct ofono_atom *atom,
 	}
 =

 	gprs->netreg =3D __ofono_atom_get_data(atom);
-	gprs->netreg_status =3D ofono_netreg_get_status(gprs->netreg);
+	status =3D ofono_netreg_get_status(gprs->netreg);
+
+	/*
+	 * If the status is known, assign it, otherwise keep the init value
+	 * to indicate that the netreg atom is not initialised with a known
+	 * value
+	 */
+	if (status !=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)
+		gprs->netreg_status =3D ofono_netreg_get_status(status);
+
 	gprs->status_watch =3D __ofono_netreg_add_status_watch(gprs->netreg,
 					netreg_status_changed, gprs, NULL);
 =

-- =

2.20.1


--===============2450737365632729076==--

