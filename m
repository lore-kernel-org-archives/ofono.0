Content-Type: multipart/mixed; boundary="===============1055186634998110306=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] atmodem: add AT+CREG handling for lte status
Date: Tue, 11 Sep 2018 14:02:36 +0530
Message-ID: <1536654756-394-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1055186634998110306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added CREG 'status' 6 and 7 for sms only registered state on E-UTRAN
for  CREG cmd reply callback and URC notfiy.
---
 drivers/atmodem/network-registration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 0854cd1..c0ec8c7 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -228,6 +228,10 @@ static void at_creg_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
 		tech =3D nd->tech;
 =

+	/* Handle EUTRAN cases */
+	if ((status =3D=3D 6 || status =3D=3D 7) && (tech =3D=3D -1))
+		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

@@ -1522,8 +1526,11 @@ static void creg_notify(GAtResult *result, gpointer =
user_data)
 				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
 		return;
 =

-	if (status !=3D 1 && status !=3D 5)
-		goto notify;
+	/* Not camped case */
+	if (status !=3D 1 && status !=3D 5) {
+		if (status !=3D 6 && status !=3D 7)
+			goto notify;
+	}
 =

 	tq =3D g_try_new0(struct tech_query, 1);
 	if (tq =3D=3D NULL)
@@ -1569,6 +1576,9 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
 		tech =3D nd->tech;
 =

+	if ((status =3D=3D 6 || status =3D=3D 7) && tech =3D=3D -1)
+		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+
 notify:
 	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 }
-- =

2.7.4


--===============1055186634998110306==--

