Content-Type: multipart/mixed; boundary="===============5135358890481454381=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/4] hfp_hf_bluez5: Add support for Enabling/Disabling the
 modem
Date: Fri, 01 Feb 2013 20:33:09 -0300
Message-ID: <1359761589-18561-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359761589-18561-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5135358890481454381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have the support for sending the correct messages
to BlueZ, we are able to dynamically power up/down the HFP modem.

We add another property to the modem to be able to get the D-Bus
object path that represents the remote device.
---
 plugins/hfp_hf_bluez5.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0d6bdd9..de580f2 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -180,6 +180,7 @@ static struct ofono_modem *modem_register(const char *d=
evice,
 		return NULL;
 =

 	ofono_modem_set_string(modem, "Remote", device_address);
+	ofono_modem_set_string(modem, "DevicePath", device);
 =

 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
@@ -219,19 +220,53 @@ static void hfp_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static void connect_cb(gboolean success, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	if (success)
+		return;
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 /* power up hardware */
 static int hfp_enable(struct ofono_modem *modem)
 {
+	const char *path;
+
 	DBG("%p", modem);
 =

-	return 0;
+	path =3D ofono_modem_get_string(modem, "DevicePath");
+
+	/*
+	 * We call Device1.ConnectProfile() with our UUID, and we hope for the
+	 * NewConnection() method to be called, if ConnectProfile() fails we
+	 * force the modem to powered off
+	 */
+	bt_connect_profile(ofono_dbus_get_connection(), path, HFP_AG_UUID,
+							connect_cb, modem);
+
+	return -EINPROGRESS;
 }
 =

 static int hfp_disable(struct ofono_modem *modem)
 {
+	const char *path;
+
 	DBG("%p", modem);
 =

-	return 0;
+	path =3D ofono_modem_get_string(modem, "DevicePath");
+
+	/*
+	 * We call Device1.DisconnectProfile() for the connection to be
+	 * dropped, which will cause the profile RequestDisconnection() method
+	 * to be called which will bring the modem down
+	 */
+	bt_disconnect_profile(ofono_dbus_get_connection(), path, HFP_AG_UUID,
+							NULL, NULL);
+
+	return -EINPROGRESS;
 }
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
-- =

1.8.1.1


--===============5135358890481454381==--

