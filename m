Content-Type: multipart/mixed; boundary="===============3156590002345853179=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv3 0/9] Quectel M95 support
Date: Thu, 11 Jul 2019 00:21:44 +0200
Message-ID: <26e9846b-7fea-4ab3-f687-aec9e32f5691@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3156590002345853179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The modem supports an unsolicited notification for voltage level =

warnings and errors. I.e it can send

   UNDER_VOLTAGE POWER DOWN
   UNDER_VOLTAGE WARNING
   OVER_VOLTAGE WARNING
   OVER_VOLTAGE POWER DOWN

The power down messages should probably just close the serial ports and =

call ofono_modem_set_powered(modem, false), but what about the warnings?

Should I just add a hardware monitor dbus interface like the =

gemalto/cinterion drivers do, with a signal for the warnings?

Thanks,
Martin

On 10/07/2019 23.51, Martin Hundeb=C3=B8ll wrote:
> Changes since v1/v2:
>   * remove c types patch
>   * add patch with m95 sms quirks
>   * add patch to query device model
>   * add patch to create voicecall, phonebook, and sms functionality
>   * add patch to enable flow control on modem if configured
> =

> Martin Hundeb=C3=B8ll (9):
>    atmodem: sms: add quectel m95 quirks
>    quectel: always print modem pointer in debug messages
>    quectel: unwrap call to at_util_open_device()
>    quectel: replace glib uses with ell
>    quectel: add basic support for serial connected modems
>    quectel: support gpio to power on/off the modem
>    quectel: configure flow control when enabled
>    quectel: query device model to enable vendor quirks
>    quectel: initialize call, phonebook and sms when ready
> =

>   drivers/atmodem/sms.c |  24 ++-
>   plugins/quectel.c     | 491 ++++++++++++++++++++++++++++++++++++++----
>   plugins/udevng.c      |  32 ++-
>   3 files changed, 494 insertions(+), 53 deletions(-)
>=20

--===============3156590002345853179==--

