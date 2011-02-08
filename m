Content-Type: multipart/mixed; boundary="===============5434167914314421187=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1] ifx: Selftest at command syntax fix to support latest
 fw
Date: Tue, 08 Feb 2011 14:47:00 -0800
Message-ID: <1297205220.1520.459.camel@aeonflux>
In-Reply-To: <1297204462-9766-1-git-send-email-anandx.ramakrishna@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5434167914314421187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anand,

> It is a fix to support the selftest at command syntax changed in latest =

> IFX fw version
> =

> ---
>  plugins/ifx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 2a95720..a41fc36 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -573,7 +573,7 @@ static void rtc_gti_selftest_cb(gboolean ok, GAtResul=
t *result,
>  	if (ok)
>  		return;
>  =

> -	ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
> +	ofono_error("at(a)rtc_drv:rtc_gti_test_verify_32khz()-FAILED");

so I did apply this patch now, but I am really unhappy with this. Since
this clearly relies on internal naming of IFX firmware internal driver
and function names. That is not a good idea.

We need an IFX based abstraction like AT+XSELFTEST or similar for this.
Otherwise the concept of a generic IFX driver will not work out long
term.

Regards

Marcel



--===============5434167914314421187==--

