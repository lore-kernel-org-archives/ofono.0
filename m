Content-Type: multipart/mixed; boundary="===============2477144840692729080=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 21:33:44 +0200
Message-ID: <h2kfb249edb1004201233lf8c2807en734f9ee8d40daeff@mail.gmail.com>
In-Reply-To: <201004151648.11027.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2477144840692729080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 15 April 2010 23:48, Denis Kenzior <denkenz@gmail.com> wrote:
> The terminal response goes something like this:
>
>> +
>> + =C2=A0 =C2=A0 len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
10 + length * 2, length);
>> +
>> + =C2=A0 =C2=A0 for (; length; length--)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D sprintf(buf + len, =
"%02hhX", *value++);
>> +
>
> In the new stk envelope code it goes something like this:
>
>>
>> + =C2=A0 =C2=A0 len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
12 + length * 2, length);
>> +
>> + =C2=A0 =C2=A0 for (; length; length--)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D sprintf(buf + len, =
"%02hhX", *command++);
>> +
>> + =C2=A0 =C2=A0 len +=3D sprintf(buf + len, "FF");
>
> What is the point of this last 'FF'? =C2=A0The code removed from the sim =
atom
> driver doesn't have it either...

Rereading the etsi ts102.221 the "Le" field in the Envelope APDU
(11.2.2.2) is not explictly defined "not present", instead it says
"empty or maximum length of expected data".  It doesn't say what the
default value is when empty so I conclude it's safer to have the field
present or the card may think it's not allowed to send any response at
all -- depending on the implementer's interpretation of the spec.

10.1.6 says the field is the maximum respose length expected, but then
some commands suggest it should be the exact length wanted and some
make the field obligatory.

Regards

--===============2477144840692729080==--

