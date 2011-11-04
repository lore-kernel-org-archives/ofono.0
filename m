Content-Type: multipart/mixed; boundary="===============1555455512427306082=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 2/4] cdma-connman: Check cdma-netreg status to enable data
 call
Date: Fri, 04 Nov 2011 16:28:05 +0100
Message-ID: <1320420487-16334-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320420487-16334-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1555455512427306082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index db8f6c5..518fcb5 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -338,6 +338,26 @@ static void cdma_connman_settings_append_properties(
 	dbus_message_iter_close_container(dict, &entry);
 }
 =

+static ofono_bool_t cdma_connman_netreg_is_registered(struct ofono_cdma_co=
nnman *cm)
+{
+	int status;
+	ofono_bool_t registered;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cm->atom);
+	struct ofono_atom *atom =3D __ofono_modem_find_atom(modem,
+						OFONO_ATOM_TYPE_CDMA_NETREG);
+	struct ofono_cdma_netreg *cdma_netreg;
+
+	if (atom =3D=3D NULL)
+		return FALSE;
+
+	cdma_netreg =3D __ofono_atom_get_data(atom);
+	status  =3D ofono_cdma_netreg_get_status(cdma_netreg);
+
+	registered =3D status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+
+	return registered;
+}
+
 static DBusMessage *cdma_connman_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -463,9 +483,11 @@ static DBusMessage *cdma_connman_set_property(DBusConn=
ection *conn,
 				cm->driver->deactivate =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
 =

+		if (cdma_connman_netreg_is_registered(cm) =3D=3D FALSE)
+			return __ofono_error_not_registered(msg);
+
 		cm->pending =3D dbus_message_ref(msg);
 =

-		/* TODO: add logic to support CDMA Network Registration */
 		if (value)
 			cm->driver->activate(cm, cm->username, cm->password,
 						activate_callback, cm);
@@ -613,8 +635,6 @@ void ofono_cdma_connman_register(struct ofono_cdma_conn=
man *cm)
 	ofono_modem_add_interface(modem,
 				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
 =

-	/* TODO: add watch to support CDMA Network Registration atom */
-
 	__ofono_atom_register(cm->atom, cdma_connman_unregister);
 }
 =

-- =

1.7.1


--===============1555455512427306082==--

