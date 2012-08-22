Content-Type: multipart/mixed; boundary="===============1825347549829877047=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/8] call-settings: class applied is the class given by SS
 code.
Date: Wed, 22 Aug 2012 18:41:39 -0500
Message-ID: <50356E33.8060504@gmail.com>
In-Reply-To: <1345652303-12866-8-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1825347549829877047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/22/2012 11:18 AM, Philippe Nunes wrote:
> The default class is applied when no class is specified by SS code.
> ---
>   src/call-settings.c |   11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/src/call-settings.c b/src/call-settings.c
> index 51f96bf..d63d9d8 100644
> --- a/src/call-settings.c
> +++ b/src/call-settings.c
> @@ -485,7 +485,7 @@ static void cw_ss_set_callback(const struct ofono_err=
or *error, void *data)
>   		return;
>   	}
>
> -	cs->driver->cw_query(cs, BEARER_CLASS_DEFAULT,
> +	cs->driver->cw_query(cs, cs->ss_req_cls,
>   				cw_ss_query_callback, cs);

This is only used to query after the set, why are you touching this?

>   }
>
> @@ -533,13 +533,13 @@ static gboolean cw_ss_control(int type,
>   			goto bad_format;
>   	}
>
> -	cs->ss_req_cls =3D cls;
> -	cs->pending =3D dbus_message_ref(msg);
> -
>   	/* For the default case use the more readily accepted value */
>   	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
>   		cls =3D BEARER_CLASS_DEFAULT;
>
> +	cs->ss_req_cls =3D cls;
> +	cs->pending =3D dbus_message_ref(msg);
> +

And again, this part is wrong since cls is used to generate the reply.

>   	switch (type) {
>   	case SS_CONTROL_TYPE_REGISTRATION:
>   	case SS_CONTROL_TYPE_ACTIVATION:
> @@ -554,8 +554,7 @@ static gboolean cw_ss_control(int type,
>   		 * according to 22.004 Appendix A, so CLASS_DEFAULT
>   		 * is safe to use here
>   		 */
> -		cs->driver->cw_query(cs, BEARER_CLASS_DEFAULT,
> -					cw_ss_query_callback, cs);
> +		cs->driver->cw_query(cs, cls, cw_ss_query_callback, cs);
>   		break;
>
>   	case SS_CONTROL_TYPE_DEACTIVATION:

Regards,
-Denis

--===============1825347549829877047==--

