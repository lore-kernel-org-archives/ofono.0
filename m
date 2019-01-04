Content-Type: multipart/mixed; boundary="===============3732263215943231388=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] gprs: fix allocation of context id
Date: Fri, 04 Jan 2019 14:44:53 -0600
Message-ID: <e9ed51c3-8b86-d5a2-70f8-b02935087a37@gmail.com>
In-Reply-To: <20190104154440.61531-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3732263215943231388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/04/2019 09:44 AM, Martin Hundeb=C3=B8ll wrote:
> After the convertion to l_uintset, the creation of new contexts fails
> due to a range error being returned from l_uintset_find_unused().
> =

> The error happens because the uinset is created with a min-value of 1,
> but the start-value passed to l_uintset_find_unused() is initialized as
> 0.
> =

> Fix this by using the minimum id when last used id is not yet
> initialized.
> ---
>   src/gprs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 58a998ca..92820e60 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2334,7 +2334,11 @@ static void provision_context(const struct ofono_g=
prs_provision_data *ap,
>   			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
>   		return;
>   =

> -	id =3D l_uintset_find_unused(gprs->used_pids, gprs->last_context_id);
> +	if (!gprs->last_context_id)
> +		id =3D l_uintset_get_min(gprs->used_pids);

You actually want find_unused_min here.

> +	else
> +		id =3D l_uintset_find_unused(gprs->used_pids,
> +						gprs->last_context_id);
>   	if (id > l_uintset_get_max(gprs->used_pids))
>   		return;
>   =

> =


Anyway, I pushed my own version of this patch earlier as commit:
c3fdf6a7c567a7507c3558a27006b6f9559493d6

I did steal the commit description from you :)

Regards,
-Denis

--===============3732263215943231388==--

