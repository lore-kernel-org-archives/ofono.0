Content-Type: multipart/mixed; boundary="===============3566809139936905176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] gemalto: acquire the network technology
Date: Fri, 16 Mar 2018 09:27:22 -0500
Message-ID: <d6cb289e-16f9-396d-8085-88910a20ccd7@gmail.com>
In-Reply-To: <1521205172-29974-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3566809139936905176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel, Mariem,

On 03/16/2018 07:59 AM, Gabriel Lucas wrote:
> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
> =

> ---
>   drivers/atmodem/network-registration.c | 45 +++++++++++++++++++++++++++=
+++++++
>   1 file changed, 45 insertions(+)

When applying this patch I got:

   CC       drivers/atmodem/network-registration.o
drivers/atmodem/network-registration.c: In function =E2=80=98cinterion_pars=
e_tech=E2=80=99:
drivers/atmodem/network-registration.c:186:10: error: unused variable =

=E2=80=98l=E2=80=99 [-Werror=3Dunused-variable]
   GSList *l;
           ^
drivers/atmodem/network-registration.c: At top level:
cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncatio=
n=E2=80=99 =

[-Werror]
cc1: all warnings being treated as errors

Please make sure you test with --disable-debug --enable-optimization =

prior to submission so the compiler catches any unused variables.

I went ahead and removed the offending GSList *l declaration and applied =

this patch.  Thanks!

Regards,
-Denis

--===============3566809139936905176==--

