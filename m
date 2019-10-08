Content-Type: multipart/mixed; boundary="===============7296670932025116687=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] gatmux: take reference to mux object while processing
 incoming data
Date: Mon, 07 Oct 2019 23:08:06 -0500
Message-ID: <22c80e86-4a7f-05da-0ca6-051284681de5@gmail.com>
In-Reply-To: <20191007212945.19850-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7296670932025116687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> @@ -646,13 +653,6 @@ void g_at_mux_unref(GAtMux *mux)
>   	}
>   }
>   =

> -static void read_watcher_destroy_notify(gpointer user_data)
> -{
> -	GAtMux *mux =3D user_data;
> -
> -	mux->read_watch =3D 0;
> -}
> -
>   gboolean g_at_mux_start(GAtMux *mux)
>   {
>   	if (mux->channel =3D=3D NULL)
> @@ -666,8 +666,7 @@ gboolean g_at_mux_start(GAtMux *mux)
>   =

>   	mux->read_watch =3D g_io_add_watch_full(mux->channel, G_PRIORITY_DEFAU=
LT,
>   				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> -						received_data, mux,
> -						read_watcher_destroy_notify);
> +						received_data, mux, NULL);
>   =

>   	mux->shutdown =3D FALSE;
>   =

> =


Can you tell me why this part is needed?  Does glib not call =

read_watcher_destroy_notify right away when the source is removed?

Regards,
-Denis
--===============7296670932025116687==--

