Content-Type: multipart/mixed; boundary="===============5952064704486032296=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 13/14] cdmamodem: add data strength to CDMA netreg atom.
Date: Fri, 05 Aug 2011 15:21:14 +0200
Message-ID: <1312550475-8537-14-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5952064704486032296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-netreg.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 12ddd23..e57856e 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -34,6 +34,7 @@ static GSList *g_drivers;
 struct ofono_cdma_netreg {
 	enum cdma_netreg_status status;
 	int strength;
+	int data_strength;
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -82,6 +83,13 @@ static DBusMessage *network_get_properties(DBusConnectio=
n *conn,
 					&strength);
 	}
 =

+	if (cdma_netreg->data_strength !=3D -1) {
+		unsigned char data_strength =3D cdma_netreg->data_strength;
+
+		ofono_dbus_dict_append(&dict, "DataStrength", DBUS_TYPE_BYTE,
+					&data_strength);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -151,6 +159,36 @@ void ofono_cdma_netreg_strength_notify(struct ofono_cd=
ma_netreg *netreg,
 	}
 }
 =

+void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *netr=
eg,
+					int data_strength)
+{
+	if (netreg =3D=3D NULL)
+		return;
+
+	if (netreg->data_strength =3D=3D data_strength)
+		return;
+
+	/*
+	 * Theoretically we can get signal strength even when not registered
+	 * to any network.  However, what do we do with it in that case?
+	 */
+	if (netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED)
+		return;
+
+	netreg->data_strength =3D data_strength;
+
+	if (data_strength !=3D -1) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(netreg->atom);
+		unsigned char data_strength =3D netreg->data_strength;
+
+		ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"DataStrength", DBUS_TYPE_BYTE,
+				&data_strength);
+	}
+}
+
 int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -216,6 +254,7 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(stru=
ct ofono_modem *modem,
 =

 	cdma_netreg->status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 	cdma_netreg->strength =3D -1;
+	cdma_netreg->data_strength =3D -1;
 =

 	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_CDMA_NETREG,
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5952064704486032296==--

