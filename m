Content-Type: multipart/mixed; boundary="===============1261419866745447642=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] netreg, gprs: Use -1 as netreg status during init.
Date: Thu, 01 Aug 2019 11:48:55 +0000
Message-ID: <20190801114855.11639-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1261419866745447642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Previously the valid "unknown" registration status was set
during startup, but its a bit problematic for gprs.
There might be cases where a LTE context is activated
before netreg is finished updating its status.
And then gprs could make faulty actions.
Instead we set the status to -1 when the drivers supports
fetching the status manually, which is done during startup.
During the time the status is -1, gprs postpones actions until
the status is valid (>=3D 0).
---
 src/gprs.c    | 12 ++++++++++--
 src/network.c |  5 ++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index bdb8c8a2..07802c36 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1661,6 +1661,14 @@ static void gprs_netreg_update(struct ofono_gprs *gp=
rs)
 {
 	ofono_bool_t attach;
 =

+	/* This function can get called by other reasons than netreg
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
@@ -3083,8 +3091,8 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mod=
em *modem,
 		break;
 	}
 =

-	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
-	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	gprs->status =3D -1;
+	gprs->netreg_status =3D -1;
 	gprs->used_pids =3D l_uintset_new(MAX_CONTEXTS);
 =

 	return gprs;
diff --git a/src/network.c b/src/network.c
index 2824eae6..1db01bcf 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1874,7 +1874,7 @@ struct ofono_netreg *ofono_netreg_create(struct ofono=
_modem *modem,
 	if (netreg =3D=3D NULL)
 		return NULL;
 =

-	netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	netreg->status =3D -1;
 	netreg->location =3D -1;
 	netreg->cellid =3D -1;
 	netreg->technology =3D -1;
@@ -1893,6 +1893,9 @@ struct ofono_netreg *ofono_netreg_create(struct ofono=
_modem *modem,
 			continue;
 =

 		netreg->driver =3D drv;
+		/* Check if we can init the status properly using the driver */
+		if (netreg->driver->registration_status =3D=3D NULL)
+			netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 		break;
 	}
 =

-- =

2.20.1


--===============1261419866745447642==--

