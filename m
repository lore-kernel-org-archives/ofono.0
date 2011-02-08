Content-Type: multipart/mixed; boundary="===============6885446317001089886=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] sim: enable usage of SIM pass codes longer than 8 digits
Date: Tue, 08 Feb 2011 14:48:18 +0200
Message-ID: <1297169298-26209-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6885446317001089886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---


Hi,

On Tue, 2011-02-08 at 06:17 +0200, Denis Kenzior wrote:

Why don't we keep things simple.  Modify is_valid_pin to take a pin and
> a min and max number of digits.
> =

> gboolean is_valid_pin_with_limits(const char *pin, int min, int max)
> (feel free to pick some better name)
> =

> Then just add two functions:
> =

> __ofono_valid_net_pin(const char *pin)
> __ofono_valid_sim_pin(const char *pin, enum ofono_sim_password_type type)
> =

> Stick both in ofono.h / sim.c somewhere
> =


Right. Here it is. =


Br,
Jussi

 src/call-barring.c |   12 ++++----
 src/call-meter.c   |    4 +-
 src/common.c       |   37 -------------------------
 src/common.h       |    9 ------
 src/ofono.h        |    5 +++
 src/sim.c          |   76 +++++++++++++++++++++++++++++++++++++++++++++++-=
---
 6 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 649826e..384eb43 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -402,7 +402,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if (strlen(dn) > 0)
 		goto bad_format;
 =

-	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
+	if (type !=3D SS_CONTROL_TYPE_QUERY && !__ofono_is_valid_net_pin(sia))
 		goto bad_format;
 =

 	switch (type) {
@@ -524,7 +524,7 @@ static gboolean cb_ss_passwd(const char *sc,
 	if (fac =3D=3D NULL)
 		return FALSE;
 =

-	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET))
+	if (!__ofono_is_valid_net_pin(old) || !__ofono_is_valid_net_pin(new))
 		goto bad_format;
 =

 	cb->pending =3D dbus_message_ref(msg);
@@ -862,7 +862,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 			return __ofono_error_invalid_args(msg);
 =

 		dbus_message_iter_get_basic(&iter, &passwd);
-		if (!is_valid_pin(passwd, PIN_TYPE_NET))
+		if (!__ofono_is_valid_net_pin(passwd))
 			return __ofono_error_invalid_format(msg);
 	}
 =

@@ -909,7 +909,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(passwd, PIN_TYPE_NET))
+	if (!__ofono_is_valid_net_pin(passwd))
 		return __ofono_error_invalid_format(msg);
 =

 	cb_set_query_bounds(cb, fac, FALSE);
@@ -957,10 +957,10 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(old_passwd, PIN_TYPE_NET))
+	if (!__ofono_is_valid_net_pin(old_passwd))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new_passwd, PIN_TYPE_NET))
+	if (!__ofono_is_valid_net_pin(new_passwd))
 		return __ofono_error_invalid_format(msg);
 =

 	cb->pending =3D dbus_message_ref(msg);
diff --git a/src/call-meter.c b/src/call-meter.c
index d483e2e..0789935 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -549,7 +549,7 @@ static DBusMessage *cm_set_property(DBusConnection *con=
n, DBusMessage *msg,
 =

 	dbus_message_iter_get_basic(&iter, &passwd);
 =

-	if (!is_valid_pin(passwd, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(passwd, OFONO_SIM_PASSWORD_SIM_PIN2))
 		return __ofono_error_invalid_format(msg);
 =

 	for (property =3D cm_properties; property->name; property++) {
@@ -621,7 +621,7 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn, =
DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(pin2, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(pin2, OFONO_SIM_PASSWORD_SIM_PIN2))
 		return __ofono_error_invalid_format(msg);
 =

 	cm->pending =3D dbus_message_ref(msg);
diff --git a/src/common.c b/src/common.c
index f25f105..247fff0 100644
--- a/src/common.c
+++ b/src/common.c
@@ -649,43 +649,6 @@ const char *bearer_class_to_string(enum bearer_class c=
ls)
 	return NULL;
 }
 =

-gboolean is_valid_pin(const char *pin, enum pin_type type)
-{
-	unsigned int i;
-
-	/* Pin must not be empty */
-	if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
-		return FALSE;
-
-	i =3D strlen(pin);
-	if (i !=3D strspn(pin, "0123456789"))
-		return FALSE;
-
-	switch (type) {
-	case PIN_TYPE_PIN:
-		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
-		if (4 <=3D i && i <=3D 8)
-			return TRUE;
-		break;
-	case PIN_TYPE_PUK:
-		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
-		if (i =3D=3D 8)
-			return TRUE;
-		break;
-	case PIN_TYPE_NET:
-		/* 22.004 Section 5.2, 4 IA-5 digits */
-		if (i =3D=3D 4)
-			return TRUE;
-		break;
-	case PIN_TYPE_NONE:
-		if (i < 8)
-			return TRUE;
-		break;
-	}
-
-	return FALSE;
-}
-
 const char *registration_status_to_string(int status)
 {
 	switch (status) {
diff --git a/src/common.h b/src/common.h
index 09f2deb..6dc7bff 100644
--- a/src/common.h
+++ b/src/common.h
@@ -122,13 +122,6 @@ enum ss_cssu {
 	SS_MT_CALL_DEFLECTED =3D			9,
 };
 =

-enum pin_type {
-	PIN_TYPE_NONE,
-	PIN_TYPE_PIN,
-	PIN_TYPE_PUK,
-	PIN_TYPE_NET,
-};
-
 /* 27.007 Section 10.1.10 */
 enum context_status {
 	CONTEXT_STATUS_DEACTIVATED =3D 0,
@@ -162,8 +155,6 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type);
 =

 const char *bearer_class_to_string(enum bearer_class cls);
 =

-gboolean is_valid_pin(const char *pin, enum pin_type type);
-
 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
 const char *packet_bearer_to_string(int bearer);
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..4f0b7c2 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -299,6 +299,11 @@ ofono_bool_t __ofono_sim_service_available(struct ofon=
o_sim *sim,
 						int ust_service,
 						int sst_service);
 =

+ofono_bool_t __ofono_is_valid_sim_pin(const char *pin,
+					enum ofono_sim_password_type type);
+
+ofono_bool_t __ofono_is_valid_net_pin(const char *pin);
+
 #include <ofono/stk.h>
 =

 typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
diff --git a/src/sim.c b/src/sim.c
index 3350166..3462608 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -676,7 +676,7 @@ static DBusMessage *sim_lock_or_unlock(struct ofono_sim=
 *sim, int lock,
 			type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -748,10 +748,10 @@ static DBusMessage *sim_change_pin(DBusConnection *co=
nn, DBusMessage *msg,
 	if (password_is_pin(type) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(old, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(old, type))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(new, type))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!strcmp(new, old))
@@ -803,7 +803,7 @@ static DBusMessage *sim_enter_pin(DBusConnection *conn,=
 DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	if (!__ofono_is_valid_sim_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -1013,10 +1013,12 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(puk, PIN_TYPE_PUK))
+	if (!__ofono_is_valid_sim_pin(puk, type))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	type =3D puk2pin(type);
+
+	if (!__ofono_is_valid_sim_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -2378,3 +2380,65 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+ofono_bool_t is_valid_pin(const char *pin, int min, int max)
+{
+	unsigned int i;
+
+	/* Pin must not be empty */
+	if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
+		return FALSE;
+
+	i =3D strlen(pin);
+	if (i !=3D strspn(pin, "0123456789"))
+		return FALSE;
+
+	if (min <=3D i && i <=3D max)
+		return TRUE;
+
+	return FALSE;
+}
+
+ofono_bool_t __ofono_is_valid_sim_pin(const char *pin,
+					enum ofono_sim_password_type type)
+{
+	switch (type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
+		return is_valid_pin(pin, 4, 8);
+		break;
+	case OFONO_SIM_PASSWORD_PHSIM_PIN:
+	case OFONO_SIM_PASSWORD_PHFSIM_PIN:
+	case OFONO_SIM_PASSWORD_PHNET_PIN:
+	case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
+	case OFONO_SIM_PASSWORD_PHSP_PIN:
+	case OFONO_SIM_PASSWORD_PHCORP_PIN:
+	  /* 22.022 Section 14 4..16 IA-5 digits */
+		return is_valid_pin(pin, 4, 16);
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+	case OFONO_SIM_PASSWORD_PHFSIM_PUK:
+	case OFONO_SIM_PASSWORD_PHNET_PUK:
+	case OFONO_SIM_PASSWORD_PHNETSUB_PUK:
+	case OFONO_SIM_PASSWORD_PHSP_PUK:
+	case OFONO_SIM_PASSWORD_PHCORP_PUK:
+		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
+		return is_valid_pin(pin, 8, 8);
+		break;
+	case OFONO_SIM_PASSWORD_NONE:
+		return is_valid_pin(pin, 0, 8);
+		break;
+	case OFONO_SIM_PASSWORD_INVALID:
+		break;
+	}
+
+	return FALSE;
+}
+
+ofono_bool_t __ofono_is_valid_net_pin(const char *pin)
+{
+	return is_valid_pin(pin, 4, 4);
+}
+
-- =

1.7.1


--===============6885446317001089886==--

