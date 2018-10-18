Content-Type: multipart/mixed; boundary="===============7372377023977411850=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Fri, 19 Oct 2018 01:59:14 +0300
Message-ID: <85109d4e-0e01-d126-41b0-94a1abef9311@jolla.com>
In-Reply-To: <cb95ecab-da1e-878d-89d9-a6d3d5a3d321@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7372377023977411850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/10/18 22:32, Jonas Bonn wrote:
> ...
>
>> +#include <ofono/log.h>
>> +#include <ofono/types.h>
>> +
>> +#include "ofono.h"
>> +#include "gemaltomodem.h"
>> +
>> +enum gemalto_auth_option {
>> +=C2=A0=C2=A0=C2=A0 GEMALTO_AUTH_DEFAULTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 0x00,
>> +=C2=A0=C2=A0=C2=A0 GEMALTO_AUTH_USE_SGAUTH=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 0x01,
>> +=C2=A0=C2=A0=C2=A0 GEMALTO_AUTH_ORDER_PWD_USR=C2=A0=C2=A0=C2=A0 =3D 0x0=
2,
>> +=C2=A0=C2=A0=C2=A0 GEMALTO_AUTH_ALW_ALL_PARAMS=C2=A0=C2=A0=C2=A0 =3D 0x=
04,
>> +};
>
> Using an enumeration to name flags feels awkward.=C2=A0 I would #define t=
hese:
>
> #define AUTH_F_USE_SGATH (1<<0)
> #define AUTH_F_SWAP_CREDENTIALS (1<<1)
> #define AUTH_F_ALWAYS_ALL_PARAMS (1<<2)
>


It may feel awkward but I actually find that (enum'ing flags) quite =

useful for debugging with gdb - it allows the debugger to refer to those =

flags by name.

Cheers,
-Slava

--===============7372377023977411850==--

