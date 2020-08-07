Content-Type: multipart/mixed; boundary="===============1490198155871618389=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] quectel: Try to update voltage only, when received
 "vbatt"
Date: Fri, 07 Aug 2020 11:12:03 -0500
Message-ID: <b56c96ec-47f3-8c83-fc45-37be429f07fe@gmail.com>
In-Reply-To: <20200804123849.909105-4-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1490198155871618389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/4/20 7:38 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> As there are some more sources of +QIND: activated, do now only update
> voltage when we get the
> +QIND: "vbatt",-1
> but not on things like
> +QIND: "act","LTE"
> or
> +QIND: "csq",20,99
> ---
>   plugins/quectel.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1490198155871618389==--

