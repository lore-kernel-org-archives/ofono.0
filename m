Content-Type: multipart/mixed; boundary="===============1639848676125390755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/10] Fix do not emit error if extended error has emitted
Date: Mon, 22 Mar 2010 13:27:52 -0500
Message-ID: <201003221327.53092.denkenz@gmail.com>
In-Reply-To: <1268991888-17279-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1639848676125390755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatserver.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index 1ffc2c3..9683fa3 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -165,6 +165,10 @@ static void g_at_server_send_final(GAtServer *server,
>  GAtServerResult result) char r =3D v250.s4;
>  	unsigned int len;
> =

> +	/* Do not emit error if extended error has already been emitted */
> +	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
> +		return;
> +

I really don't get it, why would anyone call g_at_server_send_final with =

EXT_ERROR?  Don't we have g_at_server_send_ext_final or something for that?

>  	if (v250.quiet)
>  		return;
> =


Regards,
-Denis

--===============1639848676125390755==--

