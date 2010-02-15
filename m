Content-Type: multipart/mixed; boundary="===============4818620139499728439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH, rfc] Handle network-initiated ussd requests.
Date: Mon, 15 Feb 2010 11:03:38 -0600
Message-ID: <201002151103.39231.denkenz@gmail.com>
In-Reply-To: <1265950374-15291-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4818620139499728439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This adds the methods on the D-bus interface to allow the
> client to handle USSD requests from the network, according to 22.090.
> Unfortunately this document is not clear on every point and some
> details can't be implemented.  This includes reporting unsupported
> request to the network, unsupported language, ME busy etc, because
> there isn't an AT command for that.
> =

> To be really pedantic, the Initiate() return value and the
> NotificationReceived() and RequestReceived()  signals should also
> supply the language of the string.  I also first added a "Timeout"
> property with default value of 10 seconds after which oFono
> automatically replies "not supported" to network-initiated requests, so
> that it is compliant when no client listents to the signals, but removed
> it because it isn't useful.
> ---
>  doc/ussd-api.txt |   45 ++++++++++++++++++
>  include/ussd.h   |    4 ++
>  src/ussd.c       |  135
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++-- 3 files =

changed,
>  180 insertions(+), 4 deletions(-)
>  create mode 100644 doc/ussd-api.txt
> =

> diff --git a/doc/ussd-api.txt b/doc/ussd-api.txt
> new file mode 100644
> index 0000000..0f42b3a
> --- /dev/null
> +++ b/doc/ussd-api.txt
> @@ -0,0 +1,45 @@
> +SupplementaryServices hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.SupplementaryServices
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		string, variant Initiate(string command)
> +
> +			Sends a USSD command string to the network
> +			initiating a session.  When the request is handled
> +			by the appropriate node of the network, the
> +			method returns the response or an appropriate
> +			error.  The network may be awaiting further response
> +			from the ME after returning from this method and no
> +			new command can be initiated until this one is
> +			cancelled or ended.
> +
> +		void Respond(string reply)
> +
> +			Send a response to the network either when
> +			it is awaiting further input after Initiate()
> +			was called or after a network-initiated request.
> +
> +		void Cancel()
> +
> +			Cancel an ongoing USSD session, mobile- or
> +			network-initiated.
> +
> +		void NotSupported()
> +
> +			Send a "not supported" response to a network's
> +			request, ending current session.

Let us get rid of this for now

> +
> +Signals		NotificationReceived(string attribute, variant value)
> +
> +			Signal is emitted on a network-initiated USSD
> +			request for which no response is needed.

There is no reason to use string / variant pair here.  This was done on =

Initiate return to allow known supplementary service =

register/activate/interrogate/deactivate/erasure support.  Since we know th=
is =

is a basic text USSD, we can just send a string here.

> +
> +		RequestReceived(string attribute, variant value)
> +
> +			Signal is emitted on a network-initiated USSD
> +			request for which a response must be sent using
> +			the Respond method unless it is cancelled or
> +			the request is not supported.

Same as above, a simple string will do.

> diff --git a/include/ussd.h b/include/ussd.h
> index 96e04cb..1f66de0 100644
> --- a/include/ussd.h
> +++ b/include/ussd.h
> @@ -47,8 +47,12 @@ struct ofono_ussd_driver {
>  	void (*remove)(struct ofono_ussd *ussd);
>  	void (*request)(struct ofono_ussd *ussd, const char *str,
>  				ofono_ussd_cb_t, void *data);
> +	void (*respond)(struct ofono_ussd *ussd, const char *str,
> +				ofono_ussd_cb_t, void *data);

Respond is the same as request, there's really no need for a separate metho=
d =

here.

>  	void (*cancel)(struct ofono_ussd *ussd,
>  				ofono_ussd_cb_t cb, void *data);
> +	void (*respond_not_supported)(struct ofono_ussd *ussd,
> +				ofono_ussd_cb_t cb, void *data);
>  };

No modem I know of actually implements this and it is not in the standards.=
  =

Let us just use cancel for now.

> =

>  void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char
>  *str); diff --git a/src/ussd.c b/src/ussd.c
> index 4221dfa..6416ee9 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -274,6 +274,11 @@ out:
>  	return ret;
>  }
> =

> +static void ussd_not_supported_callback(const struct ofono_error *error,
> +		void *data)
> +{
> +}
> +
>  void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char
>  *str) {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
> @@ -303,14 +308,14 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int
>  status, const char *str) goto out;
>  	}
> =

> +	if (!str)
> +		str =3D "";
> +

This should be in a separate cleanup patch.

>  	/* TODO: Rework this in the Agent framework */
>  	if (ussd->state =3D=3D USSD_STATE_ACTIVE) {
> =

>  		reply =3D dbus_message_new_method_return(ussd->pending);
> =

> -		if (!str)
> -			str =3D "";
> -

As above.

>  		dbus_message_iter_init_append(reply, &iter);
> =

>  		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
> @@ -329,10 +334,46 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int
>  status, const char *str) else
>  			ussd->state =3D USSD_STATE_IDLE;
> =

> +	} else if (ussd->state =3D=3D USSD_STATE_IDLE && ussd->pending =3D=3D N=
ULL) {
> +		DBusMessage *signal;
> +		const char *signal_name;
> +		const char *path =3D __ofono_atom_get_path(ussd->atom);
> +
> +		if (status =3D=3D OFONO_USSD_STATUS_ACTION_REQUIRED) {
> +			ussd->state =3D USSD_STATE_USER_ACTION;
> +			signal_name =3D "RequestReceived";
> +		} else {
> +			ussd->state =3D USSD_STATE_IDLE;
> +			signal_name =3D "NotificationReceived";
> +		}
> +
> +		signal =3D dbus_message_new_signal(path,
> +				SUPPLEMENTARY_SERVICES_INTERFACE,
> +				signal_name);
> +
> +		dbus_message_iter_init_append(signal, &iter);
> +
> +		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
> +						&ussdstr);
> +
> +		dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, sig,
> +							&variant);
> +
> +		dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING,
> +						&str);
> +
> +		dbus_message_iter_close_container(&iter, &variant);
> +
> +		g_dbus_send_message(conn, signal);
> +		return;

g_dbus_emit_signal will be enough here.

>  	} else {
>  		ofono_error("Received an unsolicited USSD, ignoring for now...");
>  		DBG("USSD is: status: %d, %s", status, str);
> =

> +		if (ussd->driver->respond_not_supported)
> +			ussd->driver->respond_not_supported(ussd,
> +					ussd_not_supported_callback, NULL);
> +
>  		return;

There's no reason for this else clause to exist now.  The above else if =

condition is handling this case too.  Just look carefully at ussd driver fo=
r =

AT command modems, we always call back first, then issue ussd_notify.  This=
 is =

the case for both modems with and without cancel support.

>  	}
> =

> @@ -380,7 +421,7 @@ static DBusMessage *ussd_initiate(DBusConnection *con=
n,
>  DBusMessage *msg, if (ussd->flags & USSD_FLAG_PENDING)
>  		return __ofono_error_busy(msg);
> =

> -	if (ussd->state =3D=3D USSD_STATE_ACTIVE)
> +	if (ussd->state !=3D USSD_STATE_IDLE)
>  		return __ofono_error_busy(msg);
> =

>  	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &str,
> @@ -411,6 +452,64 @@ static DBusMessage *ussd_initiate(DBusConnection
>  *conn, DBusMessage *msg, return NULL;
>  }
> =

> +static void ussd_response_callback(const struct ofono_error *error, void
>  *data) +{
> +	struct ofono_ussd *ussd =3D data;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	DBusMessage *reply;
> +
> +	ussd->flags &=3D ~USSD_FLAG_PENDING;
> +
> +	if (!ussd->pending)
> +		return;
> +
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		ussd->state =3D USSD_STATE_IDLE;
> +
> +		reply =3D dbus_message_new_method_return(ussd->pending);
> +	} else {
> +		DBG("ussd response failed with error: %s",
> +				telephony_error_to_str(error));
> +
> +		reply =3D __ofono_error_failed(ussd->pending);
> +	}
> +
> +	g_dbus_send_message(conn, reply);
> +
> +	dbus_message_unref(ussd->pending);
> +	ussd->pending =3D NULL;

__ofono_dbus_pending_reply please.

> +}
> +
> +static DBusMessage *ussd_respond(DBusConnection *conn, DBusMessage *msg,
> +					void *data)
> +{
> +	struct ofono_ussd *ussd =3D data;
> +	const char *str;
> +
> +	if (ussd->flags & USSD_FLAG_PENDING)
> +		return __ofono_error_busy(msg);
> +
> +	if (ussd->state !=3D USSD_STATE_USER_ACTION)
> +		return __ofono_error_not_active(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &str,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (strlen(str) =3D=3D 0)
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (!ussd->driver->respond)
> +		return __ofono_error_not_implemented(msg);
> +
> +	ussd->flags |=3D USSD_FLAG_PENDING;

Don't use this flag anymore, I've taken it out.

> +	ussd->pending =3D dbus_message_ref(msg);
> +
> +	ussd->driver->respond(ussd, str, ussd_response_callback, ussd);

Use driver->request here.

> +
> +	return NULL;
> +}
> +
>  static void ussd_cancel_callback(const struct ofono_error *error, void
>  *data) {
>  	struct ofono_ussd *ussd =3D data;
> @@ -458,15 +557,43 @@ static DBusMessage *ussd_cancel(DBusConnection *con=
n,
>  DBusMessage *msg, return NULL;
>  }
> =

> +static DBusMessage *ussd_not_supported(DBusConnection *conn, DBusMessage
>  *msg, +					void *data)
> +{
> +	struct ofono_ussd *ussd =3D data;
> +
> +	if (ussd->flags & USSD_FLAG_PENDING)
> +		return __ofono_error_busy(msg);
> +
> +	if (ussd->state =3D=3D USSD_STATE_IDLE)
> +		return __ofono_error_not_active(msg);
> +
> +	if (!ussd->driver->respond_not_supported)
> +		return __ofono_error_not_implemented(msg);
> +
> +	ussd->flags |=3D USSD_FLAG_PENDING;
> +	ussd->pending =3D dbus_message_ref(msg);
> +
> +	ussd->driver->respond_not_supported(ussd, ussd_cancel_callback, ussd);
> +
> +	return NULL;
> +}

Get rid of this method

> +
>  static GDBusMethodTable ussd_methods[] =3D {
>  	{ "Initiate",	"s",	"sv",	ussd_initiate,
>  					G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "Respond",	"s",	"",	ussd_respond,
> +					G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "Cancel",	"",	"",	ussd_cancel,
>  					G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "NotSupported",	"",	"",	ussd_not_supported,
> +					G_DBUS_METHOD_FLAG_ASYNC },
>  	{ }
>  };
> =

>  static GDBusSignalTable ussd_signals[] =3D {
> +	{ "NotificationReceived",	"sv" },
> +	{ "RequestReceived",		"sv" },

Simple strings here

>  	{ }
>  };
> =


Regards,
-Denis

--===============4818620139499728439==--

