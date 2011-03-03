Content-Type: multipart/mixed; boundary="===============1238568694009582453=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 14:14:39 -0300
Message-ID: <1299172479-11086-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4D6D692E.1020209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1238568694009582453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using a GAtChat, just use a GIOChannel and close it as soon
as its fd is sent to core.

Moreover, when oFono exits it's just a matter of checking if there's an
idle callback scheduled to control if we need to close the GIOChannel.
---

Hi Denis,

Following patch implements what the previous one were trying to accomplish,=
 but
without the problem of closing the chat before the command was sent to tty.=
 As
we talked on IRC, now I'm using the GIOChannel directly, without bothering =
with
creating the chat. Even if the command to send to this channel is very shor=
t, I
preferred to use async calls. Hence the use of an idle callback.


regards,
Lucas De Marchi


 drivers/mbmmodem/location-reporting.c |  105 +++++++++++++++++++----------=
----
 1 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 941fac4..30571fe 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -48,7 +48,14 @@ static const char *e2gpsctl_prefix[] =3D { "*E2GPSCTL:",=
 NULL };
 =

 struct gps_data {
 	GAtChat *chat;
-	GAtChat *data_chat;
+
+	struct {
+		GIOChannel *channel;
+		guint idle_source;
+		gsize written;
+		ofono_location_reporting_enable_cb_t cb;
+		void *cb_data;
+	} stream;
 };
 =

 static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResult *result,
@@ -57,7 +64,6 @@ static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResul=
t *result,
 	struct cb_data *cbd =3D user_data;
 	struct ofono_location_reporting *lr =3D cbd->user;
 	ofono_location_reporting_disable_cb_t cb =3D cbd->cb;
-	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 =

 	DBG("lr=3D%p, ok=3D%d", lr, ok);
 =

@@ -70,8 +76,6 @@ static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResul=
t *result,
 		return;
 	}
 =

-	g_at_chat_unref(gd->data_chat);
-
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

@@ -94,69 +98,81 @@ static void mbm_location_reporting_disable(struct ofono=
_location_reporting *lr,
 	g_free(cbd);
 }
 =

-static int mbm_create_data_chat(struct ofono_location_reporting *lr)
+static gboolean enable_data_stream(gpointer data)
 {
-	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
-	struct ofono_modem *modem;
-	const char *gps_dev;
-	GAtSyntax *syntax;
-	GIOChannel *channel;
+	static const char *buf =3D "AT*E2GPSNPD\r\n";
+	gsize len =3D strlen(buf);
+	struct gps_data *gd =3D data;
+	GIOStatus status;
+	gsize written;
 	int fd;
 =

-	modem =3D ofono_location_reporting_get_modem(lr);
-	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	status =3D g_io_channel_write_chars(gd->stream.channel,
+						buf + gd->stream.written,
+						len - gd->stream.written,
+						&written, NULL);
+	if (status =3D=3D G_IO_STATUS_AGAIN)
+		return TRUE;
 =

-	channel =3D g_at_tty_open(gps_dev, NULL);
-	if (channel =3D=3D NULL)
-		return -1;
+	if (status !=3D G_IO_STATUS_NORMAL) {
+		CALLBACK_WITH_FAILURE(gd->stream.cb, -1, gd->stream.cb_data);
 =

-	syntax =3D g_at_syntax_new_gsm_permissive();
-	gd->data_chat =3D g_at_chat_new(channel, syntax);
-	fd =3D g_io_channel_unix_get_fd(channel);
+		return FALSE;
+	}
+
+	gd->stream.written +=3D written;
 =

-	g_at_syntax_unref(syntax);
-	g_io_channel_unref(channel);
+	if (gd->stream.written !=3D len)
+		return TRUE;
 =

-	if (gd->data_chat =3D=3D NULL)
-		return -1;
+	fd =3D g_io_channel_unix_get_fd(gd->stream.channel);
+	CALLBACK_WITH_SUCCESS(gd->stream.cb, fd, gd->stream.cb_data);
 =

-	return fd;
+	return FALSE;
+}
+
+static void destroy_data_stream(gpointer data)
+{
+	struct gps_data *gd =3D data;
+
+	g_io_channel_unref(gd->stream.channel);
+	gd->stream.idle_source =3D 0;
+	gd->stream.written =3D 0;
 }
 =

 static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_location_reporting_enable_cb_t cb =3D cbd->cb;
-	struct ofono_location_reporting *lr =3D cbd->user;
+	struct ofono_location_reporting *lr =3D user_data;
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct ofono_modem *modem;
+	const char *gps_dev;
 	struct ofono_error error;
-	int fd;
 =

 	DBG("lr=3D%p ok=3D%d", lr, ok);
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, cbd->data);
+		gd->stream.cb(&error, -1, gd->stream.cb_data);
 =

 		return;
 	}
 =

-	fd =3D mbm_create_data_chat(lr);
-
-	if (fd < 0)
-		goto out;
+	modem =3D ofono_location_reporting_get_modem(lr);
+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	gd->stream.channel =3D g_at_tty_open(gps_dev, NULL);
 =

-	if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
-								NULL) > 0) {
-		cb(&error, fd, cbd->data);
+	if (gd->stream.channel =3D=3D NULL) {
+		ofono_error("Could select data GPS channel");
+		CALLBACK_WITH_FAILURE(gd->stream.cb, -1, gd->stream.cb_data);
 =

 		return;
 	}
 =

-out:
-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	gd->stream.idle_source =3D g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
+							enable_data_stream, gd,
+							destroy_data_stream);
 }
 =

 static void mbm_location_reporting_enable(struct ofono_location_reporting =
*lr,
@@ -164,22 +180,17 @@ static void mbm_location_reporting_enable(struct ofon=
o_location_reporting *lr,
 					void *data)
 {
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	DBG("lr=3D%p", lr);
 =

-	if (cbd =3D=3D NULL)
-		goto out;
-
-	cbd->user =3D lr;
+	gd->stream.cb_data =3D data;
+	gd->stream.cb =3D cb;
 =

 	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D1,5,1", none_prefix,
-				mbm_e2gpsctl_enable_cb, cbd, g_free) > 0)
+				mbm_e2gpsctl_enable_cb, lr, NULL) > 0)
 		return;
 =

-out:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
-	g_free(cbd);
 }
 =

 static void mbm_location_reporting_support_cb(gboolean ok, GAtResult *resu=
lt,
@@ -224,6 +235,10 @@ static void mbm_location_reporting_remove(struct ofono=
_location_reporting *lr)
 	ofono_location_reporting_set_data(lr, NULL);
 =

 	g_at_chat_unref(gd->chat);
+
+	if (gd->stream.idle_source)
+		g_source_remove(gd->stream.idle_source);
+
 	g_free(gd);
 }
 =

-- =

1.7.4.1


--===============1238568694009582453==--

