Content-Type: multipart/mixed; boundary="===============7296926676580603661=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Add macro for general result and additional info
Date: Sun, 26 Sep 2010 19:47:37 -0500
Message-ID: <4C9FE9A9.9000007@gmail.com>
In-Reply-To: <1285064479-12907-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7296926676580603661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 09/21/2010 05:21 AM, Yang Gu wrote:
> ---
>  src/stkutil.h |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.h b/src/stkutil.h
> index 36b18f0..645daf8 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -254,6 +254,8 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD =3D	0x31,
>  	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
>  	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
> +	STK_RESULT_TYPE_SS_RETURN_ERROR =3D		0x34,
> +	STK_RESULT_TYPE_SMS_RP_ERROR =3D			0x35,
>  	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
>  	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D		0x37,
>  	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
> @@ -263,6 +265,27 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_MMS_ERROR =3D			0x3D,
>  };
>  =

> +enum stk_result_addnl_me_pb_fb {
> +	STK_RESULT_ADDNL_ME_PB_NO_SPECIFIC_CAUSE =3D	0x00,
> +	STK_RESULT_ADDNL_ME_PB_SCREEN_BUSY =3D		0x01,
> +	STK_RESULT_ADDNL_ME_PB_BUSY_ON_CALL =3D		0x02,
> +	STK_RESULT_ADDNL_ME_PB_NO_SERVICE =3D		0x04,
> +	STK_RESULT_ADDNL_ME_PB_NO_ACCESS =3D		0x05,
> +	STK_RESULT_ADDNL_ME_PB_NO_RADIO_RESOURCE =3D	0x06,
> +	STK_RESULT_ADDNL_ME_PB_NOT_IN_SPEECH_CALL =3D	0x07,
> +	STK_RESULT_ADDNL_ME_PB_BUSY_ON_SEND_DTMF =3D	0x09,
> +	STK_RESULT_ADDNL_ME_PB_NO_NAA_ACTIVE =3D		0x0A
> +};

Can you include a comment as to where these values are coming from?
What does ME_PB_FB stand for?

> +
> +enum stk_result_addnl_me_pb_ob {
> +	STK_RESULT_ADDNL_ME_PB_SS_BUSY =3D	0x03,
> +	STK_RESULT_ADDNL_ME_PB_USSD_BUSY =3D	0x08
> +};
> +

Same for this one..

> +enum stk_result_addnl_ss_pb_ob {
> +	STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE =3D	0x00
> +};
> +

And for this one, I assume this is from 31.111 8.12.3?

>  enum stk_tone_type {
>  	STK_TONE_TYPE_DIAL_TONE =3D	0x01,
>  	STK_TONE_TYPE_BUSY_TONE =3D	0x02,

Regards,
-Denis

--===============7296926676580603661==--

