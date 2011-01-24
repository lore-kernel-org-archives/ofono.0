Content-Type: multipart/mixed; boundary="===============6485704491747604718=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check if lock is locked after code input attempt
Date: Mon, 24 Jan 2011 16:32:47 -0600
Message-ID: <4D3DFE0F.3070607@gmail.com>
In-Reply-To: <1295264045.18761.35.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6485704491747604718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 01/17/2011 05:34 AM, Jussi Kangas wrote:
> Hi again,
> =

> This is third attempt to fix the problem where PUK required information
> is not shown correctly after user tries to change pin code too many
> times with wrong passwords. Basically solution is pretty much as in
> original made by Marit Henriksen except it does not do the sim interface
> initialization anymore and it goes to PRE_SIM state if PUK is required
> except in case of PIN2. Fix is also extended to pin locking and pin
> unlocking.  =

> =

> Br,
> -Jussi
> =

> ---
>  src/sim.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d627647..00f0463 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -622,6 +622,45 @@ static void sim_locked_cb(struct ofono_sim *sim,
> gboolean locked)
>  	sim_pin_retries_check(sim);
>  }
>  =

> +static void fail_reason_check_cb(const struct ofono_error *error,
> +				enum ofono_sim_password_type pin_type,
> +				void *data)
> +{
> +	struct ofono_sim *sim =3D data;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(sim->atom);
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
> +	const char *pin_name;
> +
> +	if (sim->pin_type !=3D pin_type) {
> +		sim->pin_type =3D pin_type;
> +		pin_name =3D sim_passwd_name(pin_type);
> +
> +		if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
> +				password_is_pin(pin_type) =3D=3D FALSE)
> +			pin_type =3D puk2pin(pin_type);
> +
> +		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
> +			sim->locked_pins[pin_type] =3D TRUE;
> +
> +		ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_SIM_MANAGER_INTERFACE,
> +						"PinRequired", DBUS_TYPE_STRING,
> +						&pin_name);
> +
> +		if ((sim->state !=3D OFONO_SIM_STATE_READY) ||
> +		   ((sim->locked_pins[pin_type] =3D=3D TRUE) && (

Please don't mix tabs and spaces for indentation

> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSIM_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHFSIM_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNET_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNETSUB_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSP_PIN ||
> +		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHCORP_PIN)))
> +			ofono_modem_reset(modem);

So I'm mostly happy with this approach except that ofono_modem_reset is
too big of a hammer to use here.  We need something that drops us back
to pre-sim state without having to re-power on the device (which is what
reset does).

Can you try using sim_inserted / sim_removed or maybe even be smarter
and do 90% of what sim removal does but without affecting information
which is already read.  So things like EFiccid, EFpl/EFlp, EFecc, etc.

Regards,
-Denis

--===============6485704491747604718==--

