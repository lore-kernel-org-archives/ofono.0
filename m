Content-Type: multipart/mixed; boundary="===============1037973079463668955=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 2/8] hso: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:08 +0300
Message-ID: <1288193954-18402-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1037973079463668955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/hsomodem/gprs-context.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index dc6f1b6..afd7fcf 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -110,7 +110,7 @@ static void at_owancall_up_cb(gboolean ok, GAtResult *r=
esult,
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

 static void hso_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -128,7 +128,7 @@ static void hso_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

@@ -144,7 +144,8 @@ static void hso_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
+				cbd->data);
 }
 =

 static void hso_gprs_activate_primary(struct ofono_gprs_context *gc,
@@ -189,7 +190,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void hso_gprs_deactivate_primary(struct ofono_gprs_context *gc,
@@ -273,7 +274,8 @@ static void owandata_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_info("DNS: %s, %s", dns1, dns2);
 =

 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, ip,
-				STATIC_IP_NETMASK, gateway, dns, gcd->cb_data);
+				STATIC_IP_NETMASK, gateway, dns, NULL,
+				gcd->cb_data);
 =

 	gcd->hso_state =3D HSO_NONE;
 	gcd->up_cb =3D NULL;
@@ -338,7 +340,8 @@ static void owancall_notifier(GAtResult *result, gpoint=
er user_data)
 =

 		if (gcd->hso_state =3D=3D HSO_ENABLING) {
 			CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL,
-						NULL, NULL, NULL, gcd->cb_data);
+						NULL, NULL, NULL, NULL,
+						gcd->cb_data);
 			gcd->hso_state =3D HSO_NONE;
 			gcd->up_cb =3D NULL;
 			gcd->cb_data =3D NULL;
-- =

1.7.1


--===============1037973079463668955==--

