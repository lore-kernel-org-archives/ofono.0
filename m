Content-Type: multipart/mixed; boundary="===============4796264330880213285=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: gprs-context: Fix router mode IP settings.
Date: Wed, 03 Apr 2019 23:11:16 +0200
Message-ID: <20190403211116.696-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4796264330880213285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

The ublox modems always run DHCP when in router mode.
Unfortunately the code overwrote the IP settings with
static IP settings while activating.

Now we respect the networking_mode regardless if
we read settings during activation or read settings
phase.
---
 drivers/ubloxmodem/gprs-context.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 35abae02..489f31e8 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -235,6 +235,14 @@ static void ublox_read_settings(struct ofono_gprs_cont=
ext *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

+	if (gcd->networking_mode =3D=3D NETWORKING_MODE_ROUTER) {
+		/* Use DHCP */
+		set_gprs_context_interface(gc);
+		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+		return;
+	}
+
 	if (ublox_send_cgcontrdp(gc) < 0)
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
@@ -247,15 +255,6 @@ static void ublox_gprs_read_settings(struct ofono_gprs=
_context *gc,
 =

 	DBG("cid %u", cid);
 =

-	if (gcd->networking_mode =3D=3D NETWORKING_MODE_ROUTER) {
-		/* Use DHCP */
-		gcd->active_context =3D cid;
-		set_gprs_context_interface(gc);
-		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
-		CALLBACK_WITH_SUCCESS(cb, data);
-		return;
-	}
-
 	gcd->active_context =3D cid;
 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
-- =

2.19.1


--===============4796264330880213285==--

