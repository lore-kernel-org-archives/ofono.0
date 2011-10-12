Content-Type: multipart/mixed; boundary="===============3161013064393836351=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 08/19] handsfree: Expose RequestPhoneNumber in D-Bus API
Date: Wed, 12 Oct 2011 14:35:29 +0200
Message-ID: <1318422940-14955-9-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3161013064393836351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index ae5007e..42b71ea 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -48,6 +48,7 @@ struct ofono_handsfree {
 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	DBusMessage *pending;
 };
 =

 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
@@ -119,11 +120,53 @@ static DBusMessage *handsfree_set_property(DBusConnec=
tion *conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void request_phone_number_cb(const struct ofono_error *error,
+					const struct ofono_phone_number *number,
+					void *data)
+{
+	struct ofono_handsfree *hf =3D data;
+	DBusMessage *reply;
+	const char *phone_number;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Phone number request callback returned error: %s",
+			telephony_error_to_str(error));
+
+		reply =3D __ofono_error_failed(hf->pending);
+		__ofono_dbus_pending_reply(&hf->pending, reply);
+		return;
+	}
+
+	phone_number =3D phone_number_to_string(number);
+	reply =3D dbus_message_new_method_return(hf->pending);
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &phone_number,
+					DBUS_TYPE_INVALID);
+	__ofono_dbus_pending_reply(&hf->pending, reply);
+}
+
+static DBusMessage *handsfree_request_phone_number(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_handsfree *hf =3D data;
+
+	if (hf->pending)
+		return __ofono_error_busy(msg);
+
+	if (!hf->driver->request_phone_number)
+		return __ofono_error_not_supported(msg);
+
+	hf->pending =3D dbus_message_ref(msg);
+	hf->driver->request_phone_number(hf, request_phone_number_cb, hf);
+	return NULL;
+}
+
 static GDBusMethodTable handsfree_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties,
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",      "sv",  "", handsfree_set_property,
 		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RequestPhoneNumber", "", "s", handsfree_request_phone_number,
+		G_DBUS_METHOD_FLAG_ASYNC },
 	{ NULL, NULL, NULL, NULL }
 };
 =

@@ -187,6 +230,12 @@ static void handsfree_unregister(struct ofono_atom *at=
om)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
+	struct ofono_handsfree *hf =3D __ofono_atom_get_data(atom);
+
+	if (hf->pending) {
+		DBusMessage *reply =3D __ofono_error_failed(hf->pending);
+		__ofono_dbus_pending_reply(&hf->pending, reply);
+	}
 =

 	ofono_modem_remove_interface(modem, OFONO_HANDSFREE_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
-- =

1.7.6.4


--===============3161013064393836351==--

