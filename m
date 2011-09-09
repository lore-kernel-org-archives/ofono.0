Content-Type: multipart/mixed; boundary="===============1337363607654205108=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/12] handsfree: Expose RequestInput in D-Bus API
Date: Fri, 09 Sep 2011 01:01:28 -0500
Message-ID: <4E69ABB8.4030403@gmail.com>
In-Reply-To: <1316104483-13144-9-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1337363607654205108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 09/15/2011 11:34 AM, Mikel Astiz wrote:
> ---
>  src/handsfree.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
> =

> diff --git a/src/handsfree.c b/src/handsfree.c
> index 2bf2284..3138474 100644
> --- a/src/handsfree.c
> +++ b/src/handsfree.c
> @@ -47,6 +47,7 @@ struct ofono_handsfree {
>  	const struct ofono_handsfree_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	DBusMessage *pending;
>  };
>  =

>  void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
> @@ -118,11 +119,71 @@ static DBusMessage *handsfree_set_property(DBusConn=
ection *conn,
>  	return __ofono_error_invalid_args(msg);
>  }
>  =

> +static void request_phone_number_cb(const struct ofono_error *error,
> +					const struct ofono_phone_number *number,
> +					void *data)
> +{
> +	struct ofono_handsfree *hf =3D data;
> +	DBusMessage *reply;
> +	const char *phone_number;
> +
> +	if (!hf->pending)
> +		return;

Is this check really necessary?

> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		DBG("Phone number request callback returned error: %s",
> +			telephony_error_to_str(error));
> +
> +		reply =3D __ofono_error_failed(hf->pending);
> +		__ofono_dbus_pending_reply(&hf->pending, reply);
> +		return;
> +	}
> +
> +	phone_number =3D phone_number_to_string(number);
> +	reply =3D dbus_message_new_method_return(hf->pending);
> +	dbus_message_append_args(reply, DBUS_TYPE_STRING, &phone_number,
> +					DBUS_TYPE_INVALID);
> +	__ofono_dbus_pending_reply(&hf->pending, reply);
> +}
> +
> +static DBusMessage *handsfree_request_input(DBusConnection *conn,
> +						DBusMessage *msg, void *data)
> +{
> +	struct ofono_handsfree *hf =3D data;
> +	DBusMessageIter iter;
> +	const char *name;
> +
> +	if (hf->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(&iter, &name);
> +
> +	if (g_str_equal(name, "PhoneNumber")) {
> +		if (!hf->driver->request_phone_number)
> +			return __ofono_error_not_supported(msg);
> +
> +		hf->pending =3D dbus_message_ref(msg);
> +		hf->driver->request_phone_number(hf, request_phone_number_cb,
> +							hf);
> +		return NULL;
> +	}

I'd rather not do it this way.  I know +BINP is supposed to be
'extendable', but it hasn't been in what 5-6 years now?  Using
RequestPhoneNumber or RequestNumberInput would probably be better.

> +
> +	return __ofono_error_invalid_args(msg);
> +}
> +
>  static GDBusMethodTable handsfree_methods[] =3D {
>  	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties,
>  		G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "SetProperty",      "sv",  "", handsfree_set_property,
>  		G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "RequestInput",      "s",  "v", handsfree_request_input,
> +		G_DBUS_METHOD_FLAG_ASYNC },

You might want to submit a formal API proposal first (e.g. in doc/)
before trying to implement the API.  This would make discussing API
details easier.

>  	{ NULL, NULL, NULL, NULL }
>  };
>  =

> @@ -143,6 +204,9 @@ static void handsfree_remove(struct ofono_atom *atom)
>  	if (hf->driver !=3D NULL && hf->driver->remove !=3D NULL)
>  		hf->driver->remove(hf);
>  =

> +	if (hf->pending)
> +		dbus_message_unref(hf->pending);
> +

The rest of the code doesn't do this, though it probably should.
However, it probably belongs in _unregister, not _remove.  Using
ofono_dbus_pending_reply might be better as well.

>  	g_free(hf);
>  }
>  =


Regards,
-Denis

--===============1337363607654205108==--

