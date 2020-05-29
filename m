Content-Type: multipart/mixed; boundary="===============5148301987352409821=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Fri, 29 May 2020 14:58:08 +0000
Message-ID: <094c8640-d1d8-7340-1de1-5b6aad31dff5@gmail.com>
In-Reply-To: <20200529124347.25767-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5148301987352409821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 5/29/20 7:43 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 does only work correctly, if the mux channel used for
> aux is the first mux channel. It does only put it's URC messages in the
> first mux channel, so this has to be the aux channel in our case.
> To be flexible on the mux order we introduce two arrays here, that then
> contain the initialization data in their needed order.
> Initialization data is then applied by for-looping over this array.
> ---
>   plugins/quectel.c | 61 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 47 insertions(+), 14 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5148301987352409821==--

