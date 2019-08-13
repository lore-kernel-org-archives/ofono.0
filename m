Content-Type: multipart/mixed; boundary="===============1242722550207175092=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gatchat: add g_at_chat_retry()
Date: Tue, 13 Aug 2019 02:16:18 -0500
Message-ID: <a037dbbb-d751-5e72-253c-53987edfc3d8@gmail.com>
In-Reply-To: <20190812203832.19096-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242722550207175092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 8/12/19 3:38 PM, Martin Hundeb=C3=B8ll wrote:
> The current API doesn't support canceling an in-progress command;
> instead g_at_chat_cancel() simply removes the callback.
> =

> In cases where the modem doesn't respond at all to a command, a chat is
> simply stalled without any way to write new commands to the modem.
> =

> Support that case by adding a g_at_chat_retry() function to the API. The
> function does nothing if the command is not yet in-progress, or if the
> command is finished. Otherwise, it resets the bytes-written counter to
> re-write the command string.
> ---
>   gatchat/gatchat.c | 31 +++++++++++++++++++++++++++++++
>   gatchat/gatchat.h |  7 +++++++
>   2 files changed, 38 insertions(+)
> =

> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> index 3f290ac2..71dc94f5 100644
> --- a/gatchat/gatchat.c
> +++ b/gatchat/gatchat.c
> @@ -1047,6 +1047,29 @@ static guint at_chat_send_common(struct at_chat *c=
hat, guint gid,
>   	return c->id;
>   }
>   =

> +static gboolean at_chat_retry(struct at_chat *chat, guint gid)

So just FYI, I changed this from gid to id.  'gid' in the context of an =

at_chat means the 'group id', e.g. which GAtChat object the command =

belongs to.  So seeing gid used for actual cmd->id comparison was weird.

> +{
> +	struct at_command *cmd =3D g_queue_peek_head(chat->command_queue);
> +
> +	if (!cmd)
> +		return FALSE;
> +
> +	/* do nothing if command is not yet started, or already finished */
> +	if (cmd->id !=3D gid)
> +		return FALSE;
> +
> +	/* do nothing if command is not fully written */
> +	if (chat->cmd_bytes_written !=3D strlen(cmd->cmd))
> +		return FALSE;
> +
> +	/* reset number of written bytes to re-write command */
> +	chat->cmd_bytes_written =3D 0;
> +
> +	chat_wakeup_writer(chat);
> +
> +	return TRUE;
> +}
> +
>   static struct at_notify *at_notify_create(struct at_chat *chat,
>   						const char *prefix,
>   						gboolean pdu)

Applied, thanks.

Regards,
-Denis

--===============1242722550207175092==--

