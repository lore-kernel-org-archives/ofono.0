Content-Type: multipart/mixed; boundary="===============5559676184890131682=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: gprs: React on context deactivation
Date: Mon, 02 Sep 2019 16:39:48 -0500
Message-ID: <11c76bb9-0446-cd32-3961-8534a9ea5dee@gmail.com>
In-Reply-To: <20190903140611.1264-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5559676184890131682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/3/19 9:06 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In case a context get deactivated when a AT+CGACT=3D0 is
> not issued, indicate that to gprs core.
> This can happen if the device has an auto activated
> LTE context and modem switches over to for instance UTRAN.
> ---
>   drivers/ubloxmodem/gprs-context.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============5559676184890131682==--

