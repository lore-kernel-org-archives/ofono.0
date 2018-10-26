Content-Type: multipart/mixed; boundary="===============0853612578520660645=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 3/5] atmodem/netreg: rename cinterion to gemalto
Date: Fri, 26 Oct 2018 07:11:04 +0200
Message-ID: <20181026051106.16828-3-gciofono@gmail.com>
In-Reply-To: <20181026051106.16828-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0853612578520660645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index e493984e..2482dfc3 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -178,7 +178,7 @@ static int option_parse_tech(GAtResult *result)
 	return tech;
 }
 =

-static int cinterion_parse_tech(GAtResult *result)
+static int gemalto_parse_tech(GAtResult *result)
 {
 	int tech =3D -1;
 	GAtResultIter iter;
@@ -234,13 +234,13 @@ static void at_creg_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

-static void cinterion_query_tech_cb(gboolean ok, GAtResult *result,
+static void gemalto_query_tech_cb(gboolean ok, GAtResult *result,
                                               gpointer user_data)
 {
 	struct tech_query *tq =3D user_data;
 	int tech;
 =

-	tech =3D cinterion_parse_tech(result);
+	tech =3D gemalto_parse_tech(result);
 =

 	ofono_netreg_status_notify(tq->netreg,
 			tq->status, tq->lac, tq->ci, tech);
@@ -879,7 +879,7 @@ static void telit_ciev_notify(GAtResult *result, gpoint=
er user_data)
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

-static void cinterion_ciev_notify(GAtResult *result, gpointer user_data)
+static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -1562,7 +1562,7 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
     case OFONO_VENDOR_GEMALTO:
               if (g_at_chat_send(nd->chat, "AT^SMONI",
                                       smoni_prefix,
-                                      cinterion_query_tech_cb, tq, g_free)=
 > 0)
+                                      gemalto_query_tech_cb, tq, g_free) >=
 0)
                       return;
               break;
 	}
@@ -2033,10 +2033,10 @@ static void at_creg_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 		break;
 	case OFONO_VENDOR_GEMALTO:
 		/*
-		 * We can't set rssi bounds from Cinterion responses
+		 * We can't set rssi bounds from Gemalto responses
 		 * so set them up to specified values here
 		 *
-		 * Cinterion rssi signal strength specified as:
+		 * Gemalto rssi signal strength specified as:
 		 * 0      <=3D -112dBm
 		 * 1 - 4  signal strengh in 15 dB steps
 		 * 5      >=3D -51 dBm
@@ -2050,7 +2050,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT^SIND=3D\"rssi\",1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_register(nd->chat, "+CIEV:",
-				cinterion_ciev_notify, FALSE, netreg, NULL);
+				gemalto_ciev_notify, FALSE, netreg, NULL);
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
-- =

2.17.1


--===============0853612578520660645==--

