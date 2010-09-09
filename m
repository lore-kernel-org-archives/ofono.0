Content-Type: multipart/mixed; boundary="===============6743731977230286066=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Add Suspended property to GPRS atom
Date: Thu, 09 Sep 2010 12:57:29 -0500
Message-ID: <4C892009.2010203@gmail.com>
In-Reply-To: <1284034091-8288-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6743731977230286066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 09/09/2010 07:08 AM, Mika Liljeberg wrote:
> =

> Signed-off-by: Mika Liljeberg <mika.liljeberg@nokia.com>

We don't use Signed-off-by, could you please configure your git not to
include it?  The only other nitpick I have is on your commit header, it
should include gprs: prefix.  E.g.

gprs: add Suspended property...

We do this to help people quickly scan git log and figure out whether a
patch potentially affects the area they are interested in.

> ---
>  doc/connman-api.txt |   19 ++++++++++++++
>  include/gprs.h      |   10 +++++++
>  src/gprs.c          |   69 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 98 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> index 43d8897..b576e19 100644
> --- a/doc/connman-api.txt
> +++ b/doc/connman-api.txt
> @@ -77,6 +77,25 @@ Properties	boolean Attached [readonly]
>  			be available, e.g. receiving SMS over packet radio
>  			or network initiated PDP activation.
>  =

> +		boolean Suspended [readonly]

My only thought here is that we should also make Suspended property
optional.  My thought here is that if we're not 'Attached', then
reporting Suspended is not really useful.

> @@ -1052,6 +1114,9 @@ static DBusMessage *gprs_get_properties(DBusConnect=
ion *conn,
>  	value =3D gprs->powered;
>  	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
>  =

> +	value =3D gprs->suspended;
> +	ofono_dbus_dict_append(&dict, "Suspended", DBUS_TYPE_BOOLEAN, &value);
> +
>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;

See my comment above here, perhaps we should only include this in the
dict if Attached is true.

> @@ -1697,6 +1762,9 @@ static void gprs_remove(struct ofono_atom *atom)
>  	if (gprs =3D=3D NULL)
>  		return;
>  =

> +	if (gprs->suspend_timeout)
> +		g_source_remove(gprs->suspend_timeout);
> +
>  	if (gprs->pid_map) {
>  		idmap_free(gprs->pid_map);
>  		gprs->pid_map =3D NULL;
> @@ -1746,6 +1814,7 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_m=
odem *modem,
>  =

>  	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
>  	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +	gprs->suspended =3D TRUE;
>  	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
>  =

>  	return gprs;

And this could be just set to FALSE (or not set since the structure is
zeroed)

Otherwise patch looks great.

Another housekeeping item: Please send a patch taking ownership of this
task on the TODO list.  See ofono/TODO, the GPRS section.  This way
others know not to interfere with your work.

Regards,
-Denis

--===============6743731977230286066==--

