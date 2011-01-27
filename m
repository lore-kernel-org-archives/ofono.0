Content-Type: multipart/mixed; boundary="===============7565063046984393891=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: Ofono has too tight limits for SIM lock code lengths
Date: Thu, 27 Jan 2011 14:52:51 +0200
Message-ID: <1296132771-17621-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7565063046984393891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 2011-01-20 at 19:35 +0200, Denis Kenzior wrote:
> The first option sounds reasonable to me as a first attempt.  Care to
> submit a proposal?
> =

This seems to do the trick

---
 include/sim.h      |    1 +
 src/call-barring.c |   14 ++++++++------
 src/call-meter.c   |    4 ++--
 src/common.c       |   29 ++++++++++++++++++++++++-----
 src/common.h       |   11 +++--------
 src/ofono.h        |    3 +++
 src/sim.c          |   13 +++++++------
 7 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 5e3ba5b..ee63d74 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -54,6 +54,7 @@ enum ofono_sim_password_type {
 	OFONO_SIM_PASSWORD_PHNETSUB_PUK,
 	OFONO_SIM_PASSWORD_PHSP_PUK,
 	OFONO_SIM_PASSWORD_PHCORP_PUK,
+	OFONO_PASSWORD_PIN_TYPE_NET,
 	OFONO_SIM_PASSWORD_INVALID,
 };
 =

diff --git a/src/call-barring.c b/src/call-barring.c
index bb15530..6768833 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -402,7 +402,8 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if (strlen(dn) > 0)
 		goto bad_format;
 =

-	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
+	if (type !=3D SS_CONTROL_TYPE_QUERY &&
+		!is_valid_pin(sia, OFONO_PASSWORD_PIN_TYPE_NET))
 		goto bad_format;
 =

 	switch (type) {
@@ -524,7 +525,8 @@ static gboolean cb_ss_passwd(const char *sc,
 	if (fac =3D=3D NULL)
 		return FALSE;
 =

-	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET))
+	if (!is_valid_pin(old, OFONO_PASSWORD_PIN_TYPE_NET) ||
+		!is_valid_pin(new, OFONO_PASSWORD_PIN_TYPE_NET))
 		goto bad_format;
 =

 	cb->pending =3D dbus_message_ref(msg);
@@ -862,7 +864,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 			return __ofono_error_invalid_args(msg);
 =

 		dbus_message_iter_get_basic(&iter, &passwd);
-		if (!is_valid_pin(passwd, PIN_TYPE_NET))
+		if (!is_valid_pin(passwd, OFONO_PASSWORD_PIN_TYPE_NET))
 			return __ofono_error_invalid_format(msg);
 	}
 =

@@ -909,7 +911,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(passwd, PIN_TYPE_NET))
+	if (!is_valid_pin(passwd, OFONO_PASSWORD_PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

 	cb_set_query_bounds(cb, fac, FALSE);
@@ -957,10 +959,10 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(old_passwd, PIN_TYPE_NET))
+	if (!is_valid_pin(old_passwd, OFONO_PASSWORD_PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new_passwd, PIN_TYPE_NET))
+	if (!is_valid_pin(new_passwd, OFONO_PASSWORD_PIN_TYPE_NET))
 		return __ofono_error_invalid_format(msg);
 =

 	cb->pending =3D dbus_message_ref(msg);
diff --git a/src/call-meter.c b/src/call-meter.c
index ac3ae6b..dd04459 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -548,7 +548,7 @@ static DBusMessage *cm_set_property(DBusConnection *con=
n, DBusMessage *msg,
 =

 	dbus_message_iter_get_basic(&iter, &passwd);
 =

-	if (!is_valid_pin(passwd, PIN_TYPE_PIN))
+	if (!is_valid_pin(passwd, OFONO_SIM_PASSWORD_SIM_PIN2))
 		return __ofono_error_invalid_format(msg);
 =

 	for (property =3D cm_properties; property->name; property++) {
@@ -620,7 +620,7 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn, =
DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(pin2, PIN_TYPE_PIN))
+	if (!is_valid_pin(pin2, OFONO_SIM_PASSWORD_SIM_PIN2))
 		return __ofono_error_invalid_format(msg);
 =

 	cm->pending =3D dbus_message_ref(msg);
diff --git a/src/common.c b/src/common.c
index 8bf9dbb..19459ac 100644
--- a/src/common.c
+++ b/src/common.c
@@ -649,7 +649,7 @@ const char *bearer_class_to_string(enum bearer_class cl=
s)
 	return NULL;
 }
 =

-gboolean is_valid_pin(const char *pin, enum pin_type type)
+gboolean is_valid_pin(const char *pin, enum ofono_sim_password_type type)
 {
 	unsigned int i;
 =

@@ -662,25 +662,44 @@ gboolean is_valid_pin(const char *pin, enum pin_type =
type)
 		return FALSE;
 =

 	switch (type) {
-	case PIN_TYPE_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
 		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
 		if (4 <=3D i && i <=3D 8)
 			return TRUE;
 		break;
-	case PIN_TYPE_PUK:
+	case OFONO_SIM_PASSWORD_PHSIM_PIN:
+	case OFONO_SIM_PASSWORD_PHFSIM_PIN:
+	case OFONO_SIM_PASSWORD_PHNET_PIN:
+	case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
+	case OFONO_SIM_PASSWORD_PHSP_PIN:
+	case OFONO_SIM_PASSWORD_PHCORP_PIN:
+	  /* 22.022 Section 14 4..16 IA-5 digits */
+		if (4 <=3D i && i <=3D 16)
+			return TRUE;
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+	case OFONO_SIM_PASSWORD_PHFSIM_PUK:
+	case OFONO_SIM_PASSWORD_PHNET_PUK:
+	case OFONO_SIM_PASSWORD_PHNETSUB_PUK:
+	case OFONO_SIM_PASSWORD_PHSP_PUK:
+	case OFONO_SIM_PASSWORD_PHCORP_PUK:
 		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
 		if (i =3D=3D 8)
 			return TRUE;
 		break;
-	case PIN_TYPE_NET:
+	case OFONO_PASSWORD_PIN_TYPE_NET:
 		/* 22.004 Section 5.2, 4 IA-5 digits */
 		if (i =3D=3D 4)
 			return TRUE;
 		break;
-	case PIN_TYPE_NONE:
+	case OFONO_SIM_PASSWORD_NONE:
 		if (i < 8)
 			return TRUE;
 		break;
+	case OFONO_SIM_PASSWORD_INVALID:
+		break;
 	}
 =

 	return FALSE;
diff --git a/src/common.h b/src/common.h
index 09f2deb..acdbce5 100644
--- a/src/common.h
+++ b/src/common.h
@@ -19,6 +19,8 @@
  *
  */
 =

+#include "ofono.h"
+
 /* 27.007 Section 7.3 <AcT> */
 enum access_technology {
 	ACCESS_TECHNOLOGY_GSM =3D			0,
@@ -122,13 +124,6 @@ enum ss_cssu {
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
@@ -162,7 +157,7 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type);
 =

 const char *bearer_class_to_string(enum bearer_class cls);
 =

-gboolean is_valid_pin(const char *pin, enum pin_type type);
+gboolean is_valid_pin(const char *pin, enum ofono_sim_password_type type);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
diff --git a/src/ofono.h b/src/ofono.h
index df20103..40602af 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -18,6 +18,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
  */
+#ifndef OFONO_H
+#define OFONO_H
 =

 #include <glib.h>
 =

@@ -429,3 +431,4 @@ ofono_bool_t __ofono_gprs_provision_get_settings(const =
char *mcc,
 void __ofono_gprs_provision_free_settings(
 				struct ofono_gprs_provision_data *settings,
 				int count);
+#endif
diff --git a/src/sim.c b/src/sim.c
index 3c5db90..a186cae 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -174,6 +174,7 @@ static gboolean password_is_pin(enum ofono_sim_password=
_type type)
 	case OFONO_SIM_PASSWORD_PHCORP_PUK:
 	case OFONO_SIM_PASSWORD_INVALID:
 	case OFONO_SIM_PASSWORD_NONE:
+	case OFONO_PASSWORD_PIN_TYPE_NET:
 		return FALSE;
 	}
 =

@@ -675,7 +676,7 @@ static DBusMessage *sim_lock_or_unlock(struct ofono_sim=
 *sim, int lock,
 			type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	if (!is_valid_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -747,10 +748,10 @@ static DBusMessage *sim_change_pin(DBusConnection *co=
nn, DBusMessage *msg,
 	if (password_is_pin(type) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(old, PIN_TYPE_PIN))
+	if (!is_valid_pin(old, type))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new, PIN_TYPE_PIN))
+	if (!is_valid_pin(new, type))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!strcmp(new, old))
@@ -802,7 +803,7 @@ static DBusMessage *sim_enter_pin(DBusConnection *conn,=
 DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	if (!is_valid_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
@@ -1012,10 +1013,10 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
 	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(puk, PIN_TYPE_PUK))
+	if (!is_valid_pin(puk, type))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+	if (!is_valid_pin(pin, type))
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
-- =

1.7.1


--===============7565063046984393891==--

