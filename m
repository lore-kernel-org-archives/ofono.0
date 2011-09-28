Content-Type: multipart/mixed; boundary="===============1960680238633758530=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 3/5] sap: enable SAP modem, when BlueZ replies
Date: Wed, 28 Sep 2011 17:48:58 -0300
Message-ID: <1317242940-4014-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317242940-4014-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1960680238633758530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

---
 plugins/sap.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 28b07e7..850ed2f 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -127,6 +127,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	struct sap_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
 	DBusMessage *reply;
+	int fd, err;
 =

 	DBG("");
 =

@@ -138,16 +139,29 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 		goto done;
 =

 	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply))
+	if (dbus_set_error_from_message(&derr, reply)) {
+
+		DBG("Connect reply: %s", derr.message);
+
+		dbus_error_free(&derr);
 		goto done;
+	}
 =

-	DBG("Connect reply: %s", derr.message);
+	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID))
+		goto done;
 =

-	ofono_modem_set_powered(modem, FALSE);
+	data->hw_modem =3D sap_hw_modem;
+	data->sap_driver =3D sap_hw_driver;
 =

-	dbus_error_free(&derr);
+	err =3D data->sap_driver->enable(data->hw_modem, modem, fd);
+	if (err =3D=3D -EINPROGRESS) {
+		dbus_message_unref(reply);
+		return;
+	}
 =

 done:
+	ofono_modem_set_powered(modem, FALSE);
 	dbus_message_unref(reply);
 }
 =

-- =

1.7.6.2


--===============1960680238633758530==--

