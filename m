Content-Type: multipart/mixed; boundary="===============6073562398673681665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/13] stk: Simplify and add icon to alphaId api.
Date: Thu, 14 Oct 2010 03:56:50 -0500
Message-ID: <4CB6C5D2.5060309@gmail.com>
In-Reply-To: <1286978056-16600-9-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6073562398673681665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/13/2010 08:54 AM, Andrzej Zaborowski wrote:
> The assumption is now that stk_alpha_id_set will handle NULL
> or empty alphaIds or icons.
> ---
>  src/stk.c |   36 ++++++++++--------------------------
>  1 files changed, 10 insertions(+), 26 deletions(-)
> =


I applied most of the chunks in this patch except for:

> @@ -1883,9 +1872,7 @@ static void send_dtmf_cancel(struct ofono_stk *stk)
>  	stk->respond_on_exit =3D FALSE;
>  	stk->extern_req->cancelled =3D TRUE;
>  =

> -	if (stk->pending_cmd->send_dtmf.alpha_id &&
> -			stk->pending_cmd->send_dtmf.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);
>  }
>  =

>  static void dtmf_sent_cb(const struct ofono_error *error, void *user_dat=
a)
> @@ -1904,9 +1891,7 @@ static void dtmf_sent_cb(const struct ofono_error *=
error, void *user_data)
>  =

>  	stk->respond_on_exit =3D FALSE;
>  =

> -	if (stk->pending_cmd->send_dtmf.alpha_id &&
> -			stk->pending_cmd->send_dtmf.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);
>  =

>  	if (error->type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
>  			error->error =3D=3D ENOENT) {
> @@ -2006,8 +1991,7 @@ static gboolean handle_command_send_dtmf(const stru=
ct stk_command *cmd,
>  		return TRUE;
>  	}
>  =

> -	if (cmd->send_dtmf.alpha_id && cmd->send_dtmf.alpha_id[0])
> -		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id);
> +	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id, &cmd->send_dtmf.icon_id);
>  =

>  	/*
>  	 * Note that we don't strictly require an agent to be connected,

Thanks.

Regards,
-Denis

--===============6073562398673681665==--

