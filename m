Content-Type: multipart/mixed; boundary="===============2038190498038068625=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 11/19] sms: send PropertyChanged signals on state change
Date: Tue, 03 Aug 2010 16:51:00 -0700
Message-ID: <fcc4b4125797680118f92515b50a3cfdf55917b2.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2038190498038068625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This hooks sms_msg_stch_dbus_cb() into the SMS state change callback
so that a D-Bus signal will be emitted whenever an SMS Message
transitions state. This allows a client to track, if desired, what is
going on with the SMS Message it cares about.
---
 src/sms.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 06dfd08..fbaa271 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -790,6 +790,40 @@ struct tx_queue_entry *sms_msg_send(
 }
 =

 /*
+ * Send a PropertyChange signal when the state changes
+ *
+ * In D-Bus we don't care about the initial state transition to
+ * _QUEUED, as the object path hasn't even been published yet in the
+ * bus.
+ */
+static
+void sms_msg_stch_dbus_cb(void *_dbus_path,
+			  enum ofono_sms_tx_state new_state)
+{
+	char *dbus_path =3D _dbus_path;
+	DBusConnection *dbus_conn =3D ofono_dbus_get_connection();
+	DBusMessage *dbus_signal;
+	DBusMessageIter iter;
+	const char *property =3D "State";
+	const char *new_state_str;
+
+	if (new_state =3D=3D OFONO_SMS_TX_ST_QUEUED)
+		return;
+
+	dbus_signal =3D dbus_message_new_signal(
+		dbus_path, SMS_MSG_INTERFACE, "PropertyChanged");
+
+	if (!dbus_signal)
+		return;
+
+	dbus_message_iter_init_append(dbus_signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+	new_state_str =3D ofono_sms_tx_state_to_string(new_state);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &new_state_str);
+	g_dbus_send_message(dbus_conn, dbus_signal);
+}
+
+/*
  * D-Bus: Send a SMS text message
  *
  * @conn: D-Bus connection
@@ -820,7 +854,7 @@ static DBusMessage *dbus_sms_msg_send(DBusConnection *c=
onn, DBusMessage *msg,
 	 */
 	dbus_path =3D g_strdup_printf("%s/%04x", sms_path, 0);
 	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY,
-			       NULL,
+			       sms_msg_stch_dbus_cb,
 			       sms_msg_dbus_destroy,
 			       dbus_path);
 =

-- =

1.6.6.1


--===============2038190498038068625==--

