Content-Type: multipart/mixed; boundary="===============1136384107652487775=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] voicecall: create generic dial function
Date: Thu, 12 May 2011 16:40:55 +0200
Message-ID: <1305211258-8189-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1305211258-8189-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1136384107652487775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

split manager_dial between generic and dbus parts
---
 src/voicecall.c |  106 +++++++++++++++++++++++++++++++++++++++++----------=
----
 1 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d46f463..037caac 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -42,6 +42,17 @@
 =

 #define VOICECALL_FLAG_SIM_ECC_READY 0x1
 =

+enum dial_error {
+	DIAL_NO_ERROR,
+	DIAL_TOO_MANY_CALLS,
+	DIAL_INVALID_PHONE,
+	DIAL_NO_NETWORK,
+	DIAL_NOT_SUPPORTED,
+	DIAL_INCOMING,
+	DIAL_BUSY,
+	DIAL_ACTIVE
+};
+
 GSList *g_drivers =3D NULL;
 =

 struct multi_release {
@@ -1437,59 +1448,100 @@ static void manager_dial_callback(const struct ofo=
no_error *error, void *data)
 		voicecalls_emit_call_added(vc, v);
 }
 =

-static DBusMessage *manager_dial(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static enum dial_error voicecall_dial(struct ofono_voicecall *vc,
+					const char *number,
+					enum ofono_clir_option clir,
+					ofono_voicecall_cb_t cb, void *data)
 {
-	struct ofono_voicecall *vc =3D data;
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
-	const char *number;
 	struct ofono_phone_number ph;
-	const char *clirstr;
-	enum ofono_clir_option clir;
-
-	if (vc->pending)
-		return __ofono_error_busy(msg);
 =

 	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
-		return __ofono_error_failed(msg);
-
-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-					DBUS_TYPE_STRING, &clirstr,
-					DBUS_TYPE_INVALID) =3D=3D FALSE)
-		return __ofono_error_invalid_args(msg);
+		return DIAL_TOO_MANY_CALLS;
 =

 	if (!valid_long_phone_number_format(number))
-		return __ofono_error_invalid_format(msg);
-
-	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
-		return __ofono_error_invalid_format(msg);
+		return DIAL_INVALID_PHONE;
 =

 	if (ofono_modem_get_online(modem) =3D=3D FALSE)
-		return __ofono_error_not_available(msg);
+		return DIAL_NO_NETWORK;
 =

 	if (vc->driver->dial =3D=3D NULL)
-		return __ofono_error_not_implemented(msg);
+		return DIAL_NOT_SUPPORTED;
 =

 	if (voicecalls_have_incoming(vc))
-		return __ofono_error_failed(msg);
+		return DIAL_INCOMING;
 =

 	/* We can't have two dialing/alerting calls, reject outright */
 	if (voicecalls_num_connecting(vc) > 0)
-		return __ofono_error_failed(msg);
+		return DIAL_BUSY;
 =

 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
-		return __ofono_error_failed(msg);
+		return DIAL_ACTIVE;
 =

 	if (is_emergency_number(vc, number) =3D=3D TRUE)
 		__ofono_modem_inc_emergency_mode(modem);
 =

+	string_to_phone_number(number, &ph);
+
+	vc->driver->dial(vc, &ph, clir, cb, vc);
+
+	return DIAL_NO_ERROR;
+}
+
+static DBusMessage *manager_dial(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	const char *number;
+	const char *clirstr;
+	enum ofono_clir_option clir;
+	enum dial_error err;
+	DBusMessage *reply =3D NULL;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_STRING, &clirstr,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
 	vc->pending =3D dbus_message_ref(msg);
 =

-	string_to_phone_number(number, &ph);
+	err =3D voicecall_dial(vc, number, clir, manager_dial_callback, vc);
+	switch (err) {
+	case DIAL_NO_ERROR:
+		break;
+
+	case DIAL_INVALID_PHONE:
+		reply =3D __ofono_error_invalid_format(msg);
+		break;
 =

-	vc->driver->dial(vc, &ph, clir, manager_dial_callback, vc);
+	case DIAL_NO_NETWORK:
+		reply =3D __ofono_error_not_available(msg);
+		break;
 =

-	return NULL;
+	case DIAL_NOT_SUPPORTED:
+		reply =3D __ofono_error_not_implemented(msg);
+		break;
+
+	case DIAL_TOO_MANY_CALLS:
+	case DIAL_INCOMING:
+	case DIAL_BUSY:
+	case DIAL_ACTIVE:
+		reply =3D __ofono_error_failed(msg);
+		break;
+	}
+
+	if (reply !=3D NULL) {
+		dbus_message_unref(msg);
+		vc->pending =3D NULL;
+	}
+
+	return reply;
 }
 =

 static DBusMessage *manager_transfer(DBusConnection *conn,
-- =

1.7.1


--===============1136384107652487775==--

