Content-Type: multipart/mixed; boundary="===============0363432927336852763=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC PATCH 1/3] radio-settings: add frequency band selection
 methods
Date: Wed, 01 Dec 2010 23:51:57 -0200
Message-ID: <AANLkTi=0AvJ60S4_8uHatKFkyh89gL8Vu9iNWtPsuMad@mail.gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A719@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0363432927336852763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 1, 2010 at 8:24 PM,  <Rajesh.Nagaiah@elektrobit.com> wrote:
> Hi Lucas,
>
>> +enum ofono_radio_band_gsm {
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_ANY =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
0,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_850 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
1,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_900P =C2=A0 =C2=A0 =C2=A0 =3D 2,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_900E =C2=A0 =C2=A0 =C2=A0 =3D 3,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_1800 =C2=A0 =C2=A0 =C2=A0 =3D 4,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_GSM_1900 =C2=A0 =C2=A0 =C2=A0 =3D 5,
>> +};
>> +
>> +enum ofono_radio_band_umts {
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_ANY =C2=A0 =C2=A0 =C2=A0 =3D 0,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_850 =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_900 =C2=A0 =C2=A0 =C2=A0 =3D 2,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_1700AWS =C2=A0 =3D 3,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_1900 =C2=A0 =C2=A0 =C2=A0=3D 4,
>> + =C2=A0 =C2=A0 OFONO_RADIO_BAND_UMTS_2100 =C2=A0 =C2=A0 =C2=A0=3D 5,
>> +};
>
> A minor coding style comment. Accodring to code style M11: Naming of
> enums,
> If the enum contents have values (e.g. from specification) then the

What I understood is that "specification" is just an example, it might
be because of  other things.

But I agree with your comment.

Thanks, fixed.


Lucas De Marchi

--===============0363432927336852763==--

