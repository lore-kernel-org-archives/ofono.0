Content-Type: multipart/mixed; boundary="===============4655255964590947903=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/3] hfp: wait Disconnect reply to power down the modem
Date: Thu, 04 Feb 2010 19:30:21 -0200
Message-ID: <1265319021-28299-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265319021-28299-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4655255964590947903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 4202ddf..4f6da06 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -796,13 +796,34 @@ static int hfp_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void hfp_power_down(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_debug("Disconnect reply: %s", derr.message);
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
 static int hfp_disconnect_ofono_handsfree(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
 				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-				NULL, NULL, DBUS_TYPE_INVALID);
+				hfp_power_down, modem, DBUS_TYPE_INVALID);
 }
 =

 static int hfp_disable(struct ofono_modem *modem)
@@ -816,7 +837,8 @@ static int hfp_disable(struct ofono_modem *modem)
 	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
 =

 	hfp_disconnect_ofono_handsfree(modem);
-	return 0;
+
+	return -EINPROGRESS;
 }
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
-- =

1.6.4.4


--===============4655255964590947903==--

