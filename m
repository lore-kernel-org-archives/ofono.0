Content-Type: multipart/mixed; boundary="===============6400862772263059881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 2/5] GPRS context plan support
Date: Fri, 12 Aug 2011 01:43:52 -0500
Message-ID: <4E44CBA8.70201@gmail.com>
In-Reply-To: <1312547162-26420-3-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6400862772263059881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 08/05/2011 07:25 AM, Oleg Zhurakivskyy wrote:
> ---
>  include/gprs-context.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =


Logically this patch is out of order since you make use of these defines
in Patch 1.

> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index f82fcaa..8dfc106 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -48,6 +48,11 @@ enum ofono_gprs_context_type {
>  	OFONO_GPRS_CONTEXT_TYPE_IMS,
>  };
>  =

> +enum ofono_gprs_context_plan {
> +	OFONO_GPRS_CONTEXT_PLAN_PREPAID,
> +	OFONO_GPRS_CONTEXT_PLAN_POSTPAID,
> +};
> +

What exactly is the usecase here?  oFono doesn't really care whether a
plan is prepaid or postpaid, that is information purely for the UI.

>  struct ofono_gprs_primary_context {
>  	unsigned int cid;
>  	int direction;

Regards,
-Denis

--===============6400862772263059881==--

