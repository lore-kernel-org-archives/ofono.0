Content-Type: multipart/mixed; boundary="===============1614057099179454952=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 09/26] gathdlc: add g_at_hdlc_suspend() definition
Date: Mon, 02 May 2011 07:24:31 -0500
Message-ID: <4DBEA27F.4080009@gmail.com>
In-Reply-To: <1301648188-7208-10-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1614057099179454952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/01/2011 03:56 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gathdlc.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
> index db4ad5a..37f2539 100644
> --- a/gatchat/gathdlc.c
> +++ b/gatchat/gathdlc.c
> @@ -595,3 +595,12 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, =
gboolean detect)
>  =

>  	hdlc->no_carrier_detect =3D detect;
>  }
> +
> +void g_at_hdlc_suspend(GAtHDLC *hdlc)
> +{
> +	if (hdlc =3D=3D NULL)
> +		return;
> +
> +	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
> +	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
> +}

What do you think of simply putting this into the function that calls
the HDLC suspend callback?

Regards,
-Denis

--===============1614057099179454952==--

