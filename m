Content-Type: multipart/mixed; boundary="===============2640762152855994463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-reset-pin PATCH 1/4] sim: pass reset password type to driver
Date: Thu, 26 Aug 2010 10:10:08 -0500
Message-ID: <4C7683D0.1030501@gmail.com>
In-Reply-To: <1282826957-8238-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2640762152855994463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 07:49 AM, Pekka.Pessi(a)nokia.com wrote:
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
>  			ofono_sim_lock_unlock_cb_t cb, void *data);

I don't get it, reset_passwd maps to +CPIN which does not take a type
parameter...

>  	void (*change_passwd)(struct ofono_sim *sim,
>  			enum ofono_sim_password_type type,
> diff --git a/src/sim.c b/src/sim.c
> index 04a708b..bac77e0 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -753,8 +753,13 @@ static DBusMessage *sim_reset_pin(DBusConnection *co=
nn, DBusMessage *msg,
>  =

>  	type =3D sim_string_to_passwd(typestr);
>  =

> -	if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim->pin_type)
> +	switch (type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		break;

sim->pin_type is PUK or PUK2  here, not PIN/PIN2.

> +	default:
>  		return __ofono_error_invalid_format(msg);
> +	}
>  =

>  	if (!is_valid_pin(puk, PIN_TYPE_PUK))
>  		return __ofono_error_invalid_format(msg);
> @@ -763,7 +768,7 @@ static DBusMessage *sim_reset_pin(DBusConnection *con=
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

--===============2640762152855994463==--

