Content-Type: multipart/mixed; boundary="===============8660459274572424014=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Skip unsolicited CREG/CGREG correctly
Date: Thu, 02 Dec 2010 15:22:21 -0600
Message-ID: <4CF80E0D.6010901@gmail.com>
In-Reply-To: <1291299788.2038.2.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8660459274572424014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

On 12/02/2010 08:23 AM, Tonny Tzeng wrote:
> This patch skip unsolicited CREG/CGREG correctly.
> =

> Signed-off-by: Tonny Tzeng <tonny.tzeng@gmail.com>

Please don't use Signed-off-by

> ---
>  drivers/atmodem/atutil.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index b6f0d92..2ca7b44 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -244,8 +244,9 @@ gboolean at_util_parse_reg(GAtResult *result, const
> char *prefix,
>  			continue;
>  =

>  		/* Some firmware will report bogus lac/ci when unregistered */
> +		/* in this case, we should skip it                          */
>  		if (s !=3D 1 && s !=3D 5)
> -			goto out;
> +			continue;

And this fix is wrong.  what this is doing is skipping the parsing of
the lac/ci values if we're not registered / roaming.  Using continue
here will cause the parser to fail for those cases.

What you probably meant was continuing if the status was not between 1
and 5.  But even that won't really help you if an lac of 1..5 is
encountered ;)

>  =

>  		switch (vendor) {
>  		case OFONO_VENDOR_HUAWEI:

Regards,
-Denis

--===============8660459274572424014==--

