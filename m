Content-Type: multipart/mixed; boundary="===============7178452996096310639=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 5/7] quectel: add support for the Quectel MC60 modem
Date: Tue, 16 Jul 2019 21:10:51 +0200
Message-ID: <20190716191053.71990-5-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7178452996096310639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modem is AT-compatible with the Quectel M95 modem, but also features
a GNSS module.
---
 plugins/quectel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index e84e3cf1..9cac92fa 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -56,7 +56,8 @@
 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
-static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", NULL };
+static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_MC6=
0",
+					NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static const uint8_t gsm0710_terminate[] =3D {
@@ -342,6 +343,10 @@ static void cgmm_cb(int ok, GAtResult *result, void *u=
ser_data)
 		DBG("%p model M95", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
 		data->model =3D QUECTEL_M95;
+	} else if (strcmp(model, "Quectel_MC60") =3D=3D 0) {
+		DBG("%p model MC60", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
+		data->model =3D QUECTEL_MC60;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
-- =

2.22.0


--===============7178452996096310639==--

