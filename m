Content-Type: multipart/mixed; boundary="===============6624962599525318735=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] Add CDMA voice call sending DTMF tone support
Date: Fri, 12 Aug 2011 17:20:00 +0800
Message-ID: <1313140800-29011-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6624962599525318735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-voicecall.h |    3 ++
 src/cdma-voicecall.c     |   54 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
index b170e39..f12e0b6 100644
--- a/include/cdma-voicecall.h
+++ b/include/cdma-voicecall.h
@@ -61,6 +61,9 @@ struct ofono_cdma_voicecall_driver {
 =

 	void (*send_flash)(struct ofono_cdma_voicecall *vc, const char *string,
 			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*send_tones)(struct ofono_cdma_voicecall *vc, const char *tones,
+			ofono_cdma_voicecall_cb_t cb, void *data);
 };
 =

 void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index 37db8d5..bbf805f 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -330,6 +330,58 @@ static DBusMessage *voicecall_manager_flash(DBusConnec=
tion *conn,
 	return NULL;
 }
 =

+static ofono_bool_t is_valid_tones(const char *tones)
+{
+	int len;
+	int i;
+
+	if (tones =3D=3D NULL)
+		return FALSE;
+
+	len =3D strlen(tones);
+	if (len =3D=3D 0)
+		return FALSE;
+
+	for (i =3D 0; i < len; i++) {
+		if (g_ascii_isdigit(tones[i]) || tones[i] =3D=3D '*' ||
+				tones[i] =3D=3D '#')
+			continue;
+		else
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
+static DBusMessage *voicecall_manager_tone(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall *vc =3D data;
+	const char *tones;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (vc->driver->send_tones =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (vc->status !=3D CDMA_CALL_STATUS_ACTIVE)
+		return __ofono_error_failed(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &tones,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (is_valid_tones(tones) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	vc->driver->send_tones(vc,  tones, generic_callback, vc);
+
+	return NULL;
+}
+
 static GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",
 					voicecall_manager_get_properties },
@@ -341,6 +393,8 @@ static GDBusMethodTable manager_methods[] =3D {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SendFlash",      "s",    "",         voicecall_manager_flash,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendTones",     "s",    "",        voicecall_manager_tone,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.5


--===============6624962599525318735==--

