Content-Type: multipart/mixed; boundary="===============6093234633209229675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] quectel: Extend power-on timeout
Date: Tue, 29 Sep 2020 09:23:18 -0500
Message-ID: <2a362f7c-29d7-04af-0412-99f62cc998f2@gmail.com>
In-Reply-To: <20200924103806.2518502-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6093234633209229675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 9/24/20 5:38 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> More complicated modems emerge and they need longer start-up times. An
> EC21 takes about 13 seconds to boot up. This is slightly longer than the
> 20 * 500 ms we have at the moment. This extends the retries to 30, so we
> have 30 * 500 ms and this does successfully power up an EC21 modem.
> ---
>   plugins/quectel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6093234633209229675==--

