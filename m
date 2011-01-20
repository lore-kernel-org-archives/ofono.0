Content-Type: multipart/mixed; boundary="===============1606966660773454306=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3] bluetooth: Add reference count for bluetooth utils
Date: Thu, 20 Jan 2011 11:16:32 +0100
Message-ID: <1295518592.3873.266.camel@aeonflux>
In-Reply-To: <1295435871-3462-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1606966660773454306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 602c6da..8202381 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -40,6 +40,7 @@
>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
>  static GHashTable *adapter_address_hash =3D NULL;
> +static gint ref_count;

you need a better name for this. This is too generic. Maybe using
bluetooth_refcount is better.

>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
> @@ -504,12 +505,12 @@ static guint adapter_added_watch;
>  static guint adapter_removed_watch;
>  static guint property_watch;
>  =

> -int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> +static int bluetooth_ref(void)
>  {
>  	int err;
>  =

> -	if (uuid_hash)
> -		goto done;
> +	if (ref_count > 0)
> +		return 0;

This is pretty much wrong. A reference count can't work this way. You
need to track the number of times this has been taken.

	g_atomic_int_inc(&bluetooth_refcount);

	if (bluetooth_refcount > 1)
		return 0;

In addition, I think the return value is pointless, just make sure to
decrease the reference count in an error case.

> +static void bluetooth_unref(void)
>  {
> -	g_hash_table_remove(uuid_hash, uuid);
> +	gboolean is_zero;
> +
> +	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
>  =

> -	if (g_hash_table_size(uuid_hash))
> +	if (is_zero =3D=3D FALSE)
>  		return;

I know that we have it like this in GAtChat, but just do the check right
away is fine.

	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
		return;

Regards

Marcel



--===============1606966660773454306==--

