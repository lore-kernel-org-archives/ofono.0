Content-Type: multipart/mixed; boundary="===============0822866558682519718=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 6/8] Add prototype to watch voicecall
Date: Tue, 13 Apr 2010 22:18:17 +0800
Message-ID: <1271168299-4862-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0822866558682519718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h     |    4 +++
 src/voicecall.c |   33 +++++++++++++++++++++++
 3 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e21d826..4b4591f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -42,8 +42,24 @@ struct ofono_emulator {
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct ofono_atom *voicecall;		/* emulated voicecall atom */
+	GSList *calls;
+	int call_watch;
 };
 =

+static gint call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *ca =3D a;
+	const struct ofono_call *cb =3D b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
 /* steal from plugins/hfp.c */
 static int send_method_call_with_reply(const char *dest, const char *path,
 				const char *interface, const char *method,
@@ -141,6 +157,62 @@ gboolean ofono_emulator_dial(struct ofono_emulator *em=
ulator,
 	return TRUE;
 }
 =

+static GSList *parse_call_list(GSList *calls)
+{
+	GSList *new_calls =3D NULL;
+	GSList *l =3D NULL;
+	struct ofono_call *c;
+	struct ofono_call *nc;
+
+	for (l =3D calls; l; l =3D l->next) {
+		c =3D l->data;
+
+		nc =3D g_try_new0(struct ofono_call, 1);
+		if (!nc)
+			break;
+
+		memcpy(nc, c, sizeof(struct ofono_call));
+
+		new_calls =3D g_slist_insert_sorted(new_calls, nc, call_compare);
+	}
+
+	return new_calls;
+}
+
+static void voicecall_call_watch(GSList *calls, void *user_data)
+{
+	struct ofono_emulator *emulator =3D user_data;
+	GSList *new_calls, *n, *o;
+	struct ofono_call *nc, *oc;
+
+	new_calls =3D parse_call_list(calls);
+	n =3D new_calls;
+	o =3D emulator->calls;
+
+	while (n || o) {
+		nc =3D n ? n->data : NULL;
+		oc =3D o ? o->data : NULL;
+
+		if (oc && (!nc || (nc->id > oc->id))) {
+			/* a call is released */
+			o =3D o->next;
+		} else if (nc && (!oc || (nc->id < oc->id))) {
+			if (emulator->driver->notify_call)
+				emulator->driver->notify_call(emulator, nc);
+
+			n =3D n->next;
+		} else {
+			n =3D n->next;
+			o =3D o->next;
+		}
+	}
+
+	g_slist_foreach(emulator->calls, (GFunc) g_free, NULL);
+	g_slist_free(emulator->calls);
+
+	emulator->calls =3D new_calls;
+}
+
 static void ofono_emulator_watch_voicecall(struct ofono_emulator *emulator)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(emulator->atom);
@@ -149,6 +221,11 @@ static void ofono_emulator_watch_voicecall(struct ofon=
o_emulator *emulator)
 	voicecall =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL);
 =

 	emulator->voicecall =3D voicecall;
+	emulator->call_watch =3D __ofono_atom_add_signal_watch(voicecall,
+					OFONO_SIGNAL_TYPE_VOICECALL_STATUS,
+					(ofono_signal_watch_func)
+						voicecall_call_watch,
+					emulator, NULL);
 }
 =

 static DBusMessage *emulator_get_properties(DBusConnection *conn,
diff --git a/src/ofono.h b/src/ofono.h
index 118406d..54c0a7b 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -125,6 +125,7 @@ enum ofono_atom_watch_condition {
 enum ofono_signal_type {
 	OFONO_SIGNAL_TYPE_NETREG_STATUS =3D 0,
 	OFONO_SIGNAL_TYPE_SIM_READY =3D 1,
+	OFONO_SIGNAL_TYPE_VOICECALL_STATUS =3D 2,
 };
 =

 typedef void (*ofono_atom_watch_func)(struct ofono_atom *atom,
@@ -189,6 +190,9 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/phonebook.h>
 #include <ofono/sms.h>
 #include <ofono/voicecall.h>
+
+typedef void (*ofono_voicecall_status_notify_cb_t)(GSList *calls, void *da=
ta);
+
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
diff --git a/src/voicecall.c b/src/voicecall.c
index 8bf6379..a80678a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -682,6 +682,37 @@ static gboolean voicecalls_have_incoming(struct ofono_=
voicecall *vc)
 	return voicecalls_have_with_status(vc, CALL_STATUS_INCOMING);
 }
 =

+static void notify_call_watches(struct ofono_voicecall *vc)
+{
+	struct ofono_watchlist_item *item;
+	GSList *calls =3D NULL;
+	GSList *call_watches;
+	GSList *l;
+	struct voicecall *v;
+	ofono_voicecall_status_notify_cb_t notify;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+
+		calls =3D g_slist_prepend(calls, v->call);
+	}
+
+	if (calls)
+		calls =3D g_slist_reverse(calls);
+
+	call_watches =3D __ofono_atom_get_signal_watches(vc->atom,
+					OFONO_SIGNAL_TYPE_VOICECALL_STATUS);
+
+	for (l =3D call_watches; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(calls, item->notify_data);
+	}
+
+	g_slist_free(calls);
+}
+
 static gboolean real_emit_call_list_changed(void *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -700,6 +731,8 @@ static gboolean real_emit_call_list_changed(void *data)
 =

 	vc->emit_calls_source =3D 0;
 =

+	notify_call_watches(vc);
+
 	return FALSE;
 }
 =

-- =

1.6.6.1


--===============0822866558682519718==--

