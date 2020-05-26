Content-Type: multipart/mixed; boundary="===============7106187901784302857=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 1/7] quectel: Add Quectel EC21 to known serial modems
Date: Tue, 26 May 2020 12:16:19 +0200
Message-ID: <20200526101625.31871-2-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7106187901784302857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

This adds the Quectel EC21 to the known modems of the quectel driver and
therefore allows to use it with its serial interface.
---
 plugins/quectel.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 5d3ad470..1a49a5b3 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -64,7 +64,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *cbc_prefix[] =3D { "+CBC:", NULL };
 static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_MC6=
0",
-					NULL };
+					"EC21", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static const uint8_t gsm0710_terminate[] =3D {
@@ -83,6 +83,7 @@ enum quectel_model {
 	QUECTEL_UC15,
 	QUECTEL_M95,
 	QUECTEL_MC60,
+	QUECTEL_EC21,
 };
 =

 struct quectel_data {
@@ -512,6 +513,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 =

 	switch (data->model) {
 	case QUECTEL_UC15:
+	case QUECTEL_EC21:
 		g_at_chat_register(data->aux, "+QIND",  qind_notify, FALSE, hw,
 					NULL);
 		break;
@@ -556,6 +558,7 @@ static void qinistat_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 =

 	switch (data->model) {
 	case QUECTEL_UC15:
+	case QUECTEL_EC21:
 		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
 		ready =3D 7;
 		break;
@@ -788,6 +791,10 @@ static void cgmm_cb(int ok, GAtResult *result, void *u=
ser_data)
 		DBG("%p model MC60", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
 		data->model =3D QUECTEL_MC60;
+	} else if (strcmp(model, "EC21") =3D=3D 0) {
+		DBG("%p model EC21", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_EC21;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
-- =

2.26.2

--===============7106187901784302857==--

