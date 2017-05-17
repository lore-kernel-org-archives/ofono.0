Content-Type: multipart/mixed; boundary="===============9034929756011712348=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v3] gemalto: Implement HardwareMonitor method
Date: Wed, 17 May 2017 11:12:59 +0200
Message-ID: <1495012379-32261-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <3bd5451f-22f9-b7ed-3503-946fdcf87bcd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9034929756011712348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use Gemalto commands ^SCTM and ^SBV to monitor temperature and voltage.
Use a single method GetStatistics to read and return both values.
---
 plugins/gemalto.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 3798e09..011713e 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -53,6 +53,8 @@
 #define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMonit=
or"
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
+static const char *sbv_prefix[] =3D { "^SBV:", NULL };
 =

 struct gemalto_hardware_monitor {
 	DBusMessage *msg;
@@ -155,13 +157,102 @@ static void cfun_enable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 						NULL);
 }
 =

+static void gemalto_sctm_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct gemalto_data *data =3D user_data;
+	DBusMessage *reply;
+	GAtResultIter iter;
+	DBusMessageIter dbus_iter;
+	DBusMessageIter dbus_dict;
+
+	if (data->hm->msg =3D=3D NULL)
+		return;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SCTM:"))
+		goto error;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &data->hm->temperature))
+		goto error;
+
+	reply =3D dbus_message_new_method_return(data->hm->msg);
+
+	dbus_message_iter_init_append(reply, &dbus_iter);
+
+	dbus_message_iter_open_container(&dbus_iter, DBUS_TYPE_ARRAY,
+			OFONO_PROPERTIES_ARRAY_SIGNATURE,
+			&dbus_dict);
+
+	ofono_dbus_dict_append(&dbus_dict, "Temperature",
+			DBUS_TYPE_INT32, &data->hm->temperature);
+
+	ofono_dbus_dict_append(&dbus_dict, "Voltage",
+			DBUS_TYPE_UINT32, &data->hm->voltage);
+
+	dbus_message_iter_close_container(&dbus_iter, &dbus_dict);
+
+	__ofono_dbus_pending_reply(&data->hm->msg, reply);
+
+	return;
+
+error:
+	__ofono_dbus_pending_reply(&data->hm->msg,
+			__ofono_error_failed(data->hm->msg));
+}
+
+static void gemalto_sbv_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct gemalto_data *data =3D user_data;
+	GAtResultIter iter;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SBV:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &data->hm->voltage))
+		goto error;
+
+	if (g_at_chat_send(data->app, "AT^SCTM?", sctm_prefix, gemalto_sctm_cb,
+				data, NULL) > 0)
+		return;
+
+error:
+	__ofono_dbus_pending_reply(&data->hm->msg,
+			__ofono_error_failed(data->hm->msg));
+}
+
 static DBusMessage *hardware_monitor_get_statistics(DBusConnection *conn,
 							DBusMessage *msg,
 							void *user_data)
 {
+	struct gemalto_data *data =3D user_data;
+
 	DBG("");
 =

-	return __ofono_error_not_implemented(msg);
+	if (data->hm->msg !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (!g_at_chat_send(data->app, "AT^SBV", sbv_prefix, gemalto_sbv_cb,
+			data, NULL))
+		return __ofono_error_failed(msg);
+
+	data->hm->msg =3D dbus_message_ref(msg);
+
+	return NULL;
 }
 =

 static const GDBusMethodTable hardware_monitor_methods[] =3D {
-- =

1.9.1


--===============9034929756011712348==--

