Content-Type: multipart/mixed; boundary="===============1240057925401264286=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 09/15] handsfree-audio: Add calling connect callback
Date: Tue, 12 Mar 2013 09:42:07 -0300
Message-ID: <1363092133-1092-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1240057925401264286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the call of the connect callback implemented in the
driver when "Connect" method of the Audio Card gets called.
---
 src/handsfree-audio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c11c325..8a0d97d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -237,7 +237,18 @@ static DBusMessage *card_get_properties(DBusConnection=
 *conn,
 static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return __ofono_error_not_implemented(msg);
+	struct ofono_handsfree_card *card =3D data;
+	const struct ofono_handsfree_card_driver *driver =3D card->driver;
+	int sk;
+
+	if (driver =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	sk =3D driver->audio_connect(card->remote, card->local);
+	if (sk < 0)
+		return __ofono_error_failed(msg);
+
+	return NULL;
 }
 =

 static const GDBusMethodTable card_methods[] =3D {
-- =

1.7.11.7


--===============1240057925401264286==--

