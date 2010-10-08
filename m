Content-Type: multipart/mixed; boundary="===============0180098161909768052=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC ssn PATCH 2/4] ssn: add ssn code argument to ssn notify callbacks
Date: Fri, 08 Oct 2010 18:36:38 +0300
Message-ID: <1286552200-18282-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286552200-18282-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0180098161909768052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Including the ssn code as an argument in notify callbacks allows
handling of multiple notifications in single function.
---
 src/call-barring.c |   33 +++++++++++----------------------
 src/ofono.h        |    4 ++--
 src/ssn.c          |    8 ++++++--
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 7a17479..e2de404 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -993,33 +993,22 @@ static GDBusSignalTable cb_signals[] =3D {
 	{ }
 };
 =

-static void call_barring_incoming_enabled_notify(int idx, void *userdata)
+static void call_barring_notify(int code, int idx, void *userdata)
 {
 	struct ofono_call_barring *cb =3D userdata;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cb->atom);
+	char const *member;
 =

-	g_dbus_emit_signal(conn, path, OFONO_CALL_BARRING_INTERFACE,
-			"IncomingBarringInEffect", DBUS_TYPE_INVALID);
-}
-
-static void call_barring_outgoing_enabled_notify(int idx, void *userdata)
-{
-	struct ofono_call_barring *cb =3D userdata;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(cb->atom);
-	DBusMessage *signal;
-
-	signal =3D dbus_message_new_signal(path, OFONO_CALL_BARRING_INTERFACE,
-						"OutgoingBarringInEffect");
-
-	if (!signal) {
-		ofono_error("Unable to allocate new %s.OutgoingBarringInEffect"
-				" signal", OFONO_CALL_BARRING_INTERFACE);
+	if (code =3D=3D OFONO_SS_MO_INCOMING_BARRING)
+		member =3D "IncomingBarringInEffect";
+	else if (code =3D=3D OFONO_SS_MO_OUTGOING_BARRING)
+		member =3D "OutgoingBarringInEffect";
+	else
 		return;
-	}
 =

-	g_dbus_send_message(conn, signal);
+	g_dbus_emit_signal(conn, path, OFONO_CALL_BARRING_INTERFACE,
+				member, DBUS_TYPE_INVALID);
 }
 =

 int ofono_call_barring_driver_register(const struct ofono_call_barring_dri=
ver *d)
@@ -1132,11 +1121,11 @@ static void ssn_watch(struct ofono_atom *atom,
 =

 	cb->incoming_bar_watch =3D
 		__ofono_ssn_mo_watch_add(cb->ssn, OFONO_SS_MO_INCOMING_BARRING,
-				call_barring_incoming_enabled_notify, cb, NULL);
+				call_barring_notify, cb, NULL);
 =

 	cb->outgoing_bar_watch =3D
 		__ofono_ssn_mo_watch_add(cb->ssn, OFONO_SS_MO_OUTGOING_BARRING,
-				call_barring_outgoing_enabled_notify, cb, NULL);
+				call_barring_notify, cb, NULL);
 }
 =

 static void ussd_watch(struct ofono_atom *atom,
diff --git a/src/ofono.h b/src/ofono.h
index 6c7f649..1cbc935 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -243,8 +243,8 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, co=
nst struct cbs *msg);
 =

 #include <ofono/ssn.h>
 =

-typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
-typedef void (*ofono_ssn_mt_notify_cb)(int index,
+typedef void (*ofono_ssn_mo_notify_cb)(int index, int mo_code, void *user);
+typedef void (*ofono_ssn_mt_notify_cb)(int index, int mt_code,
 					const struct ofono_phone_number *ph,
 					void *user);
 =

diff --git a/src/ssn.c b/src/ssn.c
index b886dba..8a4ad70 100644
--- a/src/ssn.c
+++ b/src/ssn.c
@@ -118,12 +118,14 @@ void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int=
 code1, int index)
 	GSList *l;
 	ofono_ssn_mo_notify_cb notify;
 =

+	DBG("ssn %p, code %u, index %u", (void *)ssn, code1, index);
+
 	for (l =3D ssn->mo_handler_list->items; l; l =3D l->next) {
 		h =3D l->data;
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code1)
-			notify(index, h->item.notify_data);
+			notify(index, code1, h->item.notify_data);
 	}
 }
 =

@@ -134,12 +136,14 @@ void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int=
 code2, int index,
 	GSList *l;
 	ofono_ssn_mt_notify_cb notify;
 =

+	DBG("ssn %p, code %u, index %u", (void *)ssn, code2, index);
+
 	for (l =3D ssn->mt_handler_list->items; l; l =3D l->next) {
 		h =3D l->data;
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code2)
-			notify(index, ph, h->item.notify_data);
+			notify(index, code2, ph, h->item.notify_data);
 	}
 }
 =

-- =

1.7.0.4


--===============0180098161909768052==--

