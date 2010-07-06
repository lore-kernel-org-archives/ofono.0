Content-Type: multipart/mixed; boundary="===============7595916291296739820=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] gatppp: Check ppp instance before unref it
Date: Tue, 06 Jul 2010 09:48:53 -0300
Message-ID: <1278420533.2789.36.camel@localhost.localdomain>
In-Reply-To: <1278410258-3077-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7595916291296739820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatppp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 1d41ded..d9b1627 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -446,6 +446,9 @@ void g_at_ppp_unref(GAtPPP *ppp)
>  {
>  	gboolean is_zero;
>  =

> +	if (ppp =3D=3D NULL)
> +		return;
> +
>  	is_zero =3D g_atomic_int_dec_and_test(&ppp->ref_count);
>  =

>  	if (is_zero =3D=3D FALSE)

since we have been safe-guarding this in other unref functions as well,
I also applied this patch.

In general the calling code is doing something wrong here if it tries to
unref a NULL pointer.

Regards

Marcel



--===============7595916291296739820==--

