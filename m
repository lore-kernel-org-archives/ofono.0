Content-Type: multipart/mixed; boundary="===============5749055398383951856=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] Add CDMA voice call sending air interface flash support
Date: Fri, 12 Aug 2011 17:19:46 +0800
Message-ID: <1313140786-28970-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5749055398383951856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-voicecall.h |    3 +++
 src/cdma-voicecall.c     |   25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
index 6f77462..b170e39 100644
--- a/include/cdma-voicecall.h
+++ b/include/cdma-voicecall.h
@@ -58,6 +58,9 @@ struct ofono_cdma_voicecall_driver {
 =

 	void (*answer)(struct ofono_cdma_voicecall *vc,
 			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*send_flash)(struct ofono_cdma_voicecall *vc, const char *string,
+			ofono_cdma_voicecall_cb_t cb, void *data);
 };
 =

 void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index b7323c8..37db8d5 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -307,6 +307,29 @@ static DBusMessage *voicecall_manager_answer(DBusConne=
ction *conn,
 	return NULL;
 }
 =

+static DBusMessage *voicecall_manager_flash(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall *vc =3D data;
+	const char *string;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (vc->driver->send_flash =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &string,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	vc->driver->send_flash(vc, string, generic_callback, vc);
+
+	return NULL;
+}
+
 static GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",
 					voicecall_manager_get_properties },
@@ -316,6 +339,8 @@ static GDBusMethodTable manager_methods[] =3D {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Answer",           "",    "",         voicecall_manager_answer,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendFlash",      "s",    "",         voicecall_manager_flash,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.5


--===============5749055398383951856==--

