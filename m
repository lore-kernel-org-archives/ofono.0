Content-Type: multipart/mixed; boundary="===============9174757272828896949=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/4] src: Implement RAT list property
Date: Fri, 05 Dec 2014 17:46:30 +0100
Message-ID: <1417797991-19700-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1417797991-19700-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9174757272828896949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/radio-settings.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index d1b1cc1..4967994 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -48,6 +48,8 @@ struct ofono_radio_settings {
 	enum ofono_radio_band_gsm pending_band_gsm;
 	enum ofono_radio_band_umts pending_band_umts;
 	ofono_bool_t fast_dormancy_pending;
+	ofono_bool_t modem_rats[OFONO_RADIO_ACCESS_MODE_LAST];
+	ofono_bool_t modem_rats_filled;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -222,6 +224,21 @@ static DBusMessage *radio_get_properties_reply(DBusMes=
sage *msg,
 					DBUS_TYPE_BOOLEAN, &value);
 	}
 =

+	if (rs->driver->query_modem_rats) {
+		const char *rats_strs[OFONO_RADIO_ACCESS_MODE_LAST + 1];
+		const char *(*strs)[] =3D &rats_strs;
+		int i, str_i;
+
+		for (i =3D 0, str_i =3D 0; i < OFONO_RADIO_ACCESS_MODE_LAST; ++i)
+			if (rs->modem_rats[i])
+				rats_strs[str_i++] =3D
+						radio_access_mode_to_string(i);
+		rats_strs[str_i] =3D NULL;
+
+		ofono_dbus_dict_append_array(&dict, "ModemTechnologies",
+						DBUS_TYPE_STRING, &strs);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -374,6 +391,43 @@ static void radio_send_properties_reply(struct ofono_r=
adio_settings *rs)
 	__ofono_dbus_pending_reply(&rs->pending, reply);
 }
 =

+static void radio_set_modem_rats(struct ofono_radio_settings *rs,
+					const ofono_bool_t rats[])
+{
+	memcpy(rs->modem_rats, rats, sizeof(rs->modem_rats));
+	rs->modem_rats_filled =3D TRUE;
+}
+
+static void radio_modem_rats_query_callback(const struct ofono_error *erro=
r,
+						const ofono_bool_t rats[],
+						void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during modem rats query");
+
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+
+		return;
+	}
+
+	radio_set_modem_rats(rs, rats);
+	radio_send_properties_reply(rs);
+}
+
+static void radio_query_modem_rats(struct ofono_radio_settings *rs)
+{
+	if (rs->driver->query_modem_rats =3D=3D NULL) {
+		radio_send_properties_reply(rs);
+		return;
+	}
+
+	rs->driver->query_modem_rats(rs, radio_modem_rats_query_callback, rs);
+}
+
 static void radio_fast_dormancy_query_callback(const struct ofono_error *e=
rror,
 						ofono_bool_t enable, void *data)
 {
@@ -390,7 +444,12 @@ static void radio_fast_dormancy_query_callback(const s=
truct ofono_error *error,
 	}
 =

 	radio_set_fast_dormancy(rs, enable);
-	radio_send_properties_reply(rs);
+
+	/* Modem technology is not supposed to change, so one query is enough */
+	if (rs->modem_rats_filled)
+		radio_send_properties_reply(rs);
+	else
+		radio_query_modem_rats(rs);
 }
 =

 static void radio_query_fast_dormancy(struct ofono_radio_settings *rs)
-- =

2.1.0


--===============9174757272828896949==--

