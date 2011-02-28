Content-Type: multipart/mixed; boundary="===============3726698094652038479=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] mbmmodem: close chat before sending fd
Date: Mon, 28 Feb 2011 10:43:52 -0300
Message-ID: <1298900634-2337-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3726698094652038479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/location-reporting.c |   44 ++++++++++++++++++-----------=
----
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 941fac4..b671d71 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -48,7 +48,7 @@ static const char *e2gpsctl_prefix[] =3D { "*E2GPSCTL:", =
NULL };
 =

 struct gps_data {
 	GAtChat *chat;
-	GAtChat *data_chat;
+	GIOChannel *data_channel;
 };
 =

 static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResult *result,
@@ -70,7 +70,7 @@ static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResul=
t *result,
 		return;
 	}
 =

-	g_at_chat_unref(gd->data_chat);
+	g_io_channel_unref(gd->data_channel);
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
@@ -94,33 +94,33 @@ static void mbm_location_reporting_disable(struct ofono=
_location_reporting *lr,
 	g_free(cbd);
 }
 =

-static int mbm_create_data_chat(struct ofono_location_reporting *lr)
+static GAtChat *mbm_create_data_chat(struct ofono_location_reporting *lr)
 {
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct ofono_modem *modem;
 	const char *gps_dev;
 	GAtSyntax *syntax;
-	GIOChannel *channel;
-	int fd;
+	GAtChat *chat;
 =

 	modem =3D ofono_location_reporting_get_modem(lr);
 	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
 =

-	channel =3D g_at_tty_open(gps_dev, NULL);
-	if (channel =3D=3D NULL)
-		return -1;
+	gd->data_channel =3D g_at_tty_open(gps_dev, NULL);
+	if (gd->data_channel =3D=3D NULL)
+		return NULL;
 =

 	syntax =3D g_at_syntax_new_gsm_permissive();
-	gd->data_chat =3D g_at_chat_new(channel, syntax);
-	fd =3D g_io_channel_unix_get_fd(channel);
+	chat =3D g_at_chat_new(gd->data_channel, syntax);
 =

 	g_at_syntax_unref(syntax);
-	g_io_channel_unref(channel);
 =

-	if (gd->data_chat =3D=3D NULL)
-		return -1;
+	if (chat =3D=3D NULL) {
+		g_io_channel_unref(gd->data_channel);
+
+		return NULL;
+	}
 =

-	return fd;
+	return chat;
 }
 =

 static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResult *result,
@@ -131,7 +131,7 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResu=
lt *result,
 	struct ofono_location_reporting *lr =3D cbd->user;
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct ofono_error error;
-	int fd;
+	GAtChat *chat;
 =

 	DBG("lr=3D%p ok=3D%d", lr, ok);
 =

@@ -143,18 +143,22 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtRe=
sult *result,
 		return;
 	}
 =

-	fd =3D mbm_create_data_chat(lr);
-
-	if (fd < 0)
+	chat =3D mbm_create_data_chat(lr);
+	if (chat =3D=3D NULL)
 		goto out;
 =

-	if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
-								NULL) > 0) {
+	if (g_at_chat_send(chat, "AT*E2GPSNPD", NULL, NULL, NULL, NULL) > 0) {
+		int fd =3D g_io_channel_unix_get_fd(gd->data_channel);
+
+		g_at_chat_unref(chat);
 		cb(&error, fd, cbd->data);
 =

 		return;
 	}
 =

+	g_at_chat_unref(chat);
+	g_io_channel_unref(gd->data_channel);
+
 out:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
-- =

1.7.4.1


--===============3726698094652038479==--

