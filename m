Content-Type: multipart/mixed; boundary="===============8059555566825368483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [V3 PATCH 2/3] PPP: Use default ACCM (0xffffffff) to trasmit
 package
Date: Wed, 16 Feb 2011 12:02:18 -0600
Message-ID: <4D5C112A.5000808@gmail.com>
In-Reply-To: <1297752796-9547-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8059555566825368483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 02/15/2011 12:53 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
> event breaks PPP link, after IP package transmit for a while.
> Using default ACCM, the issue can be fixed.
> I tested it at China Unicom networks.
> ---
>  gatchat/ppp_lcp.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============8059555566825368483==--

