Content-Type: multipart/mixed; boundary="===============6157736020772486852=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 09:31:13 -0800
Message-ID: <1294162273.5852.100.camel@aeonflux>
In-Reply-To: <1294145763-30703-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6157736020772486852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> According to dbus documentation, dbus_message_iter_append_basic()
> expects a "const char**" if type is string and a simple pointer for
> other types. Since we a iterating an array, the value passed is already
> a pointer.
> ---
>  src/dbus.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/src/dbus.c b/src/dbus.c
> index c24615f..292f11a 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -139,8 +139,13 @@ static void append_dict_variant(DBusMessageIter *ite=
r, int type, void *val)
>  =

>  		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
>  						&(val_array[i + 0]));
> -		dbus_message_iter_append_basic(&entry, type,
> -						&(val_array[i + 1]));
> +		if (type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_append_basic(&entry, type,
> +							&(val_array[i + 1]));
> +		} else {
> +			dbus_message_iter_append_basic(&entry, type,
> +							val_array[i + 1]);
> +		}

this does looks a bit hackish. Can you put it into context please. It
might be that our call chain is wrong.

Regards

Marcel



--===============6157736020772486852==--

