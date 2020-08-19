Content-Type: multipart/mixed; boundary="===============3861196481617725872=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] atmodem: Deactivate AT+CPSB for quectel serial modems
Date: Wed, 19 Aug 2020 09:57:28 -0500
Message-ID: <8317e9f4-ce50-95f5-3e1f-06561abc597e@gmail.com>
In-Reply-To: <20200819121339.879624-2-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3861196481617725872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/19/20 7:13 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> There are at the moment two quectel modems in ofono vendored as
> OFONO_VENDOR_QUECTEL_SERIAL: The M95 and the MC60.
> Both modems are GSM only modems, and their official documentation does
> not mention the AT+CPSB command.
> I have a M95 here that gives an error on issuing the AT+CPSB=3D1 command.
> So skip this command for these two modems.
> ---
>   drivers/atmodem/gprs.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis
--===============3861196481617725872==--

