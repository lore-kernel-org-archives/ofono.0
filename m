Content-Type: multipart/mixed; boundary="===============0004025802780161742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: make sure to unsubscribe the GAtIO write handler
 on disconnect.
Date: Tue, 23 Nov 2010 03:22:43 -0600
Message-ID: <4CEB87E3.8050708@gmail.com>
In-Reply-To: <1290400982-17615-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0004025802780161742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/21/2010 10:43 PM, Andrzej Zaborowski wrote:
> There's a small probability that we call chat_wakeup_writer
> just before the channel disonnects and for some reason glib then
> calls can_write_data after we have unrefed the io and freed all the
> resources.  Calling at_chat_suspend unsubscribes can_write_data
> from the io.
> ---
>  gatchat/gatchat.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> index 218f592..957181c 100644
> --- a/gatchat/gatchat.c
> +++ b/gatchat/gatchat.c
> @@ -40,6 +40,7 @@
>  =

>  struct at_chat;
>  static void chat_wakeup_writer(struct at_chat *chat);
> +static void at_chat_suspend(struct at_chat *chat);

This is really against the coding standard ;)

>  =

>  static const char *none_prefix[] =3D { NULL };
>  =

> @@ -364,6 +365,7 @@ static void io_disconnect(gpointer user_data)
>  	struct at_chat *chat =3D user_data;
>  =

>  	chat_cleanup(chat);
> +	at_chat_suspend(chat);
>  	g_at_io_unref(chat->io);
>  	chat->io =3D NULL;
>  =


Actually I think the right fix is to remove the write watcher in
io_shutdown.

I pushed an experimental patch 99107c6c9d0ae42eb96621b0fc34972e418f1755,
please let me know if this fixes the issue.

Regards,
-Denis

--===============0004025802780161742==--

