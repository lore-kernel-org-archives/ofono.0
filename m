Content-Type: multipart/mixed; boundary="===============2413997111620807666=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 6/8] mbm: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:12 +0300
Message-ID: <1288193954-18402-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2413997111620807666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/mbmmodem/gprs-context.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index 553b7fd..c5a4cf0 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -142,8 +142,8 @@ out:
 	ofono_info("DNS: %s, %s", dns[0], dns[1]);
 =

 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, success, ip,
-					STATIC_IP_NETMASK, gateway,
-					success ? dns : NULL, gcd->cb_data);
+				STATIC_IP_NETMASK, gateway,
+				success ? dns : NULL, NULL, gcd->cb_data);
 	gcd->mbm_state =3D MBM_NONE;
 	gcd->up_cb =3D NULL;
 	gcd->cb_data =3D NULL;
@@ -170,7 +170,7 @@ static void mbm_get_ip_details(struct ofono_gprs_contex=
t *gc)
 	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, FALSE, NULL, NULL,
-			NULL, NULL, gcd->cb_data);
+				NULL, NULL, NULL, gcd->cb_data);
 =

 	gcd->mbm_state =3D MBM_NONE;
 	gcd->up_cb =3D NULL;
@@ -195,7 +195,7 @@ static void mbm_state_changed(struct ofono_gprs_context=
 *gc, int state)
 			gcd->down_cb =3D NULL;
 		} else if (gcd->mbm_state =3D=3D MBM_ENABLING) {
 			CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
+						NULL, NULL, NULL, gcd->cb_data);
 			gcd->up_cb =3D NULL;
 		} else {
 			ofono_gprs_context_deactivated(gc, gcd->active_context);
@@ -314,7 +314,7 @@ static void mbm_enap_up_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

 static void mbm_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -334,7 +334,7 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

@@ -350,7 +350,8 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
+				cbd->data);
 }
 =

 static void mbm_gprs_activate_primary(struct ofono_gprs_context *gc,
@@ -396,7 +397,7 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void mbm_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============2413997111620807666==--

