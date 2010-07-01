Content-Type: multipart/mixed; boundary="===============7560351998352682275=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 17:35:09 -0500
Message-ID: <4C2D181D.2060609@gmail.com>
In-Reply-To: <AANLkTinbEd4WdRbbEYB-zSCdMmh0k6oZ-1mXonMwy_3e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7560351998352682275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 07/01/2010 05:10 PM, Andrzej Zaborowski wrote:
> Hi
> =

> On 1 July 2010 18:30, Denis Kenzior <denkenz@gmail.com> wrote:
>>> +char *stk_text_to_html(char *text, int text_len,
>>> +                             const unsigned char *attrs, int attrs_len)
>>> +{
>>> +     GString *string =3D g_string_sized_new(text_len + 1);
>>> +     int formats[257];  /* maximum number of chars in text + 1 */
>>> +     int pos =3D 0, i, j, attr, prev_attr;
>>> +     guint8 start, end, code, color, len, align;
>>> +
>>> +     /* we will need formatting at the position beyond the last char */
>>> +     for (i =3D 0; i <=3D text_len; i++)
>>> +             formats[i] =3D STK_TEXT_FORMAT_INIT;
>>> +
>>
>> Please note that the same formatting can be used for EMS messages
>> (23.040).  These messages have a fairly large max-len (255 segments *
>> ~153 characters)  I'd like to have this function useable for EMS
>> messages as well.
> =

> It would have a different signature because as far as I understand a
> separate array of attributes is sent in each segment (the start/len
> fields can't address more than 256 characters anyway).  So that
> function can be a wrapper around this function.
> =


It depends actually.  I'd like to avoid writing a separate EMS
concatenator, and re-use sms_decode_text.  This means that if possible,
I'd like this function to work on arbitrary length strings.  The text
attributes can be massaged pretty easily without knowing what's inside
the SMS message.

Regards,
-Denis

--===============7560351998352682275==--

