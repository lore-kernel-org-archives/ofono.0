Content-Type: multipart/mixed; boundary="===============0764051852705503574=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sim: change vendor CINTERION in GEMALTO
Date: Tue, 25 Sep 2018 09:12:32 +0200
Message-ID: <20180925071233.25070-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0764051852705503574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 0907635d..2ce72c83 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -66,7 +66,7 @@ static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *simcom_spic_prefix[] =3D { "+SPIC:", NULL };
-static const char *cinterion_spic_prefix[] =3D { "^SPIC:", NULL };
+static const char *gemalto_spic_prefix[] =3D { "^SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
@@ -1110,7 +1110,7 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

-static void cinterion_spic_cb(gboolean ok, GAtResult *result,
+static void gemalto_spic_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -1227,9 +1227,9 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 					upincnt_cb, cbd, g_free) > 0)
 			return;
 		break;
-	case OFONO_VENDOR_CINTERION:
-		if (g_at_chat_send(sd->chat, "AT^SPIC", cinterion_spic_prefix,
-					cinterion_spic_cb, cbd, g_free) > 0)
+	case OFONO_VENDOR_GEMALTO:
+		if (g_at_chat_send(sd->chat, "AT^SPIC", gemalto_spic_prefix,
+					gemalto_spic_cb, cbd, g_free) > 0)
 			return;
 		break;
 	default:
-- =

2.17.1


--===============0764051852705503574==--

