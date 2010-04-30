Content-Type: multipart/mixed; boundary="===============3311890817763645015=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4][RFC] gatchat: Allow cancelling a running command.
Date: Thu, 29 Apr 2010 21:53:49 -0500
Message-ID: <201004292153.49983.denkenz@gmail.com>
In-Reply-To: <1272540754-19028-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3311890817763645015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Users need to be extra careful using the cancel functions because
> there's a potential race condition where an OK or ERROR for the command
> being cancelled arrives just the same moment the next command in the
> queue is being submitted, and is treated as a response to that command.

This is why this is just a really bad idea.  The only one I think we should =

cancel (and most vendors support reliably) is an ATD...

Are you sure your CSIM STATUS poll would actually time out or would the mod=
em =

return a +CME/+CMS error?  In the end the modem does this polling itself...

> @@ -1040,18 +1041,20 @@ gboolean g_at_chat_cancel(GAtChat *chat, guint id)
>  	if (!l)
>  		return FALSE;
> =

> -	if (l =3D=3D g_queue_peek_head(chat->command_queue) &&
> -			chat->cmd_bytes_written > 0) {
> -		struct at_command *c =3D l->data;
> +	head =3D l->data =3D=3D g_queue_peek_head(chat->command_queue);
> =

> -		/* We can't actually remove it since it is most likely
> -		 * already in progress, just null out the callback
> -		 * so it won't be called
> -		 */
> -		c->callback =3D NULL;
> -	} else {
> -		at_command_destroy(l->data);
> -		g_queue_remove(chat->command_queue, l->data);
> +	at_command_destroy(l->data);
> +	g_queue_remove(chat->command_queue, l->data);
> +
> +	if (head) {
> +		chat->cmd_bytes_written =3D 0;
> +
> +		g_slist_foreach(chat->response_lines, (GFunc)g_free, NULL);
> +		g_slist_free(chat->response_lines);
> +		chat->response_lines =3D NULL;
> +
> +		if (g_queue_get_length(chat->command_queue) > 0)
> +			chat_wakeup_writer(chat);

Quoting V.250 5.6.1:
"Some action commands that require time to execute may be aborted while in =

progress; these are explicitly noted in the description of the command. =

Aborting of commands is accomplished by the transmission from the DTE to th=
e =

DCE of any character. A single character shall be sufficient to abort the =

command in progress; however, characters transmitted during the first 125 =

milliseconds after transmission of the termination character shall be ignor=
ed =

(to allow for the DTE to append additional control characters such as line =

feed after the command line termination character)."

Sounds like your device's AT parser is 'not quite' compliant ;)

Regards,
-Denis

--===============3311890817763645015==--

