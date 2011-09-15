Content-Type: multipart/mixed; boundary="===============1501443914480307462=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 05/12] handsfree: Atom supports inband ringing status
Date: Thu, 15 Sep 2011 18:34:36 +0200
Message-ID: <1316104483-13144-6-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1501443914480307462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    3 +++
 src/handsfree.c     |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index ddec353..cd60975 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -37,6 +37,9 @@ struct ofono_handsfree_driver {
 	void (*remove)(struct ofono_handsfree *hf);
 };
 =

+void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
+						ofono_bool_t enabled);
+
 int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
 void ofono_handsfree_driver_unregister(
 			const struct ofono_handsfree_driver *d);
diff --git a/src/handsfree.c b/src/handsfree.c
index 797fe69..2bf2284 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -43,17 +43,38 @@
 static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
+	ofono_bool_t inband_ringing;
 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
 };
 =

+void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
+						ofono_bool_t enabled)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+	dbus_bool_t dbus_enabled =3D enabled;
+
+	if (hf->inband_ringing =3D=3D enabled)
+		return;
+
+	hf->inband_ringing =3D enabled;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					"InbandRinging", DBUS_TYPE_BOOLEAN,
+					&dbus_enabled);
+}
+
 static DBusMessage *handsfree_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct ofono_handsfree *hf =3D data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
+	dbus_bool_t inband_ringing;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -64,6 +85,11 @@ static DBusMessage *handsfree_get_properties(DBusConnect=
ion *conn,
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
+
+	inband_ringing =3D hf->inband_ringing;
+	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
+				&inband_ringing);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
-- =

1.7.6


--===============1501443914480307462==--

