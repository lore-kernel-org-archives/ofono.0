Content-Type: multipart/mixed; boundary="===============0428373756171071608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] avoid glib runtime warning
Date: Mon, 16 May 2016 10:47:17 -0500
Message-ID: <5739EB85.1090908@gmail.com>
In-Reply-To: <1463381616-12304-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0428373756171071608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/16/2016 01:53 AM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> When set modem power off, in the callback of the request gril is cleaned
> up, 'out_queue' and 'command_queue' is NULL. If don't check before use
> them, there will be glib runtime warning.
> ---
>   gril/gril.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/gril/gril.c b/gril/gril.c
> index 297a772..34cadbb 100644
> --- a/gril/gril.c
> +++ b/gril/gril.c
> @@ -374,7 +374,10 @@ static void handle_response(struct ril_s *p, struct =
ril_msg *message)
>   			if (req->callback)
>   				req->callback(message, req->user_data);
>

Can we simply return if p->destroyed is set to true instead?

> -			len =3D g_queue_get_length(p->out_queue);
> +			if (p->out_queue)
> +				len =3D g_queue_get_length(p->out_queue);
> +			else
> +				len =3D 0;
>
>   			for (i =3D 0; i < len; i++) {
>   				id =3D GPOINTER_TO_INT(g_queue_peek_nth(
> @@ -387,8 +390,10 @@ static void handle_response(struct ril_s *p, struct =
ril_msg *message)
>
>   			ril_request_destroy(req);
>
> -			if (g_queue_peek_head(p->command_queue))
> -				ril_wakeup_writer(p);
> +			if (p->command_queue) {
> +				if (g_queue_peek_head(p->command_queue))
> +					ril_wakeup_writer(p);
> +			}
>
>   			break;
>   		}
>

Regards,
-Denis

--===============0428373756171071608==--

