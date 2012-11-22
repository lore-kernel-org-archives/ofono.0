Content-Type: multipart/mixed; boundary="===============7453162146758549684=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 04/11] hfp_hf: Add SLC setup
Date: Thu, 22 Nov 2012 14:53:21 -0300
Message-ID: <1353606808-25032-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7453162146758549684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the SLC setup when the NewConnection is notified.
---
 plugins/hfp_hf.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index edb7671..819c8cd 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -101,9 +101,10 @@ static void slc_failed(gpointer userdata)
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	DBusMessage *msg;
 =

-	msg =3D g_dbus_create_error(data->slc_msg, HFP_AGENT_ERROR_INTERFACE
-					".Failed",
-					"HFP Handshake failed");
+	msg =3D g_dbus_create_error(data->slc_msg, BLUEZ_ERROR_INTERFACE
+						".Failed",
+						"HFP Handshake failed");
+
 	g_dbus_send_message(connection, msg);
 	dbus_message_unref(data->slc_msg);
 	data->slc_msg =3D NULL;
@@ -343,9 +344,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_modem *modem;
+	struct hfp_data *hfp_data;
 	const char *device;
 	DBusMessageIter entry;
-	int fd;
+	int fd, err;
+	guint16 version =3D 0x0105;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -370,9 +373,18 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto error;
 =

-	DBG("modem %p, SLC FD: %d", modem, fd);
+	hfp_data =3D ofono_modem_get_data(modem);
+	DBG("modem %p, hfp_data: %p SLC FD: %d", modem, hfp_data, fd);
 =

-	return dbus_message_new_method_return(msg);
+	hfp_slc_info_init(&hfp_data->info, version);
+
+	err =3D service_level_connection(modem, fd);
+	if (err < 0 && err !=3D -EINPROGRESS)
+		return __ofono_error_failed(msg);
+
+	hfp_data->slc_msg =3D dbus_message_ref(msg);
+
+	return NULL;
 =

 error:
 	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
-- =

1.7.11.7


--===============7453162146758549684==--

