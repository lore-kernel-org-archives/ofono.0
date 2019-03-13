Content-Type: multipart/mixed; boundary="===============2766694377650232201=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/14] ublox: make device selection more flexible
Date: Wed, 13 Mar 2019 13:43:51 -0500
Message-ID: <0912df07-2fcb-a359-a736-5c06176a4929@gmail.com>
In-Reply-To: <20190312111008.29258-4-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2766694377650232201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/12/2019 06:09 AM, Jonas Bonn wrote:
> Many ublox modems can sit on either the USB bus or talk directly to a
> UART.  The udev plugin mostly takes care of figuring out what ports to
> talk to and the protocol is common for all devices after that.
> =

> This patch simplifies the setup a bit:
> i)  There must always be an aux channel for communication with the modem
> ii)  The aux channel may be found behind the string Aux for USB modems
> or Device for serial modems
> iii)  If the Modem string is set, use it; if not set, assume it's not
> available.
> ---
>   plugins/ublox.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============2766694377650232201==--

