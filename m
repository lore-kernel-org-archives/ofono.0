Content-Type: multipart/mixed; boundary="===============3112014357124455322=="
MIME-Version: 1.0
From: jeevaka.badrappan@linux.intel.com
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Fri, 15 Jul 2011 05:46:12 -0700
Message-ID: <65215.10.254.189.70.1310733972.squirrel@linux.intel.com>
In-Reply-To: <1310733734-4206-4-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3112014357124455322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> @@ -529,7 +531,12 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
>
>  static void stk_alpha_id_unset(struct ofono_stk *stk)
>  {
> -	stk_agent_request_cancel(stk->current_agent);
> +	/*
> +	 * If there is no default agent, then current agent also will be NULL.
> +	 * So, call request cancel only when there is a valid current agent.
> +	 */
> +	if (stk->current_agent)
> +		stk_agent_request_cancel(stk->current_agent);
>  }
>

If needed, I can send this code change alone in a separate fix patch.

Regards,
Jeevaka

--===============3112014357124455322==--

