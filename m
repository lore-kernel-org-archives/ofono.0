Content-Type: multipart/mixed; boundary="===============5572619115299440487=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] cdma-connman: Add RoamingAllowed support
Date: Mon, 05 Dec 2011 15:04:17 +0100
Message-ID: <1323093857-28071-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323093857-28071-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5572619115299440487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to use status watch in case we are registered to a network
and we pass into roaming status. We have to deactivate the data
call.
---
 src/cdma-connman.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 87cefd6..d880b94 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -52,6 +52,7 @@ struct cdma_connman_settings {
 struct ofono_cdma_connman {
 	ofono_bool_t powered;
 	ofono_bool_t dormant;
+	ofono_bool_t roaming_allowed;
 	struct cdma_connman_settings *settings;
 	DBusMessage *pending;
 	const struct ofono_cdma_connman_driver *driver;
@@ -354,8 +355,10 @@ static ofono_bool_t network_registered(struct ofono_cd=
ma_connman *cm)
 =

 	switch (status) {
 	case NETWORK_REGISTRATION_STATUS_REGISTERED:
-	case NETWORK_REGISTRATION_STATUS_ROAMING:
 		return TRUE;
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		if (cm->roaming_allowed =3D=3D TRUE)
+			return TRUE;
 	default:
 		break;
 	}
@@ -390,6 +393,10 @@ static DBusMessage *cdma_connman_get_properties(DBusCo=
nnection *conn,
 	value =3D cm->dormant;
 	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN, &value);
 =

+	value =3D cm->roaming_allowed;
+	ofono_dbus_dict_append(&dict, "RoamingAllowed",
+				DBUS_TYPE_BOOLEAN, &value);
+
 	if (cm->settings)
 		cdma_connman_settings_append_properties(cm, &dict);
 =

@@ -512,6 +519,16 @@ static DBusMessage *cdma_connman_set_property(DBusConn=
ection *conn,
 =

 		dbus_message_iter_get_basic(&var, &str);
 		return cdma_connman_set_password(cm, conn, msg, str);
+	} else if (!strcmp(property, "RoamingAllowed")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (cm->roaming_allowed =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		cm->roaming_allowed =3D value;
 	}
 =

 	/* TODO: Dormant property. Not yet supported. */
-- =

1.7.1


--===============5572619115299440487==--

