Content-Type: multipart/mixed; boundary="===============1830660928506168192=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Revert "quectel: EC21 needs aux channel to be the first
 mux channel"
Date: Fri, 07 Aug 2020 11:07:34 -0500
Message-ID: <e991a1fa-c330-774f-6117-54c497864a58@gmail.com>
In-Reply-To: <20200804115649.907281-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1830660928506168192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/4/20 6:56 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> This reverts commit 1868dbf2b3e5929a7081b03a8ff76d214fd38624.
> Development for this was done on EC21 firmware version
> EC21EFAR06A01M4G_BETA0318. It now turns out, that actual release
> firmware versions for this modem again need the original mux order with
> aux channel as the second mux channel. (We know for sure for firmware
> version EC21EFAR06A03M4G.)
> We do not know for sure when and for what firmware versions quectel did
> the switch back on the mux order, but we suspect that the "BETA"
> firmware is the only one with the reversed mux order. This "BETA"
> firmware was only given out for development purposes and will not appear
> "in the wild", so we revert the patch here and hope for the best.
> ---
>   plugins/quectel.c | 61 +++++++++++------------------------------------
>   1 file changed, 14 insertions(+), 47 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============1830660928506168192==--

