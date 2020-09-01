Content-Type: multipart/mixed; boundary="===============8965524615458773904=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] atmodem: Detect usage of AT+CGEREP
Date: Tue, 01 Sep 2020 11:10:39 -0500
Message-ID: <417ceb42-a4ae-813f-f715-2a2f051fc236@gmail.com>
In-Reply-To: <20200901092111.1205313-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8965524615458773904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 9/1/20 4:21 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> Currently AT+CGEREP=3D2,1 is sent in case we don't know what the modem
> needs. (default case) Not all modems understand this. So, we first query
> what the modem supports with AT+CGEREP=3D? and then use this information
> to be nice to the modem. This way modems, like the Quectel M95 that do
> only understand AT+CGEREP=3D1 do also work nicely.
> ---
> Changes since v2:
> - (min <=3D 1 <=3D max)
> - error handling
> =


Applied, thanks.

Regards,
-Denis

--===============8965524615458773904==--

