Content-Type: multipart/mixed; boundary="===============8302310559746549998=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 1/8] atmodem: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:07 +0300
Message-ID: <1288193954-18402-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8302310559746549998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/atmodem/gprs-context.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 03c6f46..11551e4 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -95,7 +95,7 @@ static void ppp_connect(const char *interface, const char=
 *local,
 	gcd->state =3D STATE_ACTIVE;
 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, local,
 					STATIC_IP_NETMASK, NULL,
-					dns, gcd->cb_data);
+					dns, NULL, gcd->cb_data);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
@@ -111,7 +111,7 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 	switch (gcd->state) {
 	case STATE_ENABLING:
 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
-					NULL, NULL, NULL, gcd->cb_data);
+					NULL, NULL, NULL, NULL, gcd->cb_data);
 		break;
 	case STATE_DISABLING:
 		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
@@ -181,7 +181,7 @@ static void at_cgdata_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		gcd->state =3D STATE_IDLE;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL,
+		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL,
 				gcd->cb_data);
 		return;
 	}
@@ -204,7 +204,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		gcd->state =3D STATE_IDLE;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL,
+		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL,
 				gcd->cb_data);
 		return;
 	}
@@ -217,7 +217,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
 =

-	CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
+	CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
 				gcd->cb_data);
 }
 =

@@ -249,7 +249,7 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 				at_cgdcont_cb, gc, NULL) > 0)
 		return;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void at_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============8302310559746549998==--

