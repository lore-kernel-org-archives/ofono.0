Content-Type: multipart/mixed; boundary="===============1411229281269186453=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v3] atmodem: Detect usage of AT+CGEREP
Date: Tue, 01 Sep 2020 11:21:11 +0200
Message-ID: <20200901092111.1205313-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1411229281269186453==
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
Changes since v2:
- (min <=3D 1 <=3D max)
- error handling

 drivers/atmodem/gprs.c | 64 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 68470f11..c208f6e6 100644
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
@@ -648,6 +649,65 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
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
+	int min, max, arg1 =3D 0, arg2 =3D 0;
+	gboolean two_arguments =3D true;
+	char buf[20];
+
+	if (!ok) {
+		ofono_error("Error querying AT+CGEREP=3D? Failing...");
+		ofono_gprs_remove(gprs);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	g_at_result_iter_next(&iter, "+CGEREP:");
+
+	if (!g_at_result_iter_open_list(&iter)) {
+		ofono_error("Malformed reply from AT+CGEREP=3D? Failing...");
+		ofono_gprs_remove(gprs);
+		return;
+	}
+
+	while (g_at_result_iter_next_range(&iter, &min, &max)) {
+		if ((min <=3D 1) && (max >=3D 1))
+			arg1 =3D 1;
+
+		if ((min <=3D 2) && (max >=3D 2))
+			arg1 =3D 2;
+	}
+
+	if (!g_at_result_iter_close_list(&iter))
+		goto out;
+
+	if (!g_at_result_iter_open_list(&iter)) {
+		two_arguments =3D false;
+		goto out;
+	}
+
+	while (g_at_result_iter_next_range(&iter, &min, &max)) {
+		if ((min <=3D 1) && (max >=3D 1))
+			arg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+out:
+	if (two_arguments)
+		sprintf(buf, "AT+CGEREP=3D%u,%u", arg1, arg2);
+	else
+		sprintf(buf, "AT+CGEREP=3D%u", arg1);
+
+	g_at_chat_send(gd->chat, buf, none_prefix, gprs_initialized, gprs,
+		NULL);
+}
+
 static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -702,8 +762,8 @@ retry:
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

2.28.0

--===============1411229281269186453==--

