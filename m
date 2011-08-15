Content-Type: multipart/mixed; boundary="===============9035927275916100438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add CDMA voice call sending air interface flash support
Date: Mon, 15 Aug 2011 01:00:48 -0500
Message-ID: <4E48B610.5080805@gmail.com>
In-Reply-To: <1313140786-28970-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9035927275916100438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 08/12/2011 04:19 AM, Caiwen Zhang wrote:
> ---
>  include/cdma-voicecall.h |    3 +++
>  src/cdma-voicecall.c     |   25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
> =


I applied this patch, but broke it up into two:

949f0ad44756cebf5dc8e5cb54ea23fb4bb23684 and
fbf909fad44da2245ada23a4f90f3920ab49e633

One further comment:

<snip>

> @@ -307,6 +307,29 @@ static DBusMessage *voicecall_manager_answer(DBusCon=
nection *conn,
>  	return NULL;
>  }
>  =

> +static DBusMessage *voicecall_manager_flash(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_cdma_voicecall *vc =3D data;
> +	const char *string;
> +
> +	if (vc->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (vc->driver->send_flash =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &string,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +

Is there a format for what constitutes a valid flash string? Sending
un-filtered user input here seems wrong.  Please send a patch with a
flash string validator, similar to how send_tones was implemented.

> +	vc->pending =3D dbus_message_ref(msg);
> +
> +	vc->driver->send_flash(vc, string, generic_callback, vc);
> +
> +	return NULL;
> +}
> +
>  static GDBusMethodTable manager_methods[] =3D {
>  	{ "GetProperties",    "",    "a{sv}",
>  					voicecall_manager_get_properties },

Regards,
-Denis

--===============9035927275916100438==--

