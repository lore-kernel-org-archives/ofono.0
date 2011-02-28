Content-Type: multipart/mixed; boundary="===============8959998627336732771=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] mbmmodem: ensure we close fd when ofono exits
Date: Mon, 28 Feb 2011 10:43:54 -0300
Message-ID: <1298900634-2337-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298900634-2337-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8959998627336732771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/location-reporting.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index b671d71..24ff4b8 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -71,6 +71,7 @@ static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResul=
t *result,
 	}
 =

 	g_io_channel_unref(gd->data_channel);
+	gd->data_channel =3D NULL;
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
@@ -116,6 +117,7 @@ static GAtChat *mbm_create_data_chat(struct ofono_locat=
ion_reporting *lr)
 =

 	if (chat =3D=3D NULL) {
 		g_io_channel_unref(gd->data_channel);
+		gd->data_channel =3D NULL;
 =

 		return NULL;
 	}
@@ -158,6 +160,7 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResu=
lt *result,
 =

 	g_at_chat_unref(chat);
 	g_io_channel_unref(gd->data_channel);
+	gd->data_channel =3D NULL;
 =

 out:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
@@ -225,6 +228,9 @@ static void mbm_location_reporting_remove(struct ofono_=
location_reporting *lr)
 {
 	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
 =

+	if (gd->data_channel !=3D NULL)
+		g_io_channel_unref(gd->data_channel);
+
 	ofono_location_reporting_set_data(lr, NULL);
 =

 	g_at_chat_unref(gd->chat);
-- =

1.7.4.1


--===============8959998627336732771==--

