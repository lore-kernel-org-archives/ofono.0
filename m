Content-Type: multipart/mixed; boundary="===============3966069322904570773=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 3/8] huawei: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:09 +0300
Message-ID: <1288193954-18402-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3966069322904570773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/huaweimodem/gprs-context.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index 48e21ab..43e5248 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -69,7 +69,7 @@ static gboolean dhcp_poll(gpointer user_data)
 =

 	if (gcd->dhcp_count > 20)
 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
+						NULL, NULL, NULL, gcd->cb_data);
 	else
 		check_dhcp(gc);
 =

@@ -193,7 +193,7 @@ static void dhcp_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	interface =3D "invalid";
 =

 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, ip,
-					netmask, gateway, dns, gcd->cb_data);
+				netmask, gateway, dns, NULL, gcd->cb_data);
 	gcd->up_cb =3D NULL;
 	gcd->cb_data =3D NULL;
 =

@@ -261,7 +261,7 @@ static void at_ndisdup_up_cb(gboolean ok, GAtResult *re=
sult,
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

 static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -281,7 +281,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

@@ -297,7 +297,8 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
+				cbd->data);
 }
 =

 static void huawei_gprs_activate_primary(struct ofono_gprs_context *gc,
@@ -331,7 +332,7 @@ static void huawei_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void huawei_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============3966069322904570773==--

