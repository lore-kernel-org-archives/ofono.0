Content-Type: multipart/mixed; boundary="===============5787348466338945071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] TODO: Add owner to extend the voicecall interface with a
 property indicating emergency call
Date: Wed, 10 Nov 2010 08:33:23 -0600
Message-ID: <4CDAAD33.3070901@gmail.com>
In-Reply-To: <1289391944-3184-1-git-send-email-john.mathew@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5787348466338945071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 11/10/2010 06:25 AM, John Mathew wrote:
> ---
>  TODO |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 84d5aa7..ed37c58 100644
> --- a/TODO
> +++ b/TODO
> @@ -416,7 +416,7 @@ Emergency Calls
>  =

>    Priority: High
>    Complexity: C1
> -
> +  Owner: John Mathew <john.mathew@elektrobit.com> =

>  =

>  Miscellaneous
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We have pretty strict git apply settings in effect, so your patch does
not apply:

Applying: TODO: Add owner to extend the voicecall interface with a
property indicating emergency call
/home/denkenz/ofono-master/.git/rebase-apply/patch:14: trailing whitespace.
  Owner: John Mathew <john.mathew@elektrobit.com>
fatal: 1 line adds whitespace errors.
Patch failed at 0001 TODO: Add owner to extend the voicecall interface
with a property indicating emergency call

Also, please keep your commit header under 50 characters.  And yes, I
know the task description is rather 'long' in this case ;)  So sometimes
we have to be a bit 'creative'.  Something like:

"TODO: Assign Voicecall emergency property task"

would work in this case.

Regards,
-Denis

--===============5787348466338945071==--

