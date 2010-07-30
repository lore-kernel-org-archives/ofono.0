Content-Type: multipart/mixed; boundary="===============9158577298564289467=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/3] Add dun_disable() to power down the modem
Date: Thu, 29 Jul 2010 23:09:13 -0300
Message-ID: <1280455753-24523-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280455753-24523-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9158577298564289467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When setting Powered to 0 the link rfcomm is disconnected.
---
 plugins/dun.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/plugins/dun.c b/plugins/dun.c
index 7dc8422..6d96696 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -201,10 +201,45 @@ static int dun_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void dun_power_down(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
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
+				dun_power_down, modem, NULL, 15,
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


--===============9158577298564289467==--

