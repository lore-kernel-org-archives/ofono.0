Content-Type: multipart/mixed; boundary="===============8896430886914041665=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH 4/4] modem: Add modem access tech set/get functions
Date: Thu, 28 Oct 2010 01:14:54 -0700
Message-ID: <1288253694-25800-5-git-send-email-Rajesh.Nagaiah@elektrobit.com>
In-Reply-To: <1288253694-25800-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8896430886914041665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h |    4 ++++
 src/modem.c     |   30 ++++++++++++++++++++++++++++++
 src/ofono.h     |    2 ++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 7b13ee0..de941a9 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -69,6 +69,10 @@ ofono_bool_t ofono_modem_get_boolean(struct ofono_modem =
*modem,
 typedef void (*ofono_modem_online_cb_t)(const struct ofono_error *error,
 					void *data);
 =

+void ofono_modem_set_access_tech(struct ofono_modem *modem,
+					int access_tech);
+int ofono_modem_get_access_tech(struct ofono_modem *modem);
+
 struct ofono_modem_driver {
 	const char *name;
 =

diff --git a/src/modem.c b/src/modem.c
index 3776461..cec6dd8 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -61,6 +61,7 @@ enum modem_state {
 struct ofono_modem {
 	char			*path;
 	enum modem_state	modem_state;
+	guint8			access_tech;
 	GSList			*atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList			*interface_list;
@@ -1268,6 +1269,35 @@ ofono_bool_t ofono_modem_get_boolean(struct ofono_mo=
dem *modem, const char *key)
 	return value;
 }
 =

+void ofono_modem_set_access_tech(struct ofono_modem *modem, int access_tec=
h)
+{
+	const char *tech =3D modem_access_tech_to_string(access_tech);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	modem->access_tech =3D access_tech;
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"ModemAccessTechnology",
+					DBUS_TYPE_STRING,
+					&tech);
+}
+
+int ofono_modem_get_access_tech(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->access_tech;
+}
+
+int __ofono_modem_get_access_tech(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->access_tech;
+}
+
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name)
 {
 	if (modem->name)
diff --git a/src/ofono.h b/src/ofono.h
index bd7f33c..b4974a3 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -99,6 +99,8 @@ void __ofono_modem_callid_release(struct ofono_modem *mod=
em, int id);
 void __ofono_modem_append_properties(struct ofono_modem *modem,
 						DBusMessageIter *dict);
 =

+int __ofono_modem_get_access_tech(struct ofono_modem *modem);
+
 struct ofono_atom;
 =

 enum ofono_atom_type {
-- =

1.7.0.4


--===============8896430886914041665==--

