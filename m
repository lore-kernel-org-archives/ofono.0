Content-Type: multipart/mixed; boundary="===============7735535438583687046=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] isimodem: gprs-context: properly null terminate
 cd->password
Date: Mon, 17 Jun 2019 13:51:17 -0500
Message-ID: <9e6dcb46-1b22-6910-bc2d-72c75d957ae0@gmail.com>
In-Reply-To: <20190617183805.32599-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7735535438583687046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 06/17/2019 01:38 PM, James Prestwood wrote:
> It looks like a previous line was copied and cd->username was re-terminat=
ed
> instead of password. This also fixes a compiler error when using GCC 9:
> =

> In function =E2=80=98strncpy=E2=80=99,
>      inlined from =E2=80=98isi_gprs_activate_primary=E2=80=99 at drivers/=
isimodem/gprs-context.c:546:3:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_st=
rncpy=E2=80=99 output may be truncated copying 53 bytes from a string of le=
ngth 255 [-Werror=3Dstringop-truncation]
>    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (_=
_dest));
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> ---
>   drivers/isimodem/gprs-context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7735535438583687046==--

