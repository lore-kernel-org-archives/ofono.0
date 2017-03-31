Content-Type: multipart/mixed; boundary="===============1579443279131595850=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC hwdb v1 25/28] mbm: use standard atom names
Date: Fri, 31 Mar 2017 17:54:02 -0500
Message-ID: <f6da62f8-65b1-d49f-49a4-003f75f11711@gmail.com>
In-Reply-To: <20170330205309.25850-26-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1579443279131595850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/30/2017 03:53 PM, Jonas Bonn wrote:
> ---
>  drivers/mbmmodem/location-reporting.c |  2 +-
>  plugins/mbm.c                         |  6 +++---
>  plugins/udevng.c                      | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
>

make --no-print-directory all-am
   CC       plugins/udevng.o
plugins/udevng.c: In function =E2=80=98setup_mbm=E2=80=99:
plugins/udevng.c:145:21: error: =E2=80=98app=E2=80=99 undeclared (first use=
 in this =

function)
   if (mdm =3D=3D NULL || app =3D=3D NULL)
                      ^
plugins/udevng.c:145:21: note: each undeclared identifier is reported =

only once for each function it appears in



--===============1579443279131595850==--

