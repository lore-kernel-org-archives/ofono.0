Content-Type: multipart/mixed; boundary="===============1251548499936242445=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] Add basic command parsing
Date: Wed, 17 Mar 2010 12:02:17 -0600
Message-ID: <201003171302.17451.denkenz@gmail.com>
In-Reply-To: <1268836241-4834-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1251548499936242445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> According to V.250 5.3.1, the basic command is either a single
> character or the '&' followed by a single character.
> ---
>  gatchat/gatserver.c |   68
>  ++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files changed, =

67
>  insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index fb82ad4..b68894d 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -211,10 +211,67 @@ static char *parse_extended_command(GAtServer
>  *server, const char *buf, return NULL;
>  }
> =

> +static gboolean get_basic_prefix(const char *buf, char *prefix)
> +{
> +	char c =3D *buf;
> +
> +	if (g_ascii_isalpha(c)) {

if (!g_ascii_isalpha && c !=3D '&')
	return

No nested ifs if you can avoid them please.

> +		c =3D g_ascii_toupper(c);
> +		if (c =3D=3D 'S') {
> +			int i =3D 0;
> +
> +			prefix[0] =3D 'S';
> +
> +			/* V.250 5.3.2 'S' command follows with
> +			 * a parameter number.
> +			 */
> +			while (g_ascii_isdigit(buf[++i]))
> +				prefix[i] =3D buf[i];
> +
> +			prefix[i] =3D '\0';
> +		} else {
> +			prefix[0] =3D c;
> +			prefix[1] =3D '\0';
> +		}
> +	} else if (c =3D=3D '&') {
> +		prefix[0] =3D '&';
> +		prefix[1] =3D g_ascii_toupper(buf[1]);
> +		prefix[2] =3D '\0';
> +	} else
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
>  static char *parse_next_command(GAtServer *server, const char *buf,
> @@ -263,6 +320,15 @@ static void server_parse_line(GAtServer *server, char
>  *line) break;
>  		}
> =

> +		/* Commands like ATA, ATD, ATZ cause the remainder line
> +		 * to be ignored.
> +		 */
> +		if (!strcmp(prefix, "A") || !strcmp(prefix, "D") ||
> +				!strcmp(prefix, "Z")) {
> +			g_free(command);
> +			break;
> +		}
> +

strcmp might be overkill here

>  		buf +=3D strlen(command);
> =

>  		g_free(command);
>=20

--===============1251548499936242445==--

