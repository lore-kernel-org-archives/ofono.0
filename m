Content-Type: multipart/mixed; boundary="===============2506338758901350006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-reset-pin-v2 1/3] sim: pass reset password type to driver
Date: Wed, 01 Sep 2010 15:09:56 -0500
Message-ID: <4C7EB314.6010808@gmail.com>
In-Reply-To: <1283190824-9876-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2506338758901350006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/30/2010 12:53 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> ---
>  include/sim.h |    5 +++--
>  src/sim.c     |    9 +++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 36a99b9..d3e564c 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -143,8 +143,9 @@ struct ofono_sim_driver {
>  			ofono_sim_passwd_cb_t cb, void *data);
>  	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
>  			ofono_sim_lock_unlock_cb_t cb, void *data);
> -	void (*reset_passwd)(struct ofono_sim *sim, const char *puk,
> -			const char *passwd,
> +	void (*reset_passwd)(struct ofono_sim *sim,
> +			enum ofono_sim_password_type type,
> +			const char *puk, const char *passwd,

Honestly I'm still lost, why are we doing this again?  reset_passwd
corresponds to CPIN from 27.007.  This one does not accept a type.  Some
modems (like the calypso) have the +CPIN2 command which can be used to
enter PIN/PUK2.  Are you trying to solve this case?

If so, we either need to add the type to both reset_passwd and
send_passwd or leave this up to the driver to figure out.

>  			ofono_sim_lock_unlock_cb_t cb, void *data);
>  	void (*change_passwd)(struct ofono_sim *sim,
>  			enum ofono_sim_password_type type,
> diff --git a/src/sim.c b/src/sim.c
> index d0b5988..5e918f2 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -747,8 +747,13 @@ static DBusMessage *sim_reset_pin(DBusConnection *co=
nn, DBusMessage *msg,
>  =

>  	type =3D sim_string_to_passwd(typestr);
>  =

> -	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
> +	switch (type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		break;
> +	default:

And now you're changing the API semantics completely.  ResetPin is
supposed to be called like this:

ResetPin("puk"/"puk2"/"corppuk"/"networkpuk"/etc, puk, newpin)

Now you're changing this to be called like:

ResetPin("pin"/"pin2", ...)

I'm not necessarily saying this is a bad idea, but this does not cover
all the other puks described in 27.007.  It also arbitrarily changes the
API with no reasoning given.

If you're making such subtle changes, at least describe the reasoning in
the commit description.  Otherwise everyone has to stare at this code
and figure out what you're doing and why.

>  		return __ofono_error_invalid_format(msg);
> +	}
>  =

>  	if (!is_valid_pin(puk, PIN_TYPE_PUK))
>  		return __ofono_error_invalid_format(msg);
> @@ -757,7 +762,7 @@ static DBusMessage *sim_reset_pin(DBusConnection *con=
n, DBusMessage *msg,
>  		return __ofono_error_invalid_format(msg);
>  =

>  	sim->pending =3D dbus_message_ref(msg);
> -	sim->driver->reset_passwd(sim, puk, pin, sim_enter_pin_cb, sim);
> +	sim->driver->reset_passwd(sim, type, puk, pin, sim_enter_pin_cb, sim);
>  =

>  	return NULL;
>  }

Regards,
-Denis

--===============2506338758901350006==--

