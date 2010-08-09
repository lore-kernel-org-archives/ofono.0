Content-Type: multipart/mixed; boundary="===============3990346810244922589=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH resend 2/3] voicecall: Add support for function hangup_all
Date: Mon, 09 Aug 2010 23:18:38 +0200
Message-ID: <1281388719-11781-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281388719-11781-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3990346810244922589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch fixes problem for modems that cannot terminate DIALING/ALERTING
calls with CHUP=3D1X. The main change is that voicecall-callback function
hangup is split into the functions hangup_all and hangup_active.

Changes:
o In cases where hangup previously was used, hangup_all is used if implemen=
ted
  otherwise hangup_active is used.
o Call in state DIALING/ALERTING is released with hangup_active if implemen=
ted.
o manager_hangup_all will simply call hangup_all if implemented.
o manager_hangup_all will release calls in state ALERTING/DIALING/INCOMING
  using hangup_active otherwise release_specific.
---
 include/voicecall.h |    2 +
 src/voicecall.c     |   56 +++++++++++++++++++++++++++++++++++++++--------=
---
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 998c02d..2356fcf 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -69,6 +69,8 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*hangup_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
+	void (*hangup_all)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
 	void (*hold_all_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	void (*release_all_held)(struct ofono_voicecall *vc,
diff --git a/src/voicecall.c b/src/voicecall.c
index a30aaa5..49b9c79 100644
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
@@ -286,12 +289,18 @@ static DBusMessage *voicecall_hangup(DBusConnection *=
conn,
 =

 	num_calls =3D g_slist_length(vc->call_list);
 =

-	if (num_calls =3D=3D 1 && vc->driver->hangup &&
+	if (num_calls =3D=3D 1 &&
 			(call->status =3D=3D CALL_STATUS_ACTIVE ||
 				call->status =3D=3D CALL_STATUS_DIALING ||
-				call->status =3D=3D CALL_STATUS_ALERTING)) {
+				call->status =3D=3D CALL_STATUS_ALERTING) &&
+				(vc->driver->hangup_all !=3D NULL ||
+					vc->driver->hangup_active !=3D NULL)) {
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
@@ -304,6 +313,15 @@ static DBusMessage *voicecall_hangup(DBusConnection *c=
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

@@ -762,7 +780,14 @@ static void voicecalls_release_next(struct ofono_voice=
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

@@ -1119,7 +1144,9 @@ static DBusMessage *manager_hangup_all(DBusConnection=
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
@@ -1131,9 +1158,12 @@ static DBusMessage *manager_hangup_all(DBusConnectio=
n *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	voicecalls_release_queue(vc, vc->call_list);
-	voicecalls_release_next(vc);
-
+	if (vc->driver->hangup_all !=3D NULL)
+		vc->driver->hangup_all(vc, generic_callback, vc);
+	else {
+		voicecalls_release_queue(vc, vc->call_list);
+		voicecalls_release_next(vc);
+	}
 	return NULL;
 }
 =

-- =

1.6.3.3


--===============3990346810244922589==--

