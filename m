Content-Type: multipart/mixed; boundary="===============7384395362707002348=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] isimodem: add some ss error enums
Date: Tue, 12 Oct 2010 20:23:58 +0300
Message-ID: <AANLkTi=stJ2fd_KXr8CdB-r9h45rBKmTPMtX23tY3j0C@mail.gmail.com>
In-Reply-To: <4CB1AA6D.5060402@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7384395362707002348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/10/10 Denis Kenzior <denkenz@gmail.com>:
>> +enum ss_other_error {
>> + =C2=A0 =C2=A0 SS_SERVICE_BUSY =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
>> + =C2=A0 =C2=A0 SS_GSM_MM_RELEASE =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01,
>> + =C2=A0 =C2=A0 SS_GSM_DATA_ERROR =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02,
>> + =C2=A0 =C2=A0 SS_GSM_TIMER_EXPIRED =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x03,
>> + =C2=A0 =C2=A0 SS_GSM_REQUEST_CANCELLED =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x04,
>> + =C2=A0 =C2=A0 SS_GSM_INDICATE_DEVICE_PASSWORD =3D =C2=A0 =C2=A0 =C2=A0=
 0x05,
>> + =C2=A0 =C2=A0 SS_GSM_ACTIVATION_DATA_LOST =3D =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x09,
>> + =C2=A0 =C2=A0 SS_GSM_MM_ERROR =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0B,
>> + =C2=A0 =C2=A0 SS_GSM_SERVICE_NOT_ON_FDN_LIST =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0C,
>> + =C2=A0 =C2=A0 SS_SIMATKCC_REJECTED =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0D,
>> + =C2=A0 =C2=A0 SS_SIMATKCC_MODIFIED =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0E,
>> + =C2=A0 =C2=A0 SS_CS_INACTIVE =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0F,
>> + =C2=A0 =C2=A0 /* SS_GSM_SS_NOT_AVAILABLE =3D =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x12, */
>> + =C2=A0 =C2=A0 /* SS_GSM_USSD_BUSY =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x48, */
>
> Why are these commented out?

The isimodem supplementary service API designer have decided to save a
couple of code points and reused the MAP error enums in as error codes
generated internally.

I'll check the indenting, add a comment clarifying the comments and resubmi=
t.

-- =

Pekka.Pessi mail at nokia.com

--===============7384395362707002348==--

