Content-Type: multipart/mixed; boundary="===============5442791781628680864=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/12] Add Send USSD command specific result codes
Date: Thu, 09 Sep 2010 10:09:31 -0500
Message-ID: <4C88F8AB.7080704@gmail.com>
In-Reply-To: <1284035516-21359-9-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5442791781628680864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 07:31 AM, Jeevaka Badrappan wrote:
> ---
>  src/stkutil.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.h b/src/stkutil.h
> index 44d167a..00cb264 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -237,6 +237,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_GO_BACK =3D			0x11,
>  	STK_RESULT_TYPE_NO_RESPONSE =3D			0x12,
>  	STK_RESULT_TYPE_HELP_REQUESTED =3D		0x13,
> +	STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION =3D	0x14,
>  =

>  	/* 0x20 to 0x2F are used to indicate that SIM should retry */
>  	STK_RESULT_TYPE_TERMINAL_BUSY =3D			0x20,
> @@ -254,6 +255,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
>  	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
>  	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
> +	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D		0x37,
>  	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
>  	STK_RESULT_TYPE_BIP_ERROR =3D			0x3A,
>  	STK_RESULT_TYPE_ACCESS_TECHNOLOGY_ERROR =3D	0x3B,

This patch has been applied, thanks.

Regards,
-Denis

--===============5442791781628680864==--

