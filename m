Content-Type: multipart/mixed; boundary="===============8682914053566868564=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 04/24] sap: add support to connect the RFCOMM link
Date: Tue, 13 Sep 2011 15:58:12 -0300
Message-ID: <1315940312-1238-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8682914053566868564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 2a5db74..9f464e7 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -38,11 +38,14 @@
 #include <ofono/modem.h>
 =

 #include "bluetooth.h"
+#include "util.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
 =

+#define BLUEZ_SERIAL_INTERFACE	BLUEZ_SERVICE ".Serial"
+
 static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *sap_hw_hash =3D NULL;
@@ -114,12 +117,52 @@ static void sap_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	DBusError derr;
+	DBusMessage *reply;
+
+	DBG("");
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (ofono_modem_get_powered(modem))
+		goto done;
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply))
+		goto done;
+
+	DBG("Connect reply: %s", derr.message);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+}
+
 /* power up hardware */
 static int sap_enable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
+	int status;
+	const char *str =3D "sap";
+
+	DBG("%p", modem);
+
+	status =3D bluetooth_send_with_reply(data->server_path,
+					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
+					sap_connect_reply, modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_STRING,
+					&str, DBUS_TYPE_INVALID);
+
+	if (status < 0)
+		return -EINVAL;
 =

-	return data->sap_driver->enable(data->hw_modem);
+	return -EINPROGRESS;
 }
 =

 static int sap_disable(struct ofono_modem *modem)
-- =

1.7.6.2


--===============8682914053566868564==--

