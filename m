Content-Type: multipart/mixed; boundary="===============0492486017855373503=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Wed, 23 Feb 2011 00:15:13 -0600
Message-ID: <4D64A5F1.5090004@gmail.com>
In-Reply-To: <1298376352-24521-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0492486017855373503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>  include/sim.h    |    2 ++
>  src/call-meter.c |   27 +++++++++++++++++++++++++++
>  src/sim.c        |    8 ++++----
>  3 files changed, 33 insertions(+), 4 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 412ae44..a56056e 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -227,6 +227,8 @@ unsigned int ofono_sim_add_file_watch(struct ofono_si=
m_context *context,
>  void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
>  					unsigned int id);
>  =

> +void sim_pin_check(struct ofono_sim *sim);
> +

Please name this __ofono_sim_recheck_pin(struct ofono_sim *sim);

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/src/call-meter.c b/src/call-meter.c
> index 0789935..61678d8 100644
> --- a/src/call-meter.c
> +++ b/src/call-meter.c
> @@ -335,11 +335,20 @@ static void set_acm_max_query_callback(const struct=
 ofono_error *error,
>  static void set_acm_max_callback(const struct ofono_error *error, void *=
data)
>  {
>  	struct ofono_call_meter *cm =3D data;
> +	struct ofono_atom *sim_atom;
> +	struct ofono_sim *sim =3D NULL;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBG("Setting acm_max failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
> +		sim_atom =3D __ofono_modem_find_atom(
> +			__ofono_atom_get_modem(cm->atom),
> +				OFONO_ATOM_TYPE_SIM);
> +		if (!sim_atom)

doc/coding-style.txt M1, and M13

> +			return;
> +		sim =3D __ofono_atom_get_data(sim_atom);

doc/coding-style.txt M1

> +		sim_pin_check(sim);
>  		return;
>  	}
>

And please factor out this code into a separate function, you repeat it
three times.

> @@ -396,11 +405,20 @@ static void set_puct_query_callback(const struct of=
ono_error *error,
>  static void set_puct_callback(const struct ofono_error *error, void *dat=
a)
>  {
>  	struct ofono_call_meter *cm =3D data;
> +	struct ofono_atom *sim_atom;
> +	struct ofono_sim *sim =3D NULL;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBG("setting puct failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
> +		sim_atom =3D __ofono_modem_find_atom(
> +			__ofono_atom_get_modem(cm->atom),
> +				OFONO_ATOM_TYPE_SIM);
> +		if (!sim_atom)
> +			return;
> +		sim =3D __ofono_atom_get_data(sim_atom);
> +		sim_pin_check(sim);
>  		return;
>  	}
>  =

> @@ -593,11 +611,20 @@ static void reset_acm_query_callback(const struct o=
fono_error *error, int value,
>  static void acm_reset_callback(const struct ofono_error *error, void *da=
ta)
>  {
>  	struct ofono_call_meter *cm =3D data;
> +	struct ofono_atom *sim_atom;
> +	struct ofono_sim *sim =3D NULL;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBG("reseting acm failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
> +		sim_atom =3D __ofono_modem_find_atom(
> +			__ofono_atom_get_modem(cm->atom),
> +				OFONO_ATOM_TYPE_SIM);
> +		if (!sim_atom)
> +			return;
> +		sim =3D __ofono_atom_get_data(sim_atom);
> +		sim_pin_check(sim);
>  		return;
>  	}
>  =

> diff --git a/src/sim.c b/src/sim.c
> index c39269d..08236f2 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -49,7 +49,6 @@
>  static GSList *g_drivers =3D NULL;
>  =

>  static void sim_own_numbers_update(struct ofono_sim *sim);
> -static void sim_pin_check(struct ofono_sim *sim);
>  =

>  struct ofono_sim {
>  	/* Contents of the SIM file system, in rough initialization order */
> @@ -2231,8 +2230,9 @@ static void sim_pin_query_cb(const struct ofono_err=
or *error,
>  						&pin_name);
>  	}
>  =

> -	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
> -			sim->state =3D=3D OFONO_SIM_STATE_READY) {
> +	if ((pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
> +			sim->state =3D=3D OFONO_SIM_STATE_READY) &&
> +				(pin_type !=3D OFONO_SIM_PASSWORD_SIM_PIN2)) {

I don't see how this can work.  You need to check for pin_type !=3D NONE,
PIN2 and PUK2 AND state =3D=3D READY here.  This also only covers the case
of the PIN2 or PUK2 being triggered when call-meter is active.  You do
not take care of the case where PIN2 or PUK2 are already required during
sim initialization.

>  		/* Force the sim state out of READY */
>  		sim_free_main_state(sim);
>  =

> @@ -2247,7 +2247,7 @@ checkdone:
>  		sim_initialize_after_pin(sim);
>  }
>  =

> -static void sim_pin_check(struct ofono_sim *sim)
> +void sim_pin_check(struct ofono_sim *sim)
>  {
>  	if (sim->driver->query_passwd_state =3D=3D NULL) {
>  		sim_initialize_after_pin(sim);

Regards,
-Denis

--===============0492486017855373503==--

