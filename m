Content-Type: multipart/mixed; boundary="===============1384508310309579484=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 1/2] stk: fix issue with null data object
Date: Fri, 11 Mar 2011 14:05:03 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E70A9C@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTimqv2UCkOEmirpLsNDL+q+WNW_ytRD5-ac88RTT@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1384508310309579484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Andrzej Zaborowski wrote:
> Hi Jeevaka
> =

> On 7 March 2011 16:35, Jeevaka Badrappan
> <jeevaka.badrappan@elektrobit.com> wrote:
>> As per the specification, if alphad identifier is provided and is a
>> null data object, no information should be given to the user.
> =

> What do do you think of the following change?
> =

> diff --git a/src/stkutil.c b/src/stkutil.c index
> abd1c99..c64cb7a 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -309,7 +309,7 @@ static gboolean
> parse_dataobj_alpha_id(struct comprehension_tlv_iter *iter,
> =

>         len =3D comprehension_tlv_iter_get_length(iter);         if
> (len =3D=3D 0) { -               *alpha_id =3D g_try_malloc0(1);
> +               *alpha_id =3D NULL;
>                 return TRUE;
>         }
> =

> =

> This actually lets the caller detect a NULL alpha identifier
> and then, as far as I can see, the stk.c code will not give
> any information to the user if either the alpha_id is NULL or not
> provided. =


Change is fine with me.

Regards,
Jeevaka

--===============1384508310309579484==--

