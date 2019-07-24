Content-Type: multipart/mixed; boundary="===============8397376290551520391=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Postpone attach decisions until netreg is finished
Date: Wed, 24 Jul 2019 19:02:55 +0200
Message-ID: <20190724170255.8670-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8397376290551520391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In case the gprs_netreg_update is called from somewhere else
than the actual netreg update before any netreg updates have
happened. It can not make proper decisions. For instance
we might run on EUTRAN but it does not know yet. So check
if the technology is known to netreg, if not just return
since netreg will kick us when its finished initialising,
which will be very soon.
---
 src/gprs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index bdb8c8a2..4e79c528 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1660,6 +1660,16 @@ static void gprs_netreg_removed(struct ofono_gprs *g=
prs)
 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attach;
+	int technology;
+
+	technology =3D ofono_netreg_get_technology(gprs->netreg);
+
+	/* If we are called before netreg has updated us, just return
+	 * we will get called again when the technology is available
+	 * and we can make better decisions
+	 */
+	if (technology =3D=3D -1)
+		return;
 =

 	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED;
 =

@@ -1670,8 +1680,7 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 =

 	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
 =

-	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
-			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
+	if (technology =3D=3D ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs=
))
 		/*
 		 * For LTE we set attached status only on successful
 		 * context activation.
-- =

2.20.1


--===============8397376290551520391==--

