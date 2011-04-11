Content-Type: multipart/mixed; boundary="===============7819965529694375583=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 09/20] modem: add preferred ue mode handling
Date: Mon, 11 Apr 2011 13:20:07 +0300
Message-ID: <1302517218-2147-10-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7819965529694375583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index a8b8744..bb0374a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -75,6 +75,7 @@ struct ofono_modem {
 	char			*lock_owner;
 	guint			lock_watch;
 	guint			timeout;
+	int			pref_mode;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
 	struct ofono_watchlist	*powered_watches;
@@ -119,6 +120,22 @@ struct modem_property {
 	void *value;
 };
 =

+static const char *preferred_ue_mode_to_string(int mode)
+{
+	switch (mode) {
+	case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
+		return "PS mode 2";
+	case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
+		return "PS/CS mode 1";
+	case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
+		return "PS/CS mode 2";
+	case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
+		return "PS mode 1";
+	}
+
+	return "unknown";
+}
+
 unsigned int __ofono_modem_callid_next(struct ofono_modem *modem)
 {
 	unsigned int i;
@@ -748,6 +765,14 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 	ofono_dbus_dict_append(dict, "Emergency", DBUS_TYPE_BOOLEAN,
 				&emergency);
 =

+	if (modem->pref_mode !=3D -1) {
+		const char *mode =3D preferred_ue_mode_to_string(
+							modem->pref_mode);
+
+		ofono_dbus_dict_append(dict, "PreferredMode",
+					DBUS_TYPE_STRING, &mode);
+	}
+
 	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
 =

 	/* We cheat a little here and don't check the registered status */
@@ -1181,6 +1206,24 @@ ofono_bool_t ofono_modem_get_powered(struct ofono_mo=
dem *modem)
 	return modem->powered;
 }
 =

+void ofono_modem_set_preferred_ue_mode(struct ofono_modem *modem, int mode)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *strmode;
+
+	if (modem->pref_mode =3D=3D mode)
+		return;
+
+	modem->pref_mode =3D mode;
+
+	strmode =3D preferred_ue_mode_to_string(mode);
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"PreferredMode",
+						DBUS_TYPE_STRING, &strmode);
+}
+
 static gboolean trigger_interface_update(void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -1777,6 +1820,7 @@ struct ofono_modem *ofono_modem_create(const char *na=
me, const char *type)
 	modem->driver_type =3D g_strdup(type);
 	modem->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, unregister_property);
+	modem->pref_mode =3D -1;
 =

 	g_modem_list =3D g_slist_prepend(g_modem_list, modem);
 =

-- =

1.7.0.4


--===============7819965529694375583==--

