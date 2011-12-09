Content-Type: multipart/mixed; boundary="===============8726919812430249675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] cdmamodem: Disable dormant mode at initialization
Date: Fri, 09 Dec 2011 05:37:20 -0600
Message-ID: <4EE1F2F0.1040404@gmail.com>
In-Reply-To: <1323428678-10373-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8726919812430249675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/09/2011 05:04 AM, Guillaume Zajac wrote:
> ---
>  drivers/cdmamodem/connman.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
> index c03841e..61573ff 100644
> --- a/drivers/cdmamodem/connman.c
> +++ b/drivers/cdmamodem/connman.c
> @@ -276,6 +276,20 @@ static void at_c0_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
>  	ofono_cdma_connman_register(cm);
>  }
>  =

> +static void at_cta0_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_cdma_connman *cm =3D user_data;
> +
> +	DBG("ok %d", ok);
> +
> +	if (ok =3D=3D FALSE) {
> +		ofono_info("Unable to configure Dormant mode");
> +		return;
> +	}
> +
> +	ofono_cdma_connman_dormant_notify(cm, FALSE);
> +}
> +

The core atom will default to FALSE here anyway, so I see no need in
this callback, so I pushed a much simplified patch upstream.

>  static int cdma_connman_probe(struct ofono_cdma_connman *cm,
>  					unsigned int vendor, void *data)
>  {
> @@ -300,6 +314,7 @@ static int cdma_connman_probe(struct ofono_cdma_connm=
an *cm,
>  	ofono_cdma_connman_set_data(cm, cd);
>  =

>  	g_at_chat_send(cd->chat, "AT&C0", none_prefix, at_c0_cb, cm, NULL);
> +	g_at_chat_send(cd->chat, "AT+CTA=3D0", none_prefix, at_cta0_cb, cm, NUL=
L);
>  =

>  	return 0;
>  }

Regards,
-Denis

--===============8726919812430249675==--

