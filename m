Content-Type: multipart/mixed; boundary="===============8850160806367918707=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] stk: Fix issue in stk_alpha_id_set
Date: Wed, 26 Jan 2011 18:16:27 +0100
Message-ID: <AANLkTin3HtArLFwXMauDpZQYCUgnKFEGLniB_OUHdWB1@mail.gmail.com>
In-Reply-To: <1296053007-1110-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8850160806367918707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 26 January 2011 15:43, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> Fixes the crash seen when the null alpha identifier.
> Also removed the icon check as icon will always be a
> valid pointer.

Good catch, but we should fix this check instead of removing it, by
using icon->id !=3D 0.

> ---
> =C2=A0src/stk.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 29d2087..c968eef 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -477,9 +477,9 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *text, =
const struct stk_text_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct stk_i=
con_id *icon)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 char *alpha =3D dbus_apply_text_attributes(text, a=
ttr);
> + =C2=A0 =C2=A0 =C2=A0 char *alpha =3D dbus_apply_text_attributes(text ? =
text : "", attr);
>
> - =C2=A0 =C2=A0 =C2=A0 if (alpha || icon)
> + =C2=A0 =C2=A0 =C2=A0 if (alpha !=3D NULL && alpha[0] !=3D '\0')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stk_agent_display_=
action_info(stk->current_agent, alpha, icon);

Ah, now I think I know where that crash is coming from, it's because
of NULL alpha and non-NULL icon.  I think the right thing to do would
be to use alpha ? alpha : "" in the parameter.

Best regards

--===============8850160806367918707==--

