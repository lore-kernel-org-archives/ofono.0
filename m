Content-Type: multipart/mixed; boundary="===============4232953744670051797=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7modem: enabling simtoolkit in modem driver
Date: Thu, 16 May 2019 10:49:22 -0500
Message-ID: <0cbf8d2a-32a4-5974-c5fb-3e7d59d8ed4b@gmail.com>
In-Reply-To: <1557918613-16921-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4232953744670051797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 05/15/2019 06:10 AM, Antara Borwankar wrote:
> handled enabling of stk for xmm7modem vendor in atmodem
> driver.
> ---
>   drivers/atmodem/stk.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> =

> diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
> index f0dc5c0..43ae953 100644
> --- a/drivers/atmodem/stk.c
> +++ b/drivers/atmodem/stk.c
> @@ -191,6 +191,19 @@ static gboolean at_stk_register(gpointer user)
>   		g_at_chat_register(sd->chat, "*HCMD:", phonesim_hcmd_notify,
>   						FALSE, stk, NULL);
>   =

> +	if (sd->vendor =3D=3D OFONO_VENDOR_XMM) {
> +		/*	enabling stk	*/
> +		g_at_chat_send(sd->chat, "AT+CFUN=3D6", none_prefix,
> +						NULL, NULL, NULL);
> +		/*	Here ofono has missed stk menu proactive command
> +		 *	that comes after sim initialization only. Doing a
> +		 *	sim reset will enable the stk driver to get the
> +		 *	missed +CUSATP notifications.
> +		 */

This seems really dangerous.  STK is created in post_sim, e.g. after the =

SIM has been detected and initialized.  What happens if you reset it and =

the PIN is locked, etc?  E.g. wouldn't the SIM PIN be needed again?

Would it make more sense to perform a SIM reset as part of the .enable() =

operation?

> +		g_at_chat_send(sd->chat, "AT+CFUN=3D27,1", none_prefix,
> +						NULL, NULL, NULL);
> +	}
> +
>   	ofono_stk_register(stk);
>   =

>   	return FALSE;
> =


Regards,
-Denis

--===============4232953744670051797==--

