Content-Type: multipart/mixed; boundary="===============4478244811358197362=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] call-forward: Call forwarding state handling
Date: Thu, 16 Jun 2011 16:31:35 +0200
Message-ID: <1308234695-11428-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4478244811358197362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When CFU is active be cautious with conditional
call-forward activation/deactivation
---
 src/call-forwarding.c |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 73ce433..eff5e9d 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -504,6 +504,7 @@ static DBusMessage *cf_get_properties_reply(DBusMessage=
 *msg,
 	DBusMessageIter dict;
 	int i;
 	dbus_bool_t status;
+	GSList *hidden =3D NULL;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -515,17 +516,33 @@ static DBusMessage *cf_get_properties_reply(DBusMessa=
ge *msg,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 						&dict);
 =

-	for (i =3D 0; i < 4; i++)
-		property_append_cf_conditions(&dict, cf->cf_conditions[i],
-						BEARER_CLASS_VOICE,
-						cf_type_lut[i]);
-
 	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
 			cf->cfis_record_id > 0)
 		status =3D is_cfu_enabled(cf, NULL);
 	else
 		status =3D FALSE;
 =

+	/*
+	 * If unconditional call-forwarding is enabled,
+	 * hide conditionnal status
+	 */
+	if (status =3D=3D TRUE) {
+		struct ofono_call_forwarding_condition cd =3D {0, 0, {"", 0}, 0};
+
+		for (i =3D 0; i < 4; i++)
+			hidden =3D g_slist_prepend(hidden, &cd);
+	}
+
+	for (i =3D 0; i < 4; i++)
+		property_append_cf_conditions(&dict, (status &&
+				i !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) ?
+				hidden : cf->cf_conditions[i],
+				BEARER_CLASS_VOICE,
+				cf_type_lut[i]);
+
+	if (status =3D=3D TRUE)
+		g_slist_free(hidden);
+
 	ofono_dbus_dict_append(&dict, "ForwardingFlagOnSim", DBUS_TYPE_BOOLEAN,
 					&status);
 =

@@ -552,6 +569,13 @@ static void get_query_cf_callback(const struct ofono_e=
rror *error, int total,
 			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
 	}
 =

+	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf, NULL) =3D=3D TRUE) {
+		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
+		__ofono_dbus_pending_reply(&cf->pending, reply);
+		return;
+	}
+
 	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
 		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
 		__ofono_dbus_pending_reply(&cf->pending, reply);
@@ -575,7 +599,8 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CACHED) ||
-			ofono_modem_get_online(modem) =3D=3D FALSE)
+			ofono_modem_get_online(modem) =3D=3D FALSE ||
+			is_cfu_enabled(cf, NULL) =3D=3D TRUE)
 		return cf_get_properties_reply(msg, cf);
 =

 	if (cf->driver->query =3D=3D NULL)
@@ -698,6 +723,15 @@ static void set_property_callback(const struct ofono_e=
rror *error, void *data)
 		return;
 	}
 =

+	if (cf->query_next !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf, NULL) =3D=3D TRUE) {
+		DBusMessage *reply;
+		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
+		reply =3D dbus_message_new_method_return(cf->pending);
+		__ofono_dbus_pending_reply(&cf->pending, reply);
+		return;
+	}
+
 	/* Successfully set, query the entire set just in case */
 	set_query_next_cf_cond(cf);
 }
-- =

1.7.1


--===============4478244811358197362==--

