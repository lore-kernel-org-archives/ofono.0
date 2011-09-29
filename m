Content-Type: multipart/mixed; boundary="===============3649062842030462610=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v5 03/13] telit: add support the enable the SAP client
 modem
Date: Thu, 29 Sep 2011 10:53:18 -0500
Message-ID: <4E84946E.4080308@gmail.com>
In-Reply-To: <1317245061-6312-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3649062842030462610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 09/28/2011 04:24 PM, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> =

> ---
>  plugins/bluetooth.h |    3 +-
>  plugins/telit.c     |  191 +++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 184 insertions(+), 10 deletions(-)

Patch has been applied, see below:

> +static int telit_sap_open()
> +{
> +	const char *device =3D "/dev/ttyUSB4";

This part should probably come from udev or a config file somewhere.
Worst case /etc/ofono/telitsap.conf or something like that.

> +	struct termios ti;
> +	int fd;
> +
> +	DBG("%s", device);
> +
> +	fd =3D open(device, O_RDWR | O_NOCTTY | O_NONBLOCK);
> +	if (fd < 0)
> +		return -EINVAL;
>  =

> +	/* Switch TTY to raw mode */
> +	memset(&ti, 0, sizeof(ti));
> +	cfmakeraw(&ti);
> +
> +	ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
> +
> +	tcflush(fd, TCIOFLUSH);
> +	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
> +		close(fd);
> +		return -EBADF;
> +	}
> +
> +	return fd;
>  }
>  =

> -static int telit_sap_enable(struct ofono_modem *modem)
> +static int telit_sap_enable(struct ofono_modem *modem,
> +					struct ofono_modem *sap_modem,
> +					int bt_fd)
>  {
>  	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	int fd;
>  =

>  	DBG("%p", modem);
>  =

> -	data->chat =3D open_device(modem, "Data", "Aux: ");
> -	if (data->chat =3D=3D NULL)
> +	data->aux =3D open_device(modem, "Data", "Aux: ");
> +	if (data->aux =3D=3D NULL)
>  		return -EINVAL;
>  =

> -	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
> +	fd =3D telit_sap_open();
> +	if (fd < 0)
> +		return fd;
> +
> +	data->hw_io =3D g_io_channel_unix_new(fd);
> +	if (data->hw_io =3D=3D NULL) {
> +		close(fd);

You weren't closing the aux channel here

> +		return -ENOMEM;
> +	}
> +
> +	g_io_channel_set_encoding(data->hw_io, NULL, NULL);
> +	g_io_channel_set_buffered(data->hw_io, FALSE);
> +	g_io_channel_set_close_on_unref(data->hw_io, TRUE);
> +
> +	data->hw_watch =3D g_io_add_watch_full(data->hw_io, G_PRIORITY_DEFAULT,
> +				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
> +				hw_event_cb, modem, hw_watch_remove);
> +
> +	data->bt_io =3D g_io_channel_unix_new(bt_fd);
> +	if (data->bt_io =3D=3D NULL) {
> +		sap_close_io(modem);
> +		return -ENOMEM;
> +	}
> +
> +	g_io_channel_set_encoding(data->bt_io, NULL, NULL);
> +	g_io_channel_set_buffered(data->bt_io, FALSE);
> +	g_io_channel_set_close_on_unref(data->bt_io, TRUE);
> +
> +	data->bt_watch =3D g_io_add_watch_full(data->bt_io, G_PRIORITY_DEFAULT,
> +				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
> +				bt_event_cb, modem, bt_watch_remove);
> +
> +
> +	data->sap_modem =3D sap_modem;
> +
> +	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
>  				FALSE, modem, NULL);
>  =

> -	g_at_chat_send(data->chat, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->aux, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
>  =

>  	/* Set SAP functionality */
> -	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
> +	g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
>  				rsen_enable_cb, modem, NULL);
>  =

>  	return -EINPROGRESS;

So I reflowed this function in a follow on patch, please double check it
for correctness.

Regards,
-Denis

--===============3649062842030462610==--

