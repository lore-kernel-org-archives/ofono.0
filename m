Content-Type: multipart/mixed; boundary="===============7374391444803846425=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] atmodem: Signal quality on quectel serial modems
Date: Tue, 25 Aug 2020 11:40:39 -0500
Message-ID: <bb4e3731-6240-e7e8-6e43-7c2eed4d100f@gmail.com>
In-Reply-To: <20200821092402.1001245-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7374391444803846425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/21/20 4:24 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> As the default way of getting the signal quality with +CIND is also
> unstable on quectel serial modems (the same as on quectel EC21). In fact
> the signal quality is only updated on cell changes. Those trigger a
> manual AT+CSQ in ofono and get an update this way, but the URCs do not
> work.
> So we implement a quectelish way here as well. The quectelish way is
> very similar to the way ifx modems work. We can reuse their csq_notify
> function.
> ---
>   drivers/atmodem/network-registration.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7374391444803846425==--

