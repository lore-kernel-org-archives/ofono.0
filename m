Content-Type: multipart/mixed; boundary="===============0040670535305637562=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] Add air interface flash validation in CDMA voice call
Date: Tue, 16 Aug 2011 15:39:35 +0800
Message-ID: <1313480375-30628-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0040670535305637562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check whether air interface flash is valid:

1. Air interface flash should be sent during a call

2. flash string may include feature code, digits (0-9) and end marks(*, #),
   along with any additional PIN information, called party number, etc.
   Generally, should be characters can be input in dialer.

3. flash without a string is allowed, it is used to switch call status.

---
 src/cdma-voicecall.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index bbf805f..8de94c7 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -307,6 +307,30 @@ static DBusMessage *voicecall_manager_answer(DBusConne=
ction *conn,
 	return NULL;
 }
 =

+static ofono_bool_t is_valid_flash_string(const char *str)
+{
+	int len;
+	int i;
+
+	/* flash string is empty, it is allowed */
+	if (str =3D=3D NULL)
+		return TRUE;
+
+	len =3D strlen(str);
+	if (len =3D=3D 0)
+		return TRUE;
+
+	for (i =3D 0; i < len; i++) {
+		if (g_ascii_isdigit(str[i]) || str[i] =3D=3D '*' ||
+				str[i] =3D=3D '#' || str[i] =3D=3D '+')
+			continue;
+		else
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
 static DBusMessage *voicecall_manager_flash(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -319,10 +343,16 @@ static DBusMessage *voicecall_manager_flash(DBusConne=
ction *conn,
 	if (vc->driver->send_flash =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

+	if (vc->status =3D=3D CDMA_CALL_STATUS_DISCONNECTED)
+		return __ofono_error_failed(msg);
+
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &string,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

+	if (is_valid_flash_string(string) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
 	vc->pending =3D dbus_message_ref(msg);
 =

 	vc->driver->send_flash(vc, string, generic_callback, vc);
-- =

1.7.5


--===============0040670535305637562==--

