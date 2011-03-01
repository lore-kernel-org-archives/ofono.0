Content-Type: multipart/mixed; boundary="===============2110141896232057936=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] mbmmodem: close chat before sending fd
Date: Tue, 01 Mar 2011 15:46:22 -0600
Message-ID: <4D6D692E.1020209@gmail.com>
In-Reply-To: <1298900634-2337-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2110141896232057936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/28/2011 07:43 AM, Lucas De Marchi wrote:
> ---
>  drivers/mbmmodem/location-reporting.c |   44 ++++++++++++++++++---------=
------
>  1 files changed, 24 insertions(+), 20 deletions(-)
> =

> diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/loc=
ation-reporting.c
> index 941fac4..b671d71 100644
> --- a/drivers/mbmmodem/location-reporting.c
> +++ b/drivers/mbmmodem/location-reporting.c
> @@ -48,7 +48,7 @@ static const char *e2gpsctl_prefix[] =3D { "*E2GPSCTL:"=
, NULL };
>  =

>  struct gps_data {
>  	GAtChat *chat;
> -	GAtChat *data_chat;
> +	GIOChannel *data_channel;
>  };
>  =

>  static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResult *result,
> @@ -70,7 +70,7 @@ static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtRes=
ult *result,
>  		return;
>  	}
>  =

> -	g_at_chat_unref(gd->data_chat);
> +	g_io_channel_unref(gd->data_channel);
>  =

>  	CALLBACK_WITH_SUCCESS(cb, cbd->data);
>  }
> @@ -94,33 +94,33 @@ static void mbm_location_reporting_disable(struct ofo=
no_location_reporting *lr,
>  	g_free(cbd);
>  }
>  =

> -static int mbm_create_data_chat(struct ofono_location_reporting *lr)
> +static GAtChat *mbm_create_data_chat(struct ofono_location_reporting *lr)
>  {
>  	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
>  	struct ofono_modem *modem;
>  	const char *gps_dev;
>  	GAtSyntax *syntax;
> -	GIOChannel *channel;
> -	int fd;
> +	GAtChat *chat;
>  =

>  	modem =3D ofono_location_reporting_get_modem(lr);
>  	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
>  =

> -	channel =3D g_at_tty_open(gps_dev, NULL);
> -	if (channel =3D=3D NULL)
> -		return -1;
> +	gd->data_channel =3D g_at_tty_open(gps_dev, NULL);
> +	if (gd->data_channel =3D=3D NULL)
> +		return NULL;
>  =

>  	syntax =3D g_at_syntax_new_gsm_permissive();
> -	gd->data_chat =3D g_at_chat_new(channel, syntax);
> -	fd =3D g_io_channel_unix_get_fd(channel);
> +	chat =3D g_at_chat_new(gd->data_channel, syntax);
>  =

>  	g_at_syntax_unref(syntax);
> -	g_io_channel_unref(channel);
>  =

> -	if (gd->data_chat =3D=3D NULL)
> -		return -1;
> +	if (chat =3D=3D NULL) {
> +		g_io_channel_unref(gd->data_channel);
> +
> +		return NULL;
> +	}
>  =

> -	return fd;
> +	return chat;
>  }
>  =

>  static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResult *result,
> @@ -131,7 +131,7 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtRe=
sult *result,
>  	struct ofono_location_reporting *lr =3D cbd->user;
>  	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
>  	struct ofono_error error;
> -	int fd;
> +	GAtChat *chat;
>  =

>  	DBG("lr=3D%p ok=3D%d", lr, ok);
>  =

> @@ -143,18 +143,22 @@ static void mbm_e2gpsctl_enable_cb(gboolean ok, GAt=
Result *result,
>  		return;
>  	}
>  =

> -	fd =3D mbm_create_data_chat(lr);
> -
> -	if (fd < 0)
> +	chat =3D mbm_create_data_chat(lr);
> +	if (chat =3D=3D NULL)
>  		goto out;
>  =

> -	if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
> -								NULL) > 0) {
> +	if (g_at_chat_send(chat, "AT*E2GPSNPD", NULL, NULL, NULL, NULL) > 0) {

Are you sure this actually works as intended?  By default chat uses
non-blocking writes and waits for the write watcher to fire.  So just
because we succeed here does not mean anything has been written to the
channel.  It just means we queued something up and created a write watch.

> +		int fd =3D g_io_channel_unix_get_fd(gd->data_channel);
> +
> +		g_at_chat_unref(chat);

And here you destroy the write queue and the write watch.

>  		cb(&error, fd, cbd->data);
>  =

>  		return;
>  	}
>  =

> +	g_at_chat_unref(chat);
> +	g_io_channel_unref(gd->data_channel);
> +
>  out:
>  	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>  }

Regards,
-Denis

--===============2110141896232057936==--

