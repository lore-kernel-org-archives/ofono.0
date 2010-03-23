Content-Type: multipart/mixed; boundary="===============2859158347722471052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add basic command parsing
Date: Tue, 23 Mar 2010 16:18:57 -0500
Message-ID: <201003231618.57357.denkenz@gmail.com>
In-Reply-To: <1269339283-9697-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2859158347722471052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatserver.c |  110
>  ++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files changed, =

109
>  insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index 6579b38..c207bd8 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -308,9 +308,117 @@ next:
>  	return i + 1;
>  }
> =

> +static gboolean get_basic_prefix(const char *buf, char *prefix)
> +{
> +	char c =3D *buf;
> +
> +	if (!g_ascii_isalpha(c) && c !=3D '&')
> +		return FALSE;
> +
> +	if (g_ascii_isalpha(c)) {
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

Is there some limit on the number?  Can we limit it to max int or something?

> +
> +			prefix[i] =3D '\0';
> +		} else {
> +			prefix[0] =3D c;
> +			prefix[1] =3D '\0';
> +		}

Use a return here or an else if clause, no sense checking the if twice.

> +	}
> +
> +	if (c =3D=3D '&') {
> +		prefix[0] =3D '&';
> +		prefix[1] =3D g_ascii_toupper(buf[1]);
> +		prefix[2] =3D '\0';
> +	}
> +
> +	return TRUE;
> +}
> +
>  static unsigned int parse_basic_command(GAtServer *server, char *buf)
>  {
> -	return 0;
> +	char *command =3D NULL;

Why do you initialize this?  Doesn't seem to be a point.

> +	char prefix[3];
> +	unsigned int i;
> +	GAtServerRequestType type;
> +	gboolean seen_equals =3D FALSE;
> +
> +	if (!get_basic_prefix(buf, prefix))
> +		return 0;
> +
> +	i =3D strlen(prefix);
> +
> +	if (*prefix =3D=3D 'D') {
> +		type =3D G_AT_SERVER_REQUEST_TYPE_SET;
> +
> +		/* All following characters are the part of the call */
> +		while (buf[i] !=3D '\0')
> +			i +=3D 1;

Quoting V.250:
All characters appearing on the same command line after the "D" are conside=
red =

part of the call addressing information to be signalled to the network, or =

modifiers used to control the signalling process (collectively known as a "=
dial =

string"), up to a semicolon character (IA5 3/11) or the end of the command =

line.

So this logic seems incorrect.

> +
> +		goto done;
> +	}
> +
> +	if (buf[i] =3D=3D '\0' || buf[i] =3D=3D ';') {
> +		type =3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY;
> +		goto done;
> +	}
> +
> +	/* Additional commands may follow a command without any character
> +	 * required for separation.
> +	 */
> +	if (is_basic_command_prefix(&buf[i])) {
> +		type =3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY;
> +		goto done;
> +	}
> +
> +	/* Match '?', '=3D',  '=3D?' and '=3Dxxx' */
> +	if (buf[i] =3D=3D '=3D') {
> +		seen_equals =3D TRUE;
> +		i +=3D 1;
> +	}
> +
> +	if (buf[i] =3D=3D '?') {
> +		i +=3D 1;
> +
> +		if (seen_equals)
> +			type =3D G_AT_SERVER_REQUEST_TYPE_SUPPORT;
> +		else
> +			type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
> +	} else {
> +		/* V.250 5.3.1 The subparameter (if any) are all digits */
> +		while (g_ascii_isdigit(buf[i]))
> +			i++;
> +
> +		type =3D G_AT_SERVER_REQUEST_TYPE_SET;
> +	}
> +
> +done:
> +	command =3D g_strndup(buf, i);
> +
> +	at_command_notify(server, command, prefix, type);
> +
> +	g_free(command);
> +
> +	/* Commands like ATA, ATD, ATZ cause the remainder line
> +	 * to be ignored.
> +	 */
> +	if (*prefix =3D=3D 'A' || *prefix =3D=3D 'D' || *prefix =3D=3D 'Z')
> +		return 0;

Returning 0 means this command was not properly formatted.  Not something y=
ou =

want.  Also, as we saw before this is true of ATA and possibly ATZ, but not =

ATD.

> +
> +	/* Consumed the seperator ';' */
> +	if (buf[i] =3D=3D ';')
> +		i +=3D 1;
> +
> +	return i;
>  }
> =

>  static void server_parse_line(GAtServer *server, char *line)
> =


Regards,
-Denis

--===============2859158347722471052==--

