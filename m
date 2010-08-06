Content-Type: multipart/mixed; boundary="===============0106744437016037507=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFCv2] STE-driver: Terminating voice call in state DIALING/ALERTING.
Date: Fri, 06 Aug 2010 14:59:20 +0200
Message-ID: <1281099560-2289-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <4C5B0EA5.80806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0106744437016037507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch fixes problem with terminating calls in state DIALING/ALERTING
for STE-modem. The main change is that voicecall-callback function
hangup is split into the functions hangup_all and hangup_active.

CHANGES:
include/voicecall.h:
o hangup is replaced with hangup_active and hangup_all.
o As a tmp hack to provide backwards portability
  the previous hangup is defined to hangup_all

drivers/atmodem/voicecall.c:
o hangup_all uses ATH
o hangup_active uses CHUP

drivers/stemodem/voicecall.c:
o hangup_active uses CHUP while hangup_all is not implemented.

src/voicecall.c:
o In cases where hangup previously was used, hangup_all is used if implemen=
ted
  otherwise hangup_active is used.
o Call in state DIALING/ALERTING is released with hangup_active if implemen=
ted.
o manager_hangup_all will no longer release calls in state waiting.
o manager_hangup_all will simply call hangup_all if implemented.
o manager_hangup_all will release calls in state ALERTING/DIALING/INCOMING
  using hangup_active otherwise release_specific.
---
 drivers/atmodem/voicecall.c  |   14 ++++++--
 drivers/stemodem/voicecall.c |    4 +-
 include/voicecall.h          |    6 +++-
 src/voicecall.c              |   76 +++++++++++++++++++++++++++++++++-----=
---
 4 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index fce9144..80ce897 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -406,10 +406,17 @@ static void at_answer(struct ofono_voicecall *vc,
 	at_template("ATA", vc, generic_cb, 0, cb, data);
 }
 =

-static void at_hangup(struct ofono_voicecall *vc,
+static void at_hangup_all(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	/* Hangup all calls */
+	/* Hangup all calls, except waiting */
+	at_template("ATH", vc, generic_cb, 0x3f, cb, data);
+}
+
+static void at_hangup_active(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Hangup  currently active call */
 	at_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
 }
 =

@@ -874,7 +881,8 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D at_voicecall_remove,
 	.dial			=3D at_dial,
 	.answer			=3D at_answer,
-	.hangup			=3D at_hangup,
+	.hangup_active		=3D at_hangup_active,
+	.hangup_all		=3D at_hangup_all,
 	.hold_all_active	=3D at_hold_all_active,
 	.release_all_held	=3D at_release_all_held,
 	.set_udub		=3D at_set_udub,
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index a56709a..2ddae05 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -260,7 +260,7 @@ static void ste_answer(struct ofono_voicecall *vc,
 	ste_template("ATA", vc, ste_generic_cb, 0, cb, data);
 }
 =

-static void ste_hangup(struct ofono_voicecall *vc,
+static void ste_hangup_active(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	ste_template("AT+CHUP", vc, ste_generic_cb, 0x3f, cb, data);
@@ -569,7 +569,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D ste_voicecall_remove,
 	.dial			=3D ste_dial,
 	.answer			=3D ste_answer,
-	.hangup			=3D ste_hangup,
+	.hangup_active		=3D ste_hangup_active,
 	.hold_all_active	=3D ste_hold_all_active,
 	.release_all_held	=3D ste_release_all_held,
 	.set_udub		=3D ste_set_udub,
diff --git a/include/voicecall.h b/include/voicecall.h
index 6ceb3d8..d43954c 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -67,7 +67,11 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
-	void (*hangup)(struct ofono_voicecall *vc,
+/* HACK: for temporary backwards compatibility */
+#define hangup_all hangup
+	void (*hangup_all)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	void (*hangup_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	void (*hold_all_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
diff --git a/src/voicecall.c b/src/voicecall.c
index a30aaa5..6ba6bb7 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -261,15 +261,18 @@ static DBusMessage *voicecall_hangup(DBusConnection *=
conn,
 	if (vc->pending)
 		return __ofono_error_busy(msg);
 =

-	/* According to various specs, other than 27.007, +CHUP is used
-	 * to reject an incoming call
-	 */
 	if (call->status =3D=3D CALL_STATUS_INCOMING) {
-		if (vc->driver->hangup =3D=3D NULL)
+
+		if (vc->driver->hangup_all =3D=3D NULL &&
+				vc->driver->hangup_active =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
 =

 		vc->pending =3D dbus_message_ref(msg);
-		vc->driver->hangup(vc, generic_callback, vc);
+
+		if (vc->driver->hangup_all)
+			vc->driver->hangup_all(vc, generic_callback, vc);
+		else
+			vc->driver->hangup_active(vc, generic_callback, vc);
 =

 		return NULL;
 	}
@@ -286,12 +289,19 @@ static DBusMessage *voicecall_hangup(DBusConnection *=
conn,
 =

 	num_calls =3D g_slist_length(vc->call_list);
 =

-	if (num_calls =3D=3D 1 && vc->driver->hangup &&
+	if (num_calls =3D=3D 1 &&
+			(vc->driver->hangup_all !=3D NULL ||
+				vc->driver->hangup_active !=3D NULL) &&
 			(call->status =3D=3D CALL_STATUS_ACTIVE ||
 				call->status =3D=3D CALL_STATUS_DIALING ||
 				call->status =3D=3D CALL_STATUS_ALERTING)) {
+
 		vc->pending =3D dbus_message_ref(msg);
-		vc->driver->hangup(vc, generic_callback, vc);
+
+		if (vc->driver->hangup_all)
+			vc->driver->hangup_all(vc, generic_callback, vc);
+		else
+			vc->driver->hangup_active(vc, generic_callback, vc);
 =

 		return NULL;
 	}
@@ -304,6 +314,15 @@ static DBusMessage *voicecall_hangup(DBusConnection *c=
onn,
 		return NULL;
 	}
 =

+	if (vc->driver->hangup_active !=3D NULL &&
+		(call->status =3D=3D CALL_STATUS_ALERTING ||
+			call->status =3D=3D CALL_STATUS_DIALING)) {
+		vc->pending =3D dbus_message_ref(msg);
+		vc->driver->hangup_active(vc, generic_callback, vc);
+
+		return NULL;
+	}
+
 	if (vc->driver->release_specific =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

@@ -743,12 +762,18 @@ static void emit_multiparty_call_list_changed(struct =
ofono_voicecall *vc)
 static void voicecalls_release_queue(struct ofono_voicecall *vc, GSList *c=
alls)
 {
 	GSList *l;
+	struct voicecall *call;
 =

 	g_slist_free(vc->release_list);
 	vc->release_list =3D NULL;
 =

-	for (l =3D calls; l; l =3D l->next)
-		vc->release_list =3D g_slist_prepend(vc->release_list, l->data);
+	for (l =3D calls; l; l =3D l->next) {
+		call =3D l->data;
+
+		if (call->call->status !=3D CALL_STATUS_WAITING)
+			vc->release_list =3D
+				g_slist_prepend(vc->release_list, call);
+	}
 }
 =

 static void voicecalls_release_next(struct ofono_voicecall *vc)
@@ -762,7 +787,14 @@ static void voicecalls_release_next(struct ofono_voice=
call *vc)
 =

 	vc->release_list =3D g_slist_remove(vc->release_list, call);
 =

-	vc->driver->release_specific(vc, call->call->id,
+	if (vc->driver->hangup_active !=3D NULL &&
+			(call->call->status =3D=3D CALL_STATUS_ALERTING ||
+				call->call->status =3D=3D CALL_STATUS_DIALING ||
+				call->call->status =3D=3D CALL_STATUS_INCOMING))
+
+		vc->driver->hangup_active(vc, multirelease_callback, vc);
+	else
+		vc->driver->release_specific(vc, call->call->id,
 						multirelease_callback, vc);
 }
 =

@@ -1119,7 +1151,9 @@ static DBusMessage *manager_hangup_all(DBusConnection=
 *conn,
 	if (vc->pending)
 		return __ofono_error_busy(msg);
 =

-	if (!vc->driver->release_specific)
+	if (vc->driver->hangup_all =3D=3D NULL &&
+		(vc->driver->release_specific =3D=3D NULL ||
+			vc->driver->hangup_active =3D=3D NULL))
 		return __ofono_error_not_implemented(msg);
 =

 	if (vc->call_list =3D=3D NULL) {
@@ -1131,9 +1165,17 @@ static DBusMessage *manager_hangup_all(DBusConnectio=
n *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	voicecalls_release_queue(vc, vc->call_list);
-	voicecalls_release_next(vc);
+	if (vc->driver->hangup_all !=3D NULL)
+		vc->driver->hangup_all(vc, generic_callback, vc);
 =

+	/* In case of INCOMING call, assume we only have this one call */
+	else if (voicecalls_have_incoming(vc) &&
+			vc->driver->hangup_active !=3D NULL)
+		vc->driver->hangup_active(vc, generic_callback, vc);
+	else {
+		voicecalls_release_queue(vc, vc->call_list);
+		voicecalls_release_next(vc);
+	}
 	return NULL;
 }
 =

@@ -1370,8 +1412,12 @@ static DBusMessage *multiparty_hangup(DBusConnection=
 *conn,
 =

 	/* Fall back to the old-fashioned way */
 	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
-	voicecalls_release_queue(vc, vc->multiparty_list);
-	voicecalls_release_next(vc);
+	if (vc->driver->hangup_all !=3D NULL)
+		vc->driver->hangup_all(vc, generic_callback, vc);
+	else {
+		voicecalls_release_queue(vc, vc->call_list);
+		voicecalls_release_next(vc);
+	}
 =

 out:
 	return NULL;
-- =

1.6.3.3


--===============0106744437016037507==--

