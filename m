Content-Type: multipart/mixed; boundary="===============7938081775200400823=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v3 2/3] phonesim: Add modem reset trigger
Date: Tue, 23 Nov 2010 04:59:33 -0600
Message-ID: <4CEB9E95.8000703@gmail.com>
In-Reply-To: <1290202590-23190-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7938081775200400823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 11/19/2010 03:36 PM, Gustavo F. Padovan wrote:
> ---
>  plugins/phonesim.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index d2faf42..7426da6 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -237,6 +237,13 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	ofono_modem_set_powered(modem, ok);
>  }
>  =

> +static void crst_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	ofono_modem_reset(modem);

I suggest you simply clean up the phonesim connection (e.g. closing the
tcp socket) when you receive this notification, and then call
modem_reset at the end.

> +}
> +
>  static void phonesim_disconnected(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -389,6 +396,9 @@ static int phonesim_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
>  			NULL, NULL, NULL);
>  =

> +	g_at_chat_register(data->chat, "+CRST:",
> +				crst_notify, FALSE, modem, NULL);
> +
>  	return 0;
>  }
>  =


Regards,
-Denis

--===============7938081775200400823==--

