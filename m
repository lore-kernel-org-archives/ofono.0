Content-Type: multipart/mixed; boundary="===============7217669427939547898=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Fri, 02 Jul 2010 00:10:54 +0200
Message-ID: <AANLkTinbEd4WdRbbEYB-zSCdMmh0k6oZ-1mXonMwy_3e@mail.gmail.com>
In-Reply-To: <4C2CC28F.2000707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7217669427939547898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On 1 July 2010 18:30, Denis Kenzior <denkenz@gmail.com> wrote:
>> +char *stk_text_to_html(char *text, int text_len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *attrs, int attrs_len)
>> +{
>> + =C2=A0 =C2=A0 GString *string =3D g_string_sized_new(text_len + 1);
>> + =C2=A0 =C2=A0 int formats[257]; =C2=A0/* maximum number of chars in te=
xt + 1 */
>> + =C2=A0 =C2=A0 int pos =3D 0, i, j, attr, prev_attr;
>> + =C2=A0 =C2=A0 guint8 start, end, code, color, len, align;
>> +
>> + =C2=A0 =C2=A0 /* we will need formatting at the position beyond the la=
st char */
>> + =C2=A0 =C2=A0 for (i =3D 0; i <=3D text_len; i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 formats[i] =3D STK_TEXT_FORM=
AT_INIT;
>> +
>
> Please note that the same formatting can be used for EMS messages
> (23.040). =C2=A0These messages have a fairly large max-len (255 segments *
> ~153 characters) =C2=A0I'd like to have this function useable for EMS
> messages as well.

It would have a different signature because as far as I understand a
separate array of attributes is sent in each segment (the start/len
fields can't address more than 256 characters anyway).  So that
function can be a wrapper around this function.

Regards,
Andrew

--===============7217669427939547898==--

