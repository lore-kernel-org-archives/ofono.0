Content-Type: multipart/mixed; boundary="===============3447394581273455925=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/3] Inline release_id in voicecall.c
Date: Wed, 28 Oct 2009 13:59:06 +0900
Message-ID: <1256705946.5768.34.camel@localhost.localdomain>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B925006@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3447394581273455925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Move and rename alloc_next_id and release_id into atutil.c
> =

> So that they could be shared by atmodem and hfpmodem drivers.
> ---
>  drivers/atmodem/atutil.c    |   20 ++++++++++++++++++++
>  drivers/atmodem/atutil.h    |    2 ++
>  drivers/atmodem/voicecall.c |   24 ++----------------------
>  3 files changed, 24 insertions(+), 22 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index 465d258..847a4ee 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -82,3 +82,23 @@ gint at_util_call_compare(gconstpointer a,
> gconstpointer b)
>         return 0;
>  }
>  =

> +unsigned int at_util_alloc_next_id(unsigned int *id_list)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 1; i < sizeof(unsigned int) * 8; i++) {
> +               if (*id_list & (0x1 << i))
> +                       continue;
> +
> +               *id_list |=3D (0x1 << i);
> +               return i;
> +       }
> +
> +       return 0;
> +}
> +
> +inline void at_util_release_id(unsigned int *id_list, unsigned int
> id)
> +{
> +       *id_list &=3D ~(0x1 << id);
> +}

what is this? Don't use inline at all and let the compiler decide. I
also don't really understand how you think this works. There is nothing
to inline here.

And while at it. Drop the 0x1 stuff. Using 1 is much more readable.

Regards

Marcel



--===============3447394581273455925==--

