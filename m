Content-Type: multipart/mixed; boundary="===============2664240038296102658=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] stkutil: fix issue with null data object
Date: Wed, 09 Mar 2011 00:54:31 +0100
Message-ID: <AANLkTimY967kApou=eQLt4D4eMB3_o8AAj57krWKCJSv@mail.gmail.com>
In-Reply-To: <1299512150-19314-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2664240038296102658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 7 March 2011 16:35, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> ---
> =C2=A0src/stkutil.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/stkutil.c b/src/stkutil.c
> index abd1c99..66b2924 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -308,7 +308,7 @@ static gboolean parse_dataobj_alpha_id(struct compreh=
ension_tlv_iter *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *utf8;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D comprehension_tlv_iter_get_length(iter=
);
> - =C2=A0 =C2=A0 =C2=A0 if (len =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 if (len <=3D 1) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*alpha_id =3D g_tr=
y_malloc0(1);

In the description you talk about Length =3D=3D 00 and no value part but
this change affects the case of Length =3D=3D 1, which I think we're
handling correctly already.  What is the exact problem case?

I'm not sure but I think we already considered an identical patch, but
in the spec there's nothing special about this case so I think the
zero-length string needs to be sent to the user like any other string.

Best regards

--===============2664240038296102658==--

