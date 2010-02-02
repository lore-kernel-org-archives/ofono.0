Content-Type: multipart/mixed; boundary="===============2304217183531709171=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Fix use of uninitialized variable
Date: Tue, 02 Feb 2010 16:33:07 -0600
Message-ID: <201002021633.07612.denkenz@gmail.com>
In-Reply-To: <1265148510-24408-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2304217183531709171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> ---
>  gatchat/gatchat.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> index e25bfd6..5b0851b 100644
> --- a/gatchat/gatchat.c
> +++ b/gatchat/gatchat.c
> @@ -692,7 +692,7 @@ static gboolean received_data(GIOChannel *channel,
>  GIOCondition cond, unsigned char *buf;
>  	GAtChat *chat =3D data;
>  	GIOError err;
> -	gsize rbytes;
> +	gsize rbytes =3D 0;
>  	gsize toread;
>  	gsize total_read =3D 0;
>  	guint read_count =3D 0;
> =


I'm convinced that this is a false positive.  The read_count keeps rbytes f=
rom =

ever being referenced when undefined.

Regards,
-Denis

--===============2304217183531709171==--

