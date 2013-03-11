Content-Type: multipart/mixed; boundary="===============7858325924104898907=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v0 11/13] handsfree-audio: Add sending SCO fd
Date: Mon, 11 Mar 2013 07:55:47 -0700
Message-ID: <20130311145547.GA28047@x220>
In-Reply-To: <1362784285-22731-12-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7858325924104898907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Fri, Mar 08, 2013, Claudio Takahasi wrote:
> This patch adds the call of NewConnection method when the SCO connection
> is established for HF initiated scenarios.
> ---
>  src/handsfree-audio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index f5d0a7b..6fa8b67 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -242,12 +242,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOC=
ondition cond,
>  {
>  	struct ofono_handsfree_card *card =3D user_data;
>  	DBusMessage *reply;
> +	int sk;
>  =

>  	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
>  		reply =3D __ofono_error_failed(card->msg);
>  		goto done;
>  	}
>  =

> +	sk =3D g_io_channel_unix_get_fd(io);
> +
> +	send_new_connection(card->path, sk);
> +
> +	close(sk);
> +
>  	reply =3D dbus_message_new_method_return(card->msg);

Shouldn't you be adding a watch for the connected SCO socket instead of
closing it? Is it not necessary for oFono to know the SCO state? (to
detect when PA did shutdown() on the socket, return "already connected"
for Connect(), etc.)

Johan

--===============7858325924104898907==--

