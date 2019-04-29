Content-Type: multipart/mixed; boundary="===============0706021429106531612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: handling of IPv6 address for activated context
Date: Mon, 29 Apr 2019 11:36:17 -0500
Message-ID: <0e321fc9-b0d0-b23c-c001-16044b1681f3@gmail.com>
In-Reply-To: <1556085290-14876-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0706021429106531612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 04/24/2019 12:54 AM, Antara Borwankar wrote:
> Handled IPv6 address after activating PDP context.
> Received IPv6 address is of format addr + netmask in the same string
> in the form of "a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.
> m1.m2.m3.m4.m5.m6.m7.m8.m9.m10.m11.m12.m13.m14.m15.m16"
> ---
>   drivers/atmodem/atutil.c        | 39 +++++++++++++++++++++++++++++++++
>   drivers/atmodem/atutil.h        |  3 +++
>   drivers/ifxmodem/gprs-context.c | 48 +++++++++++++++++++++++++++++-----=
-------
>   3 files changed, 76 insertions(+), 14 deletions(-)
> =


I went ahead and applied this version after fixing up some lines which =

had > 80 chars.  But:

> +		ofono_gprs_context_set_ipv6_prefix_length(gc, IPV6_DEFAULT_PREFIX_LEN);

This really should be addressed at some point.  Assuming a default =

netmask won't work in every situation.

Regards,
-Denis

--===============0706021429106531612==--

