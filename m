Content-Type: multipart/mixed; boundary="===============4171836380023022191=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: fix channel remove on error.
Date: Tue, 04 Oct 2016 22:16:17 -0500
Message-ID: <57F47081.9010406@gmail.com>
In-Reply-To: <413c78b0-58b5-42cc-0d2f-ec0615a83688@overkiz.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4171836380023022191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

On 10/04/2016 02:42 AM, Antoine Aubert wrote:
> In case of invalid IO, read_watch is not reset. Fix crash on destroy
> gatmux.
>
> Signed-off-by: Antoine Aubert<a.aubert@overkiz.com>

We don't use Signed-off-by here.  See HACKING, Submitting Patches section.

> ---
>   gatchat/gatmux.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
> index 9beeece..896ddff 100644
> --- a/gatchat/gatmux.c
> +++ b/gatchat/gatmux.c
> @@ -186,8 +186,10 @@ static gboolean received_data(GIOChannel *channel, G=
IOCondition cond,
>   	GIOStatus status;
>   	gsize bytes_read;
>
> -	if (cond & G_IO_NVAL)
> +	if (cond & G_IO_NVAL) {
> +		mux->read_watch =3D 0;
>   		return FALSE;
> +	}

Good catch on this one.  However it might be easier solved by using a =

watch destroy notify function.  E.g. in g_at_mux_start():

         mux->read_watch =3D g_io_add_watch_full(mux->channel, =

G_PRIORITY_DEFAULT,
                                 G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
                                                 received_data, mux, NULL);

The last NULL parameter should be set to a new function that resets the =

mux->read_watch to 0.  Similar to write_watcher_destroy_notify.

>
>   	debug(mux, "received data");
>
> @@ -223,14 +225,20 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
>   		}
>   	}
>
> -	if (cond & (G_IO_HUP | G_IO_ERR))
> +	if (cond & (G_IO_HUP | G_IO_ERR)) {
> +		mux->read_watch =3D 0;
>   		return FALSE;
> +	}
>
> -	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
> +	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN) {
> +		mux->read_watch =3D 0;
>   		return FALSE;
> +	}
>
> -	if (mux->buf_used =3D=3D sizeof(mux->buf))
> +	if (mux->buf_used =3D=3D sizeof(mux->buf)) {
> +		mux->read_watch =3D 0;
>   		return FALSE;
> +	}

That way all these redundant statements are handled by the destroy notify.

>
>   	return TRUE;
>   }
> --
> 2.7.4
>

Care to resubmit?

Regards,
-Denis


--===============4171836380023022191==--

