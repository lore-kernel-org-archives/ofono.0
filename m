Content-Type: multipart/mixed; boundary="===============0039883056152083578=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Wed, 19 Aug 2020 14:13:38 +0200
Message-ID: <20200819121339.879624-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0039883056152083578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

Currently AT+CGEREP=3D2,1 is sent in case we don't know what the modem
needs. (default case) Not all modems understand this. So, we first query
what the modem supports with AT+CGEREP=3D? and then use this information
to be nice to the modem. This way modems, like the Quectel M95 that do
only understand AT+CGEREP=3D1 do also work nicely.
---
 drivers/atmodem/gprs.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index d829e2e6..3900b95b 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -45,6 +45,7 @@
 #define MAX_CONTEXTS 255
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cgerep_prefix[] =3D { "+CGEREP:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
 static const char *none_prefix[] =3D { NULL };
@@ -647,6 +648,76 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	ofono_gprs_register(gprs);
 }
 =

+static void at_cgerep_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+	int min1, max1 =3D 1, min2, max2 =3D 1;
+	gboolean two_arguments =3D true;
+	char buf[20];
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	g_at_result_iter_next(&iter, "+CGEREP:");
+
+	if (!g_at_result_iter_open_list(&iter))
+		return;
+
+	if (!g_at_result_iter_next_range(&iter, &min1, &max1))
+		return;
+
+	/* if min1 =3D=3D max1 we had no range but a list and that
+	 * means we are interested in the last number of that list*/
+	if (min1 =3D=3D max1) {
+		while (!g_at_result_iter_close_list(&iter)) {
+			if (!g_at_result_iter_next_number(&iter, &max1))
+				break;
+		}
+	}
+
+	if (!g_at_result_iter_skip_next(&iter)) {
+		two_arguments =3D false;
+		goto out;
+	}
+
+	if (!g_at_result_iter_open_list(&iter)) {
+		two_arguments =3D false;
+		goto out;
+	}
+
+	if (!g_at_result_iter_next_range(&iter, &min2, &max2)) {
+		two_arguments =3D false;
+		goto out;
+	}
+
+	if (min2 =3D=3D max2) {
+		while (!g_at_result_iter_close_list(&iter)) {
+			if (!g_at_result_iter_next_number(&iter, &max2)) {
+				break;
+			}
+		}
+	}
+
+out:
+	if (max1 > 2)
+		max1 =3D 2;
+
+	if (max2 > 1)
+		max2 =3D 1;
+
+	if (two_arguments)
+		sprintf(buf, "AT+CGEREP=3D%u,%u", max1, max2);
+	else
+		sprintf(buf, "AT+CGEREP=3D%u", max1);
+
+	g_at_chat_send(gd->chat, buf, none_prefix, gprs_initialized, gprs, NULL);
+}
+
 static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -701,8 +772,8 @@ retry:
 			gprs_initialized, gprs, NULL);
 		break;
 	default:
-		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
-			gprs_initialized, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D?", cgerep_prefix,
+			at_cgerep_test_cb, gprs, NULL);
 		break;
 	}
 =

-- =

2.27.0

--===============0039883056152083578==--

