Content-Type: multipart/mixed; boundary="===============5311632966267638919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] call-forwarding: class applied is the class given by
 SS code
Date: Wed, 22 Aug 2012 18:36:53 -0500
Message-ID: <50356D15.1050609@gmail.com>
In-Reply-To: <1345652303-12866-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5311632966267638919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/22/2012 11:18 AM, Philippe Nunes wrote:
> GCF test cases 31.2.1.6.1/2 are asking to make a query according a specif=
ic
> class.
> The default class is applied when no class is specified in the SS code.
> ---
>   src/call-forwarding.c |   22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 91e34c6..7531f07 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -1012,7 +1012,7 @@ static void ss_set_query_cf_callback(const struct o=
fono_error *error, int total,
>
>   static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)
>   {
> -	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
> +	cf->driver->query(cf, cf->query_next, cf->ss_req->cls,
>   			ss_set_query_cf_callback, cf);
>   }
>
> @@ -1167,6 +1167,16 @@ static gboolean cf_ss_control(int type, const char=
 *sc,
>   		return TRUE;
>   	}
>
> +	/*
> +	 * Some modems don't understand all classes very well, particularly
> +	 * the older models.  So if the bearer class is the default, we
> +	 * just use the more commonly understood value of 7 since BEARER_SMS
> +	 * is not applicable to CallForwarding conditions according to 22.004
> +	 * Annex A
> +	 */
> +	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
> +		cls =3D BEARER_CLASS_DEFAULT;
> +

Strictly speaking this is wrong.  You cannot modify the cls here as it =

is used to generate the reply in cf_ss_control_reply.  Since =

BEARER_CLASS_SS_DEFAULT !=3D BEARER_CLASS_DEFAULT you will generate the =

wrong result.

>   	cf->ss_req->ss_type =3D type;
>   	cf->ss_req->cf_type =3D cf_type;
>   	cf->ss_req->cls =3D cls;
> @@ -1188,16 +1198,6 @@ static gboolean cf_ss_control(int type, const char=
 *sc,
>   		break;
>   	}
>
> -	/*
> -	 * Some modems don't understand all classes very well, particularly
> -	 * the older models.  So if the bearer class is the default, we
> -	 * just use the more commonly understood value of 7 since BEARER_SMS
> -	 * is not applicable to CallForwarding conditions according to 22.004
> -	 * Annex A
> -	 */
> -	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
> -		cls =3D BEARER_CLASS_DEFAULT;
> -
>   	switch (cf->ss_req->ss_type) {
>   	case SS_CONTROL_TYPE_REGISTRATION:
>   		string_to_phone_number(sia,&ph);

Regards,
-Denis

--===============5311632966267638919==--

