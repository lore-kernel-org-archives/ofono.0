Content-Type: multipart/mixed; boundary="===============2185733944325906304=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC PATCH 3/3] doc: document frequency band selection
Date: Wed, 01 Dec 2010 23:43:42 -0200
Message-ID: <AANLkTimG2F7rq8tukNqP=FeaQaHvamUHwQnOwzyQ0FuC@mail.gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A721@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2185733944325906304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 1, 2010 at 8:29 PM,  <Rajesh.Nagaiah@elektrobit.com> wrote:
> Hi Lucas,
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string UmtsBand [readwrite, =
optional]
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Frequency band in which the modem is allowed to
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
operate when using "umts" mode. Setting this
> property
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
has an imediate effect on modem only if
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
TechnologyPreference is set to "gsm".
>
> Should be "Setting this property has an imediate effect on modem only if
> TechnologyPreference is set to "umts"."

Thanks, fixed.


Lucas De Marchi

--===============2185733944325906304==--

