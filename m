Content-Type: multipart/mixed; boundary="===============2399017593530505699=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Fri, 02 Jul 2010 00:47:36 +0200
Message-ID: <AANLkTinrzAGtJW4Xg4U6rFdG6L6bbykaNDN0DZrGLG6y@mail.gmail.com>
In-Reply-To: <4C2D181D.2060609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2399017593530505699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2 July 2010 00:35, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 07/01/2010 05:10 PM, Andrzej Zaborowski wrote:
>> Hi
>>
>> On 1 July 2010 18:30, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> +char *stk_text_to_html(char *text, int text_len,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *attrs, int attrs_len)
>>>> +{
>>>> + =C2=A0 =C2=A0 GString *string =3D g_string_sized_new(text_len + 1);
>>>> + =C2=A0 =C2=A0 int formats[257]; =C2=A0/* maximum number of chars in =
text + 1 */
>>>> + =C2=A0 =C2=A0 int pos =3D 0, i, j, attr, prev_attr;
>>>> + =C2=A0 =C2=A0 guint8 start, end, code, color, len, align;
>>>> +
>>>> + =C2=A0 =C2=A0 /* we will need formatting at the position beyond the =
last char */
>>>> + =C2=A0 =C2=A0 for (i =3D 0; i <=3D text_len; i++)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 formats[i] =3D STK_TEXT_FO=
RMAT_INIT;
>>>> +
>>>
>>> Please note that the same formatting can be used for EMS messages
>>> (23.040). =C2=A0These messages have a fairly large max-len (255 segment=
s *
>>> ~153 characters) =C2=A0I'd like to have this function useable for EMS
>>> messages as well.
>>
>> It would have a different signature because as far as I understand a
>> separate array of attributes is sent in each segment (the start/len
>> fields can't address more than 256 characters anyway). =C2=A0So that
>> function can be a wrapper around this function.
>>
>
> It depends actually. =C2=A0I'd like to avoid writing a separate EMS
> concatenator, and re-use sms_decode_text. =C2=A0This means that if possib=
le,
> I'd like this function to work on arbitrary length strings. =C2=A0The text
> attributes can be massaged pretty easily without knowing what's inside
> the SMS message.

My point is that it won't work on a message longer than 256 bytes
anyway, because you would need to either change how the attribute
start byte is coded, or supplement each attribute with information
about which segment it relates to.

Regards,
Andrew

--===============2399017593530505699==--

