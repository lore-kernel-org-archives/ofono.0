Content-Type: multipart/mixed; boundary="===============0256910284824494536=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix modem doesn't auto register to network issue
Date: Wed, 11 Sep 2013 12:43:57 -0500
Message-ID: <5230ABDD.40808@gmail.com>
In-Reply-To: <1378920827-6086-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0256910284824494536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 09/11/2013 12:33 PM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> Some modem may return registration status whitch is out of the range
> (0-5). it will cause the modem don't auto register to network when
> network atom initializes.

oFono core will not validate values outside what is defined in 27.007. =

If your driver reports such values, then it is an obvious bug in the driver.

Please fix your modem driver.

> ---
>   src/network.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>

Regards,
-Denis


--===============0256910284824494536==--

