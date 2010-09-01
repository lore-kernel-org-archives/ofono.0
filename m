Content-Type: multipart/mixed; boundary="===============7419664739954788835=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/11] added stk_response_text_string for USSD result
Date: Wed, 01 Sep 2010 10:33:33 -0500
Message-ID: <4C7E724D.8000106@gmail.com>
In-Reply-To: <1283338836-13572-7-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7419664739954788835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/01/2010 06:00 AM, Jeevaka Badrappan wrote:
> ---
>  src/stkutil.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.h b/src/stkutil.h
> index 44d167a..66d2e55 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -237,6 +237,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_GO_BACK =3D			0x11,
>  	STK_RESULT_TYPE_NO_RESPONSE =3D			0x12,
>  	STK_RESULT_TYPE_HELP_REQUESTED =3D		0x13,
> +	STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION =3D   0x14,
>  =

>  	/* 0x20 to 0x2F are used to indicate that SIM should retry */
>  	STK_RESULT_TYPE_TERMINAL_BUSY =3D			0x20,
> @@ -254,6 +255,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
>  	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
>  	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
> +	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D             0x37,
>  	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
>  	STK_RESULT_TYPE_BIP_ERROR =3D			0x3A,
>  	STK_RESULT_TYPE_ACCESS_TECHNOLOGY_ERROR =3D	0x3B,
> @@ -1445,6 +1447,11 @@ struct stk_response_run_at_command {
>  	const char *at_response;
>  };
>  =

> +struct stk_response_text_string {
> +	unsigned char dcs;
> +	const unsigned char *text;
> +};
> +

3GPP 31.111 says that the terminal response to Send USSD should contain
a simple Text String.  The DCS of the text string in STK is different
from DCS that is returned by USSD.  Copying it directly from the USSD
DCS seems incorrect.  Or is there something I'm missing?

>  struct stk_response {
>  	unsigned char number;
>  	unsigned char type;
> @@ -1474,6 +1481,7 @@ struct stk_response {
>  		struct stk_response_generic send_dtmf;
>  		struct stk_response_generic language_notification;
>  		struct stk_response_generic launch_browser;
> +		struct stk_response_text_string send_ussd;
>  	};
>  =

>  	void (*destructor)(struct stk_response *response);

Regards,
-Denis

--===============7419664739954788835==--

