Content-Type: multipart/mixed; boundary="===============5104981266205172189=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Tue, 03 Nov 2009 14:53:08 -0200
Message-ID: <fbf08280911030853l65e00f5m859d4f13d1427cd2@mail.gmail.com>
In-Reply-To: <1257270416.26789.11.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5104981266205172189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On Tue, Nov 3, 2009 at 3:46 PM, Zhenhua Zhang <zhenhua.zhang@intel.com> w=
rote:
> Hi Padovan,
>
> Gustavo F. Padovan wrote:
>> This driver handles phone informations about registration status, signal
>> strength and roaming status listening +CIEV commands. =C2=A0It also gets=
 the
>> Network Operator name with +COPS commands.
>> ---
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +-
>> =C2=A0drivers/hfpmodem/hfpmodem.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A02 +
>> =C2=A0drivers/hfpmodem/hfpmodem.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A03 +
>> =C2=A0drivers/hfpmodem/network-registration.c | =C2=A0365 ++++++++++++++=
+++++++++++++++++
>> =C2=A0plugins/hfp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A05 files changed, 373 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 drivers/hfpmodem/network-registration.c
>
> On compiling your code I got:
>
> =C2=A0CC =C2=A0 =C2=A0 drivers/hfpmodem/network-registration.o
> cc1: warnings being treated as errors
> drivers/hfpmodem/network-registration.c: In function =E2=80=98cops_cb=E2=
=80=99:
> drivers/hfpmodem/network-registration.c:101: error: label =E2=80=98error=
=E2=80=99
> defined but not used
> drivers/hfpmodem/network-registration.c:58: error: unused variable =E2=80=
=98nd=E2=80=99
> make[1]: *** [drivers/hfpmodem/network-registration.o] Error 1
> make: *** [all] Error 2

Sorry, I forgot the --enable-maintainer-mode. :(

>
> So I have below patch to remove 'nd' and refine labels in cops_cb.
> Please review it.
>
> I would suggest to replace 'out' label by return. We really don't need
> two labels that is confusing. Atmodem netreg has the same problem.

I agree with you, thanks for the patch and the review.


-- =

Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

--===============5104981266205172189==--

