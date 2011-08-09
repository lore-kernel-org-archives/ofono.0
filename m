Content-Type: multipart/mixed; boundary="===============5210505159218092043=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/3] cdma-connman: Add D-Bus API to remove credentials
Date: Tue, 09 Aug 2011 16:48:06 +0200
Message-ID: <1312901287-30032-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312901287-30032-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5210505159218092043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 3967080..9f40104 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -510,16 +510,50 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static DBusMessage *cdma_connman_remove_credentials(DBusConnection *conn,
+							DBusMessage *msg,
+							void *data)
+{
+	struct ofono_cdma_connman *cm =3D data;
+	const char *path;
+
+	DBG("");
+
+	strcpy(cm->username, "");
+	strcpy(cm->password, "");
+
+	if (cm->powered =3D=3D TRUE)
+		cm->driver->deactivate(cm, deactivate_callback, cm);
+
+	if (cm->credentials) {
+		g_key_file_remove_group(cm->credentials, CREDENTIALS_GROUP,
+					NULL);
+		storage_sync(cm->serial, CREDENTIALS_STORE, cm->credentials);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	path =3D __ofono_atom_get_path(cm->atom);
+	g_dbus_emit_signal(conn, path, OFONO_CONNECTION_MANAGER_INTERFACE,
+				"CredentialsRemoved", DBUS_TYPE_INVALID);
+
+	return NULL;
+}
+
 static GDBusMethodTable cdma_connman_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",
 						cdma_connman_get_properties },
 	{ "SetProperty",	"sv",	"",	cdma_connman_set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RemoveCredentials",	"",	"",
+					cdma_connman_remove_credentials,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

 static GDBusSignalTable cdma_connman_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
+	{ "CredentialsRemoved",	"" },
 	{ }
 };
 =

-- =

1.7.1


--===============5210505159218092043==--

