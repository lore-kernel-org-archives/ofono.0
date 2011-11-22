Content-Type: multipart/mixed; boundary="===============8217438900138937283=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 31/32] modem: Append ModemType to GetProperties()
Date: Tue, 22 Nov 2011 18:10:00 +0100
Message-ID: <1321981801-5452-32-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8217438900138937283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/modem.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 344a2a6..e3e6632 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -119,6 +119,20 @@ struct modem_property {
 	void *value;
 };
 =

+static const char *modem_type_to_string(enum ofono_modem_type type)
+{
+	switch (type) {
+	case OFONO_MODEM_TYPE_HARDWARE:
+		return "hardware";
+	case OFONO_MODEM_TYPE_HFP:
+		return "hfp";
+	case OFONO_MODEM_TYPE_SAP:
+		return "sap";
+	}
+
+	return "unknown";
+}
+
 unsigned int __ofono_modem_callid_next(struct ofono_modem *modem)
 {
 	unsigned int i;
@@ -755,6 +769,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
 	dbus_bool_t emergency =3D ofono_modem_get_emergency_mode(modem);
+	const char *strtype;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -813,6 +828,9 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	if (modem->name)
 		ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
 					&modem->name);
+
+	strtype =3D modem_type_to_string(modem->driver->modem_type);
+	ofono_dbus_dict_append(dict, "ModemType", DBUS_TYPE_STRING, &strtype);
 }
 =

 static DBusMessage *modem_get_properties(DBusConnection *conn,
-- =

1.7.8.rc1.14.g248db


--===============8217438900138937283==--

