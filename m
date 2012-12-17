Content-Type: multipart/mixed; boundary="===============4072813736879536868=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Drop checking whether +CMER is supported.
Date: Mon, 17 Dec 2012 10:27:32 -0600
Message-ID: <50CF47F4.8070700@gmail.com>
In-Reply-To: <1355761338-9081-3-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4072813736879536868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,

On 12/17/2012 10:22 AM, Mingli Wu wrote:
> For Telit HE910,  ofono always got "\r\n+CME ERROR: 14\r\n"
> after issuing "AT+CMER=3D3,0,0,2\r" command. "CME ERROR: 14"
> means that SIM is busy. Now we igonre the result of the
> command "AT+CMER=3D3,0,0,2\r", and register network anyway.
> ---
>   drivers/atmodem/network-registration.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 19b19b2..518a548 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -1480,7 +1480,6 @@ static void at_cmer_not_supported(struct ofono_netr=
eg *netreg)
>   	ofono_error("+CMER not supported by this modem.  If this is an error"
>   			" please submit patches to support this hardware");
>
> -	ofono_netreg_remove(netreg);

You are changing the global behavior of the driver here.  This affects =

other modems than HE910...

>   }
>
>   static void at_cmer_set_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> @@ -1490,7 +1489,6 @@ static void at_cmer_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>
>   	if (!ok) {
>   		at_cmer_not_supported(netreg);
> -		return;
>   	}
>
>   	/*

Regards,
-Denis

--===============4072813736879536868==--

