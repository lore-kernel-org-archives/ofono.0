Content-Type: multipart/mixed; boundary="===============6579052270164787834=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 7/9] handsfree-audio: Add Audio Card GetProperties
Date: Tue, 26 Feb 2013 10:50:51 -0300
Message-ID: <1361886653-30873-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6579052270164787834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial implementation of the GetProperties method
of the Handsfree Audio Card. This version supports the Bluetooth address
of the remote peer only.
---
 src/handsfree-audio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index fcebce8..f8c598f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -285,7 +285,19 @@ void ofono_handsfree_audio_unref(void)
 static DBusMessage *card_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return __ofono_error_not_implemented(msg);
+	struct audio_card *card =3D user_data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	card_append_properties(&iter, card);
+
+	return reply;
 }
 =

 static const GDBusMethodTable card_methods[] =3D {
-- =

1.7.11.7


--===============6579052270164787834==--

