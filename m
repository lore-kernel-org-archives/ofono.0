Content-Type: multipart/mixed; boundary="===============5131096057518152862=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 1/2] Add plugin for Cinterion TC65 modem
Date: Mon, 10 Jan 2011 15:17:59 -0600
Message-ID: <4D2B7787.3030609@gmail.com>
In-Reply-To: <1294616688-17246-2-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5131096057518152862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On 01/09/2011 05:44 PM, oskari.timperi(a)ixonos.com wrote:
> From: Oskari Timperi <oskari.timperi@iki.fi>
> =

> ---
>  Makefile.am    |    3 +
>  plugins/tc65.c |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 268 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/tc65.c
> =


So I applied this patch since it seemed a good enough start to me.
However, I did make some additional fixes afterward.  Can you please
check them and make sure you agree with these?

Also, one other thing for you to fix:

> +static int tc65_disable(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	g_at_chat_send(chat, "AT+CFUN=3D7", NULL, NULL, NULL, NULL);
> +
> +	g_at_chat_unref(chat);
> +
> +	return 0;
> +}

The g_at_chat_send above has no effect since you unref the channel right
afterward.  GAtChat uses non-blocking reads / writes and poll / select.
 This means that the even loop must be entered before any read / write
happens.  If you truly wish to send the CFUN=3D7 on disable, then you
should add a callback that calls ofono_modem_set_powered(modem, FALSE).

I leave this up to you to add as a separate patch.

Regards,
-Denis

--===============5131096057518152862==--

