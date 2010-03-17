Content-Type: multipart/mixed; boundary="===============1311059658773175172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8][RFC] Invalidate SIM manager properties when SIM
 extracted, add Present property.
Date: Wed, 17 Mar 2010 15:10:51 -0600
Message-ID: <201003171610.51399.denkenz@gmail.com>
In-Reply-To: <1268688136-4209-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1311059658773175172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  src/sim.c |  107
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++------- 1 files
>  changed, 95 insertions(+), 12 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index cddb3e4..fe535bb 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -285,6 +285,7 @@ static DBusMessage *sim_get_properties(DBusConnection
>  *conn, char **service_numbers;
>  	char **locked_pins;
>  	const char *pin_name;
> +	dbus_bool_t present =3D sim->inserted;
> =

>  	reply =3D dbus_message_new_method_return(msg);
>  	if (!reply)
> @@ -296,6 +297,8 @@ static DBusMessage *sim_get_properties(DBusConnection
>  *conn, OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  					&dict);
> =

> +	ofono_dbus_dict_append(&dict, "Present", DBUS_TYPE_BOOLEAN, &present);
> +

I suggest you simply skip the rest of the properties if Present is false an=
d =

skip checking each and every one afterwards.

> @@ -992,6 +1001,8 @@ static void sim_imsi_cb(const struct ofono_error
>  *error, const char *imsi, void *data)
>  {
>  	struct ofono_sim *sim =3D data;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(sim->atom);
> =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		ofono_error("Unable to read IMSI, emergency calls only");
> @@ -1000,6 +1011,11 @@ static void sim_imsi_cb(const struct ofono_error
>  *error, const char *imsi,
> =

>  	sim->imsi =3D g_strdup(imsi);
> =

> +	ofono_dbus_signal_property_changed(conn, path,
> +					SIM_MANAGER_INTERFACE,
> +					"SubscriberIdentity",
> +					DBUS_TYPE_STRING, &sim->imsi);
> +
>  	/* Read CPHS-support bits, this is still part of the SIM
>  	 * initialisation but no order is specified for it.  */
>  	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
> @@ -1755,9 +1771,21 @@ const unsigned char
>  *ofono_sim_get_cphs_service_table(struct ofono_sim *sim) return
>  sim->cphs_service_table;
>  }
> =

> +static void sim_inserted_update(struct ofono_sim *sim)
> +{
> +	dbus_bool_t present =3D sim->inserted;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(sim->atom);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +			SIM_MANAGER_INTERFACE, "Present",
> +			DBUS_TYPE_BOOLEAN, &present);
> +}
> +
>  void ofono_sim_inserted(struct ofono_sim *sim)
>  {
>  	sim->inserted =3D TRUE;
> +	sim_inserted_update(sim);
> =

>  	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
>  	 * The assumption here is that if sim manager is being initialized,
> @@ -1781,6 +1809,18 @@ void ofono_sim_inserted(struct ofono_sim *sim)
>  	sim_determine_phase(sim);
>  }
> =

> +static void sim_file_op_fail(struct sim_file_op *op)
> +{
> +	if (op->is_read =3D=3D TRUE)
> +		((ofono_sim_file_read_cb_t) op->cb)
> +			(0, 0, 0, 0, 0, op->userdata);
> +	else
> +		((ofono_sim_file_write_cb_t) op->cb)
> +			(0, op->userdata);
> +
> +	sim_file_op_free(op);
> +}
> +
>  void ofono_sim_removed(struct ofono_sim *sim)
>  {
>  	GSList *l;
> @@ -1790,18 +1830,61 @@ void ofono_sim_removed(struct ofono_sim *sim)
>  		return;
> =

>  	sim->inserted =3D FALSE;
> +	sim_inserted_update(sim);
> =

>  	if (sim->ready =3D=3D FALSE)
>  		return;
> =

>  	sim->ready =3D FALSE;
> =

> +	if (sim->simop_source) {
> +		g_source_remove(sim->simop_source);
> +		sim->simop_source =3D 0;
> +	}
> +
> +	if (sim->simop_q) {
> +		/* NOTE: there's an assumption here that the op's callback
> +		 * does not queue new ops on failure... */
> +		g_queue_foreach(sim->simop_q, (GFunc) sim_file_op_fail, NULL);
> +		g_queue_free(sim->simop_q);
> +		sim->simop_q =3D NULL;
> +	}
> +

You have to be really careful here, it is possible that we have an operatio=
n =

pending with the driver, so the driver will call back for that one.  Also, =

since you're removing everything anyway I see no need to call the error =

callback.

>  	for (l =3D sim->removed_watches->items; l; l =3D l->next) {
>  		struct ofono_watchlist_item *item =3D l->data;
>  		notify =3D item->notify;
> =

>  		notify(item->notify_data);
>  	}
> +
> +	if (sim->imsi) {
> +		g_free(sim->imsi);
> +		sim->imsi =3D NULL;
> +	}
> +
> +	if (sim->own_numbers) {
> +		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
> +		g_slist_free(sim->own_numbers);
> +		sim->own_numbers =3D NULL;
> +	}
> +
> +	if (sim->service_numbers) {
> +		g_slist_foreach(sim->service_numbers,
> +				(GFunc)service_number_free, NULL);
> +		g_slist_free(sim->service_numbers);
> +		sim->service_numbers =3D NULL;
> +	}
> +
> +	if (sim->efli) {
> +		g_free(sim->efli);
> +		sim->efli =3D NULL;
> +		sim->efli_length =3D 0;
> +	}
> +
> +	if (sim->language_prefs) {
> +		g_strfreev(sim->language_prefs);
> +		sim->language_prefs =3D NULL;
> +	}

This needs to be put into a common destructor instead of duplicating =

everything twice.

>  }
> =

>  static void sim_command_fetch_cb(const struct ofono_error *error,
> =


Regards,
-Denis

--===============1311059658773175172==--

