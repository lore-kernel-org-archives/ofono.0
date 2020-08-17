Content-Type: multipart/mixed; boundary="===============7608952466256243802=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4] gprs: Quectel EC21 does not understand AT+CPSB
Date: Mon, 17 Aug 2020 10:15:01 -0500
Message-ID: <1280d2ee-84a4-4eb3-8ba9-78abc720b1cd@gmail.com>
In-Reply-To: <20200817075807.491927-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7608952466256243802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/17/20 2:58 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 modem does not understand the AT+CPSB command, and we
> did not find a suitable replacement in the
> Quectel_EC25&EC21_AT_Commands_Manual_V1.3.pdf
> AT+CPSB gives an error on this modem, so we just skip it.
> ---
>   drivers/atmodem/gprs.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============7608952466256243802==--

