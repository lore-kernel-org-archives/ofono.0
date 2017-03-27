Content-Type: multipart/mixed; boundary="===============7832892473297083898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 2/2] udevng: add Telit LE910 V1 support
Date: Sun, 26 Mar 2017 22:41:38 -0500
Message-ID: <11c9ba24-3fef-48f8-a8f6-b87abf47362d@gmail.com>
In-Reply-To: <1490604978-10639-3-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7832892473297083898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/27/2017 03:56 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Tested with LE910-SVG and Verizon.
> ---
>  plugins/udevng.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>

plugins/udevng.c: In function =E2=80=98setup_telitqmi=E2=80=99:
plugins/udevng.c:672:11: error: unused variable =E2=80=98telit=E2=80=99 =

[-Werror=3Dunused-variable]
   gboolean telit =3D FALSE;
            ^
cc1: all warnings being treated as errors

I went ahead and squashed that line and pushed out this patch.

Regards,
-Denis

--===============7832892473297083898==--

