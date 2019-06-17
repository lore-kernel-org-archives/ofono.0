Content-Type: multipart/mixed; boundary="===============6181944583733412649=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] isimodem: voicecall: fix strncpy compiler error (GCC
 9)
Date: Mon, 17 Jun 2019 14:13:01 -0500
Message-ID: <887ad535-5363-8d90-d25a-cc2c51b12b00@gmail.com>
In-Reply-To: <20190617183805.32599-2-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6181944583733412649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 06/17/2019 01:38 PM, James Prestwood wrote:
> GCC complains that the destination buffer equals the size to copy:
> =

> In function =E2=80=98strncpy=E2=80=99,
>      inlined from =E2=80=98isi_call_any_address_sb_proc.isra.0=E2=80=99 a=
t drivers/isimodem/voicecall.c:230:2:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_st=
rncpy=E2=80=99 specified bound 20 equals destination size [-Werror=3Dstring=
op-truncation]
>    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (_=
_dest));
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> ---
>   drivers/isimodem/voicecall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
> index 9a63f100..3fb150f6 100644
> --- a/drivers/isimodem/voicecall.c
> +++ b/drivers/isimodem/voicecall.c
> @@ -227,7 +227,7 @@ static void isi_call_any_address_sb_proc(struct isi_v=
oicecall *ivc,
>   =

>   	call->addr_type =3D type | 0x80;
>   	call->presentation =3D pres;
> -	strncpy(call->address, addr, sizeof(call->address));
> +	strncpy(call->address, addr, sizeof(call->address) - 1);

Note that this doesn't null terminate call->address in all cases... =

This file is full of these, so the sanest approach might be to use =

l_strlcpy.

>   =

>   	g_free(addr);
>   }
> =


Regards,
-Denis

--===============6181944583733412649==--

