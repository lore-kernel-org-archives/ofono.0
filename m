Content-Type: multipart/mixed; boundary="===============3810468503049308671=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] common: '+' is not valid phone number anymore
Date: Thu, 24 Feb 2011 09:47:33 -0600
Message-ID: <4D667D95.3060505@gmail.com>
In-Reply-To: <1298536438-2646-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3810468503049308671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paavo,

On 02/24/2011 02:33 AM, Paavo Leinonen wrote:
> Reject phone number if it contains only plus sign.
> ---
> Hi,
> =

> Originally this issue was found while testing Call Forwarding. If =

> user would set call fowarding to number '+', oFono actually erased =

> existing CF settings. Fix was made to common.c as I don't think plus
> should be considered as a valid phone number in any case.
> =

> BR,
> Paavo
> =

>  src/common.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3810468503049308671==--

