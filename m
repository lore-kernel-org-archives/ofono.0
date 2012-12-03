Content-Type: multipart/mixed; boundary="===============5338368270394175941=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 10/14] hfp_hf: Add Version and Features parsing
Date: Mon, 03 Dec 2012 10:11:51 -0300
Message-ID: <1354540315-27731-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5338368270394175941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds parsing of the Version and Features properties of the
NewConnection fd_dictionary.
---
 plugins/hfp_hf.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index da20917..8dd8dd9 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -79,6 +79,16 @@ static void hfp_data_free(gpointer user_data)
 	g_free(hfp_data);
 }
 =

+static void parse_guint16(DBusMessageIter *iter, gpointer user_data)
+{
+	guint16 *value =3D user_data;
+
+	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_UINT16)
+		return;
+
+	dbus_message_iter_get_basic(iter, value);
+}
+
 static void hfp_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -172,11 +182,11 @@ static int service_level_connection(struct ofono_mode=
m *modem, int fd)
 	return -EINPROGRESS;
 }
 =

-static int modem_register(const char *device, struct hfp_data *hfp_data, i=
nt fd)
+static int modem_register(const char *device, struct hfp_data *hfp_data,
+							int fd, guint16 version)
 {
 	struct ofono_modem *modem;
 	char buf[256];
-	guint16 version =3D 0x0105;
 =

 	/* We already have this device in our hash, ignore */
 	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
@@ -294,6 +304,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	const char *device;
 	DBusMessageIter entry;
 	int fd, err;
+	guint16 version =3D 0x0105, features =3D 0x0000;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -318,9 +329,17 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto error;
 =

-	DBG("hfp_data: %p SLC FD: %d", hfp_data, fd);
+	dbus_message_iter_next(&entry);
+
+	bluetooth_parse_properties(&entry,
+					"Version", parse_guint16, &version,
+					"Features", parse_guint16, &features,
+					NULL);
+
+	DBG("hfp_data: %p SLC FD: %d Version: 0x%04x Features: 0x%04x",
+					hfp_data, fd, version, features);
 =

-	err =3D modem_register(device, hfp_data, fd);
+	err =3D modem_register(device, hfp_data, fd, version);
 	if (err < 0 && err !=3D -EINPROGRESS)
 		return __ofono_error_failed(msg);
 =

-- =

1.7.11.7


--===============5338368270394175941==--

