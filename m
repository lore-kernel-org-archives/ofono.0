Content-Type: multipart/mixed; boundary="===============1085267202508389851=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 3/5] voicecall: Add functionality to manager to dial from a
 memory location.
Date: Mon, 12 Feb 2018 20:37:16 +0200
Message-ID: <20180212183718.17194-4-philippedeswert@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1085267202508389851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

Implement functionality to allow to  dial favourites/quick contacts over
bluetooth.
---
 src/voicecall.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index eae4b904..d45b3aa2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1606,7 +1606,7 @@ error:
 					__ofono_error_failed(vc->pending));
 }
 =

-static int voicecall_dial_hfp(struct ofono_voicecall *vc,
+static int voicecall_dial_hfp(struct ofono_voicecall *vc, unsigned int pos=
ition,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
@@ -1617,9 +1617,6 @@ static int voicecall_dial_hfp(struct ofono_voicecall =
*vc,
 	if (ofono_modem_get_online(modem) =3D=3D FALSE)
 		return -ENETDOWN;
 =

-	if (vc->driver->dial_last =3D=3D NULL)
-		return -ENOTSUP;
-
 	if (voicecalls_have_incoming(vc))
 		return -EBUSY;
 =

@@ -1630,7 +1627,18 @@ static int voicecall_dial_hfp(struct ofono_voicecall=
 *vc,
 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
 		return -EBUSY;
 =

-	vc->driver->dial_last(vc, cb, vc);
+	/* when position is not given we dial the last called number */
+	if(position =3D=3D 0) {
+		if (vc->driver->dial_last =3D=3D NULL)
+			return -ENOTSUP;
+
+		vc->driver->dial_last(vc, cb, vc);
+	} else {
+		if(vc->driver->dial_memory =3D=3D NULL )
+		return -ENOTSUP;
+
+		vc->driver->dial_memory(vc, position, cb, vc);
+       }
 =

 	return 0;
 }
@@ -1646,7 +1654,7 @@ static DBusMessage *manager_dial_last(DBusConnection =
*conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	err =3D voicecall_dial_hfp(vc, manager_dial_hfp_callback, vc);
+	err =3D voicecall_dial_hfp(vc, 0, manager_dial_hfp_callback, vc);
 =

 	if (err >=3D 0)
 		return NULL;
@@ -1668,6 +1676,44 @@ static DBusMessage *manager_dial_last(DBusConnection=
 *conn,
 	return __ofono_error_failed(msg);
 }
 =

+static DBusMessage *manager_dial_memory(DBusConnection *conn,
+                                       DBusMessage *msg, void *data)
+{
+       struct ofono_voicecall *vc =3D data;
+       int memory_location;
+       int err;
+
+       if (vc->pending || vc->dial_req || vc->pending_em)
+               return __ofono_error_busy(msg);
+
+       if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &memory_loca=
tion,
+                                       DBUS_TYPE_INVALID) =3D=3D FALSE)
+               return __ofono_error_invalid_args(msg);
+
+       vc->pending =3D dbus_message_ref(msg);
+
+       err =3D voicecall_dial_hfp(vc, memory_location, manager_dial_hfp_ca=
llback, vc);
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
@@ -2225,6 +2271,8 @@ static const GDBusMethodTable manager_methods[] =3D {
 		GDBUS_ARGS({ "path", "o" }),
 		manager_dial) },
 	{ GDBUS_ASYNC_METHOD("DialLast", NULL, NULL, manager_dial_last)},
+	{ GDBUS_ASYNC_METHOD("DialMemory",
+		GDBUS_ARGS({"memory_location", "u" }), NULL, manager_dial_memory) },
 	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
 	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
 	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
-- =

2.11.0


--===============1085267202508389851==--

