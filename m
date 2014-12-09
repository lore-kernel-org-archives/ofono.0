Content-Type: multipart/mixed; boundary="===============7588858082025823060=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/4] src: Implement RAT list property
Date: Tue, 09 Dec 2014 13:34:38 +0100
Message-ID: <1418128479-5491-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7588858082025823060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/radio-settings.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index d1b1cc1..5d166cc 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
+#include <stdint.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -48,6 +49,7 @@ struct ofono_radio_settings {
 	enum ofono_radio_band_gsm pending_band_gsm;
 	enum ofono_radio_band_umts pending_band_umts;
 	ofono_bool_t fast_dormancy_pending;
+	uint32_t available_rats;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -222,6 +224,23 @@ static DBusMessage *radio_get_properties_reply(DBusMes=
sage *msg,
 					DBUS_TYPE_BOOLEAN, &value);
 	}
 =

+	if (rs->available_rats) {
+		const char *rats_strs[OFONO_RADIO_ACCESS_MODE_LTE + 1];
+		const char **strs =3D rats_strs;
+		int str_i =3D 0;
+		size_t i, techs =3D sizeof(rats_strs)/sizeof(rats_strs[0]) - 1;
+
+		for (i =3D 0; i < techs; ++i)
+			if (rs->available_rats & (1 << i))
+				rats_strs[str_i++] =3D
+					radio_access_mode_to_string(i + 1);
+
+		rats_strs[str_i] =3D NULL;
+
+		ofono_dbus_dict_append_array(&dict, "AvailableTechnologies",
+						DBUS_TYPE_STRING, &strs);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -374,6 +393,32 @@ static void radio_send_properties_reply(struct ofono_r=
adio_settings *rs)
 	__ofono_dbus_pending_reply(&rs->pending, reply);
 }
 =

+static void radio_available_rats_query_callback(const struct ofono_error *=
error,
+						unsigned int available_rats,
+						void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		rs->available_rats =3D available_rats;
+	else
+		DBG("Error while querying available rats");
+
+	radio_send_properties_reply(rs);
+}
+
+static void radio_query_available_rats(struct ofono_radio_settings *rs)
+{
+	/* Modem technology is not supposed to change, so one query is enough */
+	if (rs->driver->query_available_rats =3D=3D NULL || rs->available_rats) {
+		radio_send_properties_reply(rs);
+		return;
+	}
+
+	rs->driver->query_available_rats(
+				rs, radio_available_rats_query_callback, rs);
+}
+
 static void radio_fast_dormancy_query_callback(const struct ofono_error *e=
rror,
 						ofono_bool_t enable, void *data)
 {
@@ -390,7 +435,7 @@ static void radio_fast_dormancy_query_callback(const st=
ruct ofono_error *error,
 	}
 =

 	radio_set_fast_dormancy(rs, enable);
-	radio_send_properties_reply(rs);
+	radio_query_available_rats(rs);
 }
 =

 static void radio_query_fast_dormancy(struct ofono_radio_settings *rs)
-- =

2.1.0


--===============7588858082025823060==--

