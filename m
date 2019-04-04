Content-Type: multipart/mixed; boundary="===============8521125890355530830=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: gprs-context: Fix router mode IP settings.
Date: Thu, 04 Apr 2019 09:56:03 -0500
Message-ID: <6f70925b-7e90-58a1-18ae-7104263a2cf6@gmail.com>
In-Reply-To: <20190403211116.696-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8521125890355530830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 04/03/2019 04:11 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> The ublox modems always run DHCP when in router mode.
> Unfortunately the code overwrote the IP settings with
> static IP settings while activating.
> =

> Now we respect the networking_mode regardless if
> we read settings during activation or read settings
> phase.
> ---
>   drivers/ubloxmodem/gprs-context.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8521125890355530830==--

