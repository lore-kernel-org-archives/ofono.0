Content-Type: multipart/mixed; boundary="===============2317380105586329837=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add vendor quirk for SIMCOM
Date: Tue, 12 Mar 2013 12:59:26 -0500
Message-ID: <513F6CFE.7090902@gmail.com>
In-Reply-To: <1363099212-13463-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2317380105586329837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 03/12/2013 09:40 AM, r.r.zaripov(a)gmail.com wrote:
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

The embedded null character is not necessary, strcpy will take care of =

that for you.

> +	else
> +		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> +
>   	if (g_at_chat_send(gcd->chat, buf, none_prefix,
>   				at_cgdata_cb, gc, NULL)>  0)
>   		return;

Regards,
-Denis

--===============2317380105586329837==--

