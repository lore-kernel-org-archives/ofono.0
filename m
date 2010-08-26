Content-Type: multipart/mixed; boundary="===============0999851522385914558=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sim: add ofono_sim_ready_notify() support
Date: Thu, 26 Aug 2010 11:10:18 -0500
Message-ID: <4C7691EA.1070506@gmail.com>
In-Reply-To: <AANLkTi=23A=db++wwE0wsrmQk7P0=9Cip00+XRg1BvDA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0999851522385914558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 10:49 AM, Pekka Pessi wrote:
> Hi Kristen and all,
> =

> This is what I have in mind:
> - no sim_pin_check after return from sim_pin_enter() but driver calls
> sim_ready_notify()
> - if driver has no pin check, retry initialization after sim_ready_notify=
()
> - when SIM requires PUK, change state back to SIM_INSERTED

Isn't it already in state SIM_INSERTED?  We go to SIM_INSERTED as soon
as the driver calls sim_inserted_notify()

> =

> There is no sim_set_state() yet, it has to be added
> =

> PIN2 and PUK2 results from pin query should be ignored, they are
> transient and do not prevent SIM from being ready.
> =

> --Pekka
> =

> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -80,6 +80,15 @@ struct ofono_sim {
>  	gboolean sdn_ready;
>  	enum ofono_sim_state state;
>  	enum ofono_sim_password_type pin_type;
> +	union {
> +		struct {
> +			unsigned pre_pin_started:1;
> +			unsigned pre_pin_done:1;
> +			unsigned post_pin_started:1;
> +			unsigned ready_notified:1;
> +		};
> +		unsigned all;
> +	} init;
>  	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
>  	char **language_prefs;
>  	GQueue *simop_q;
> @@ -693,8 +702,6 @@ static void sim_enter_pin_cb(const struct
> ofono_error *error, void *data)
>  		reply =3D dbus_message_new_method_return(sim->pending);
> =

>  	__ofono_dbus_pending_reply(&sim->pending, reply);
> -
> -	sim_pin_check(sim);

You do want to check the PIN if this is not PIN/PIN2.  E.g. some weird
carrier/corp/etc lock.

>  }
> =

>  static DBusMessage *sim_enter_pin(DBusConnection *conn, DBusMessage *msg,
> @@ -980,6 +987,12 @@ static void sim_imsi_cb(const struct ofono_error
> *error, const char *imsi,
> =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		ofono_error("Unable to read IMSI, emergency calls only");
> +
> +		sim->init.post_pin_started =3D 0;
> +
> +		if (sim->init.ready_notified)
> +			sim_pin_check(sim);
> +

I am lost, are we polling the IMSI here?  What is the point of
sim_ready_notify then?

>  		return;
>  	}
> =

> @@ -1130,6 +1143,9 @@ static void sim_efphase_read_cb(int ok, int
> length, int record,
> =

>  static void sim_initialize_after_pin(struct ofono_sim *sim)
>  {
> +	sim->init.post_pin_started =3D 1;
> +	sim->init.ready_notified =3D 0;
> +
>  	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
>  			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>  			sim_efphase_read_cb, sim);
> @@ -1167,6 +1183,10 @@ static void sim_pin_query_cb(const struct
> ofono_error *error,
>  		goto checkdone;
>  	}
> =

> +	if (pin_type =3D=3D OFONO_SIM_PASSWORD_PIN2 ||
> +			pin_type =3D=3D OFONO_SIM_PASSWORD_PUK2)
> +		pin_type =3D OFONO_SIM_PASSWORD_NONE;
> +

Again, not sure you can really assume that if there are other PINs present.

>  	if (sim->pin_type !=3D pin_type) {
>  		sim->pin_type =3D pin_type;
>  		pin_name =3D sim_passwd_name(pin_type);
> @@ -1185,7 +1205,18 @@ static void sim_pin_query_cb(const struct
> ofono_error *error,
>  	}
> =

>  checkdone:
> -	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
> +	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE) {
> +		int ready_notified =3D sim->init.ready_notified;
> +
> +		sim->init.post_pin_started =3D 0;
> +		sim->init.ready_notified =3D 0;
> +
> +		sim_set_state(sim, OFONO_SIM_STATE_INSERTED);
> +
> +		return;
> +	}
> +
> +	if (sim->init.pre_pin_done && !sim->init.post_pin_started)
>  		sim_initialize_after_pin(sim);

I am lost here :) I think we need to talk this over on IRC.

>  }
> =

> @@ -1199,6 +1230,22 @@ static void sim_pin_check(struct ofono_sim *sim)
>  	sim->driver->query_passwd_state(sim, sim_pin_query_cb, sim);
>  }
> =

> +void ofono_sim_ready_notify(struct ofono_sim *sim)
> +{
> +	if (sim =3D=3D NULL)
> +		return;
> +
> +	sim->init.ready_notified =3D 1;
> +
> +	if (sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
> +		return;
> +
> +	if (!sim->init.pre_pin_done)
> +		return;
> +
> +	sim_pin_check(sim);
> +}
> +
>  static void sim_efli_read_cb(int ok, int length, int record,
>  				const unsigned char *data,
>  				int record_length, void *userdata)
> @@ -1379,6 +1426,8 @@ skip_efpl:
>  						DBUS_TYPE_STRING,
>  						&sim->language_prefs);
> =

> +	sim->init.pre_pin_done =3D 1;
> +
>  	sim_pin_check(sim);
>  }
> =

> @@ -1407,6 +1456,8 @@ static void sim_iccid_read_cb(int ok, int
> length, int record,
> =

>  static void sim_initialize(struct ofono_sim *sim)
>  {
> +	sim->init.pre_pin_started =3D 1;
> +
>  	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
>  	 * The assumption here is that if sim manager is being initialized,
>  	 * then sim commands are implemented, and the sim manager is then
>  static void sim_free_state(struct ofono_sim *sim)
> @@ -2007,6 +2060,8 @@ static void sim_free_state(struct ofono_sim *sim)
>  		g_free(sim->iccid);
>  		sim->iccid =3D NULL;
>  	}
> +
> +	sim->init.all =3D 0;
>  }
> =

>  void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inser=
ted)
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
-Denis

--===============0999851522385914558==--

