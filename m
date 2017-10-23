Content-Type: multipart/mixed; boundary="===============1629086829643667054=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] atmodem: Query the list of supported <fac>s from the
 modem
Date: Mon, 23 Oct 2017 15:33:24 -0500
Message-ID: <e5088452-35c4-cafa-ae8b-b256120c228b@gmail.com>
In-Reply-To: <1508790108-20038-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1629086829643667054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/23/2017 03:21 PM, Slava Monich wrote:
> Not all modems support all <fac>s (particularly, "PS"), let's be polite
> and not ask them for the ones they don't support.
> ---
>   drivers/atmodem/sim.c | 57 ++++++++++++++++++++++++++++++++++++++++----=
-------
>   1 file changed, 45 insertions(+), 12 deletions(-)
> =


drivers/atmodem/sim.c: In function =E2=80=98at_clck_query_cb=E2=80=99:
drivers/atmodem/sim.c:1593:17: error: comparison between signed and =

unsigned integer expressions [-Werror=3Dsign-compare]
    for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++) {
                  ^
drivers/atmodem/sim.c: In function =E2=80=98at_sim_probe=E2=80=99:
drivers/atmodem/sim.c:1623:16: error: comparison between signed and =

unsigned integer expressions [-Werror=3Dsign-compare]
   for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++)
                 ^
drivers/atmodem/sim.c: At top level:
cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncatio=
n=E2=80=99 =

[-Werror]


Regards,
-Denis

--===============1629086829643667054==--

