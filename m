Content-Type: multipart/mixed; boundary="===============2633355940517756150=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH] Checking PIN length based on its type (PIN / PUK / NET).
Date: Fri, 19 Mar 2010 17:00:31 +0200
Message-ID: <1269010831-21798-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2633355940517756150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/call-barring.c |   12 ++++++------
 src/call-meter.c   |    4 ++--
 src/common.c       |   30 +++++++++++++++++++++++-------
 src/common.h       |   11 ++++++++++-
 src/sim.c          |   12 ++++++------
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 07e324d..7607f3f 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -402,7 +402,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if (strlen(dn) > 0)
 		goto bad_format;
 =

-	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia))
+	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
 		goto bad_format;
 =

 	switch (type) {
@@ -523,7 +523,7 @@ static gboolean cb_ss_passwd(const char *sc,
 	if (!fac)
 		return FALSE;
 =

-	if (!is_valid_pin(old) || !is_valid_pin(new))
+	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET))
 		goto bad_format;
 =

 	cb->pending =3D dbus_message_ref(msg);
@@ -854,7 +854,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 			return __ofono_error_invalid_args(msg);
 =

 		dbus_message_iter_get_basic(&iter, &passwd);
-		if (!is_valid_pin(passwd))
+		if (!is_valid_pin(passwd, PIN_TYPE_NET))
 			return __ofono_error_invalid_format(msg);
 	}
 =

@@ -901,7 +901,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(passwd))
+	if (!is_valid_pin(passwd, PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

 	cb_set_query_bounds(cb, fac, FALSE);
@@ -949,10 +949,10 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(old_passwd))
+	if (!is_valid_pin(old_passwd, PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new_passwd))
+	if (!is_valid_pin(new_passwd, PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

 	cb->pending =3D dbus_message_ref(msg);
diff --git a/src/call-meter.c b/src/call-meter.c
index 2b1e6a5..335b33c 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -546,7 +546,7 @@ static DBusMessage *cm_set_property(DBusConnection *con=
n, DBusMessage *msg,
 =

 	dbus_message_iter_get_basic(&iter, &passwd);
 =

-	if (!is_valid_pin(passwd))
+	if (!is_valid_pin(passwd, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	for (property =3D cm_properties; property->name; property++) {
@@ -618,7 +618,7 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn, =
DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(pin2))
+	if (!is_valid_pin(pin2, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	cm->pending =3D dbus_message_ref(msg);
diff --git a/src/common.c b/src/common.c
index db3e38b..4b5c463 100644
--- a/src/common.c
+++ b/src/common.c
@@ -580,7 +580,7 @@ const char *bearer_class_to_string(enum bearer_class cl=
s)
 	return NULL;
 }
 =

-gboolean is_valid_pin(const char *pin)
+gboolean is_valid_pin(const char *pin, enum pin_type type)
 {
 	unsigned int i;
 =

@@ -588,14 +588,30 @@ gboolean is_valid_pin(const char *pin)
 	if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
 		return FALSE;
 =

-	for (i =3D 0; i < strlen(pin); i++)
-		if (pin[i] < '0' || pin[i] > '9')
-			return FALSE;
-
-	if (i > 8)
+	i =3D strlen(pin);
+	if (i !=3D strspn(pin, "012345679"))
 		return FALSE;
 =

-	return TRUE;
+	switch (type)
+	{
+	case PIN_TYPE_PIN:
+		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
+		if (4 <=3D i && i <=3D 8)
+			return TRUE;
+	case PIN_TYPE_PUK:
+		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
+		if (i =3D=3D 8)
+			return TRUE;
+	case PIN_TYPE_NET:
+		/* 22.004 Section 5.2, 4 IA-5 digits */
+		if (i =3D=3D 4)
+			return TRUE;
+	case PIN_TYPE_NONE:
+		if (i < 8)
+			return TRUE;
+	}
+
+	return FALSE;
 }
 =

 const char *registration_status_to_string(int status)
diff --git a/src/common.h b/src/common.h
index 2b74dc4..303ce5e 100644
--- a/src/common.h
+++ b/src/common.h
@@ -115,6 +115,13 @@ enum ss_cssu {
 	SS_MT_CALL_DEFLECTED		=3D 9,
 };
 =

+enum pin_type {
+	PIN_TYPE_NONE =3D 0,
+	PIN_TYPE_PIN =3D 1,
+	PIN_TYPE_PUK =3D 2,
+	PIN_TYPE_NET =3D 3,
+};
+
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
@@ -134,7 +141,9 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type);
 =

 const char *bearer_class_to_string(enum bearer_class cls);
 =

-gboolean is_valid_pin(const char *pin);
+
+
+gboolean is_valid_pin(const char *pin, enum pin_type type);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
diff --git a/src/sim.c b/src/sim.c
index cc258c8..2e92329 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -554,7 +554,7 @@ static DBusMessage *sim_lock_or_unlock(struct ofono_sim=
 *sim, int lock,
 			type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin))
+	if (!is_valid_pin(pin, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -621,10 +621,10 @@ static DBusMessage *sim_change_pin(DBusConnection *co=
nn, DBusMessage *msg,
 	if (password_is_pin(type) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(old))
+	if (!is_valid_pin(old, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new))
+	if (!is_valid_pin(new, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!strcmp(new, old))
@@ -676,7 +676,7 @@ static DBusMessage *sim_enter_pin(DBusConnection *conn,=
 DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin))
+	if (!is_valid_pin(pin, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -711,10 +711,10 @@ static DBusMessage *sim_reset_pin(DBusConnection *con=
n, DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(puk))
+	if (!is_valid_pin(puk, PIN_TYPE_PUK))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin))
+	if (!is_valid_pin(pin, PIN_TYPE_PIN))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
-- =

1.6.3.3


--===============2633355940517756150==--

