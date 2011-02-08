Content-Type: multipart/mixed; boundary="===============0269737893240780579=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: enable usage of SIM pass codes longer than 8 digits
Date: Mon, 07 Feb 2011 22:17:32 -0600
Message-ID: <4D50C3DC.9020209@gmail.com>
In-Reply-To: <1297090177-26010-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0269737893240780579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/07/2011 08:49 AM, Jussi Kangas wrote:
> ---
> =

> Hi,
> =

> Here is my second proposal for how to enable usage of SIM lock codes long=
er than eight digits. I removed the namespace problem and fixed a problem w=
ith puk reset. =

> =

> Br,
> Jussi
> =

>  include/sim.h      |    1 +
>  src/call-barring.c |   14 ++++++++------
>  src/call-meter.c   |    4 ++--
>  src/common.c       |   29 ++++++++++++++++++++++++-----
>  src/common.h       |   11 +++--------
>  src/ofono.h        |    3 +++
>  src/sim.c          |   15 +++++++++------
>  7 files changed, 50 insertions(+), 27 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 5e3ba5b..7f0313e 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -54,6 +54,7 @@ enum ofono_sim_password_type {
>  	OFONO_SIM_PASSWORD_PHNETSUB_PUK,
>  	OFONO_SIM_PASSWORD_PHSP_PUK,
>  	OFONO_SIM_PASSWORD_PHCORP_PUK,
> +	OFONO_SIM_PASSWORD_PIN_TYPE_NET,

So just adding an enum here is a little dangerous since we use the array
size for things like look up tables and iterators inside src/sim.c

>  	OFONO_SIM_PASSWORD_INVALID,
>  };
>  =

> diff --git a/src/call-barring.c b/src/call-barring.c
> index 649826e..fdcecbf 100644
> --- a/src/call-barring.c
> +++ b/src/call-barring.c
> @@ -402,7 +402,8 @@ static gboolean cb_ss_control(int type, const char *s=
c,
>  	if (strlen(dn) > 0)
>  		goto bad_format;
>  =

> -	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
> +	if (type !=3D SS_CONTROL_TYPE_QUERY &&
> +		!is_valid_pin(sia, OFONO_SIM_PASSWORD_PIN_TYPE_NET))

Watch out for coding style, see item M4.

>  		goto bad_format;
>  =

>  	switch (type) {
> @@ -524,7 +525,8 @@ static gboolean cb_ss_passwd(const char *sc,
>  	if (fac =3D=3D NULL)
>  		return FALSE;
>  =

> -	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET=
))
> +	if (!is_valid_pin(old, OFONO_SIM_PASSWORD_PIN_TYPE_NET) ||
> +		!is_valid_pin(new, OFONO_SIM_PASSWORD_PIN_TYPE_NET))

As above

>  		goto bad_format;
>  =

>  	cb->pending =3D dbus_message_ref(msg);
> @@ -862,7 +864,7 @@ static DBusMessage *cb_set_property(DBusConnection *c=
onn, DBusMessage *msg,
>  			return __ofono_error_invalid_args(msg);
>  =

>  		dbus_message_iter_get_basic(&iter, &passwd);
> -		if (!is_valid_pin(passwd, PIN_TYPE_NET))
> +		if (!is_valid_pin(passwd, OFONO_SIM_PASSWORD_PIN_TYPE_NET))
>  			return __ofono_error_invalid_format(msg);
>  	}
>  =

> @@ -909,7 +911,7 @@ static DBusMessage *cb_disable_all(DBusConnection *co=
nn, DBusMessage *msg,
>  					DBUS_TYPE_INVALID) =3D=3D FALSE)
>  		return __ofono_error_invalid_args(msg);
>  =

> -	if (!is_valid_pin(passwd, PIN_TYPE_NET))
> +	if (!is_valid_pin(passwd, OFONO_SIM_PASSWORD_PIN_TYPE_NET))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	cb_set_query_bounds(cb, fac, FALSE);
> @@ -957,10 +959,10 @@ static DBusMessage *cb_set_passwd(DBusConnection *c=
onn, DBusMessage *msg,
>  					DBUS_TYPE_INVALID) =3D=3D FALSE)
>  		return __ofono_error_invalid_args(msg);
>  =

> -	if (!is_valid_pin(old_passwd, PIN_TYPE_NET))
> +	if (!is_valid_pin(old_passwd, OFONO_SIM_PASSWORD_PIN_TYPE_NET))
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(new_passwd, PIN_TYPE_NET))
> +	if (!is_valid_pin(new_passwd, OFONO_SIM_PASSWORD_PIN_TYPE_NET))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	cb->pending =3D dbus_message_ref(msg);
> diff --git a/src/call-meter.c b/src/call-meter.c
> index d483e2e..a7f8ebb 100644
> --- a/src/call-meter.c
> +++ b/src/call-meter.c
> @@ -549,7 +549,7 @@ static DBusMessage *cm_set_property(DBusConnection *c=
onn, DBusMessage *msg,
>  =

>  	dbus_message_iter_get_basic(&iter, &passwd);
>  =

> -	if (!is_valid_pin(passwd, PIN_TYPE_PIN))
> +	if (!is_valid_pin(passwd, OFONO_SIM_PASSWORD_SIM_PIN2))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	for (property =3D cm_properties; property->name; property++) {
> @@ -621,7 +621,7 @@ static DBusMessage *cm_acm_reset(DBusConnection *conn=
, DBusMessage *msg,
>  					DBUS_TYPE_INVALID) =3D=3D FALSE)
>  		return __ofono_error_invalid_args(msg);
>  =

> -	if (!is_valid_pin(pin2, PIN_TYPE_PIN))
> +	if (!is_valid_pin(pin2, OFONO_SIM_PASSWORD_SIM_PIN2))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	cm->pending =3D dbus_message_ref(msg);
> diff --git a/src/common.c b/src/common.c
> index f25f105..60bf20c 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -649,7 +649,7 @@ const char *bearer_class_to_string(enum bearer_class =
cls)
>  	return NULL;
>  }
>  =

> -gboolean is_valid_pin(const char *pin, enum pin_type type)
> +gboolean is_valid_pin(const char *pin, enum ofono_sim_password_type type)

Why don't we keep things simple.  Modify is_valid_pin to take a pin and
a min and max number of digits.

gboolean is_valid_pin_with_limits(const char *pin, int min, int max)
(feel free to pick some better name)

Then just add two functions:

__ofono_valid_net_pin(const char *pin)
__ofono_valid_sim_pin(const char *pin, enum ofono_sim_password_type type)

Stick both in ofono.h / sim.c somewhere

>  {
>  	unsigned int i;
>  =

> @@ -662,25 +662,44 @@ gboolean is_valid_pin(const char *pin, enum pin_typ=
e type)
>  		return FALSE;
>  =

>  	switch (type) {
> -	case PIN_TYPE_PIN:
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
>  		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
>  		if (4 <=3D i && i <=3D 8)
>  			return TRUE;
>  		break;
> -	case PIN_TYPE_PUK:
> +	case OFONO_SIM_PASSWORD_PHSIM_PIN:
> +	case OFONO_SIM_PASSWORD_PHFSIM_PIN:
> +	case OFONO_SIM_PASSWORD_PHNET_PIN:
> +	case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
> +	case OFONO_SIM_PASSWORD_PHSP_PIN:
> +	case OFONO_SIM_PASSWORD_PHCORP_PIN:
> +	  /* 22.022 Section 14 4..16 IA-5 digits */
> +		if (4 <=3D i && i <=3D 16)
> +			return TRUE;
> +		break;
> +	case OFONO_SIM_PASSWORD_SIM_PUK:
> +	case OFONO_SIM_PASSWORD_SIM_PUK2:
> +	case OFONO_SIM_PASSWORD_PHFSIM_PUK:
> +	case OFONO_SIM_PASSWORD_PHNET_PUK:
> +	case OFONO_SIM_PASSWORD_PHNETSUB_PUK:
> +	case OFONO_SIM_PASSWORD_PHSP_PUK:
> +	case OFONO_SIM_PASSWORD_PHCORP_PUK:
>  		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
>  		if (i =3D=3D 8)
>  			return TRUE;
>  		break;
> -	case PIN_TYPE_NET:
> +	case OFONO_SIM_PASSWORD_PIN_TYPE_NET:
>  		/* 22.004 Section 5.2, 4 IA-5 digits */
>  		if (i =3D=3D 4)
>  			return TRUE;
>  		break;
> -	case PIN_TYPE_NONE:
> +	case OFONO_SIM_PASSWORD_NONE:
>  		if (i < 8)
>  			return TRUE;
>  		break;
> +	case OFONO_SIM_PASSWORD_INVALID:
> +		break;
>  	}
>  =

>  	return FALSE;
> diff --git a/src/common.h b/src/common.h
> index 09f2deb..acdbce5 100644
> --- a/src/common.h
> +++ b/src/common.h
> @@ -19,6 +19,8 @@
>   *
>   */
>  =

> +#include "ofono.h"
> +

Please don't do that, common.h is supposed to be semi-independent from
the rest of the core so it can be unit-tested separately.  I'm only
allowing inclusion of types.h here.  Maybe this is a bad idea, and I
will change my mind later, but for now I'd like to stick to this.

>  /* 27.007 Section 7.3 <AcT> */
>  enum access_technology {
>  	ACCESS_TECHNOLOGY_GSM =3D			0,
> @@ -122,13 +124,6 @@ enum ss_cssu {
>  	SS_MT_CALL_DEFLECTED =3D			9,
>  };
>  =

> -enum pin_type {
> -	PIN_TYPE_NONE,
> -	PIN_TYPE_PIN,
> -	PIN_TYPE_PUK,
> -	PIN_TYPE_NET,
> -};
> -
>  /* 27.007 Section 10.1.10 */
>  enum context_status {
>  	CONTEXT_STATUS_DEACTIVATED =3D 0,
> @@ -162,7 +157,7 @@ const char *ss_control_type_to_string(enum ss_control=
_type type);
>  =

>  const char *bearer_class_to_string(enum bearer_class cls);
>  =

> -gboolean is_valid_pin(const char *pin, enum pin_type type);
> +gboolean is_valid_pin(const char *pin, enum ofono_sim_password_type type=
);
>  =

>  const char *registration_status_to_string(int status);
>  const char *registration_tech_to_string(int tech);
> diff --git a/src/ofono.h b/src/ofono.h
> index 6ba0187..ddd1bb9 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -18,6 +18,8 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
>   *
>   */
> +#ifndef OFONO_H
> +#define OFONO_H
>  =


Please don't do this.  We actually leave out the include guards for a
reason.  Besides, this has no bearing on this patch.

>  #include <glib.h>
>  =

> @@ -430,3 +432,4 @@ ofono_bool_t __ofono_gprs_provision_get_settings(cons=
t char *mcc,
>  void __ofono_gprs_provision_free_settings(
>  				struct ofono_gprs_provision_data *settings,
>  				int count);
> +#endif
> diff --git a/src/sim.c b/src/sim.c
> index 41d7e1d..42d0f39 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -174,6 +174,7 @@ static gboolean password_is_pin(enum ofono_sim_passwo=
rd_type type)
>  	case OFONO_SIM_PASSWORD_PHCORP_PUK:
>  	case OFONO_SIM_PASSWORD_INVALID:
>  	case OFONO_SIM_PASSWORD_NONE:
> +	case OFONO_SIM_PASSWORD_PIN_TYPE_NET:
>  		return FALSE;
>  	}
>  =

> @@ -675,7 +676,7 @@ static DBusMessage *sim_lock_or_unlock(struct ofono_s=
im *sim, int lock,
>  			type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(pin, PIN_TYPE_PIN))
> +	if (!is_valid_pin(pin, type))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	sim->pending =3D dbus_message_ref(msg);
> @@ -747,10 +748,10 @@ static DBusMessage *sim_change_pin(DBusConnection *=
conn, DBusMessage *msg,
>  	if (password_is_pin(type) =3D=3D FALSE)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(old, PIN_TYPE_PIN))
> +	if (!is_valid_pin(old, type))
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(new, PIN_TYPE_PIN))
> +	if (!is_valid_pin(new, type))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	if (!strcmp(new, old))
> @@ -802,7 +803,7 @@ static DBusMessage *sim_enter_pin(DBusConnection *con=
n, DBusMessage *msg,
>  	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(pin, PIN_TYPE_PIN))
> +	if (!is_valid_pin(pin, type))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	sim->pending =3D dbus_message_ref(msg);
> @@ -1012,10 +1013,12 @@ static DBusMessage *sim_reset_pin(DBusConnection =
*conn, DBusMessage *msg,
>  	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(puk, PIN_TYPE_PUK))
> +	if (!is_valid_pin(puk, type))
>  		return __ofono_error_invalid_format(msg);
>  =

> -	if (!is_valid_pin(pin, PIN_TYPE_PIN))
> +	type =3D puk2pin(type);
> +
> +	if (!is_valid_pin(pin, type))
>  		return __ofono_error_invalid_format(msg);
>  =

>  	sim->pending =3D dbus_message_ref(msg);

Regards,
-Denis

--===============0269737893240780579==--

