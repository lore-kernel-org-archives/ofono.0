Content-Type: multipart/mixed; boundary="===============2567007181681546457=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Refactor the command parsing
Date: Mon, 29 Mar 2010 14:35:01 -0500
Message-ID: <201003291435.01473.denkenz@gmail.com>
In-Reply-To: <1269870604-28896-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2567007181681546457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatserver.c |  103
>  +++++++++++++++++++++++++++----------------------- 1 files changed, 56
>  insertions(+), 47 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index c75fbf5..07999a8 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -112,6 +112,8 @@ struct _GAtServer {
>  	guint max_read_attempts;		/* Max reads per select */
>  	enum ParserState parser_state;
>  	gboolean destroyed;			/* Re-entrancy guard */
> +	char *read_line;			/* Current read line */

How about char *last_cmd;

> +	unsigned int read_pos;			/* Current read offset */

And cur_pos;

>  };
> =

>  static void g_at_server_wakeup_writer(GAtServer *server);
> @@ -215,7 +217,7 @@ static void at_command_notify(GAtServer *server, char
>  *command, g_slist_free(result.lines);
>  }
> =

> -static unsigned int parse_extended_command(GAtServer *server, char *buf)
> +static void parse_extended_command(GAtServer *server, char *buf)
>  {
>  	const char *valid_extended_chars =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>  						"0123456789!%-./:_";
> @@ -230,7 +232,7 @@ static unsigned int parse_extended_command(GAtServer
>  *server, char *buf) prefix_len =3D strcspn(buf, separators);
> =

>  	if (prefix_len > 17 || prefix_len < 2)
> -		return 0;
> +		goto error;
> =

>  	/* Convert to upper case, we will always use upper case naming */
>  	for (i =3D 0; i < prefix_len; i++)
> @@ -239,17 +241,17 @@ static unsigned int parse_extended_command(GAtServer
>  *server, char *buf) prefix[prefix_len] =3D '\0';
> =

>  	if (strspn(prefix + 1, valid_extended_chars) !=3D (prefix_len - 1))
> -		return 0;
> +		goto error;
> =

>  	/*
>  	 * V.250 Section 5.4.1: "The first character following "+" shall be
>  	 * an alphabetic character in the range "A" through "Z".
>  	 */
>  	if (prefix[1] <=3D 'A' || prefix[1] >=3D 'Z')
> -		return 0;
> +		goto error;
> =

>  	if (buf[i] !=3D '\0' && buf[i] !=3D ';' && buf[i] !=3D '?' && buf[i] !=
=3D '=3D')
> -		return 0;
> +		goto error;
> =

>  	type =3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY;
> =

> @@ -265,16 +267,16 @@ static unsigned int parse_extended_command(GAtServer
>  *server, char *buf)
> =

>  		if (buf[i] =3D=3D '?') {
>  			if (seen_question || seen_equals)
> -				return 0;
> +				goto error;
> =

>  			if (buf[i + 1] !=3D '\0' && buf[i + 1] !=3D ';')
> -				return 0;
> +				goto error;
> =

>  			seen_question =3D TRUE;
>  			type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
>  		} else if (buf[i] =3D=3D '=3D') {
>  			if (seen_equals || seen_question)
> -				return 0;
> +				goto error;
> =

>  			seen_equals =3D TRUE;
> =

> @@ -291,10 +293,15 @@ next:
>  	/* We can scratch in this buffer, so mark ';' as null */
>  	buf[i] =3D '\0';
> =

> +	/* Also consume the terminating null */
> +	server->read_pos +=3D i + 1;
> +
>  	at_command_notify(server, buf, prefix, type);
> =

> -	/* Also consume the terminating null */
> -	return i + 1;
> +	return;
> +
> +error:
> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>  }

So I suggest you leave this function as is and do the read_pos logic in =

server_parse_line.

> =

>  static int get_basic_prefix_size(const char *buf)
> @@ -336,16 +343,20 @@ static int get_basic_prefix_size(const char *buf)
>  	return 0;
>  }
> =

> -static unsigned int parse_basic_command(GAtServer *server, char *buf)
> +static void parse_basic_command(GAtServer *server, char *buf)
>  {
>  	gboolean seen_equals =3D FALSE;
>  	char prefix[4], tmp;
> -	unsigned int i, prefix_size;
> +	unsigned int i, prefix_size, end;
>  	GAtServerRequestType type;
> =

>  	prefix_size =3D get_basic_prefix_size(buf);
>  	if (prefix_size =3D=3D 0)
> -		return 0;
> +		goto error;
> +
> +	/* Handle S-parameter with 100+ */
> +	if (prefix_size > 3)
> +		goto error;
> =

>  	i =3D prefix_size;
>  	prefix[0] =3D g_ascii_toupper(buf[0]);
> @@ -390,33 +401,39 @@ static unsigned int parse_basic_command(GAtServer
>  *server, char *buf) }
> =

>  done:
> -	if (prefix_size <=3D 3) {
> -		memcpy(prefix + 1, buf + 1, prefix_size - 1);
> -		prefix[prefix_size] =3D '\0';
> -
> -		tmp =3D buf[i];
> -		buf[i] =3D '\0';
> -		at_command_notify(server, buf, prefix, type);
> -		buf[i] =3D tmp;
> -	} else /* Handle S-parameter with 100+ */
> -		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +	end =3D i;
> =

>  	/* Commands like ATA, ATZ cause the remainder line
>  	 * to be ignored.
>  	 */
>  	if (prefix[0] =3D=3D 'A' || prefix[0] =3D=3D 'Z')
> -		return strlen(buf);
> +		i =3D strlen(buf);
> =

>  	/* Consume the seperator ';' */
>  	if (buf[i] =3D=3D ';')
>  		i +=3D 1;
> =

> -	return i;
> +	/* Update read offset before notify the callback */
> +	server->read_pos +=3D i;
> +
> +	memcpy(prefix + 1, buf + 1, prefix_size - 1);
> +	prefix[prefix_size] =3D '\0';
> +
> +	tmp =3D buf[end];
> +	buf[end] =3D '\0';
> +	at_command_notify(server, buf, prefix, type);
> +	buf[end] =3D tmp;
> +
> +	return;
> +
> +error:
> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>  }
> =


As above.

Regards,
-Denis

--===============2567007181681546457==--

