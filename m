Content-Type: multipart/mixed; boundary="===============0504366383264033815=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/11] Add framework of server parser
Date: Wed, 17 Mar 2010 11:55:59 -0600
Message-ID: <201003171256.00500.denkenz@gmail.com>
In-Reply-To: <1268836241-4834-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0504366383264033815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> a. The parser fetch and parse one command per loop. The prefix is
> the command prefix without parameter. For example, the prefix of
> "AT+CLIP=3D1" is "+CLIP".
> =

> b. Search registered notification node in command_list. Invoke the
> callback if found.
> =

> c. Termiate the execution if the result is an error. Otherwise,
> parse next command.
> ---
>  gatchat/gatserver.c |   95
>  +++++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, =

95
>  insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index 46fa423..fb82ad4 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -173,8 +173,103 @@ static void g_at_server_send_final(GAtServer *serve=
r,
>  GAtServerResult result) send_common(server, buf, MIN(len, sizeof(buf)-1)=
);
>  }
> =

> +static inline gboolean is_extended_command_prefix(const char c)
> +{
> +	switch (c) {
> +	case '+':
> +	case '*':
> +	case '!':
> +	case '%':
> +		return TRUE;
> +	default:
> +		return FALSE;
> +	}
> +}

So I don't see the point of a patch that removes the entire function, then =

puts the same function back in with the same name.  If you want to rename i=
t, =

send a patch to do so.

>  static void server_parse_line(GAtServer *server, char *line)
>  {
> +	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
> +	char *buf =3D line;
> +	char *command =3D NULL;
> +	char prefix[20];
> +
> +	while (buf) {

So this part is wrong, buf will never be NULL.  I suggest you preserve the =

logic of the current implementation here.

> +		char c =3D *buf;
> +
> +		/* skip semicolon */
> +		if (c =3D=3D ';')
> +			c =3D *(++buf);
> +
> +		if (c =3D=3D '\0') {
> +			res =3D G_AT_SERVER_RESULT_OK;
> +			break;
> +		}
> +
> +		command =3D parse_next_command(server, buf, prefix);
> +		if (!command) {
> +			res =3D G_AT_SERVER_RESULT_ERROR;
> +			break;
> +		}

Why is a char * being allocated by parse_next_command?  What is the purpose=
?  =

I suggest you get rid of this and perform notifications there.  It is too h=
ard =

to keep track of who should free what and where otherwise.

> +
> +		res =3D at_command_notify(server, command, prefix);

I've mentioned this before, I don't like returning a result here.  We shoul=
d =

simply store the last result given to g_at_server_send_final or =

g_at_server_send_ext_final (e.g. do not send it out right away).  If it is =
not =

OK then quit command processing and send the final result.

> +		if (res !=3D G_AT_SERVER_RESULT_OK) {
> +			g_free(command);
> +			break;
> +		}
> +
> +		buf +=3D strlen(command);
> +
> +		g_free(command);
> +	}
> +
> +	g_at_server_send_final(server, res);
> +
>  	g_free(line);
>  }
>=20

--===============0504366383264033815==--

