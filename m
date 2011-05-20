Content-Type: multipart/mixed; boundary="===============3446226605682883628=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V2 1/4] voicecall: create generic dial function
Date: Fri, 20 May 2011 11:40:58 +0200
Message-ID: <1305884461-4476-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1305884461-4476-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3446226605682883628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

split manager_dial between generic and dbus parts
---
 src/voicecall.c |   91 ++++++++++++++++++++++++++++++++++++++-------------=
---
 1 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 2ab67ac..7dbb311 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1437,59 +1437,96 @@ static void manager_dial_callback(const struct ofon=
o_error *error, void *data)
 		voicecalls_emit_call_added(vc, v);
 }
 =

-static DBusMessage *manager_dial(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static int voicecall_dial(struct ofono_voicecall *vc, const char *number,
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
+		return -EPERM;
 =

 	if (!valid_long_phone_number_format(number))
-		return __ofono_error_invalid_format(msg);
-
-	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
-		return __ofono_error_invalid_format(msg);
+		return -EINVAL;
 =

 	if (ofono_modem_get_online(modem) =3D=3D FALSE)
-		return __ofono_error_not_available(msg);
+		return -ENETDOWN;
 =

 	if (vc->driver->dial =3D=3D NULL)
-		return __ofono_error_not_implemented(msg);
+		return -ENOTSUP;
 =

 	if (voicecalls_have_incoming(vc))
-		return __ofono_error_failed(msg);
+		return -EBUSY;
 =

 	/* We can't have two dialing/alerting calls, reject outright */
 	if (voicecalls_num_connecting(vc) > 0)
-		return __ofono_error_failed(msg);
+		return -EBUSY;
 =

 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
-		return __ofono_error_failed(msg);
+		return -EBUSY;
 =

 	if (is_emergency_number(vc, number) =3D=3D TRUE)
 		__ofono_modem_inc_emergency_mode(modem);
 =

+	string_to_phone_number(number, &ph);
+
+	vc->driver->dial(vc, &ph, clir, cb, vc);
+
+	return 0;
+}
+
+static DBusMessage *manager_dial(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	const char *number;
+	const char *clirstr;
+	enum ofono_clir_option clir;
+	int err;
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
+	case 0:
+		break;
+
+	case -EINVAL:
+		reply =3D __ofono_error_invalid_format(msg);
+		break;
 =

-	vc->driver->dial(vc, &ph, clir, manager_dial_callback, vc);
+	case -ENETDOWN:
+		reply =3D __ofono_error_not_available(msg);
+		break;
 =

-	return NULL;
+	case -ENOTSUP:
+		reply =3D __ofono_error_not_implemented(msg);
+		break;
+
+	default:
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


--===============3446226605682883628==--

