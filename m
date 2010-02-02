Content-Type: multipart/mixed; boundary="===============8786520837549112512=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Remove dead assignments at gatchat
Date: Tue, 02 Feb 2010 16:32:16 -0600
Message-ID: <201002021632.17042.denkenz@gmail.com>
In-Reply-To: <1265148510-24408-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8786520837549112512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> ---
>  gatchat/gatchat.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)

So I applied this patch with one minor change:
 =

> @@ -753,7 +751,7 @@ static void wakeup_cb(gboolean ok, GAtResult *result,
>  gpointer user_data) static gboolean wakeup_no_response(gpointer user)
>  {
>  	GAtChat *chat =3D user;
> -	struct at_command *cmd =3D g_queue_peek_head(chat->command_queue);
> +	struct at_command *cmd;

This part was no longer necessary.

Regards,
-Denis

--===============8786520837549112512==--

