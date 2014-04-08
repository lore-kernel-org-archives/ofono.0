Content-Type: multipart/mixed; boundary="===============4745450438377073133=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH 3/4] hfp: Add subscriber number to handsfree properties
Date: Tue, 08 Apr 2014 09:21:46 +0100
Message-ID: <1396945307-12195-4-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4745450438377073133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 745cc9f..5462b19 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -44,6 +44,8 @@
 =

 static GSList *g_drivers =3D NULL;
 =

+#define HANDSFREE_FLAG_CACHED 0x1
+
 struct ofono_handsfree {
 	ofono_bool_t nrec;
 	ofono_bool_t inband_ringing;
@@ -52,11 +54,13 @@ struct ofono_handsfree {
 	unsigned int ag_features;
 	unsigned int ag_chld_features;
 	unsigned char battchg;
+	GSList *subscriber_numbers;
 =

 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
 	DBusMessage *pending;
+	int flags;
 };
 =

 static const char **ag_features_list(unsigned int features,
@@ -177,10 +181,50 @@ void ofono_handsfree_battchg_notify(struct ofono_hand=
sfree *hf,
 					&level);
 }
 =

-static DBusMessage *handsfree_get_properties(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static gboolean ofono_handsfree_is_busy(struct ofono_handsfree *hf)
+{
+	return hf->pending ? TRUE : FALSE;
+}
+
+static void ofono_append_subscriber_numbers(GSList *subscriber_numbers,
+				DBusMessageIter *iter)
+{
+	DBusMessageIter entry;
+	DBusMessageIter variant, array;
+	int i;
+	GSList *l;
+	const char *subscriber_number_string;
+	char arraysig[3];
+	char *subscriber_number_text =3D "SubscriberNumbers";
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D DBUS_TYPE_STRING;
+	arraysig[2] =3D '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
+					NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					&subscriber_number_text);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+					arraysig, &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	for (i =3D 0, l =3D subscriber_numbers; l; l =3D l->next, i++) {
+		subscriber_number_string =3D phone_number_to_string(l->data);
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+					&subscriber_number_string);
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+static DBusMessage *generate_get_properties_reply(struct ofono_handsfree *=
hf,
+						DBusMessage *msg)
 {
-	struct ofono_handsfree *hf =3D data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
@@ -217,11 +261,81 @@ static DBusMessage *handsfree_get_properties(DBusConn=
ection *conn,
 	ofono_dbus_dict_append(&dict, "BatteryChargeLevel", DBUS_TYPE_BYTE,
 				&hf->battchg);
 =

+	if (hf->subscriber_numbers)
+		ofono_append_subscriber_numbers(hf->subscriber_numbers, &dict);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
 }
 =

+static void hf_cnum_callback(const struct ofono_error *error, int total,
+				const struct ofono_phone_number *numbers,
+				void *data)
+{
+	struct ofono_handsfree *hf =3D data;
+	int num;
+	struct ofono_phone_number *subscriber_number_string;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto out;
+
+	for (num =3D 0; num < total; num++) {
+		subscriber_number_string =3D g_new0(struct ofono_phone_number, 1);
+
+		subscriber_number_string->type =3D numbers[num].type;
+		strncpy(subscriber_number_string->number, numbers[num].number,
+					OFONO_MAX_PHONE_NUMBER_LENGTH+1);
+
+		hf->subscriber_numbers =3D g_slist_prepend(hf->subscriber_numbers,
+					subscriber_number_string);
+	}
+
+	hf->subscriber_numbers =3D g_slist_reverse(hf->subscriber_numbers);
+
+out:
+	hf->flags |=3D HANDSFREE_FLAG_CACHED;
+
+	if (hf->pending) {
+		DBusMessage *reply =3D generate_get_properties_reply(
+							hf, hf->pending);
+		__ofono_dbus_pending_reply(&hf->pending, reply);
+	}
+}
+
+static void query_cnum(struct ofono_handsfree *hf)
+{
+	if (hf->driver->cnum_query =3D=3D NULL) {
+		if (hf->pending) {
+			DBusMessage *reply =3D generate_get_properties_reply(
+							hf, hf->pending);
+			__ofono_dbus_pending_reply(&hf->pending, reply);
+		}
+		return;
+	}
+
+	hf->driver->cnum_query(hf, hf_cnum_callback, hf);
+}
+
+static DBusMessage *handsfree_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_handsfree *hf =3D data;
+
+	if (ofono_handsfree_is_busy(hf))
+		return __ofono_error_busy(msg);
+
+	if (hf->flags & HANDSFREE_FLAG_CACHED)
+		return generate_get_properties_reply(hf, msg);
+
+	/* Query the settings and report back */
+	hf->pending =3D dbus_message_ref(msg);
+
+	query_cnum(hf);
+
+	return NULL;
+}
+
 static void voicerec_set_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_handsfree *hf =3D data;
@@ -453,6 +567,10 @@ static void handsfree_unregister(struct ofono_atom *at=
om)
 		__ofono_dbus_pending_reply(&hf->pending, reply);
 	}
 =

+	g_slist_foreach(hf->subscriber_numbers, (GFunc) g_free, NULL);
+	g_slist_free(hf->subscriber_numbers);
+	hf->subscriber_numbers =3D NULL;
+
 	ofono_modem_remove_interface(modem, OFONO_HANDSFREE_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
 					OFONO_HANDSFREE_INTERFACE);
-- =

1.7.11.7


--===============4745450438377073133==--

