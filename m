Content-Type: multipart/mixed; boundary="===============0850749833549421480=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 1/7] voicecall: Support clir for last call dialing
Date: Wed, 06 Dec 2017 17:35:58 +0200
Message-ID: <20171206153604.15080-2-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0850749833549421480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When dialing the last called number we also want to use the caller id (clir)
settings that are currently used.

---
 doc/voicecallmanager-api.txt |  2 +-
 drivers/hfpmodem/voicecall.c |  4 ++--
 include/voicecall.h          |  3 ++-
 src/voicecall.c              | 18 ++++++++++++++----
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 7aeb81f7..f82a0a10 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -59,7 +59,7 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

-		object DialLast()
+		object DialLast(string hide_callerid)
 =

 			Initiates a new outgoing call to the last dialled number.
 =

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 1e0489c2..a32a3242 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -405,8 +405,8 @@ static void hfp_dial(struct ofono_voicecall *vc,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void hfp_dial_last(struct ofono_voicecall *vc, ofono_voicecall_cb_t=
 cb,
-			void *data)
+static void hfp_dial_last(struct ofono_voicecall *vc, enum ofono_clir_opti=
on clir,
+			ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
diff --git a/include/voicecall.h b/include/voicecall.h
index 6871a6b5..79a64bb4 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -64,7 +64,8 @@ struct ofono_voicecall_driver {
 	/* Dials the last number again, this handles the hfp profile last number
          * dialing with the +BLDN AT command
          */
-	void (*dial_last)(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, vo=
id *data);
+	void (*dial_last)(struct ofono_voicecall *vc, enum ofono_clir_option clir,
+				ofono_voicecall_cb_t cb, void *data);
 	/* Answers an incoming call, this usually corresponds to ATA */
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
diff --git a/src/voicecall.c b/src/voicecall.c
index cd9182a1..9f323c6e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1605,7 +1605,7 @@ error:
 					__ofono_error_failed(vc->pending));
 }
 =

-static int voicecall_dial_last(struct ofono_voicecall *vc,
+static int voicecall_dial_last(struct ofono_voicecall *vc, enum ofono_clir=
_option clir,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
@@ -1629,7 +1629,7 @@ static int voicecall_dial_last(struct ofono_voicecall=
 *vc,
 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
 		return -EBUSY;
 =

-	vc->driver->dial_last(vc, cb, vc);
+	vc->driver->dial_last(vc, clir, cb, vc);
 =

 	return 0;
 }
@@ -1638,14 +1638,23 @@ static DBusMessage *manager_dial_last(DBusConnectio=
n *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	const char *clirstr;
+	enum ofono_clir_option clir;
 	int err;
 =

 	if (vc->pending || vc->dial_req || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &clirstr,
+						DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
 	vc->pending =3D dbus_message_ref(msg);
 =

-	err =3D voicecall_dial_last(vc, manager_dial_last_callback, vc);
+	err =3D voicecall_dial_last(vc, clir, manager_dial_last_callback, vc);
 =

 	if (err >=3D 0)
 		return NULL;
@@ -2223,7 +2232,8 @@ static const GDBusMethodTable manager_methods[] =3D {
 		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
 		GDBUS_ARGS({ "path", "o" }),
 		manager_dial) },
-	{ GDBUS_ASYNC_METHOD("DialLast", NULL, NULL, manager_dial_last)},
+	{ GDBUS_ASYNC_METHOD("DialLast",
+		GDBUS_ARGS({ "hide_callerid", "s" }), NULL, manager_dial_last)},
 	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
 	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
 	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
-- =

2.11.0


--===============0850749833549421480==--

