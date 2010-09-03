Content-Type: multipart/mixed; boundary="===============1903291170614767533=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 10:08:10 -0500
Message-ID: <4C810F5A.2050806@gmail.com>
In-Reply-To: <AANLkTi=DWN54mvFZzn=odY9soF6h4hLVyQt30T0CvBSO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1903291170614767533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 09/03/2010 09:40 AM, Pekka Pessi wrote:
> Morjes Aki,
> =

> 2010/9/2 Aki Niemi <aki.niemi@nokia.com>:
>> +       case SMS_ALPHABET_TURKISH:
>> +               gsm_encoded =3D convert_utf8_to_gsm_with_lang(utf8, -1, =
NULL,
>> +                                                       &written, 0,
>> +                                                       GSM_DIALECT_TURK=
ISH,
>> +                                                       GSM_DIALECT_TURK=
ISH);
> =

> If you look at the tables,  the idea is normally to use either locking
> Turkish and default single, or default locking and Turkish single
> shift, never both.

The spec also says: "however it is possible to use both single shift and
locking shift with the corresponding tables in a single message."

So how exactly do we know which combination to try? Is it language
dependent?

> =

> Also, if it is possible to fit the message to one segment only using
> national single shift table, single shift should be used (if receiver
> does not support national variants, the result is much less garbled).
> =


So what you're saying is that we should try these three combinations:

default locking, default single shift
default locking, language single shift
language locking shift, language single shift

Trying language locking, default single shift does not seem useful.

Regards,
-Denis

--===============1903291170614767533==--

