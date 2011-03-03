Content-Type: multipart/mixed; boundary="===============7942694941400843914=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 19:23:27 -0300
Message-ID: <1299191007-8081-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7942694941400843914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using a GAtChat, just use a GIOChannel and close it as soon
as its fd is sent to core.
---
 drivers/mbmmodem/location-reporting.c |   32 +++++++++++++++--------------=
---
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 941fac4..b76a5c2 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -94,13 +94,13 @@ static void mbm_location_reporting_disable(struct ofono=
_location_reporting *lr,
 	g_free(cbd);
 }
 =

-static int mbm_create_data_chat(struct ofono_location_reporting *lr)
+static int enable_data_stream(struct ofono_location_reporting *lr)
 {
-	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct ofono_modem *modem;
 	const char *gps_dev;
-	GAtSyntax *syntax;
 	GIOChannel *channel;
+	GIOStatus status;
+	gsize written;
 	int fd;
 =

 	modem =3D ofono_location_reporting_get_modem(lr);
@@ -110,15 +110,18 @@ static int mbm_create_data_chat(struct ofono_location=
_reporting *lr)
 	if (channel =3D=3D NULL)
 		return -1;
 =

-	syntax =3D g_at_syntax_new_gsm_permissive();
-	gd->data_chat =3D g_at_chat_new(channel, syntax);
 	fd =3D g_io_channel_unix_get_fd(channel);
+	status =3D g_io_channel_write_chars(channel, "AT*E2GPSNPD\r\n", -1,
+								&written, NULL);
 =

-	g_at_syntax_unref(syntax);
+	g_io_channel_set_close_on_unref(channel, FALSE);
 	g_io_channel_unref(channel);
 =

-	if (gd->data_chat =3D=3D NULL)
+	if (status !=3D G_IO_STATUS_NORMAL || written !=3D 13) {
+		close(fd);
+
 		return -1;
+	}
 =

 	return fd;
 }
@@ -129,7 +132,6 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResu=
lt *result,
 	struct cb_data *cbd =3D user_data;
 	ofono_location_reporting_enable_cb_t cb =3D cbd->cb;
 	struct ofono_location_reporting *lr =3D cbd->user;
-	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 	struct ofono_error error;
 	int fd;
 =

@@ -143,20 +145,16 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtRe=
sult *result,
 		return;
 	}
 =

-	fd =3D mbm_create_data_chat(lr);
+	fd =3D enable_data_stream(lr);
 =

-	if (fd < 0)
-		goto out;
-
-	if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
-								NULL) > 0) {
-		cb(&error, fd, cbd->data);
+	if (fd < 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 =

 		return;
 	}
 =

-out:
-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	cb(&error, fd, cbd->data);
+	close(fd);
 }
 =

 static void mbm_location_reporting_enable(struct ofono_location_reporting =
*lr,
-- =

1.7.4.1


--===============7942694941400843914==--

