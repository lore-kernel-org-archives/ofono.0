Content-Type: multipart/mixed; boundary="===============1583211266626685263=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Mon, 30 Sep 2019 15:59:53 -0500
Message-ID: <b231a0fd-6b2e-c2aa-4537-42eeabd128d0@gmail.com>
In-Reply-To: <20190930173517.1425312-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1583211266626685263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> @@ -227,12 +227,15 @@ static void dispatch_sources(GAtMuxChannel *channel=
, GIOCondition condition)
>   static gboolean received_data(GIOChannel *channel, GIOCondition cond,
>   							gpointer data)
>   {
> -	GAtMux *mux =3D data;
> +	GAtMux *mux =3D g_at_mux_ref(data);

So you're taking a ref here unconditionally, yet...

>   	int i;
>   	GIOStatus status;
>   	gsize bytes_read;
>   =

>   	if (cond & G_IO_NVAL)
> +		goto out_done;
> +
> +	if (mux->shutdown)
>   		return FALSE;

You don't return it here?

>   =

>   	debug(mux, "received data");
> @@ -270,15 +273,22 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
>   	}
>   =

>   	if (cond & (G_IO_HUP | G_IO_ERR))
> -		return FALSE;
> +		goto out_done;
>   =

>   	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
> -		return FALSE;
> +		goto out_done;
>   =

>   	if (mux->buf_used =3D=3D sizeof(mux->buf))
> -		return FALSE;
> +		goto out_done;
> +
> +	g_at_mux_unref(mux);
>   =


Why not do something like:

		g_at_mux_ref(mux);

                 for (i =3D 1; i <=3D MAX_CHANNELS && !mux->shutdown; i++) {
                         int offset =3D i / 8;
                         int bit =3D i % 8;

                         if (!(mux->newdata[offset] & (1 << bit)))
                                 continue;

                         dispatch_sources(mux->dlcs[i-1], G_IO_IN);
                 }

		g_at_mux_unref(mux);


>   	return TRUE;
> +
> +out_done:
> +	g_at_mux_unref(mux);
> +
> +	return FALSE;
>   }
>   =

>   static void write_watcher_destroy_notify(gpointer user_data)
> @@ -286,6 +296,9 @@ static void write_watcher_destroy_notify(gpointer use=
r_data)
>   	GAtMux *mux =3D user_data;
>   =

>   	mux->write_watch =3D 0;
> +
> +	if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
> +		g_free(mux);
>   }
>   =

>   static gboolean can_write_data(GIOChannel *chan, GIOCondition cond,
> @@ -297,6 +310,9 @@ static gboolean can_write_data(GIOChannel *chan, GIOC=
ondition cond,
>   	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
>   		return FALSE;
>   =

> +	if (mux->shutdown)
> +		return FALSE;
> +
>   	debug(mux, "can write data");
>   =

>   	for (dlc =3D 0; dlc < MAX_CHANNELS; dlc +=3D 1) {
> @@ -607,6 +623,7 @@ GAtMux *g_at_mux_new(GIOChannel *channel, const GAtMu=
xDriver *driver)
>   	if (mux =3D=3D NULL)
>   		return NULL;
>   =

> +
>   	mux->ref_count =3D 1;
>   	mux->driver =3D driver;
>   	mux->shutdown =3D TRUE;
> @@ -642,7 +659,8 @@ void g_at_mux_unref(GAtMux *mux)
>   		if (mux->driver->remove)
>   			mux->driver->remove(mux);
>   =

> -		g_free(mux);
> +		if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
> +			g_free(mux);

This looks dangerous to me.  You're going to cause a crash like this. =

You really want to call the disconnect function instead.  But I suspect =

this is a different patch entirely.

>   	}
>   }
>   =

> @@ -651,6 +669,9 @@ static void read_watcher_destroy_notify(gpointer user=
_data)
>   	GAtMux *mux =3D user_data;
>   =

>   	mux->read_watch =3D 0;
> +
> +	if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
> +		g_free(mux);

Same here

>   }
>   =

>   gboolean g_at_mux_start(GAtMux *mux)
> @@ -695,6 +716,7 @@ gboolean g_at_mux_shutdown(GAtMux *mux)
>   			continue;
>   =

>   		channel_close((GIOChannel *) mux->dlcs[i], NULL);
> +		mux->dlcs[i] =3D NULL;

This can probably be a separate cleanup patch.

>   	}
>   =

>   	if (mux->driver->shutdown)
> =


Regards,
-Denis
--===============1583211266626685263==--

