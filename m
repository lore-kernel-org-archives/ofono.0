Content-Type: multipart/mixed; boundary="===============4685896900918076190=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] telitmodem: support for CDC-NCM network adapter
Date: Fri, 27 Jan 2017 20:36:52 -0600
Message-ID: <820fe554-399e-db09-d54e-e2a1842f1632@gmail.com>
In-Reply-To: <20170127095424.19685-2-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4685896900918076190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/27/2017 03:54 AM, Piotr Haber wrote:
> Network Control Model is a new Communication Device Class
> protocol for exchanging Ethernet frames over USB.
> NCM is intended to be used with high-speed network
> attachments such as HSDPA and LTE data services.
> ---
>  Makefile.am                           |   3 +-
>  drivers/telitmodem/gprs-context-ncm.c | 485 ++++++++++++++++++++++++++++=
++++++
>  drivers/telitmodem/telitmodem.c       |   2 +
>  drivers/telitmodem/telitmodem.h       |   2 +
>  4 files changed, 491 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/telitmodem/gprs-context-ncm.c
>

I went ahead and applied this patch with a couple of small modifications:

<snip>

> +		if ((unsigned int) cid =3D=3D gcd->active_context) {
> +			found =3D TRUE;
> +
> +			if (gcd->address && strcmp(gcd->address, "") !=3D 0) {

gcd->address is always true, so this if condition was simplified to simply:
if (strcmp(gcd->address, "") !=3D 0)

> +				strncpy(gcd->netmask,
> +					&ip_mask[strlen(gcd->address)+1],
> +					sizeof(gcd->netmask));
> +			}

I also took out the curly brackets since they are not needed.

> +
> +	g_at_chat_send(gcd->chat, "AT+CGATT=3D0", none_prefix, NULL, NULL, NULL=
);
> +

I took this out.  There's no way that gprs context driver should be =

detaching.  Why is this needed anyway?

Regards,
-Denis

--===============4685896900918076190==--

