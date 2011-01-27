Content-Type: multipart/mixed; boundary="===============0391204955680286960=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] bluetooth: use GSList instead of GHashTable to store
 adapter path/address
Date: Thu, 27 Jan 2011 16:13:30 +0100
Message-ID: <1296141210.1520.158.camel@aeonflux>
In-Reply-To: <1296140740-11486-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0391204955680286960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

>  plugins/bluetooth.c |   86 +++++++++++++++++++++++++++++++++++++++++++--=
-----
>  1 files changed, 74 insertions(+), 12 deletions(-)
> =

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index e59bd31..4da662a 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -39,9 +39,14 @@
>  =

>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
> -static GHashTable *adapter_address_hash =3D NULL;
> +static GSList *adapter_list =3D NULL;
>  static gint bluetooth_refcount;
>  =

> +struct adapter_address {
> +	char *adapter;
> +	char *address;
> +};
> +

why are we doing this exactly with a list now instead of a hash table. I
don't see the point here.

Regards

Marcel



--===============0391204955680286960==--

