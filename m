Content-Type: multipart/mixed; boundary="===============7925324494212976693=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 03 Jan 2019 18:09:54 -0600
Message-ID: <e3bda6a9-f878-f615-ae0f-27f382b8ab47@gmail.com>
In-Reply-To: <1546513282-13190-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7925324494212976693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nandini,

On 01/03/2019 05:01 AM, Nandini Rebello wrote:
> Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN1 ty=
pe
> against the ICCID throughout its lifetime in a link list and enters
> implicitly upon modem reset/crash.
> =

> Violates 3GPP spec 21.111, section 5.3 - User Data stored in ME. Helps
> in user experience by not barring out cellular services unless pin is ent=
ered
> manually.
> =

> Handles cases of incorrect pin and sim pin changed externally.
> Clears all cached PINs incase modem disabled manually and selectively when
> sim is removed.
> =

> Adding to all modems by default.
> ---
>   src/sim.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 128 insertions(+)
> =


<snip>

> +static void pin_cache_enter_cb(const struct ofono_error *error, void *da=
ta)
> +{
> +	struct ofono_sim *sim =3D data;
> +
> +	/* If PIN entry fails, then remove cached PIN*/
> +	if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {

Hm, I just noticed that this if condition is incorrect.  You shouldn't =

be removing the pin if sim->initialized is true.  This would break =

drivers that call ofono_sim_initialized right after ofono_sim_inserted. =

See commit 54d56d763e40bc44c99a9b24aa0477bd373ea085 for details.

> +		pin_cache_remove(sim->iccid);
> +		goto recheck;
> +	}
> +
> +	if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
> +			sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
> +		sim->wait_initialized =3D true;
> +		DBG("Waiting for ofono_sim_initialized_notify");
> +		return;
> +	}
> +
> +recheck:
> +	__ofono_sim_recheck_pin(sim);

Actually this whole function might be better written as:

if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
	pin_cache_remove(sim->iccid);

sim_enter_pin_cb(...);

> +}
> +
>   static void sim_pin_retries_query_cb(const struct ofono_error *error,
>   					int retries[OFONO_SIM_PASSWORD_INVALID],
>   					void *data)
> @@ -683,6 +762,13 @@ static void sim_locked_cb(struct ofono_sim *sim, gbo=
olean locked)
>   						OFONO_SIM_MANAGER_INTERFACE,
>   						"LockedPins", DBUS_TYPE_STRING,
>   						&locked_pins);
> +
> +	/*Cache pin only for SIM PIN type*/
> +	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +		if (!pin_cache_update(sim->iccid, pin))
> +			ofono_error("Failed to cache PIN.");

pin_cache_update really cannot fail since g_new0 will never fail...

> +	}
> +
>   	g_strfreev(locked_pins);
>   =

>   	sim_pin_retries_check(sim);
> @@ -778,6 +864,14 @@ static DBusMessage *sim_unlock_pin(DBusConnection *c=
onn, DBusMessage *msg,
>   static void sim_change_pin_cb(const struct ofono_error *error, void *da=
ta)
>   {
>   	struct ofono_sim *sim =3D data;
> +	const char *typestr;
> +	const char *old;
> +	const char *new;
> +
> +	dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &typestr,
> +					     DBUS_TYPE_STRING, &old,
> +					     DBUS_TYPE_STRING, &new,
> +				             DBUS_TYPE_INVALID);
>   =

>   	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>   		__ofono_dbus_pending_reply(&sim->pending,
> @@ -788,6 +882,12 @@ static void sim_change_pin_cb(const struct ofono_err=
or *error, void *data)
>   		return;
>   	}
>   =

> +	/*Cache pin only for SIM PIN type*/
> +	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +		if (!pin_cache_update(sim->iccid, new))
> +			ofono_error("Failed to cache PIN.");

As above

> +	}
> +
>   	__ofono_dbus_pending_reply(&sim->pending,
>   				dbus_message_new_method_return(sim->pending));
>   =

> @@ -839,8 +939,14 @@ static DBusMessage *sim_change_pin(DBusConnection *c=
onn, DBusMessage *msg,
>   static void sim_enter_pin_cb(const struct ofono_error *error, void *dat=
a)
>   {
>   	struct ofono_sim *sim =3D data;
> +	const char *typestr;
> +	const char *pin;
>   	DBusMessage *reply;
>   =

> +	dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &typestr,
> +					     DBUS_TYPE_STRING, &pin,
> +					     DBUS_TYPE_INVALID);
> +
>   	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>   		reply =3D __ofono_error_failed(sim->pending);
>   	else
> @@ -852,6 +958,12 @@ static void sim_enter_pin_cb(const struct ofono_erro=
r *error, void *data)
>   	if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>   		goto recheck;
>   =

> +	/*Cache pin only for SIM PIN type*/
> +	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +		if (!pin_cache_update(sim->iccid, pin))
> +			ofono_error("Failed to cache PIN.");

And here

> +	}
> +
>   	if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
>   			sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
>   		sim->wait_initialized =3D true;

<snip>

> @@ -3301,6 +3420,15 @@ void ofono_sim_register(struct ofono_sim *sim)
>   	__ofono_atom_register(sim->atom, sim_unregister);
>   }
>   =

> +void ofono_sim_clear_cached_pins(void)
> +{
> +	if (cached_pins =3D=3D NULL)
> +		return;
> +
> +	g_slist_free_full(cached_pins, g_free);
> +	cached_pins =3D NULL;

Why would you clear the entire cache?  Don't you want to clear only the =

currently inserted iccid?

> +}
> +
>   void ofono_sim_remove(struct ofono_sim *sim)
>   {
>   	__ofono_atom_free(sim->atom);
> =


Regards,
-Denis

--===============7925324494212976693==--

