Content-Type: multipart/mixed; boundary="===============7477521687943221213=="
MIME-Version: 1.0
From: ofonoconn@encambio.com
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 21:04:08 +0200
Message-ID: <20110627190408.GA11941@debut.europalab.com>
In-Reply-To: <4E08B3F3.70003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7477521687943221213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon., June 27, 2011, Denis Kenzior wrote:
>On 06/27/2011 01:43 PM, ofonoconn(a)encambio.com wrote:
>> On Mon., June 27, 2011, Denis Kenzior wrote:
>>> On 06/27/2011 12:25 PM, ofonoconn(a)encambio.com wrote:
>>>> On Mon., June 27, 2011, Denis KENZIOR wrote:
>>>>> The 3607GW based modems are well supported by oFono, however we
>>>>> have not tested all of the possible ones.  So assuming that you
>>>>> have installed ofono.rules file correctly the only other problem
>>>>> might be that your device manufacturer has named the port / network
>>>>> devices slightly differently from other manufacturers.
>>>>>
>The rules seem to be OK, so the udev detection code
>in plugins/udev.c:add_mbm is not finding your modem.
>
>Try starting oFono with
>
>ofonod -n -d 'plugins/udev*' (sorry, I messed this up earlier)
>
>and report the output
>
  meego$ /usr/sbin/ofonod -n -d 'plugins/udev*'
  ofonod[811]: oFono version 0.48
  ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.1/tty/ttyACM0 (mbm)
  ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule=C2=A0Data Modem
  ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.3/tty/ttyACM1 (mbm)
  ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule Modem
  ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.6/net/wwan0 (mbm)
  ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule Network Adapter
  ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.9/tty/ttyACM2 (mbm)
  ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule NMEA
  ofonod[811]: Exit

...sorry I think before I mistyped the MeeGo 1.2 (current) ofono
version 0.48 as 0.58 incorrectly.

But the output shown above is rather good, so I'm at a loss
to what could be wrong. Any ideas? Is connman relevant here?

Regards,
Michael

--===============7477521687943221213==--

