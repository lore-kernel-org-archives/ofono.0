Content-Type: multipart/mixed; boundary="===============2634459223470412226=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 4/5] Add dun_disable() to power down the modem
Date: Wed, 04 Aug 2010 07:22:13 -0300
Message-ID: <1280917334-4519-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280917334-4519-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2634459223470412226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When setting Powered to 0 the link rfcomm is disconnected.
---
 plugins/dun.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/plugins/dun.c b/plugins/dun.c
index 60d0271..3d1e5c4 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -203,10 +203,48 @@ static int dun_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void dun_power_down(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Disconnect reply: %s", derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+done:
+	g_free(data->rfcomm);
+
+	dbus_message_unref(reply);
+}
+
 static int dun_disable(struct ofono_modem *modem)
 {
-	DBG("%p", modem);
-	return 0;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	int status;
+
+	if (!ofono_modem_get_powered(modem))
+		return 0;
+
+	status =3D bluetooth_send_with_reply(data->dun_path,
+				BLUEZ_SERIAL_INTERFACE, "Disconnect",
+				dun_power_down, modem, NULL, DBUS_TIMEOUT,
+				DBUS_TYPE_STRING, &data->rfcomm,
+				DBUS_TYPE_INVALID);
+
+	if (status < 0)
+		return -EINVAL;
+
+	return -EINPROGRESS;
 }
 =

 static struct ofono_modem_driver dun_driver =3D {
-- =

1.7.1.1


--===============2634459223470412226==--

