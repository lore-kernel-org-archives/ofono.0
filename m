Content-Type: multipart/mixed; boundary="===============7362331308815198182=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: [PATCH] Add vendor quirk for SIMCOM
Date: Tue, 12 Mar 2013 16:18:48 +0100
Message-ID: <513F4758.3060801@syscom-instruments.com>
In-Reply-To: <1363099212-13463-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7362331308815198182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12. 03. 13 15:40, r.r.zaripov(a)gmail.com wrote:
> From: Renat Zaripov<r.r.zaripov@gmail.com>
>
> ---
>   drivers/atmodem/gprs-context.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index 3694c27..0fb63c4 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -208,7 +208,11 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   		return;
>   	}
>
> -	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> +	if (gcd->vendor =3D=3D OFONO_VENDOR_SIMCOM)
> +		strcpy(buf, "ATD*99#\0");
> +	else
> +		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> +
>   	if (g_at_chat_send(gcd->chat, buf, none_prefix,
>   				at_cgdata_cb, gc, NULL)>  0)
>   		return;

Hello Renat,

I watched the AT commands set for my SIM5216 and I found AT+CGDATA. =

There isn't this command for sim900 ?

And, I saw "ATD*99#" cryptic command was already used in =

gatchat/gsmdial.c if bluetooth is enabled.

Maybe, it's a specific command for your purpose ? I mean, do you need =

this command to "establish communication between the TE and the network =

using one or more Packet Domain PDP types." ? If it's the case, the =

quirk is only for your device and so, it's not a vendor quirk.
	=

Otherwise, why this \0 after ATD*99# ? :)

Regards,
Anthony.

--===============7362331308815198182==--

