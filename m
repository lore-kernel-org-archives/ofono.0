Content-Type: multipart/mixed; boundary="===============5272409448801671392=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 10/10] hfp_hf: Add support for codec negotiation
Date: Fri, 18 Jan 2013 20:21:56 -0300
Message-ID: <1358551316-27305-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5272409448801671392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

The negotiation is very simple, if the codec the AG requests is present
in the supported codec list that the HF sent, the codec is accepted, if
not, we send the list of supported codecs again, and expect that the AG
re-sends the request with an acceptable codec.
---
 plugins/hfp_hf_bluez5.c | 50 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 17421d0..d8ec0f2 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 =

 #include <glib.h>
@@ -64,6 +65,7 @@ struct hfp {
 	char *device_address;
 	char *device_path;
 	struct hfp_slc_info info;
+	guint8 current_codec;
 	DBusMessage *msg;
 	GIOChannel *slcio;
 	GSList *endpoints;
@@ -102,12 +104,59 @@ static void hfp_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void bcs_notify(GAtResult *result, gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+	struct hfp_slc_info *info =3D &hfp->info;
+	GAtResultIter iter;
+	GString *str;
+	int i, value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BCS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	/* If some codec matches, we confirm it */
+	for (i =3D 0; i < info->codecs_len; i++) {
+		if (info->codecs[i] =3D=3D value) {
+			char buf[32];
+
+			hfp->current_codec =3D value;
+			DBG("Negotiated HFP codec: %d", value);
+
+			snprintf(buf, sizeof(buf), "AT+BCS=3D%d", value);
+			g_at_chat_send(info->chat, buf, NULL, NULL,
+							NULL, NULL);
+			return;
+		}
+	}
+
+	/* If none matches, we send our supported codecs again */
+	str =3D g_string_new("AT+BAC=3D");
+
+	for (i =3D 0; i < info->codecs_len; i++) {
+		g_string_append_printf(str, "%d", info->codecs[i]);
+		if (i + 1 < info->codecs_len)
+			str =3D g_string_append(str, ",");
+	}
+
+	g_at_chat_send(info->chat, str->str, NULL, NULL, NULL, NULL);
+	g_string_free(str, TRUE);
+}
+
 static void slc_established(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	struct hfp_slc_info *info =3D &hfp->info;
 	DBusMessage *msg;
 =

+	g_at_chat_register(info->chat, "+BCS:", bcs_notify, FALSE, hfp, NULL);
+
 	ofono_modem_set_powered(modem, TRUE);
 =

 	msg =3D dbus_message_new_method_return(hfp->msg);
@@ -436,6 +485,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	hfp->device_path =3D g_strdup(device);
 	hfp->endpoints =3D endpoints;
 	hfp->msg =3D dbus_message_ref(msg);
+	hfp->current_codec =3D HFP_CODEC_CVSD;
 =

 	err =3D modem_register(hfp, "unknown", fd, version);
 	if (err < 0 && err !=3D -EINPROGRESS) {
-- =

1.7.11.7


--===============5272409448801671392==--

