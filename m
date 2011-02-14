Content-Type: multipart/mixed; boundary="===============2405073540354742220=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gatserver: Add ATS5 command feature
Date: Mon, 14 Feb 2011 09:53:02 -0600
Message-ID: <4D594FDE.7030904@gmail.com>
In-Reply-To: <1297346382-20135-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2405073540354742220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On 02/10/2011 07:59 AM, Olivier Guiter wrote:
> ---
>  gatchat/gatserver.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> =


<snip>

> @@ -837,7 +838,11 @@ static char *extract_line(GAtServer *p, struct ring_=
buffer *rbuf)
>  		if (*buf =3D=3D '"')
>  			in_string =3D !in_string;
>  =

> -		if ((*buf =3D=3D ' ' || *buf =3D=3D '\t') && in_string =3D=3D FALSE)
> +		if (*buf =3D=3D s5) {
> +			if (i !=3D 0)
> +				i -=3D 1;
> +		}
> +		else if ((*buf =3D=3D ' ' || *buf =3D=3D '\t') && in_string =3D=3D FAL=
SE)

Please note that we follow the Linux kernel coding style, and in fact
the closing brace should be on the same line as the else if.  See
CodingStyle document in the linux kernel git for more details.

I've fixed this for you.  Patch has been applied, thanks.

Regards,
-Denis

--===============2405073540354742220==--

