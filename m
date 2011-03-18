Content-Type: multipart/mixed; boundary="===============3909816091878576817=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] atmodem: fix issue in time reporting with ifx
Date: Fri, 18 Mar 2011 09:10:11 -0700
Message-ID: <1300464611.2572.51.camel@aeonflux>
In-Reply-To: <1300463889-4828-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3909816091878576817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  drivers/atmodem/network-registration.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 4913611..0dbc72d 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -58,6 +58,7 @@ struct netreg_data {
>  	int signal_max; /* max strength reported via CIND */
>  	int tech;
>  	struct ofono_network_time time;
> +	guint nitz_source;

better call this nitz_timeout.

>  	unsigned int vendor;
>  };
>  =

> @@ -691,6 +692,18 @@ static void ctzv_notify(GAtResult *result, gpointer =
user_data)
>  	ofono_netreg_time_notify(netreg, &nd->time);
>  }
>  =

> +static gboolean notify_time(gpointer user_data)
> +{
> +	struct ofono_netreg *netreg =3D user_data;
> +	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +
> +	nd->nitz_source =3D 0;
> +
> +	ofono_netreg_time_notify(netreg, &nd->time);
> +
> +	return FALSE;
> +}
> +
>  static void ifx_ctzv_notify(GAtResult *result, gpointer user_data)
>  {
>  	struct ofono_netreg *netreg =3D user_data;
> @@ -722,6 +735,11 @@ static void ifx_ctzv_notify(GAtResult *result, gpoin=
ter user_data)
>  	nd->time.mday =3D mday;
>  	nd->time.mon =3D mon;
>  	nd->time.year =3D 2000 + year;
> +
> +	if (nd->nitz_source)
> +		g_source_remove(nd->nitz_source);

I prefer to have these checks as if (source > 0).

> +
> +	nd->nitz_source =3D g_timeout_add(0, notify_time, user_data);
>  }

Is a 0 seconds timeout good enough. It could really happen that this
still gets scheduled before the CTZDST is received.

I prefer to use nitz_timeout =3D g_timeout_add_seconds(1, ...)
 =

>  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
> @@ -742,8 +760,6 @@ static void ifx_ctzdst_notify(GAtResult *result, gpoi=
nter user_data)
>  	DBG("dst %d", dst);
>  =

>  	nd->time.dst =3D dst;
> -
> -	ofono_netreg_time_notify(netreg, &nd->time);
>  }

What I like here to see is something like this:

	if (nd->nitz_timeout > 0) {
		g_source_remove(nd->nitz_timeout);
		nd->nitz_timeout =3D 0;
	}

	ofono_netreg_time_notify(netreg, &nd->time);

There is no need to wait for the timeout to trigger.
 =

>  static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
> @@ -1367,6 +1383,11 @@ static void at_netreg_remove(struct ofono_netreg *=
netreg)
>  {
>  	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>  =

> +	if (nd->nitz_source) {
> +		g_source_remove(nd->nitz_source);
> +		nd->nitz_source =3D 0;
> +	}
> +

Use if (nd->nitz_timeout > 0) here as well. And setting it back to zero
is actually not needed here either. You will g_free(nd).

>  	ofono_netreg_set_data(netreg, NULL);
>  =

>  	g_at_chat_unref(nd->chat);

Regards

Marcel



--===============3909816091878576817==--

