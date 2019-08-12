Content-Type: multipart/mixed; boundary="===============8654223026094300505=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Mon, 12 Aug 2019 22:37:56 +0200
Message-ID: <20190812203756.32082-1-richard.rojfors@gmail.com>
In-Reply-To: <20190811145810.31475-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8654223026094300505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

There are cases where the gprs status might updated to for instance
"unknown" while LTE is the bearer.
In that case we should not set the attach state to FALSE,
since then running LTE the conext activation reflects the attached
state.
---
 src/gprs.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9cb69d14..f7a2b739 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1660,6 +1660,15 @@ static void gprs_netreg_removed(struct ofono_gprs *g=
prs)
 	gprs_attached_update(gprs);
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
 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
 	ofono_bool_t attach;
@@ -1682,8 +1691,7 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 =

 	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
 =

-	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
-			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
+	if (on_lte(gprs))
 		/*
 		 * For LTE we set attached status only on successful
 		 * context activation.
@@ -2560,7 +2568,16 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		gprs_attached_update(gprs);
+		/*
+		 * For LTE we attached status reflects successful context
+		 * activation.
+		 * Since we in gprs_netreg_update not even try to attach
+		 * to GPRS if we are running on LTE, we can on some modems
+		 * expect the gprs status to be unknown. That must not
+		 * result in detaching...
+		 */
+		if (!on_lte(gprs))
+			gprs_attached_update(gprs);
 		return;
 	}
 =

-- =

2.20.1


--===============8654223026094300505==--

