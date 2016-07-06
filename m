Content-Type: multipart/mixed; boundary="===============6997272899923885286=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Query the status of SC facility lock
Date: Wed, 06 Jul 2016 10:38:25 -0500
Message-ID: <577D25F1.7040805@gmail.com>
In-Reply-To: <1467794050-32014-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6997272899923885286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 07/06/2016 03:34 AM, Slava Monich wrote:
> Otherwise "pin" entry in LockedPins may be lost after ofono is restarted.
> ---
>   src/sim.c | 80 +++++++++++++++++++++++++++++---------------------------=
-------
>   1 file changed, 37 insertions(+), 43 deletions(-)
>
> diff --git a/src/sim.c b/src/sim.c
> index aedc617..634acfc 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -2449,58 +2449,47 @@ static void sim_free_state(struct ofono_sim *sim)
>   	sim_free_main_state(sim);
>   }
>
> -static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
> -				ofono_bool_t status,
> -				void *data)
> +static void sim_set_locked_pin(struct ofono_sim *sim,
> +			enum ofono_sim_password_type type, gboolean locked)
>   {
> -	struct ofono_sim *sim =3D data;
> -	DBusConnection *conn =3D ofono_dbus_get_connection();
> -	const char *path =3D __ofono_atom_get_path(sim->atom);
> -	char **locked_pins;
> +	if (sim->locked_pins[type] !=3D locked) {
> +		char **locked_pins;
>

I'd prefer:

if (sim->locked_pins[type] =3D=3D locked)
	return;

.. do stuff ..

> -	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		ofono_error("Querying Facility Lock for IMSI Lock failed");
> -		return;
> -	}
> +		sim->locked_pins[type] =3D locked;
> +		locked_pins =3D get_locked_pins(sim);
>
> -	sim->locked_pins[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D status;
> +		ofono_dbus_signal_array_property_changed(
> +				ofono_dbus_get_connection(),
> +				__ofono_atom_get_path(sim->atom),
> +				OFONO_SIM_MANAGER_INTERFACE, "LockedPins",
> +				DBUS_TYPE_STRING, &locked_pins);
>
> -	locked_pins =3D get_locked_pins(sim);
> -
> -	ofono_dbus_signal_array_property_changed(conn,
> -				path,
> -				OFONO_SIM_MANAGER_INTERFACE,
> -				"LockedPins", DBUS_TYPE_STRING,
> -				&locked_pins);
> +		g_strfreev(locked_pins);
> +	}
> +}
>
> -	g_strfreev(locked_pins);
> +static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
> +				ofono_bool_t status, void *data)
> +{
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHSIM_PIN, status);
> +	}

This is not in-line with the Linux Kernel coding style.  Also, I'd prefer:

if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
	return;

sim_set_locked_pin...

>   }
>
>   static void sim_query_fac_networklock_cb(const struct ofono_error *erro=
r,
> -				ofono_bool_t status,
> -				void *data)
> +				ofono_bool_t status, void *data)
>   {
> -	struct ofono_sim *sim =3D data;
> -	DBusConnection *conn =3D ofono_dbus_get_connection();
> -	const char *path =3D __ofono_atom_get_path(sim->atom);
> -	char **locked_pins;
> -
> -	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		ofono_error("Querying Facility Lock for Network Lock failed");
> -		return;
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHNET_PIN, status);
>   	}
> +}

as above

>
> -	sim->locked_pins[OFONO_SIM_PASSWORD_PHNET_PIN] =3D status;
> -
> -	locked_pins =3D get_locked_pins(sim);
> -
> -	ofono_dbus_signal_array_property_changed(conn,
> -				path,
> -				OFONO_SIM_MANAGER_INTERFACE,
> -				"LockedPins", DBUS_TYPE_STRING,
> -				&locked_pins);
> -
> -	g_strfreev(locked_pins);
> +static void sim_query_fac_pinlock_cb(const struct ofono_error *error,
> +				ofono_bool_t status, void *data)
> +{
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		sim_set_locked_pin(data, OFONO_SIM_PASSWORD_SIM_PIN, status);
> +	}

as above

>   }
>
>   void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inse=
rted)
> @@ -2529,14 +2518,19 @@ void ofono_sim_inserted_notify(struct ofono_sim *=
sim, ofono_bool_t inserted)
>   	call_state_watches(sim);
>
>   	if (inserted) {
> -		sim->driver->query_facility_lock(sim,
> +		if (sim->driver->query_facility_lock) {
> +			sim->driver->query_facility_lock(sim,
>   					OFONO_SIM_PASSWORD_PHSIM_PIN,
>   					sim_query_fac_imsilock_cb, sim);
>
> -		sim->driver->query_facility_lock(sim,
> +			sim->driver->query_facility_lock(sim,
>   					OFONO_SIM_PASSWORD_PHNET_PIN,
>   					sim_query_fac_networklock_cb, sim);
>
> +			sim->driver->query_facility_lock(sim,
> +					OFONO_SIM_PASSWORD_SIM_PIN,
> +					sim_query_fac_pinlock_cb, sim);
> +		}
>   		sim_initialize(sim);

Item M1 in doc/coding-style.txt.

>   	} else {
>   		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
>

Regards,
-Denis

--===============6997272899923885286==--

