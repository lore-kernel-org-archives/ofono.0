Content-Type: multipart/mixed; boundary="===============6033560083615026288=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Update rename result to state
Date: Wed, 03 Mar 2010 13:07:38 -0600
Message-ID: <201003031307.38317.denkenz@gmail.com>
In-Reply-To: <1267525299-5740-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6033560083615026288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> to avoid name conflict with GAtServerResult
> ---
>  gatchat/gatserver.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index 253a80a..df3c8bf 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -376,11 +376,11 @@ static void new_bytes(GAtServer *p)
>  	unsigned int len =3D ring_buffer_len(p->read_buf);
>  	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
>  	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far=
);
> -	enum ParserState result;
> +	enum ParserState state;

Actually this should be enum ParserResult result;  Fixed upstream.

Regards,
-Denis

--===============6033560083615026288==--

