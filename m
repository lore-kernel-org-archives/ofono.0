Content-Type: multipart/mixed; boundary="===============5878399141945210950=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 09/10] hfp_hf: Add service level negotiation
Date: Fri, 18 Jan 2013 20:21:55 -0300
Message-ID: <1358551316-27305-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5878399141945210950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the service level negotiation and the callbacks to
handle success and failure situations. The HFP modem is being destroyed
when the service level connection is dropped.
---
 plugins/hfp_hf_bluez5.c | 113 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index b3f8a1c..17421d0 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 =

 #include <glib.h>
@@ -64,6 +65,7 @@ struct hfp {
 	char *device_path;
 	struct hfp_slc_info info;
 	DBusMessage *msg;
+	GIOChannel *slcio;
 	GSList *endpoints;
 };
 =

@@ -76,6 +78,9 @@ static void hfp_free(gpointer user_data)
 	if (hfp->msg)
 		dbus_message_unref(hfp->msg);
 =

+	if (hfp->slcio)
+		g_io_channel_unref(hfp->slcio);
+
 	g_slist_free(hfp->endpoints);
 	g_free(hfp->device_address);
 	g_free(hfp->device_path);
@@ -90,12 +95,111 @@ static void modem_data_free(gpointer user_data)
 	hfp_free(hfp);
 }
 =

+static void hfp_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static void slc_established(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	msg =3D dbus_message_new_method_return(hfp->msg);
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+	dbus_message_unref(hfp->msg);
+	hfp->msg =3D NULL;
+
+	ofono_info("Service level connection established");
+}
+
+static void slc_failed(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	msg =3D g_dbus_create_error(hfp->msg, BLUEZ_ERROR_INTERFACE
+						".Failed",
+						"HFP Handshake failed");
+
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+	dbus_message_unref(hfp->msg);
+	hfp->msg =3D NULL;
+
+	ofono_error("Service level connection failed");
+	ofono_modem_set_powered(modem, FALSE);
+
+	hfp_slc_info_free(&hfp->info);
+}
+
+static void hfp_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
+	DBG("HFP disconnected");
+
+	hfp_slc_info_free(&hfp->info);
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static GIOChannel *service_level_connection(struct ofono_modem *modem,
+							int fd, int *err)
+{
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	io =3D g_io_channel_unix_new(fd);
+	if (io =3D=3D NULL) {
+		ofono_error("Service level connection failed: %s (%d)",
+						strerror(errno), errno);
+		*err =3D -EIO;
+		return NULL;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (chat =3D=3D NULL) {
+		*err =3D -ENOMEM;
+		goto fail;
+	}
+
+	g_at_chat_set_disconnect_function(chat, hfp_disconnected_cb, modem);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, hfp_debug, "");
+
+	hfp->info.chat =3D chat;
+	hfp_slc_establish(&hfp->info, slc_established, slc_failed, modem);
+
+	*err =3D -EINPROGRESS;
+
+	return io;
+
+fail:
+	g_io_channel_unref(io);
+	return NULL;
+}
+
 static int modem_register(struct hfp *hfp, const char *alias, int fd,
 							guint16 version)
 {
 	struct ofono_modem *modem;
-	int err =3D 0;
+	guint8 codecs[1];
 	char *path;
+	int err;
 =

 	path =3D g_strconcat("hfp", hfp->device_path, NULL);
 =

@@ -112,6 +216,13 @@ static int modem_register(struct hfp *hfp, const char =
*alias, int fd,
 =

 	g_hash_table_insert(modem_hash, g_strdup(hfp->device_path), modem);
 =

+	memset(codecs, 0, sizeof(codecs));
+	codecs[0] =3D HFP_CODEC_CVSD;
+
+	hfp_slc_info_init(&hfp->info, version, codecs, 1);
+
+	hfp->slcio =3D service_level_connection(modem, fd, &err);
+
 	return err;
 }
 =

-- =

1.7.11.7


--===============5878399141945210950==--

