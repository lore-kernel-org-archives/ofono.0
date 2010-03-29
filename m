Content-Type: multipart/mixed; boundary="===============2459414476897836371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Add server send result code
Date: Mon, 29 Mar 2010 15:13:41 -0500
Message-ID: <201003291513.42009.denkenz@gmail.com>
In-Reply-To: <1269870604-28896-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2459414476897836371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +static void g_at_server_send_result(GAtServer *server, GAtServerResult
>  result) +{
> +	char buf[1024];
> +
> +	if (server->v250.is_v1)
> +		sprintf(buf, "%s", server_result_to_string(result));
> +	else
> +		sprintf(buf, "%u", (unsigned int)result);
> +
> +	send_result_common(server, buf);
> +}

Please get rid of this function, it serves no purpose and is utterly =

confusing.  If you would put the contents at the else clause of =

g_at_server_send_final then the same thing will be accomplished.

> +
> +void g_at_server_send_final(GAtServer *server, GAtServerResult result)
> +{
> +	char *line =3D server->read_line;
> +	unsigned int pos =3D server->read_pos;
> +	unsigned int len =3D strlen(line);
> +
> +	/* Continue only if the result is OK and we have further commands */
> +	if (result =3D=3D G_AT_SERVER_RESULT_OK && pos < len)
> +		server_parse_line(server);
> +	else if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
> +		;	/* Skip */

Nobody should ever call this function with EXT_ERROR

> +	else
> +		g_at_server_send_result(server, result);
> +}
> +
> +void g_at_server_send_ext_final(GAtServer *server, const char *result)
> +{
> +	send_result_common(server, result);

Why don't we do the same server_parse_line magic here?

> +}
> +
> +void g_at_server_send_intermediate(GAtServer *server, const char *result)
> +{
> +	send_result_common(server, result);
> +}
> +
> +void g_at_server_send_unsolicited(GAtServer *server, const char *result)
> +{
> +	send_result_common(server, result);
> +}
> +
> +void g_at_server_send_info_text(GAtServer *server, GSList *text)
> +{
> +	char buf[MAX_TEXT_SIZE];
> +	char t =3D server->v250.s3;
> +	char r =3D server->v250.s4;
> +	unsigned int len;
> +	GSList *l =3D text;
> +	char *line;
> +
> +	if (!text)
> +		return;
> +
> +	while (l) {
> +		line =3D l->data;
> +		if (!line)
> +			return;
> +
> +		len =3D snprintf(buf, sizeof(buf), "%c%c%s", t, r, line);
> +		send_common(server, buf, MIN(len, sizeof(buf)-1));
> +
> +		l =3D l->next;
> +	}

Using a for loop is more compact here.

> +
> +	len =3D snprintf(buf, sizeof(buf), "%c%c", t, r);
> +	send_common(server, buf, len);
> +}
> +
>  static inline gboolean is_extended_command_prefix(const char c)
>  {
>  	switch (c) {
> @@ -205,7 +277,7 @@ static void at_command_notify(GAtServer *server, char
>  *command, node =3D g_hash_table_lookup(server->command_list, prefix);
> =

>  	if (node =3D=3D NULL) {
> -		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);

Leave it as is

>  		return;
>  	}
> =

> @@ -301,7 +373,7 @@ next:
>  	return;
> =

>  error:
> -	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +	g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);

Leave it as is

>  }
> =

>  static int get_basic_prefix_size(const char *buf)
> @@ -427,7 +499,7 @@ done:
>  	return;
> =

>  error:
> -	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +	g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);

And again,

>  }
> =

>  static void server_parse_line(GAtServer *server)
> @@ -437,7 +509,7 @@ static void server_parse_line(GAtServer *server)
>  	unsigned int len =3D strlen(line);
> =

>  	if (len =3D=3D 0) {
> -		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		g_at_server_send_result(server, G_AT_SERVER_RESULT_OK);

And again

>  		return;
>  	}
> =

> @@ -620,7 +692,7 @@ static void new_bytes(GAtServer *p)
>  			 * According to section 5.2.4 and 5.6 of V250,
>  			 * Empty commands must be OK by the DCE
>  			 */
> -			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
> +			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);

And here

>  			ring_buffer_drain(p->read_buf, p->read_so_far);
>  			break;
> =

> @@ -634,14 +706,14 @@ static void new_bytes(GAtServer *p)
> =

>  				server_parse_line(p);
>  			} else
> -				g_at_server_send_final(p,
> +				g_at_server_send_result(p,
>  						G_AT_SERVER_RESULT_ERROR);

And here

>  			break;
>  		}
> =

>  		case PARSER_RESULT_REPEAT_LAST:
>  			/* TODO */
> -			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
> +			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);

And again here

>  			ring_buffer_drain(p->read_buf, p->read_so_far);
>  			break;
> =

> diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
> index 2ae19ca..a508be6 100644
> --- a/gatchat/gatserver.h
> +++ b/gatchat/gatserver.h
> @@ -87,6 +87,23 @@ gboolean g_at_server_register(GAtServer *server, char
>  *prefix, GDestroyNotify destroy_notify);
>  gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
> =

> +/* Send a final result code. E.g. G_AT_SERVER_RESULT_NO_DIALTONE */
> +void g_at_server_send_final(GAtServer *server, GAtServerResult result);
> +
> +/* Send an extended final result code. E.g. +CME ERROR: SIM failure. */
> +void g_at_server_send_ext_final(GAtServer *server, const char *result);
> +
> +/* Send an intermediate result code to report the progress. E.g. CONNECT
>  */ +void g_at_server_send_intermediate(GAtServer *server, const char
>  *result); +
> +/* Send an unsolicited result code. E.g. RING */
> +void g_at_server_send_unsolicited(GAtServer *server, const char *result);
> +
> +/* Send an information text. The text could contain multiple lines. Each
> + * line, including line terminators, should not exceed 2048 characters.
> + */
> +void g_at_server_send_info_text(GAtServer *server, GSList *text);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> =


Regards,
-Denis

--===============2459414476897836371==--

