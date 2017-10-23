Content-Type: multipart/mixed; boundary="===============8103593837717828428=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH v2] atmodem: Query the list of supported <fac>s from the
 modem
Date: Mon, 23 Oct 2017 23:39:28 +0300
Message-ID: <65eee959-db86-1def-be38-ea3b8b1b2b7e@jolla.com>
In-Reply-To: <e5088452-35c4-cafa-ae8b-b256120c228b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8103593837717828428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 23/10/17 23:33, Denis Kenzior wrote:
> Hi Slava,
>
> On 10/23/2017 03:21 PM, Slava Monich wrote:
>> Not all modems support all <fac>s (particularly, "PS"), let's be polite
>> and not ask them for the ones they don't support.
>> ---
>> =C2=A0 drivers/atmodem/sim.c | 57 =

>> ++++++++++++++++++++++++++++++++++++++++-----------
>> =C2=A0 1 file changed, 45 insertions(+), 12 deletions(-)
>>
>
> drivers/atmodem/sim.c: In function =E2=80=98at_clck_query_cb=E2=80=99:
> drivers/atmodem/sim.c:1593:17: error: comparison between signed and =

> unsigned integer expressions [-Werror=3Dsign-compare]
> =C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^
> drivers/atmodem/sim.c: In function =E2=80=98at_sim_probe=E2=80=99:
> drivers/atmodem/sim.c:1623:16: error: comparison between signed and =

> unsigned integer expressions [-Werror=3Dsign-compare]
> =C2=A0 for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++)

Apparently we are using slightly different compilers. Will fix.

-Slava

--===============8103593837717828428==--

