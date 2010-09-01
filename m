Content-Type: multipart/mixed; boundary="===============5684669232565615489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] __ofono_call_forwarding_is_busy internal api for
 STK-Send USSD
Date: Wed, 01 Sep 2010 10:23:03 -0500
Message-ID: <4C7E6FD7.5000301@gmail.com>
In-Reply-To: <1283338836-13572-4-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5684669232565615489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/01/2010 06:00 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-forwarding.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 4e77144..b3ca6a1 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -1092,6 +1092,11 @@ static void cf_unregister_ss_controls(struct ofono=
_call_forwarding *cf)
>  	__ofono_ussd_ssc_unregister(cf->ussd, "004");
>  }
>  =

> +gboolean __ofono_call_forwarding_is_busy( struct ofono_call_forwarding *=
cf)
> +{
> +	return cf->pending ? TRUE: FALSE;
> +}
> +
>  int ofono_call_forwarding_driver_register(const struct ofono_call_forwar=
ding_driver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);

And same here again, please add chunks from patch #8 here.

--===============5684669232565615489==--

