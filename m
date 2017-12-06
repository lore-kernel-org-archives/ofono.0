Content-Type: multipart/mixed; boundary="===============0413744365055058275=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 5/7] voicecall.c : Add functionality to dial from a memory
 location.
Date: Wed, 06 Dec 2017 17:36:02 +0200
Message-ID: <20171206153604.15080-6-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0413744365055058275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now we can also dial favourites/quick contacts over bluetooth.

---
 src/voicecall.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index ed6ea83f..f35047f8 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1607,10 +1607,11 @@ error:
 					__ofono_error_failed(vc->pending));
 }
 =

-static int voicecall_dial_shortcut(struct ofono_voicecall *vc, enum ofono_=
clir_option clir,
-					ofono_voicecall_cb_t cb, void *data)
+static int voicecall_dial_shortcut(struct ofono_voicecall *vc, const char =
*position,
+				enum ofono_clir_option clir, ofono_voicecall_cb_t cb, void *data)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	long int memory_position;
 =

 	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
 		return -EPERM;
@@ -1618,9 +1619,6 @@ static int voicecall_dial_shortcut(struct ofono_voice=
call *vc, enum ofono_clir_o
 	if (ofono_modem_get_online(modem) =3D=3D FALSE)
 		return -ENETDOWN;
 =

-	if (vc->driver->dial_last =3D=3D NULL)
-		return -ENOTSUP;
-
 	if (voicecalls_have_incoming(vc))
 		return -EBUSY;
 =

@@ -1631,7 +1629,19 @@ static int voicecall_dial_shortcut(struct ofono_voic=
ecall *vc, enum ofono_clir_o
 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
 		return -EBUSY;
 =

-	vc->driver->dial_last(vc, clir, cb, vc);
+	/* when position is not given we dial the last called number */
+	if(position =3D=3D NULL) {
+		if (vc->driver->dial_last =3D=3D NULL)
+			return -ENOTSUP;
+
+		vc->driver->dial_last(vc, clir, cb, vc);
+	} else {
+		memory_position =3D strtol(position, NULL, 10);
+		if(vc->driver->dial_memory =3D=3D NULL )
+			return -ENOTSUP;
+
+		vc->driver->dial_memory(vc, memory_position, clir, cb, vc);
+	}
 =

 	return 0;
 }
@@ -1656,7 +1666,7 @@ static DBusMessage *manager_dial_last(DBusConnection =
*conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	err =3D voicecall_dial_shortcut(vc, clir, manager_dial_shortcut_callback,=
 vc);
+	err =3D voicecall_dial_shortcut(vc, NULL, clir, manager_dial_shortcut_cal=
lback, vc);
 =

 	if (err >=3D 0)
 		return NULL;
@@ -1678,6 +1688,50 @@ static DBusMessage *manager_dial_last(DBusConnection=
 *conn,
 	return __ofono_error_failed(msg);
 }
 =

+static DBusMessage *manager_dial_memory(DBusConnection *conn,
+                                       DBusMessage *msg, void *data)
+{
+       struct ofono_voicecall *vc =3D data;
+       const char *memory_location;
+       const char *clirstr;
+       enum ofono_clir_option clir;
+       int err;
+
+       if (vc->pending || vc->dial_req || vc->pending_em)
+               return __ofono_error_busy(msg);
+
+       if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &memory_loca=
tion,
+                                       DBUS_TYPE_STRING, &clirstr,
+                                       DBUS_TYPE_INVALID) =3D=3D FALSE)
+               return __ofono_error_invalid_args(msg);
+
+       if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
+               return __ofono_error_invalid_format(msg);
+
+       vc->pending =3D dbus_message_ref(msg);
+
+       err =3D voicecall_dial_shortcut(vc, memory_location, clir, manager_=
dial_shortcut_callback, vc);
+
+       if (err >=3D 0)
+               return NULL;
+
+       vc->pending =3D NULL;
+       dbus_message_unref(msg);
+
+       switch (err) {
+       case -EINVAL:
+               return __ofono_error_invalid_format(msg);
+
+       case -ENETDOWN:
+               return __ofono_error_not_available(msg);
+
+       case -ENOTSUP:
+               return __ofono_error_not_implemented(msg);
+       }
+
+       return __ofono_error_failed(msg);
+}
+
 static DBusMessage *manager_transfer(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -2236,6 +2290,10 @@ static const GDBusMethodTable manager_methods[] =3D {
 		manager_dial) },
 	{ GDBUS_ASYNC_METHOD("DialLast",
 		GDBUS_ARGS({ "hide_callerid", "s" }), NULL, manager_dial_last)},
+	{ GDBUS_ASYNC_METHOD("DialMemory",
+		GDBUS_ARGS({ "memory_location", "s" },{ "hide_callerid", "s" }),
+		NULL,
+		manager_dial_memory) },
 	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
 	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
 	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
-- =

2.11.0


--===============0413744365055058275==--

