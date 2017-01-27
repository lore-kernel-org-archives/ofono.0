Content-Type: multipart/mixed; boundary="===============1016206137465302741=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 3/3] xe910: support for Telit LE910V2 modem
Date: Fri, 27 Jan 2017 10:54:24 +0100
Message-ID: <20170127095424.19685-4-gluedig@gmail.com>
In-Reply-To: <20170127095424.19685-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1016206137465302741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LE910V2 is next generation Telit LTE modem.
It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
---
 plugins/xe910.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/plugins/xe910.c b/plugins/xe910.c
index 170a6b08..bf40a3de 100644
--- a/plugins/xe910.c
+++ b/plugins/xe910.c
@@ -64,7 +64,8 @@ static const char *qss_prefix[] =3D { "#QSS:", NULL };
 =

 enum modem_model {
 	HE910 =3D 1,
-	UE910
+	UE910,
+	LE910
 };
 =

 static struct {
@@ -84,6 +85,7 @@ static struct {
 	{ UE910,	NULL,	FALSE,	FALSE },
 	{ UE910,	"EUR",	TRUE,	FALSE },
 	{ UE910,	"NAR",	TRUE,	FALSE },
+	{ LE910,	NULL,	FALSE,	FALSE },
 	{ }
 };
 =

@@ -297,6 +299,8 @@ static gboolean find_model_variant(struct ofono_modem *=
modem,
 		data->model =3D HE910;
 	else if (g_str_equal(model, "UE910"))
 		data->model =3D UE910;
+	else if (g_str_equal(model, "LE910"))
+		data->model =3D LE910;
 	else
 		return FALSE;
 =

@@ -385,6 +389,8 @@ static int xe910_enable(struct ofono_modem *modem)
 	 */
 	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
 				NULL, NULL, NULL);
+	g_at_chat_send(data->modem, "ATE0", none_prefix,
+				NULL, NULL, NULL);
 =

 =

 	/* Get modem model and variant */
@@ -472,7 +478,13 @@ static void xe910_post_online(struct ofono_modem *mode=
m)
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->model =3D=3D LE910)
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_TELIT,
+						"telitncmmodem", data->modem);
+	else
+		gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+						data->modem);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.11.0


--===============1016206137465302741==--

