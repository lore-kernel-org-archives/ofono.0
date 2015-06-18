Content-Type: multipart/mixed; boundary="===============0618227899751054981=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] [sim] Emit LockedPins after pin_type is queried
Date: Wed, 17 Jun 2015 23:07:53 -0500
Message-ID: <55824419.5080703@gmail.com>
In-Reply-To: <1434628017-28441-2-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0618227899751054981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 06/18/2015 06:46 AM, Tommi Kenakkala wrote:
> Fixes property change not being emited when hot-swapping a
> PIN-enabled card.
> ---
>   src/sim.c |   20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/src/sim.c b/src/sim.c
> index b5badf1..0bcafe0 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -2737,6 +2737,10 @@ static void sim_pin_query_cb(const struct ofono_er=
ror *error,
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>   	const char *path =3D __ofono_atom_get_path(sim->atom);
>   	const char *pin_name;
> +	char **locked_pins;
> +	gboolean lock_changed;
> +
> +	DBG("sim->pin_type: %d, pin_type: %d", sim->pin_type, pin_type);
>
>   	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>   		ofono_error("Querying PIN authentication state failed");
> @@ -2751,9 +2755,23 @@ static void sim_pin_query_cb(const struct ofono_er=
ror *error,
>   				password_is_pin(pin_type) =3D=3D FALSE)
>   			pin_type =3D puk2pin(pin_type);
>
> -		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
> +		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID) {

you might want to add && pin_type !=3D OFONO_SIM_PASSWORD_NONE here.  See =

below.

> +			lock_changed =3D !sim->locked_pins[pin_type];
> +

So when do you want to emit LockedPins here?  Only when the list is =

non-empty or always?

There is a subtlety here.  OFONO_SIM_PASSWORD_NONE is never considered =

when emitting LockedPins.  However, in this proposal you can trigger a =

LockedPins emission even if there's no PIN set.

To me it seems like emitting LockedPins with an empty value seems =

unnecessary.  Thoughts?

>   			sim->locked_pins[pin_type] =3D TRUE;
>
> +			if (lock_changed) {
> +				locked_pins =3D get_locked_pins(sim);
> +
> +				ofono_dbus_signal_array_property_changed(conn,
> +						path,
> +						OFONO_SIM_MANAGER_INTERFACE,
> +						"LockedPins", DBUS_TYPE_STRING,
> +						&locked_pins);
> +
> +				g_strfreev(locked_pins);
> +			}
> +		}
>   		ofono_dbus_signal_property_changed(conn, path,
>   						OFONO_SIM_MANAGER_INTERFACE,
>   						"PinRequired", DBUS_TYPE_STRING,
>

Regards,
-Denis

--===============0618227899751054981==--

