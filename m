Content-Type: multipart/mixed; boundary="===============5387591805935739373=="
MIME-Version: 1.0
From: Timo =?unknown-8bit?q?M=C3=BCller?= <mail@timomueller.eu>
Subject: Re: [PATCHv4 0/8] Nokia N9 specific quirks
Date: Mon, 15 Apr 2013 16:10:51 +0200
Message-ID: <516C0A6B.6030409@timomueller.eu>
In-Reply-To: <cover.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5387591805935739373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Timo Mueller wrote, On 28.03.2013 14:36:
> From: Timo Mueller <timo.mueller@bmw-carit.de>
>
> Hi,
>
> this is the same as v3 with the changes suggested by Denis.
>
> v4 changes:
> * Retry CLCC request on outgoing callsetup is now a N9 specific quirk
> * Third patch has been split up according to HACKING rules
>
> The idea of setting the vendor during runtime was to use the "Model"
> string of the ofono_modem (analogous to what the wavecom modem
> does). But as the Nokia N9 does not support the device ID profile and
> the BT address has an OUI from Texas Instruments, I wasn't able to
> determine that the hfpmodem is a Nokia N9. Maybe you have some
> ideas on how this can be determined properly?
>
> As currently there's no functionality to detect the vendor of a
> hfpmodem on runtime the clcc quirk can be enabled for all vendors by
> patching the needs_callheld_clcc_quirk method.
>
> Regards,
> Timo
>
> Timo Mueller (8):
>    hfpmodem: Add modem vendor stub
>    hfpmodem: Add vendor header to makefile
>    hfpmodem: Add vendor information to voicecall data
>    hfp_hf_bluez4: Pass vendor on voicecall creation
>    hfp_hf_bluez5: Pass vendor on voicecall creation
>    hfpmodem: Add method to query if CLCC quirks are needed
>    hfpmodem: Add N9 quirk for outgoing callsetup
>    hfpmodem: Add N9 quirk for callheld=3D<2 or 3>
>
>   Makefile.am                  |  3 +-
>   drivers/hfpmodem/vendor.h    | 26 +++++++++++++++
>   drivers/hfpmodem/voicecall.c | 77 +++++++++++++++++++++++++++++++++++++=
++++---
>   plugins/hfp_hf_bluez4.c      |  4 ++-
>   plugins/hfp_hf_bluez5.c      |  5 ++-
>   5 files changed, 107 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/hfpmodem/vendor.h
>

Ping

--===============5387591805935739373==--

