Content-Type: multipart/mixed; boundary="===============9172216956126320944=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Thu, 13 Aug 2020 10:03:12 -0500
Message-ID: <8c4abe99-6ce3-a526-54a9-64b855f4eab6@gmail.com>
In-Reply-To: <20200813133347.489923-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9172216956126320944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/13/20 8:33 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 modem does not understand the AT+CPSB command, so
> aquire the current packet switched bearer from quectel proprietary
> QIND:"act" URC.
> ---
>   drivers/atmodem/gprs.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> =


<snip>

> @@ -624,6 +667,12 @@ static void gprs_initialized(gboolean ok, GAtResult =
*result, gpointer user_data)
>   		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
>   						NULL, NULL, NULL);
>   		break;
> +	case OFONO_VENDOR_QUECTEL_EC2X:
> +		g_at_chat_register(gd->chat, "+QIND",
> +				quectel_qind_notify, FALSE, gprs, NULL);
> +		/* The "QIND: \"act\", ..." URC is activated in
> +		 * network-registration.c */

You're using the QIND in network-registration.c to notify CREG technology. =
 And =

now you're trying to use this here in place of CPSB.  This seems fishy to m=
e. =

Looking at the Quectel AT commands manual, I'd just guess they do not suppo=
rt =

this bearer concept at all...

> +		break;
>   	default:
>   		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
>   						FALSE, gprs, NULL);
> =


Regards,
-Denis
--===============9172216956126320944==--

