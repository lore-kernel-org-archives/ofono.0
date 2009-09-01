Content-Type: multipart/mixed; boundary="===============0034017722475212121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] G1: Add initial HTC G1 modem support
Date: Tue, 01 Sep 2009 12:13:26 -0500
Message-ID: <200909011213.26591.denkenz@gmail.com>
In-Reply-To: <20090830040656.GA28039@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0034017722475212121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> This series adds support for the HTC G1 phone (that is, the Google
> phone).
>
> G1 plugin is based on generic_at, with a bunch of stuff dropped
> and simplified.  We use AT+CFUN=3D1 for powering on rather than having
> a configurable init string.  We also manually set the default state
> during init (the G1 appears to start in mode V0 by default).  The
> device (/dev/smd0) is hardcoded.
> +static gboolean connect_cb(GIOChannel *io, GIOCondition cond, gpointer
> user) +{
> +	struct ofono_modem *modem =3D user;
> +	struct g1_data *d =3D ofono_modem_get_data(modem);
> +	int err =3D 0;
> +	gboolean success;
> +	GAtSyntax *syntax;
> +
> +	if (cond & G_IO_NVAL)
> +		return FALSE;
> +
> +	if (cond & G_IO_OUT) {
> +		int sock =3D g_io_channel_unix_get_fd(io);
> +		socklen_t len =3D sizeof(err);
> +
> +		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
> +			err =3D errno =3D=3D ENOTSOCK ? 0 : errno;
> +	} else if (cond & (G_IO_HUP | G_IO_ERR))
> +		err =3D ECONNRESET;
> +
> +	success =3D !err;
> +
> +	DBG("io ref: %d", io->ref_count);
> +
> +	if (success =3D=3D FALSE)
> +		goto error;
> +
> +	syntax =3D g_at_syntax_new_gsmv1();
> +	d->chat =3D g_at_chat_new(io, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	DBG("io ref: %d", io->ref_count);
> +
> +	if (!d->chat)
> +		goto error;
> +

Since this is a tty, you probably don't need this function at all.

> +static GIOChannel *tty_connect(const char *tty)
> +{
> +	GIOChannel *io;
> +	int sk;
> +	struct termios newtio;
> +
> +	sk =3D open(tty, O_RDWR | O_NOCTTY);
> +
> +	if (sk < 0) {
> +		ofono_error("Can't open TTY %s: %s(%d)",
> +				tty, strerror(errno), errno);
> +		return NULL;
> +	}
> +
> +	newtio.c_cflag =3D B115200 | CRTSCTS | CLOCAL | CREAD;
> +	newtio.c_iflag =3D IGNPAR;
> +	newtio.c_oflag =3D 0;
> +	newtio.c_lflag =3D 0;
> +
> +	newtio.c_cc[VTIME] =3D 1;
> +	newtio.c_cc[VMIN] =3D 5;
> +
> +	tcflush(sk, TCIFLUSH);
> +	if (tcsetattr(sk, TCSANOW, &newtio) < 0) {
> +		ofono_error("Can't change serial settings: %s(%d)",
> +				strerror(errno), errno);
> +		close(sk);
> +		return NULL;
> +	}
> +
> +	io =3D g_io_channel_unix_new(sk);
> +	g_io_channel_set_close_on_unref(io, TRUE);
> +
> +	if (g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK,
> +					NULL) !=3D G_IO_STATUS_NORMAL) {
> +		g_io_channel_unref(io);
> +		return NULL;
> +	}
> +
> +	return io;
> +}

You might want to see if using g_at_chat_new_from_tty works here.  If not, =

then the opening the tty should be broken out into a separate utility funct=
ion =

that can be used from multiple drivers.

> +static int g1_enable(struct ofono_modem *modem)
> +{
> +	struct g1_data *d =3D ofono_modem_get_data(modem);
> +	GIOChannel *io;
> +	GIOCondition cond;
> +
> +	DBG("");
> +
> +	io =3D tty_connect(MODEM_DEVICE);
> +	if (io =3D=3D NULL)
> +		return -EINVAL;
> +
> +	DBG("io ref: %d", io->ref_count);
> +
> +	cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> +	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb,
> +				modem, connect_destroy);
> +
> +	DBG("io ref: %d", io->ref_count);
> +
> +	g_io_channel_unref(io);
> +
> +	DBG("io ref: %d", io->ref_count);
> +	d->io =3D io;
> +
> +	return -EINPROGRESS;
> +}

So I know the generic_at driver does this, but in a real device driver this=
 is =

wrong.  You should probably be using AT+CFUN=3D1 here.  If the g1 supports =
even =

more drastic power up/down options, then these should be used.

> +
> +static int g1_disable(struct ofono_modem *modem)
> +{
> +	struct g1_data *d =3D ofono_modem_get_data(modem);
> +
> +	if (d->io) {
> +		g_io_channel_close(d->io);
> +		d->io =3D NULL;
> +	}
> +
> +	if (d->chat) {
> +		g_at_chat_unref(d->chat);
> +		d->chat =3D NULL;
> +	}
> +
> +	return 0;
> +}

Same thing here.  AT+CFUN=3D0 or AT+CFUN=3D4.

> +static int g1_init(void)
> +{
> +	int err;
> +
> +	err =3D ofono_modem_driver_register(&g1_driver);
> +	if (err)
> +		goto done;
> +
> +	g1_modem =3D ofono_modem_create("G1", "HTC G1");
> +	if (!g1_modem) {
> +		err =3D -EIO;
> +		goto unreg;
> +	}
> +
> +	err =3D ofono_modem_register(g1_modem);
> +	if (err)
> +		goto remove;
> +
> +	return 0;
> +
> +remove:
> +	ofono_modem_remove(g1_modem);
> +unreg:
> +	ofono_modem_driver_unregister(&g1_driver);
> +done:
> +	return err;
> +}
> +

I'd really like to see some sort of detection mechanism here.  Even if it i=
s a =

basic 'if exists /dev/smd0' or reading something from /proc.  As I don't =

necessarily want to see the g1 showing up everywhere.

Regads,
-Denis

--===============0034017722475212121==--

