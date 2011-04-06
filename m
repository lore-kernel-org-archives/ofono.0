Content-Type: multipart/mixed; boundary="===============4653135257428959296=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 2/4] voicecall: refactor emergency number list handling
Date: Wed, 06 Apr 2011 07:26:41 -0700
Message-ID: <1302100003-5488-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1302100003-5488-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4653135257428959296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |  143 ++++++++++++++++++++++++++++-----------------------=
----
 1 files changed, 72 insertions(+), 71 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 469b939..b0f15fd 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -46,8 +46,9 @@ struct ofono_voicecall {
 	GSList *call_list;
 	GSList *release_list;
 	GSList *multiparty_list;
-	GSList *en_list;  /* emergency number list */
-	GSList *new_en_list; /* Emergency numbers being read from SIM */
+	GHashTable *en_list; /* emergency number list */
+	GSList *sim_en_list; /* Emergency numbers being read from SIM */
+	ofono_bool_t sim_en_list_ready;
 	DBusMessage *pending;
 	struct ofono_sim *sim;
 	struct ofono_sim_context *sim_context;
@@ -130,11 +131,12 @@ static gint call_compare(gconstpointer a, gconstpoint=
er b)
 	return 0;
 }
 =

-static void add_to_en_list(GSList **l, const char **list)
+static void add_to_en_list(struct ofono_voicecall *vc, char **list)
 {
 	int i =3D 0;
+
 	while (list[i])
-		*l =3D g_slist_prepend(*l, g_strdup(list[i++]));
+		g_hash_table_insert(vc->en_list, g_strdup(list[i++]), NULL);
 }
 =

 static const char *disconnect_reason_to_string(enum ofono_disconnect_reaso=
n r)
@@ -331,17 +333,10 @@ static void tone_request_finish(struct ofono_voicecal=
l *vc,
 	g_free(entry);
 }
 =

-static gint number_compare(gconstpointer a, gconstpointer b)
-{
-	const char *s1 =3D a, *s2 =3D b;
-	return strcmp(s1, s2);
-}
-
 static gboolean is_emergency_number(struct ofono_voicecall *vc,
 					const char *number)
 {
-	return g_slist_find_custom(vc->en_list, number,
-						number_compare) ? TRUE : FALSE;
+	return g_hash_table_lookup_extended(vc->en_list, number, NULL, NULL);
 }
 =

 static void append_voicecall_properties(struct voicecall *v,
@@ -1120,9 +1115,10 @@ static DBusMessage *manager_get_properties(DBusConne=
ction *conn,
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	int i;
-	GSList *l;
+	int i =3D 0;
 	char **list;
+	GHashTableIter ht_iter;
+	gpointer key, value;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -1135,14 +1131,16 @@ static DBusMessage *manager_get_properties(DBusConn=
ection *conn,
 					&dict);
 =

 	/* property EmergencyNumbers */
-	list =3D g_new0(char *, g_slist_length(vc->en_list) + 1);
+	list =3D g_new0(char *, g_hash_table_size(vc->en_list) + 1);
+
+	g_hash_table_iter_init(&ht_iter, vc->en_list);
 =

-	for (i =3D 0, l =3D vc->en_list; l; l =3D l->next, i++)
-		list[i] =3D g_strdup(l->data);
+	while (g_hash_table_iter_next(&ht_iter, &key, &value))
+		list[i++] =3D key;
 =

 	ofono_dbus_dict_append_array(&dict, "EmergencyNumbers",
 					DBUS_TYPE_STRING, &list);
-	g_strfreev(list);
+	g_free(list);
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

@@ -2068,46 +2066,43 @@ static void emit_en_list_changed(struct ofono_voice=
call *vc)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(vc->atom);
 	char **list;
-	GSList *l;
-	int i;
+	int i =3D 0;
+	GHashTableIter iter;
+	gpointer key, value;
 =

-	list =3D g_new0(char *, g_slist_length(vc->en_list) + 1);
-	for (i =3D 0, l =3D vc->en_list; l; l =3D l->next, i++)
-		list[i] =3D g_strdup(l->data);
+	list =3D g_new0(char *, g_hash_table_size(vc->en_list) + 1);
+
+	g_hash_table_iter_init(&iter, vc->en_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value))
+		list[i++] =3D key;
 =

 	ofono_dbus_signal_array_property_changed(conn, path,
 				OFONO_VOICECALL_MANAGER_INTERFACE,
 				"EmergencyNumbers", DBUS_TYPE_STRING, &list);
 =

-	g_strfreev(list);
+	g_free(list);
 }
 =

 static void set_new_ecc(struct ofono_voicecall *vc)
 {
-	int i =3D 0;
-
-	g_slist_foreach(vc->en_list, (GFunc) g_free, NULL);
-	g_slist_free(vc->en_list);
-	vc->en_list =3D NULL;
-
-	vc->en_list =3D vc->new_en_list;
-	vc->new_en_list =3D NULL;
+	GSList *l;
 =

-	while (default_en_list[i]) {
-		GSList *l;
+	g_hash_table_destroy(vc->en_list);
 =

-		for (l =3D vc->en_list; l; l =3D l->next)
-			if (!strcmp(l->data, default_en_list[i]))
-				break;
+	vc->en_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, NULL);
 =

-		if (l =3D=3D NULL)
-			vc->en_list =3D g_slist_prepend(vc->en_list,
-						g_strdup(default_en_list[i]));
-
-		i++;
+	/* Emergency numbers read from SIM */
+	if (vc->sim_en_list_ready =3D=3D TRUE && vc->sim_en_list) {
+		for (l =3D vc->sim_en_list; l; l =3D l->next)
+			g_hash_table_insert(vc->en_list, g_strdup(l->data),
+							NULL);
 	}
 =

-	vc->en_list =3D g_slist_reverse(vc->en_list);
+	/* Default emergency numbers */
+	add_to_en_list(vc, (char **) default_en_list);
+
 	emit_en_list_changed(vc);
 }
 =

@@ -2134,10 +2129,12 @@ static void ecc_g2_read_cb(int ok, int total_length=
, int record,
 		data +=3D 3;
 =

 		if (en[0] !=3D '\0')
-			vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
+			vc->sim_en_list =3D g_slist_prepend(vc->sim_en_list,
 								g_strdup(en));
 	}
 =

+	vc->sim_en_list =3D g_slist_reverse(vc->sim_en_list);
+	vc->sim_en_list_ready =3D TRUE;
 	set_new_ecc(vc);
 }
 =

@@ -2163,16 +2160,18 @@ static void ecc_g3_read_cb(int ok, int total_length=
, int record,
 	extract_bcd_number(data, 3, en);
 =

 	if (en[0] !=3D '\0')
-		vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
+		vc->sim_en_list =3D g_slist_prepend(vc->sim_en_list,
 							g_strdup(en));
 =

 	if (record !=3D total)
 		return;
 =

 check:
-	if (!ok && vc->new_en_list =3D=3D NULL)
+	if (!ok && vc->sim_en_list =3D=3D NULL)
 		return;
 =

+	vc->sim_en_list =3D g_slist_reverse(vc->sim_en_list);
+	vc->sim_en_list_ready =3D TRUE;
 	set_new_ecc(vc);
 }
 =

@@ -2203,11 +2202,27 @@ static void voicecall_unregister(struct ofono_atom =
*atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	if (vc->sim_state_watch) {
+		ofono_sim_remove_state_watch(vc->sim, vc->sim_state_watch);
+		vc->sim_state_watch =3D 0;
+	}
+
 	if (vc->sim_watch) {
 		__ofono_modem_remove_atom_watch(modem, vc->sim_watch);
 		vc->sim_watch =3D 0;
 	}
 =

+	vc->sim =3D NULL;
+
+	if (vc->sim_en_list) {
+		g_slist_foreach(vc->sim_en_list, (GFunc) g_free, NULL);
+		g_slist_free(vc->sim_en_list);
+		vc->sim_en_list =3D NULL;
+	}
+
+	g_hash_table_destroy(vc->en_list);
+	vc->en_list =3D NULL;
+
 	if (vc->dial_req)
 		dial_request_finish(vc);
 =

@@ -2234,24 +2249,6 @@ static void voicecall_remove(struct ofono_atom *atom)
 	if (vc->driver && vc->driver->remove)
 		vc->driver->remove(vc);
 =

-	if (vc->en_list) {
-		g_slist_foreach(vc->en_list, (GFunc) g_free, NULL);
-		g_slist_free(vc->en_list);
-		vc->en_list =3D NULL;
-	}
-
-	if (vc->new_en_list) {
-		g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
-		g_slist_free(vc->new_en_list);
-		vc->new_en_list =3D NULL;
-	}
-
-	if (vc->sim_state_watch) {
-		ofono_sim_remove_state_watch(vc->sim, vc->sim_state_watch);
-		vc->sim_state_watch =3D 0;
-		vc->sim =3D NULL;
-	}
-
 	if (vc->tone_source) {
 		g_source_remove(vc->tone_source);
 		vc->tone_source =3D 0;
@@ -2345,14 +2342,15 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
 		 * Free the currently being read EN list, just in case the
 		 * SIM is removed when we're still reading them
 		 */
-		if (vc->new_en_list) {
-			g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
-			g_slist_free(vc->new_en_list);
-			vc->new_en_list =3D NULL;
+		if (vc->sim_en_list) {
+			g_slist_foreach(vc->sim_en_list, (GFunc) g_free, NULL);
+			g_slist_free(vc->sim_en_list);
+			vc->sim_en_list =3D NULL;
 		}
 =

-		add_to_en_list(&vc->new_en_list, default_en_list_no_sim);
+		vc->sim_en_list_ready =3D FALSE;
 		set_new_ecc(vc);
+		add_to_en_list(vc, (char **) default_en_list_no_sim);
 	default:
 		break;
 	}
@@ -2396,12 +2394,15 @@ void ofono_voicecall_register(struct ofono_voicecal=
l *vc)
 =

 	ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
 =

+	vc->en_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, NULL);
+
 	/*
 	 * Start out with the 22.101 mandated numbers, if we have a SIM and
 	 * the SIM contains EFecc, then we update the list once we've read them
 	 */
-	add_to_en_list(&vc->en_list, default_en_list_no_sim);
-	add_to_en_list(&vc->en_list, default_en_list);
+	add_to_en_list(vc, (char **) default_en_list_no_sim);
+	add_to_en_list(vc, (char **) default_en_list);
 =

 	vc->sim_watch =3D __ofono_modem_add_atom_watch(modem,
 						OFONO_ATOM_TYPE_SIM,
-- =

1.7.0.4


--===============4653135257428959296==--

