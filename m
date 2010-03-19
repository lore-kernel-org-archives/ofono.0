Content-Type: multipart/mixed; boundary="===============5961470156567851392=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 4/7] Network password has exactly 4 digits.
Date: Fri, 19 Mar 2010 16:36:56 +0200
Message-ID: <80fd4e751003190736h1753cc54tb4d8e3b7fa71736c@mail.gmail.com>
In-Reply-To: <201003181143.14720.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5961470156567851392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/18 Denis Kenzior <denkenz@gmail.com>:
>> +static inline int is_valid_password(const char *pass)
>> +{
>> + =C2=A0 =C2=A0 return is_valid_pin(pass) && strlen(pass) =3D=3D 4;
>> +}

> So I suggest not doing it this way, instead let us modify is_valid_pin to=
 take
> an additional argument, namely whether this is a pin/puk and check the le=
ngth
> of the password there. =C2=A0You might want to include a reference to 22.=
004
> Section 5.2 that says the pin/pin2 is 0000 to 9999 and exactly 4 digits.

OK, sent a patch fixing is_valid_pin().

-- =

Pekka.Pessi mail at nokia.com

--===============5961470156567851392==--

