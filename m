Content-Type: multipart/mixed; boundary="===============1626162889534218035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v3 14/16] elect: Add GatChat and PPP handler
Date: Wed, 14 Dec 2011 19:20:12 -0600
Message-ID: <4EE94B4C.1010400@gmail.com>
In-Reply-To: <1323788410-9988-15-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1626162889534218035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 12/13/2011 09:00 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> ---
>  Makefile.am  |    2 +-
>  elect/dial.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 125 insertions(+), 2 deletions(-)
> =


<snip>

> +static int open_serial(struct elect_dial *dial)
> +{
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +
> +	channel =3D g_at_tty_open(dial->path, NULL);
> +	if (channel =3D=3D NULL)
> +		return -EIO;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	dial->chat =3D g_at_chat_new(channel, syntax);
> +	g_io_channel_unref(channel);
> +	g_at_syntax_unref(syntax);
> +
> +	if (dial->chat =3D=3D NULL)
> +		return -EIO;
> +
> +	g_at_chat_set_debug(dial->chat, dial_debug, "Control");
> +
> +	return 0;
> +}
> +

This is another case where the setup of the transport is really breaking
your abstractions.  While this might work for RFCOMM ttys which are just
fake ttys (e.g. no serial options, etc) this won't work for real ttys.
You really need to abstract this part and let the plugins setup the
transports.  Ideally the core should receive a fully set-up file
descriptor and take it from there.

See src/emulator.c inside oFono for some ideas.

Regards,
-Denis

--===============1626162889534218035==--

