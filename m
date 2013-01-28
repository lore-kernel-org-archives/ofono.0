Content-Type: multipart/mixed; boundary="===============2608745780060683362=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v0 3/9] hfp_hf_bluez5: Add SCO listen socket
Date: Mon, 28 Jan 2013 16:59:39 +0100
Message-ID: <1359388779.16748.35.camel@aeonflux>
In-Reply-To: <1359384259-5384-4-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2608745780060683362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> This patch adds the initial SCO server socket handling. BtIO and BlueZ
> functions should not be used, with the new Profile API the objetive is
> to get rid of these dependencies.
> ---
>  plugins/hfp_hf_bluez5.c | 93 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 93 insertions(+)
> =

> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 0e496ee..398dee0 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -64,6 +64,7 @@ struct hfp {
>  static GHashTable *modem_hash =3D NULL;
>  static GHashTable *devices_proxies =3D NULL;
>  static GDBusClient *bluez =3D NULL;
> +static guint sco_watch =3D 0;
>  =

>  static void hfp_debug(const char *str, void *user_data)
>  {
> @@ -378,6 +379,89 @@ static const GDBusMethodTable profile_methods[] =3D {
>  	{ }
>  };
>  =

> +static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	struct sockaddr_sco saddr;
> +	socklen_t optlen;
> +	int sk, nsk;
> +
> +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> +		return FALSE;
> +
> +	sk =3D g_io_channel_unix_get_fd(io);
> +
> +	memset(&saddr, 0, sizeof(saddr));
> +	optlen =3D sizeof(saddr);
> +
> +	nsk =3D accept(sk, (struct sockaddr *) &saddr, &optlen);
> +	if (nsk < 0)
> +		return TRUE;
> +
> +	/* TODO: Verify if the device has a modem */
> +
> +	return TRUE;
> +}
> +
> +static GIOChannel *sco_listen(int *err)
> +{

I do not like this int *err. Why is this a separate function anyway.
Just do the whole SCO server socket setup with accept watch setup in one
function. There is no advantage in having two functions.

> +	struct sockaddr_sco addr;
> +	GIOChannel *io;
> +	int sk, defer_setup =3D 1;
> +
> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
> +	if (sk < 0) {
> +		*err =3D -errno;
> +		return NULL;
> +	}
> +
> +	/* Bind to local address */
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sco_family =3D AF_BLUETOOTH;
> +	bt_bacpy(&addr.sco_bdaddr, BDADDR_ANY);
> +
> +	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +		close(sk);
> +		*err =3D -errno;
> +		return NULL;
> +	}
> +
> +	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
> +				&defer_setup, sizeof(defer_setup)) < 0) {
> +		ofono_warn("Can't enable deferred setup: %s (%d)",
> +						strerror(errno), errno);
> +		*err =3D -errno;

This is semantically incorrect. You can not return non-NULL and an
error.

Can we actually make HFP 1.6 work properly without defer setup enabled?

> +	}
> +
> +	io =3D g_io_channel_unix_new(sk);
> +	g_io_channel_set_close_on_unref(io, TRUE);
> +	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);

Can you just open the SOCK_NONBLOCK and SOCK_CLOEXEC as we should be
always doing.

> +
> +	if (listen(sk, 5) < 0) {
> +		g_io_channel_unref(io);
> +		*err =3D -errno;
> +		return NULL;
> +	}
> +
> +	return io;
> +}
> +
> +static int sco_init(void)
> +{
> +	GIOCondition cond =3D G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;

What is this extra declaration good for? I rather have it inside the
call that is adding the watch.

> +	GIOChannel *sco_io;
> +	int err =3D 0;
> +
> +	sco_io =3D sco_listen(&err);
> +	if (sco_io =3D=3D NULL)
> +		return err;
> +
> +	sco_watch =3D g_io_add_watch(sco_io, cond, sco_accept, NULL);
> +	g_io_channel_unref(sco_io);
> +
> +	return 0;
> +}
> +
>  static void connect_handler(DBusConnection *conn, void *user_data)
>  {
>  	DBG("Registering External Profile handler ...");
> @@ -500,6 +584,12 @@ static int hfp_init(void)
>  	if (DBUS_TYPE_UNIX_FD < 0)
>  		return -EBADF;
>  =

> +	err =3D sco_init();
> +	if (err < 0) {
> +		ofono_error("SCO: %s(%d)", strerror(-err), -err);
> +		return err;
> +	}
> +
>  	/* Registers External Profile handler */
>  	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
>  					BLUEZ_PROFILE_INTERFACE,
> @@ -550,6 +640,9 @@ static void hfp_exit(void)
>  =

>  	g_hash_table_destroy(modem_hash);
>  	g_hash_table_destroy(devices_proxies);
> +
> +	if (sco_watch)

Normally we do sco_watch > 0 for the GLib sources.

> +		g_source_remove(sco_watch);
>  }
>  =

>  OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VE=
RSION,

Regards

Marcel



--===============2608745780060683362==--

