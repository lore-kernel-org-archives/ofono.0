Content-Type: multipart/mixed; boundary="===============0266031898992047108=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 3/8] call-forwarding: Don't set conditional cfs when cfu
 is active
Date: Wed, 22 Feb 2012 04:34:43 -0600
Message-ID: <4F44C4C3.8070803@gmail.com>
In-Reply-To: <1328531641-10612-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0266031898992047108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 02/06/2012 06:33 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/call-forwarding.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 8b8d5a8..3f9d816 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -802,6 +802,13 @@ static DBusMessage *cf_set_property(DBusConnection *=
conn, DBusMessage *msg,
>  		if (strlen(number) > 0 && !valid_phone_number_format(number))
>  			return __ofono_error_invalid_format(msg);
>  =

> +		/*
> +		 * Don't set conditional cfs when cfu is active
> +		 */
> +		if (type !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +				number[0] !=3D '\0' && is_cfu_enabled(cf))
> +			return __ofono_error_not_available(msg);
> +
>  		if (number[0] !=3D '\0')
>  			string_to_phone_number(number, &ph);
>  =


I applied this chunk...

> @@ -1159,6 +1166,17 @@ static gboolean cf_ss_control(int type, const char=
 *sc,
>  		return TRUE;
>  	}
>  =

> +	/*
> +	 * Don't set conditional cfs when cfu is active
> +	 */
> +	if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION &&

You are not handling SS_CONTROL_TYPE_ACTIVATION here...

> +			cf_type !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +			sia[0] !=3D '\0' && is_cfu_enabled(cf)) {
> +		g_dbus_send_message(conn, __ofono_error_not_available(msg));
> +
> +		return TRUE;
> +	}
> +
>  	cf->ss_req =3D g_try_new0(struct cf_ss_request, 1);
>  =

>  	if (cf->ss_req =3D=3D NULL) {

However, I think we should leave this part out.  The supplementary
service control path is almost a back door directly to the network, so
if the input is valid it should go through to the driver.  This is why
interrogation is performed here regardless of whether the CACHED flag is
set.

Regards,
-Denis

--===============0266031898992047108==--

