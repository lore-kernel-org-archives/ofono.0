Content-Type: multipart/mixed; boundary="===============5308348457216936969=="
MIME-Version: 1.0
From: Gabriel LUCAS <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 3/6] gemalto: acquire the network technology
Date: Fri, 16 Mar 2018 16:30:41 +0100
Message-ID: <350a9b8abdb2c1034c3889a3de398641@smile.fr>
In-Reply-To: <d6cb289e-16f9-396d-8085-88910a20ccd7@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5308348457216936969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Denis. My apologies for the unused variable.

On 2018-03-16 15:27, Denis Kenzior wrote:

> Hi Gabriel, Mariem,
> =

> On 03/16/2018 07:59 AM, Gabriel Lucas wrote:
> =

>> From: Mariem Cherif <mariem.cherif@ardia.com.tn> ---
>> drivers/atmodem/network-registration.c | 45
>> ++++++++++++++++++++++++++++++++++ 1 file changed, 45 insertions(+)
> =

> When applying this patch I got:
> =

> CC drivers/atmodem/network-registration.o
> drivers/atmodem/network-registration.c: In function
> 'cinterion_parse_tech':
> drivers/atmodem/network-registration.c:186:10: error: unused variable
> 'l' [-Werror=3Dunused-variable]
> GSList *l;
> ^
> drivers/atmodem/network-registration.c: At top level:
> cc1: error: unrecognized command line option '-Wno-format-truncation'
> [-Werror]
> cc1: all warnings being treated as errors
> =

> Please make sure you test with --disable-debug --enable-optimization
> prior to submission so the compiler catches any unused variables.

It seems that my sdk's environment isn't configured to show all =

warnings.
I'm gonna fix that.

> I went ahead and removed the offending GSList *l declaration and =

> applied
> this patch. Thanks!
> =

> Regards,
> -Denis

Gabriel

--===============5308348457216936969==--

