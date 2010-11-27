Content-Type: multipart/mixed; boundary="===============8467264154613088646=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 1/9] coding-style: add rule about checking NULL pointer
Date: Sat, 27 Nov 2010 17:07:08 -0200
Message-ID: <AANLkTi=5TSU5YUxQyr6WC6AU3qUAJ9DzEJs8Q40FU+34@mail.gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702CCBC85@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8467264154613088646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 27, 2010 at 1:57 PM,  <Rajesh.Nagaiah@elektrobit.com> wrote:
>> +3)
>> +array =3D g_try_new0(int, 20);
>> +if (!array) =C2=A0// Correct
>
> Shouldn't be if (array =3D=3D NULL) // Correct :)?

You are right.

Thanks, fixed.

Lucas De Marchi

--===============8467264154613088646==--

