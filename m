Content-Type: multipart/mixed; boundary="===============1728497015917678078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 18:12:11 -0500
Message-ID: <4C2D20CB.4000405@gmail.com>
In-Reply-To: <1277998285-30207-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1728497015917678078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +#define STK_TEXT_FORMAT_INIT -1

I'd really prefer 0xffff here

> +char *stk_text_to_html(const char *text, int text_len,
> +				const unsigned char *attrs, int attrs_len)
> +{

I think that text_len is not required, this function can figure it out
itself by using strlen or friends.

> +	GString *string =3D g_string_sized_new(text_len + 1);
> +	int *formats;
> +	int pos, i, j, attr, prev_attr;
> +	guint8 start, end, code, color, len, align;
> +
> +	formats =3D g_try_malloc0(sizeof(int) * (text_len + 1));

Why are you allocating ints instead of shorts?

Also, you have to be really careful here.  Text inside oFono is
understood to be UTF8 always.  The formats array should be allocated
according to how many UTF8 characters there are, not how many bytes
there are.  GSM characters can be represented by up to 3 byte UTF8
chars.  UCS2 characters can be represented by up to 4 byte UTF8 chars.

Also please realize that is is not required unless you modify the
signature of attrs to be something other than unsigned char (limited to
max=3D255)

> +	if (formats =3D=3D NULL)
> +		return NULL;
> +
> +	/* we will need formatting at the position beyond the last char */
> +	for (i =3D 0; i <=3D text_len; i++)
> +		formats[i] =3D STK_TEXT_FORMAT_INIT;
> +
> +	for (i =3D 0; i+3 < attrs_len; i +=3D 4) {
> +		start =3D attrs[i];
> +		len =3D attrs[i + 1];
> +		code =3D attrs[i + 2];
> +
> +		if (i + 3 < attrs_len)
> +			color =3D attrs[i + 3];
> +		else
> +			color =3D 0;

My suggestion is to generalize this function to support both EMS
messages and STK strings.  We can treat attrs as:

unsigned short *attrs, unsigned short len where len =3D number of
quadruples.  See the earlier thread for details.

The reason for using shorts is to support larger EMS message sizes.

> +
> +	for (pos =3D 0; pos <=3D text_len; pos++) {

And again here you have to be careful and use UTF8 character lengths,
not simple ASCII lengths.

Regards,
-Denis

--===============1728497015917678078==--

