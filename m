Content-Type: multipart/mixed; boundary="===============4431542091857117390=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] gemalto: add PIN retries support in driver
Date: Mon, 06 Nov 2017 11:30:04 -0600
Message-ID: <ae9b1dd3-31be-77e9-3749-fad920be5ebe@gmail.com>
In-Reply-To: <1509976629-9430-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4431542091857117390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 11/06/2017 07:57 AM, Gabriel Lucas wrote:
> In SimManager, the Retries property isn't used for gemalto modems.
> The at command AT^SPIC is used to get the remaining retries left
> for the current required password type.
> =

> This commit adds the implementation in the SIM driver of the retries
> queries.
> ---
>   drivers/atmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> =


After applying, I get:

drivers/atmodem/sim.c:77:20: error: redefinition of =E2=80=98spic_prefix=E2=
=80=99
  static const char *spic_prefix[] =3D { "^SPIC:", NULL };
                     ^~~~~~~~~~~
drivers/atmodem/sim.c:69:20: note: previous definition of =E2=80=98spic_pre=
fix=E2=80=99 =

was here
  static const char *spic_prefix[] =3D { "+SPIC:", NULL };
                     ^~~~~~~~~~~
drivers/atmodem/sim.c:69:20: error: =E2=80=98spic_prefix=E2=80=99 defined b=
ut not used =

[-Werror=3Dunused-variable]
cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncatio=
n=E2=80=99 =

[-Werror]

Regards,
-Denis

--===============4431542091857117390==--

