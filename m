Content-Type: multipart/mixed; boundary="===============7400226546190063938=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/5] emulator: Add multi-sim support
Date: Mon, 02 Nov 2015 18:27:17 +0100
Message-ID: <1446485240-22049-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7400226546190063938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add multi-sim support in the emulator.
---
 src/emulator.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 241 insertions(+), 25 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index ccb26dc..d194aa5 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -50,8 +50,16 @@ struct hfp_codec_info {
 	ofono_bool_t supported;
 };
 =

-struct ofono_emulator {
+struct atom_callback {
 	struct ofono_atom *atom;
+	ofono_emulator_request_cb_t cb;
+	void *data;
+	ofono_destroy_func destroy;
+};
+
+struct ofono_emulator {
+	GSList *atoms;
+	struct ofono_atom *active_atom;
 	enum ofono_emulator_type type;
 	GAtServer *server;
 	GAtPPP *ppp;
@@ -68,6 +76,8 @@ struct ofono_emulator {
 	ofono_emulator_codec_negotiation_cb codec_negotiation_cb;
 	void *codec_negotiation_data;
 	ofono_bool_t bac_received;
+	/* Table of atom_callback, using prefixes as key */
+	GHashTable *prefixes;
 	bool slc : 1;
 	unsigned int events_mode : 2;
 	bool events_ind : 1;
@@ -355,9 +365,14 @@ static struct indicator *find_indicator(struct ofono_e=
mulator *em,
 static struct ofono_call *find_call_with_status(struct ofono_emulator *em,
 								int status)
 {
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(em->atom);
+	struct ofono_modem *modem;
 	struct ofono_voicecall *vc;
 =

+	if (em->active_atom =3D=3D NULL)
+		return NULL;
+
+	modem =3D __ofono_atom_get_modem(em->active_atom);
+
 	vc =3D __ofono_atom_find(OFONO_ATOM_TYPE_VOICECALL, modem);
 	if (vc =3D=3D NULL)
 		return NULL;
@@ -1148,12 +1163,35 @@ static void emulator_add_indicator(struct ofono_emu=
lator *em, const char* name,
 	em->indicators =3D g_slist_append(em->indicators, ind);
 }
 =

+static void free_atom_callback(gpointer data)
+{
+	struct atom_callback *atom_cb =3D data;
+
+	if (atom_cb->destroy)
+		atom_cb->destroy(atom_cb->data);
+
+	g_free(atom_cb);
+}
+
+static void atom_cbs_destroy(gpointer key, gpointer value, gpointer user_d=
ata)
+{
+	GSList *atom_cbs =3D value;
+
+	g_slist_free_full(atom_cbs, free_atom_callback);
+}
+
 static void emulator_unregister(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	GSList *l;
 =

-	DBG("%p", em);
+	DBG("%p %p", em, atom);
+
+	/* Do the clean up when this is the last remaining atom */
+	if (em->atoms !=3D NULL && em->atoms->next !=3D NULL)
+		return;
+
+	DBG("Last atom unregistering");
 =

 	if (em->callsetup_source) {
 		g_source_remove(em->callsetup_source);
@@ -1181,6 +1219,10 @@ static void emulator_unregister(struct ofono_atom *a=
tom)
 	g_at_server_unref(em->server);
 	em->server =3D NULL;
 =

+	g_hash_table_foreach(em->prefixes, atom_cbs_destroy, NULL);
+	g_hash_table_destroy(em->prefixes);
+	em->prefixes =3D NULL;
+
 	ofono_handsfree_card_remove(em->card);
 	em->card =3D NULL;
 }
@@ -1188,6 +1230,7 @@ static void emulator_unregister(struct ofono_atom *at=
om)
 void ofono_emulator_register(struct ofono_emulator *em, int fd)
 {
 	GIOChannel *io;
+	GSList *l;
 =

 	DBG("%p, %d", em, fd);
 =

@@ -1240,7 +1283,11 @@ void ofono_emulator_register(struct ofono_emulator *=
em, int fd)
 		g_at_server_register(em->server, "+BCS", bcs_cb, em, NULL);
 	}
 =

-	__ofono_atom_register(em->atom, emulator_unregister);
+	for (l =3D em->atoms; l; l =3D l->next) {
+		struct ofono_atom *atom =3D l->data;
+
+		__ofono_atom_register(atom, emulator_unregister);
+	}
 =

 	switch (em->type) {
 	case OFONO_EMULATOR_TYPE_DUN:
@@ -1260,18 +1307,23 @@ static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 =

-	DBG("atom: %p", atom);
+	DBG("em: %p, atom: %p", em, atom);
+
+	em->atoms =3D g_slist_remove(em->atoms, atom);
 =

+	if (em->atoms !=3D NULL)
+		return;
+
+	DBG("Removing emulator");
 	g_free(em);
 }
 =

-struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+struct ofono_emulator *ofono_emulator_create(GList *modems,
 						enum ofono_emulator_type type)
 {
 	struct ofono_emulator *em;
 	enum ofono_atom_type atom_t;
-
-	DBG("modem: %p, type: %d", modem, type);
+	GList *l;
 =

 	if (type =3D=3D OFONO_EMULATOR_TYPE_DUN)
 		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_DUN;
@@ -1296,15 +1348,39 @@ struct ofono_emulator *ofono_emulator_create(struct=
 ofono_modem *modem,
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
 =

-	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
+	em->prefixes =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+								g_free, NULL);
+
+	for (l =3D modems; l; l =3D l->next) {
+		struct ofono_atom *atom;
+		struct ofono_modem *modem =3D l->data;
+
+		DBG("modem: %p, type: %d", modem, type);
+
+		atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
+		em->atoms =3D g_slist_prepend(em->atoms, atom);
+	}
 =

 	return em;
 }
 =

+static void free_atom(gpointer data)
+{
+	struct ofono_atom *atom =3D data;
+
+	__ofono_atom_free(atom);
+}
+
 void ofono_emulator_remove(struct ofono_emulator *em)
 {
-	__ofono_atom_free(em->atom);
+	/*
+	 * emulator_remove removes the atom from the list and eventually removes
+	 * the emulator too, so we need to make this copy for a safe removal.
+	 */
+	GSList *atoms =3D g_slist_copy(em->atoms);
+
+	g_slist_free_full(atoms, free_atom);
 }
 =

 void ofono_emulator_send_final(struct ofono_emulator *em,
@@ -1371,10 +1447,37 @@ void ofono_emulator_send_info(struct ofono_emulator=
 *em, const char *line,
 	g_at_server_send_info(em->server, line, last);
 }
 =

+static struct ofono_atom *get_preferred_atom(struct ofono_emulator *em)
+{
+	if (em->active_atom)
+		return em->active_atom;
+
+	/*
+	 * TODO For the moment we just take the first on the list, we need to
+	 * ask the modem and have something configurable from settings.
+	 */
+	return em->atoms->data;
+}
+
+static struct atom_callback *find_atom_callback(GSList *prefix_cbs,
+						const struct ofono_atom *atom)
+{
+	GSList *l;
+
+	for (l =3D prefix_cbs; l; l =3D prefix_cbs->next) {
+		struct atom_callback *atom_cb =3D l->data;
+
+		if (atom_cb->atom !=3D atom)
+			continue;
+
+		return atom_cb;
+	}
+
+	return NULL;
+}
+
 struct handler {
-	ofono_emulator_request_cb_t cb;
-	void *data;
-	ofono_destroy_func destroy;
+	char *prefix;
 	struct ofono_emulator *em;
 };
 =

@@ -1386,8 +1489,19 @@ struct ofono_emulator_request {
 static void handler_proxy(GAtServer *server, GAtServerRequestType type,
 					GAtResult *result, gpointer userdata)
 {
+	GSList *prefix_cbs;
+	struct atom_callback *atom_cb;
 	struct handler *h =3D userdata;
 	struct ofono_emulator_request req;
+	struct ofono_atom *atom;
+
+	atom =3D get_preferred_atom(h->em);
+	prefix_cbs =3D g_hash_table_lookup(h->em->prefixes, h->prefix);
+	atom_cb =3D find_atom_callback(prefix_cbs, atom);
+	if (atom_cb =3D=3D NULL) {
+		ofono_error("%s: No atom for prefix %s", __func__, h->prefix);
+		return;
+	}
 =

 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
@@ -1406,7 +1520,7 @@ static void handler_proxy(GAtServer *server, GAtServe=
rRequestType type,
 	g_at_result_iter_init(&req.iter, result);
 	g_at_result_iter_next(&req.iter, "");
 =

-	h->cb(h->em, &req, h->data);
+	atom_cb->cb(h->em, &req, atom_cb->data);
 }
 =

 static void handler_proxy_need_slc(GAtServer *server,
@@ -1440,24 +1554,52 @@ static void handler_destroy(gpointer userdata)
 {
 	struct handler *h =3D userdata;
 =

-	if (h->destroy)
-		h->destroy(h->data);
-
+	g_free(h->prefix);
 	g_free(h);
 }
 =

-ofono_bool_t ofono_emulator_add_handler(struct ofono_emulator *em,
+ofono_bool_t ofono_emulator_add_handler(struct ofono_atom *atom,
 					const char *prefix,
 					ofono_emulator_request_cb_t cb,
 					void *data, ofono_destroy_func destroy)
 {
 	struct handler *h;
+	GSList *prefix_cbs;
+	struct atom_callback *atom_cb;
 	GAtServerNotifyFunc func =3D handler_proxy;
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	gboolean already_registered;
+
+	DBG("%p %s cb %p", atom, prefix, cb);
+
+	prefix_cbs =3D g_hash_table_lookup(em->prefixes, prefix);
+	already_registered =3D prefix_cbs ? TRUE : FALSE;
+
+	if (find_atom_callback(prefix_cbs, atom)) {
+		ofono_info("%s: Atom %p already registered for prefix %s",
+							__func__, atom, prefix);
+		return FALSE;
+	}
+
+	atom_cb =3D g_malloc0(sizeof(*atom_cb));
+	atom_cb->atom =3D atom;
+	atom_cb->cb =3D cb;
+	atom_cb->data =3D data;
+	atom_cb->destroy =3D destroy;
+
+	/*
+	 * Append to avoid modifying the head, which is the value in the hash
+	 * table. We refresh it for the case of the first insertion though.
+	 */
+	prefix_cbs =3D g_slist_append(prefix_cbs, atom_cb);
+
+	if (already_registered)
+		return TRUE;
+
+	g_hash_table_insert(em->prefixes, g_strdup(prefix), prefix_cbs);
 =

 	h =3D g_new0(struct handler, 1);
-	h->cb =3D cb;
-	h->data =3D data;
-	h->destroy =3D destroy;
+	h->prefix =3D g_strdup(prefix);
 	h->em =3D em;
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
@@ -1476,9 +1618,31 @@ ofono_bool_t ofono_emulator_add_handler(struct ofono=
_emulator *em,
 	return FALSE;
 }
 =

-ofono_bool_t ofono_emulator_remove_handler(struct ofono_emulator *em,
+ofono_bool_t ofono_emulator_remove_handler(struct ofono_atom *atom,
 						const char *prefix)
 {
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	GSList *prefix_cbs;
+	struct atom_callback *atom_cb;
+
+	prefix_cbs =3D g_hash_table_lookup(em->prefixes, prefix);
+	atom_cb =3D find_atom_callback(prefix_cbs, atom);
+
+	if (atom_cb =3D=3D NULL)
+		return FALSE;
+
+	prefix_cbs =3D g_slist_remove(prefix_cbs, atom_cb);
+
+	free_atom_callback(atom_cb);
+
+	if (prefix_cbs !=3D NULL) {
+		g_hash_table_replace(em->prefixes,
+						g_strdup(prefix), prefix_cbs);
+		return TRUE;
+	}
+
+	g_hash_table_remove(em->prefixes, prefix);
+
 	return g_at_server_unregister(em->server, prefix);
 }
 =

@@ -1507,8 +1671,38 @@ enum ofono_emulator_request_type ofono_emulator_requ=
est_get_type(
 	return req->type;
 }
 =

-void ofono_emulator_set_indicator(struct ofono_emulator *em,
-					const char *name, int value)
+static gboolean valid_indication(struct ofono_emulator *em,
+				struct ofono_atom *atom, const char *name)
+{
+	struct ofono_atom *preferred;
+
+	if (g_strcmp0(name, OFONO_EMULATOR_IND_BATTERY) =3D=3D 0)
+		return TRUE;
+
+	if (em->active_atom) {
+		if (em->active_atom =3D=3D atom)
+			return TRUE;
+		else
+			return FALSE;
+	} else if (g_strcmp0(name, OFONO_EMULATOR_IND_CALL) =3D=3D 0
+			|| g_strcmp0(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D 0) {
+		return TRUE;
+	}
+
+	/* Return FALSE if the modem is not the preferred one */
+	/*
+	 * TODO For the moment we just take the first on the list, we need to
+	 * ask the modem and have some configurable from settings.
+	 */
+	preferred =3D em->atoms->data;
+	if (preferred =3D=3D atom)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void ofono_emulator_set_indicator(struct ofono_atom *atom,
+						const char *name, int value)
 {
 	int i;
 	char buf[20];
@@ -1518,6 +1712,12 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 	gboolean call;
 	gboolean callsetup;
 	gboolean waiting;
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	if (!valid_indication(em, atom, name))
+		return;
+
+	DBG("%s\t%d", name, value);
 =

 	ind =3D find_indicator(em, name, &i);
 =

@@ -1533,6 +1733,18 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 	call =3D ind =3D=3D call_ind;
 	callsetup =3D ind =3D=3D cs_ind;
 =

+	if (call || callsetup) {
+		if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE
+				&& cs_ind->value =3D=3D
+					OFONO_EMULATOR_CALLSETUP_INACTIVE) {
+			DBG("Call finished for HFP atom %p", atom);
+			em->active_atom =3D NULL;
+		} else if (em->active_atom =3D=3D NULL) {
+			DBG("New call from HFP atom %p", atom);
+			em->active_atom =3D atom;
+		}
+	}
+
 	/*
 	 * When callsetup indicator goes to Incoming and there is an active
 	 * call a +CCWA should be sent before +CIEV
@@ -1586,12 +1798,16 @@ start_ring:
 							notify_ring, em);
 }
 =

-void __ofono_emulator_set_indicator_forced(struct ofono_emulator *em,
+void __ofono_emulator_set_indicator_forced(struct ofono_atom *atom,
 						const char *name, int value)
 {
 	int i;
 	struct indicator *ind;
 	char buf[20];
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	if (!valid_indication(em, atom, name))
+		return;
 =

 	ind =3D find_indicator(em, name, &i);
 =

-- =

2.1.4


--===============7400226546190063938==--

