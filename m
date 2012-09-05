Content-Type: multipart/mixed; boundary="===============7540489911789868737=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] stk: AID shall not be displayed in case of self
 explanatory icon
Date: Wed, 05 Sep 2012 14:29:02 -0500
Message-ID: <5047A7FE.1060205@gmail.com>
In-Reply-To: <1346865579-24794-5-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7540489911789868737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/05/2012 12:19 PM, Philippe Nunes wrote:
> ---
>   src/stk.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/src/stk.c b/src/stk.c
> index 5c79183..e242bf5 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -539,6 +539,11 @@ static gboolean stk_alpha_id_set(struct ofono_stk *s=
tk,
>   	if (stk->current_agent =3D=3D NULL)
>   		return FALSE;
>
> +	/* AID shall not be displayed in case of self explanatory icon */

Can you quote the relevant sentence exactly? I assume this is TS 102.223 =

Section 8.31?

> +	if (icon->id !=3D 0&&  icon->qualifier =3D=3D
> +			STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY)
> +		alpha[0]=3D'\0';
> +
>   	if (stk->respond_on_exit)
>   		stk_agent_display_action(stk->current_agent, alpha, icon,
>   						user_termination_cb, stk, NULL);

Regards,
-Denis

--===============7540489911789868737==--

