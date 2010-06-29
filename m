Content-Type: multipart/mixed; boundary="===============4567617826193708354=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 2/2] mbm: use cpin? to check if SIM is missing
Date: Tue, 29 Jun 2010 14:15:37 +0300
Message-ID: <AANLkTilrNMc7pp7zaE7o9LOp1QHgjck6MBv0V5nDJHDh@mail.gmail.com>
In-Reply-To: <AANLkTilYOIv-J2SzZd531IdEAFbUuL1vDltcFm47bkUk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4567617826193708354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/6/28 Andrzej Zaborowski <andrew.zaborowski@intel.com>:
> On 28 June 2010 20:20, Pekka Pessi <Pekka.Pessi@nokia.com> wrote:
>> Use AT+CPIN? in case AT+CRSM=3D242 is not supported.
>
> On the model where AT+CRSM works, AT+CPIN also works, so I propose to
> use it always. =C2=A0The firmware may cache information but when card is
> extracted it notices.

OK, I sent another patch that removed the AT+CRSM command...

--Pekka

-- =

Pekka.Pessi mail at nokia.com

--===============4567617826193708354==--

