Content-Type: multipart/mixed; boundary="===============0232512033083544908=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Add support for SMS national language identifiers
Date: Mon, 07 Sep 2009 14:49:03 +0300
Message-ID: <a32762a20909070449r7c26d5abtf174e66b52c51890@mail.gmail.com>
In-Reply-To: <200909041121.21109.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0232512033083544908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2009/9/4 Denis Kenzior <denkenz@gmail.com>:
> Just a couple of minor nitpicks:
> +struct single_shift_table {
> + =C2=A0 =C2=A0 =C2=A0 struct codepoint *table;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int len;
> +};
> +
> +static struct single_shift_table gsm_single_shift[] =3D
> +{
> + =C2=A0 =C2=A0 =C2=A0 { default_ext_gsm, TABLE_SIZE(default_ext_gsm) },
> + =C2=A0 =C2=A0 =C2=A0 { turkish_ext_gsm, TABLE_SIZE(turkish_ext_gsm) },
> + =C2=A0 =C2=A0 =C2=A0 { spanish_ext_gsm, TABLE_SIZE(spanish_ext_gsm) },
> + =C2=A0 =C2=A0 =C2=A0 { portuguese_ext_gsm, TABLE_SIZE(portuguese_ext_gs=
m) }
> +};
> +
> +static struct single_shift_table unicode_single_shift[] =3D
> +{
> + =C2=A0 =C2=A0 =C2=A0 { default_ext_unicode, TABLE_SIZE(default_ext_unic=
ode) },
> + =C2=A0 =C2=A0 =C2=A0 { turkish_ext_unicode, TABLE_SIZE(turkish_ext_unic=
ode) },
> + =C2=A0 =C2=A0 =C2=A0 { spanish_ext_unicode, TABLE_SIZE(spanish_ext_unic=
ode) },
> + =C2=A0 =C2=A0 =C2=A0 { portuguese_ext_unicode, TABLE_SIZE(portuguese_ex=
t_unicode) }
> +};
> +
> +static const unsigned short *gsm_locking_shift[] =3D
> +{
> + =C2=A0 =C2=A0 =C2=A0 default_gsm,
> + =C2=A0 =C2=A0 =C2=A0 turkish_gsm,
> + =C2=A0 =C2=A0 =C2=A0 default_gsm,
> + =C2=A0 =C2=A0 =C2=A0 portuguese_gsm
> +};
> +
> +static struct codepoint *unicode_locking_shift[] =3D
> +{
> + =C2=A0 =C2=A0 =C2=A0 default_unicode,
> + =C2=A0 =C2=A0 =C2=A0 turkish_unicode,
> + =C2=A0 =C2=A0 =C2=A0 default_unicode,
> + =C2=A0 =C2=A0 =C2=A0 portuguese_unicode
>
> Can we put all of these into a single table?

Can you give an example of what you mean? I tried doing something like
that, but the initializer turned a bit hairy, so I reckoned in the end
there's not much to gain by doing that.

> +char *convert_gsm_to_utf8_with_lang(const unsigned char *text, long len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long *items_=
read, long *items_written,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned cha=
r terminator,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int=
 locking_lang,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int=
 single_lang)
>
> locking_lang & single_lang should be unsigned char or an enum.

Sure.

> +gboolean sms_extract_language_variant(const struct sms *sms, int *lockin=
g,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *single);
>
> locking & single should use guint8.

Indeed.

> +enum sms_language {
> + =C2=A0 =C2=A0 =C2=A0 SMS_LANGUAGE_DEFAULT =3D 0,
> + =C2=A0 =C2=A0 =C2=A0 SMS_LANGUAGE_TURKISH =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 SMS_LANGUAGE_SPANISH =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 SMS_LANGUAGE_PORTUGUESE =3D 3
> +};
> +
>
> This part isn't used anywhere, should we just keep this out for now?

We can leave it out. It'll come in handy if/when we want to add
support on the encoding path.

Cheers,
Aki

--===============0232512033083544908==--

