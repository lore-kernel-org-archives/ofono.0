Content-Type: multipart/mixed; boundary="===============0617305640443982076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] cdmamodem: Support speedup dormant notification
Date: Sat, 10 Dec 2011 17:33:12 -0600
Message-ID: <4EE3EC38.7020607@gmail.com>
In-Reply-To: <1323688297-2538-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0617305640443982076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/12/2011 05:11 AM, Guillaume Zajac wrote:
> ---
>  drivers/cdmamodem/connman.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
> index 8c3265a..41708f7 100644
> --- a/drivers/cdmamodem/connman.c
> +++ b/drivers/cdmamodem/connman.c
> @@ -264,6 +264,11 @@ static void at_c0_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
>  	}
>  =

>  	switch (cd->vendor) {
> +	case OFONO_VENDOR_SPEEDUP:
> +		/*
> +		 * Fall through: SpeedUp modem uses same prefix as Huawei
> +		 * modem for dormant notification.
> +		 */

If the handling is exactly the same, then it is better to just skip this
step.  Using OFONO_VENDOR_HUAWEI from the speedup plugin is just fine.

>  	case OFONO_VENDOR_HUAWEI:
>  		chat =3D g_at_chat_get_slave(cd->chat);
>  		g_at_chat_register(chat, "^DSDORMANT", huawei_dsdormant_notify,

Regards,
-Denis

--===============0617305640443982076==--

