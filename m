Content-Type: multipart/mixed; boundary="===============0432728717090954174=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Do not detach when running LTE and GPRS is unavailable.
Date: Sun, 11 Aug 2019 16:58:10 +0200
Message-ID: <20190811145810.31475-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0432728717090954174==
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
 src/gprs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9cb69d14..1a9b234d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1660,6 +1660,15 @@ static void gprs_netreg_removed(struct ofono_gprs *g=
prs)
 	gprs_attached_update(gprs);
 }
 =

+static gboolean expect_lte_context_auto_activation(struct ofono_gprs *gprs)
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
+	if (expect_lte_context_auto_activation(gprs))
 		/*
 		 * For LTE we set attached status only on successful
 		 * context activation.
@@ -2560,7 +2568,12 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		gprs_attached_update(gprs);
+		/*
+		 * For LTE we attached status reflects successful context
+		 * activation.
+		 */
+		if (!expect_lte_context_auto_activation(gprs))
+			gprs_attached_update(gprs);
 		return;
 	}
 =

-- =

2.20.1


--===============0432728717090954174==--

