Content-Type: multipart/mixed; boundary="===============6014577762509943871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V2 1/4] voicecall: create generic dial function
Date: Wed, 25 May 2011 05:59:43 -0500
Message-ID: <4DDCE11F.1070001@gmail.com>
In-Reply-To: <1305884461-4476-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6014577762509943871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 05/20/2011 04:40 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> split manager_dial between generic and dbus parts
> ---
>  src/voicecall.c |   91 ++++++++++++++++++++++++++++++++++++++-----------=
-----
>  1 files changed, 64 insertions(+), 27 deletions(-)
> =


<snip>

> +
> +static DBusMessage *manager_dial(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_voicecall *vc =3D data;
> +	const char *number;
> +	const char *clirstr;
> +	enum ofono_clir_option clir;
> +	int err;
> +	DBusMessage *reply =3D NULL;
> +
> +	if (vc->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> +					DBUS_TYPE_STRING, &clirstr,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
> +		return __ofono_error_invalid_format(msg);
> +
>  	vc->pending =3D dbus_message_ref(msg);
>  =

> -	string_to_phone_number(number, &ph);
> +	err =3D voicecall_dial(vc, number, clir, manager_dial_callback, vc);
> +	switch (err) {
> +	case 0:
> +		break;

Maybe I'm missing something, but why don't you do something like:

if (err >=3D 0)
	return NULL;

vc->pending =3D NULL;
dbus_message_unref(msg);

> +
> +	case -EINVAL:
> +		reply =3D __ofono_error_invalid_format(msg);
> +		break;

And then simply use return __ofono_error... here?

>  =

> -	vc->driver->dial(vc, &ph, clir, manager_dial_callback, vc);
> +	case -ENETDOWN:
> +		reply =3D __ofono_error_not_available(msg);
> +		break;
>  =


And here

> -	return NULL;
> +	case -ENOTSUP:
> +		reply =3D __ofono_error_not_implemented(msg);
> +		break;
> +

And here

> +	default:
> +		reply =3D __ofono_error_failed(msg);
> +		break;
> +	}
> +

And here

> +	if (reply !=3D NULL) {
> +		dbus_message_unref(msg);
> +		vc->pending =3D NULL;
> +	}
> +
> +	return reply;

And then this part is not needed.

>  }
>  =

>  static DBusMessage *manager_transfer(DBusConnection *conn,

Regards,
-Denis

--===============6014577762509943871==--

