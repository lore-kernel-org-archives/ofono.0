Content-Type: multipart/mixed; boundary="===============1556923482219395124=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udev: Add check for serial before string operation
Date: Fri, 20 Aug 2010 10:20:22 +0200
Message-ID: <1282292422.23399.188.camel@localhost.localdomain>
In-Reply-To: <1282273839-4990-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1556923482219395124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> 'serial' could be NULL in some case. So it need to add check before
> doing string operation.
> ---
>  plugins/udev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 84399de..6720a0c 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -86,7 +86,7 @@ static const char *get_serial(struct udev_device *udev_=
device)
>  		entry =3D udev_list_entry_get_next(entry);
>  	}
>  =

> -	if (strpbrk(serial, ".-_?*") !=3D NULL)
> +	if (serial && strpbrk(serial, ".-_?*") !=3D NULL)
>  		return NULL;

and I was thinking at least one of these string functions does a correct
job, but seems no :(

Patch has been applied. Thanks.

Regards

Marcel



--===============1556923482219395124==--

