Content-Type: multipart/mixed; boundary="===============3266423063076700275=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] stk: Handle provide local info proactive command
Date: Fri, 26 Nov 2010 14:49:21 -0600
Message-ID: <4CF01D51.4050102@gmail.com>
In-Reply-To: <1290688142-14726-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3266423063076700275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 11/25/2010 06:29 AM, Yang Gu wrote:
> ---
>  src/smsutil.c  |    6 +-

Please send patches against smsutil separately.

>  src/stk.c      |  113 +++++++++++++++++++++++++++++++++++++++++
>  src/stkagent.c |  153 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/stkagent.h |   14 +++++
>  src/stkutil.c  |    2 +-

Same goes for stkutil

>  5 files changed, 284 insertions(+), 4 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index e6dbf5f..5394817 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -324,10 +324,10 @@ gboolean sms_encode_scts(const struct sms_scts *in,=
 unsigned char *pdu,
>  	if (in->year > 99)
>  		return FALSE;
>  =

> -	if (in->month > 12)
> +	if (in->month > 12 || in->month =3D=3D 0)
>  		return FALSE;
>  =

> -	if (in->day > 31)
> +	if (in->day > 31 || in->day =3D=3D 0)
>  		return FALSE;
>  =

>  	if (in->hour > 23)
> @@ -339,7 +339,7 @@ gboolean sms_encode_scts(const struct sms_scts *in, u=
nsigned char *pdu,
>  	if (in->second > 59)
>  		return FALSE;
>  =

> -	if ((in->timezone > 12*4-1) || (in->timezone < -(12*4-1)))
> +	if ((in->timezone > 12*4) || (in->timezone < -(12*4-1)))

Err, why would +48 be valid?

<snip>

> diff --git a/src/stkagent.c b/src/stkagent.c
> index 5cf83e4..78620d5 100644
> --- a/src/stkagent.c
> +++ b/src/stkagent.c
> @@ -956,3 +956,156 @@ int stk_agent_loop_tone(struct stk_agent *agent, co=
nst char *text,
>  =

>  	return 0;
>  }
> +int stk_agent_request_time(struct stk_agent *agent, stk_agent_time_cb cb,
> +				void *user_data, ofono_destroy_func destroy,
> +				int timeout)

So I really don't think we need an agent for this one.  Just having
oFono grab the time and return the info should be enough.


<snip>

> +int stk_agent_request_lang(struct stk_agent *agent, stk_agent_string_cb =
cb,
> +				void *user_data, ofono_destroy_func destroy,
> +				int timeout)
> +{

I'm not an expert on i18n, but this seems to be something oFono can
handle internally.  Perhaps querying the LANG environment variable or
something?

<snip>

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 377ceff..48ce93b 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4553,7 +4553,7 @@ static gboolean build_dataobj_datetime_timezone(str=
uct stk_tlv_builder *tlv,
>  		return TRUE;
>  =

>  	/* Time zone information is optional */
> -	if (scts->timezone =3D=3D (gint8) 0xff) {
> +	if (scts->timezone =3D=3D -48) {
>  		memcpy(&timestamp, scts, sizeof(timestamp));
>  		timestamp.timezone =3D 0;
>  		if (sms_encode_scts(&timestamp, value, &offset) !=3D TRUE)

As mentioned previously, my vote is for has_tz here.

Regards,
-Denis

--===============3266423063076700275==--

