Content-Type: multipart/mixed; boundary="===============6727182976905105365=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] Query locked pins after reset pin
Date: Thu, 12 Sep 2013 07:31:37 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141101D861A1@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <5230B4CE.5090707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6727182976905105365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > ---
> >   src/sim.c |   77
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/sim.c b/src/sim.c
> > index edae5eb..ef55b1c 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -123,6 +123,11 @@ struct msisdn_set_request {
> >   	DBusMessage *msg;
> >   };
> >
> > +struct sim_locked_query_request {
> > +	struct ofono_sim *sim;
> > +	enum ofono_sim_password_type type;
> > +};
> > +
> >   struct service_number {
> >   	char *id;
> >   	struct ofono_phone_number ph;
> > @@ -610,6 +615,57 @@ error:
> >   	return __ofono_error_invalid_args(msg);
> >   }
> >
> > +void sim_query_locked_cb(const struct ofono_error *error,
> > +			int locked, void *data)
> > +{
> > +	struct sim_locked_query_request *req =3D data;
> > +	struct ofono_sim *sim =3D req->sim;
> > +	char **locked_pins;
> > +	DBusConnection *conn =3D ofono_dbus_get_connection();
> > +	const char *path =3D __ofono_atom_get_path(sim->atom);
> > +
> > +	DBG("");
> > +
> > +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > +		g_free(req);
> > +		return;
> > +	}
> > +
> > +	if (req->type >=3D OFONO_SIM_PASSWORD_SIM_PUK) {
> > +		g_free(req);
> > +		return;
> =

> This check seems to be pointless
> =

> > +	}
> > +
> > +	sim->locked_pins[req->type] =3D locked;
> > +	DBG("sim_query_locked_cb pin_type: %d %d", req->type, locked);
> > +
> > +	locked_pins =3D get_locked_pins(sim);
> > +	ofono_dbus_signal_array_property_changed(conn, path,
> > +						OFONO_SIM_MANAGER_INTERFACE,
> > +						"LockedPins", DBUS_TYPE_STRING,
> > +						&locked_pins);
> > +	g_strfreev(locked_pins);
> > +	g_free(req);
> > +}
> > +
> > +static void __sim_query_locked(struct ofono_sim *sim,
> > +			enum ofono_sim_password_type type)
> =

> Why is this function prefixed by '__'?  The '__ofono' prefix is reserved =
for
> private APIs (e.g. functions that are not static, but not part of
> include/* public APIs).

Got it. I will change it.
> =

> > +{
> > +	struct sim_locked_query_request *req;
> > +
> > +	if (type =3D=3D OFONO_SIM_PASSWORD_NONE
> > +		|| type > OFONO_SIM_PASSWORD_PHCORP_PIN)
> > +		return;
> =

> This does not comply with our coding style guidelines.  Also, why do you
> bother checking type here since it is always guaranteed to be only
> OFONO_SIM_PASSWORD_SIM_PIN?
> =

Yes. only value between OFONO_SIM_PASSWORD_SIM_PIN and OFONO_SIM_PASSWORD_P=
HCORP_PIN is valid.
Other PUK relative value is invalid.

> > +
> > +	req =3D g_new0(struct sim_locked_query_request, 1);
> > +	req->sim =3D sim;
> > +	req->type =3D type;
> =

> This is wrong, see below:
> =

> > +
> > +	if (sim->driver->query_locked)
> > +		sim->driver->query_locked(sim, type, sim_query_locked_cb, req);
> =

> The oFono driver calling semantics do not allow for a cleanup handler.
> So if the modem hardware crashes or is removed in the time between you
> submit the request to the driver and the driver returns with the result, =
you will
> incur a memory leak.
> =

In any case, the callback (sim_query_locked_cb) will be invoked. If only th=
e callback is called,
"req" will be freed. If I am wrong, please correct me.

> > +}
> > +
> > +
> >   static void sim_locked_cb(struct ofono_sim *sim, gboolean locked)
> >   {
> >   	DBusConnection *conn =3D ofono_dbus_get_connection(); @@ -1039,6
> > +1095,25 @@ static DBusMessage *sim_get_icon(DBusConnection *conn,
> >   	return NULL;
> >   }
> >
> > +static void sim_reset_pin_cb(const struct ofono_error *error, void
> > +*data) {
> > +	struct ofono_sim *sim =3D data;
> > +	DBusMessage *reply;
> > +	enum ofono_sim_password_type type;
> > +
> > +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> > +		reply =3D __ofono_error_failed(sim->pending);
> > +	else
> > +		reply =3D dbus_message_new_method_return(sim->pending);
> > +
> > +	__ofono_dbus_pending_reply(&sim->pending, reply);
> > +
> > +	__ofono_sim_recheck_pin(sim);
> > +
> > +	for (type =3D OFONO_SIM_PASSWORD_SIM_PIN; type <
> OFONO_SIM_PASSWORD_SIM_PUK; type++)
> > +		__sim_query_locked(sim, type);
> =

> Why do you need this in the first place.  Are you suggesting that by unbl=
ocking
> the SIM PIN it somehow has the side-effect of also resetting the SIM lock
> status?
> =

It is true for IMC modem. After reset SIM PIN, the SIM PIN locking is chang=
ed. I doubt this is an issue of
IMC modem. Following is the log:

> AT+CLCK=3D"SC",2
< \r\n+CLCK: 0\r\n
< \r\nOK\r\n

> AT+CLCK=3D"SC",1,"1111"
< \r\nERROR\r\n

> AT+CMEE=3D1
< \r\nOK\r\n

> AT+CLCK=3D"SC",1,"1111"
< \r\n+CME ERROR: 16\r\n

> AT+CLCK=3D"SC",1,"1111"
< \r\n+CME ERROR: 12\r\n

> AT+CPIN=3D"13570794","1234"
< \r\nOK\r\n

> AT+CLCK=3D"SC",2
< \r\n+CLCK: 1\r\n
< \r\nOK\r\n

To be safe, query SIM PIN locked information after reset sim pin.

> > +}
> > +
> >   static DBusMessage *sim_reset_pin(DBusConnection *conn,
> DBusMessage *msg,
> >   					void *data)
> >   {
> > @@ -1074,7 +1149,7 @@ static DBusMessage
> *sim_reset_pin(DBusConnection *conn, DBusMessage *msg,
> >   		return __ofono_error_invalid_format(msg);
> >
> >   	sim->pending =3D dbus_message_ref(msg);
> > -	sim->driver->reset_passwd(sim, puk, pin, sim_enter_pin_cb, sim);
> > +	sim->driver->reset_passwd(sim, puk, pin, sim_reset_pin_cb, sim);
> >
> >   	return NULL;
> >   }
> >
> =

Regards,
Caiwen

--===============6727182976905105365==--

