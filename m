Content-Type: multipart/mixed; boundary="===============8987325244114536614=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] stk: Handle user termination for Send DTMF.
Date: Tue, 29 Mar 2011 22:22:43 -0500
Message-ID: <4D92A203.1080505@gmail.com>
In-Reply-To: <1301329952-10152-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8987325244114536614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 03/28/2011 11:32 AM, Philippe Nunes wrote:
> ---
>  src/stk.c |   30 ++++++++++++++++++++++++------
>  1 files changed, 24 insertions(+), 6 deletions(-)
> =

> diff --git a/src/stk.c b/src/stk.c
> index 94ad396..907d6b5 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -473,6 +473,16 @@ static void emit_menu_changed(struct ofono_stk *stk)
>  	g_dbus_send_message(conn, signal);
>  }
>  =

> +static void user_termination_cb(enum stk_agent_result result, void *user=
_data)
> +{
> +	struct ofono_stk *stk =3D user_data;
> +
> +	if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
> +		stk->respond_on_exit =3D FALSE;
> +		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
> +	}
> +}
> +
>  static void stk_alpha_id_set(struct ofono_stk *stk,
>  		const char *text, const struct stk_text_attribute *attr,
>  		const struct stk_icon_id *icon)
> @@ -484,8 +494,16 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
>  	 * and no alpha identifier cases equally. This may be changed once
>  	 * better idea is found out.
>  	 */
> -	if (alpha !=3D NULL)
> -		stk_agent_display_action_info(stk->current_agent, alpha, icon);
> +	if (alpha !=3D NULL) {
> +		if (stk->respond_on_exit) {
> +			stk_agent_display_abortable_action_info(
> +					stk->current_agent, alpha, icon,
> +					user_termination_cb, stk, NULL);
> +		}
> +		else

We use the kernel coding style, so the closing bracket and the else
should be on the same line.  We're pretty consistent throughout the
codebase, so please watch out for this.

> +			stk_agent_display_action_info(stk->current_agent,
> +								alpha, icon);
> +	}

Try not to introduce gratuitous nesting if you can avoid it.  This code
is better rewritten as:

if (alpha =3D=3D NULL)
	return;

if (stk->respond_on_exit)
	...
else
	...

...
>  =

>  	g_free(alpha);
>  }
> @@ -2329,10 +2347,6 @@ static gboolean handle_command_send_dtmf(const str=
uct stk_command *cmd,
>  		return TRUE;
>  	}
>  =

> -	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
> -				&cmd->send_dtmf.text_attr,
> -				&cmd->send_dtmf.icon_id);
> -
>  	/*
>  	 * Note that we don't strictly require an agent to be connected,
>  	 * but to comply with 6.4.24 we need to send a End Session when
> @@ -2342,6 +2356,10 @@ static gboolean handle_command_send_dtmf(const str=
uct stk_command *cmd,
>  	stk->cancel_cmd =3D send_dtmf_cancel;
>  	stk->dtmf_id =3D err;
>  =

> +	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
> +				&cmd->send_dtmf.text_attr,
> +				&cmd->send_dtmf.icon_id);
> +
>  	return FALSE;
>  }
>  =


Regards,
-Denis

--===============8987325244114536614==--

