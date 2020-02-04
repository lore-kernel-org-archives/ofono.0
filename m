Content-Type: multipart/mixed; boundary="===============3630462840074522445=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: netreg: reuse at_registration_status
Date: Tue, 04 Feb 2020 13:21:27 +0100
Message-ID: <20200204122127.30760-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3630462840074522445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Instead of implementing an own copy of requesting and parsing
CREG, reuse the existing one from at-modem.
---
 drivers/ubloxmodem/network-registration.c | 40 +++++++++--------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
index 25f239a6..6a524f47 100644
--- a/drivers/ubloxmodem/network-registration.c
+++ b/drivers/ubloxmodem/network-registration.c
@@ -48,7 +48,6 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *ureg_prefix[] =3D { "+UREG:", NULL };
-static const char *creg_prefix[] =3D { "+CREG:", NULL };
 =

 struct netreg_data {
 	struct at_netreg_data at_data;
@@ -249,30 +248,28 @@ static gboolean is_registered(int status)
 		status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING;
 }
 =

-static void ublox_creg_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static void registration_status_cb(const struct ofono_error *error,
+				   int status, int lac, int ci, int tech,
+				   void *user_data)
 {
 	struct tech_query *tq =3D user_data;
 	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
-	int status;
-	int lac;
-	int ci;
-	int tech;
-
-	nd->updating_status =3D false;
-
-	if (!ok)
-		return;
-
-	if (at_util_parse_reg(result, "+CREG:", NULL, &status,
-				&lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FALSE)
-		return;
+	struct ofono_netreg *netreg =3D tq->netreg;
 =

 	/* The query provided a tech, use that */
 	if (is_registered(status) && tq->tech !=3D -1)
 		tech =3D tq->tech;
 =

-	ofono_netreg_status_notify(tq->netreg, status, lac, ci, tech);
+	g_free(tq);
+
+	nd->updating_status =3D false;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during registration status query");
+		return;
+	}
+
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 }
 =

 static void ublox_ureg_cb(gboolean ok, GAtResult *result,
@@ -334,13 +331,8 @@ static void ureg_notify(GAtResult *result, gpointer us=
er_data)
 	tq->tech =3D ublox_ureg_state_to_tech(state);
 	tq->netreg =3D netreg;
 =

-	if (g_at_chat_send(nd->at_data.chat, "AT+CREG?", creg_prefix,
-			ublox_creg_cb, tq, g_free) > 0) {
-		nd->updating_status =3D true;
-		return;
-	}
-
-	g_free(tq);
+	nd->updating_status =3D true;
+	at_registration_status(netreg, registration_status_cb, tq);
 }
 =

 static void creg_notify(GAtResult *result, gpointer user_data)
-- =

2.20.1

--===============3630462840074522445==--

