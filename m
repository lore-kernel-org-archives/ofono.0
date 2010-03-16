Content-Type: multipart/mixed; boundary="===============8900270609877519267=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Tue, 16 Mar 2010 11:36:30 -0700
Message-ID: <1268764590.2700.20.camel@localhost.localdomain>
In-Reply-To: <1268733700-30154-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8900270609877519267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  src/stkutil.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 787f7eb..ceba2d5 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -190,6 +190,7 @@ static gboolean parse_dataobj_item(struct comprehensi=
on_tlv_iter *iter,
>  	struct stk_item *item =3D user;
>  	const unsigned char *data;
>  	unsigned int len;
> +	char *utf8;
>  =

>  	if (comprehension_tlv_iter_get_tag(iter) !=3D
>  			STK_DATA_OBJECT_TYPE_ITEM)
> @@ -206,7 +207,12 @@ static gboolean parse_dataobj_item(struct comprehens=
ion_tlv_iter *iter,
>  		return FALSE;
>  =

>  	item->id =3D data[0];
> -	item->text =3D sim_string_to_utf8(data+1, len-1);
> +	utf8 =3D sim_string_to_utf8(data+1, len-1);

please add spaces between operators like +. So data + 1, len - 1.

> +	if (utf8 =3D=3D NULL)
> +		return FALSE;
> +
> +	item->text =3D utf8;

Why bother with utf8 variable? Just do

	if (item->text =3D=3D NULL)
		return FALSE;

Regards

Marcel



--===============8900270609877519267==--

