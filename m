Content-Type: multipart/mixed; boundary="===============2995597960936691814=="
MIME-Version: 1.0
From: ofonoconn@encambio.com
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 20:43:32 +0200
Message-ID: <20110627184332.GA10037@debut.europalab.com>
In-Reply-To: <4E08A77C.2070406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2995597960936691814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On Mon., June 27, 2011, Denis Kenzior wrote:
>On 06/27/2011 12:25 PM, ofonoconn(a)encambio.com wrote:
>> On Mon., June 27, 2011, Denis KENZIOR wrote:
>>> On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
>>> The 3607GW based modems are well supported by oFono, however we
>>> have not tested all of the possible ones.  So assuming that you
>>> have installed ofono.rules file correctly the only other problem
>>> might be that your device manufacturer has named the port / network
>>> devices slightly differently from other manufacturers.
>>>
>oFono has so far only released version 0.50 upstream, so I'm not sure
>how Meego is making 0.58 ;)  Try putting plugins/ofono.rules from
>ofono.git into /etc/udev/rules.d, re-plugging your dongle and starting
>oFono with -n -d 'udev*'
>
Its not a dongle, rather a Mini PCI-E  that I semi-permanently
installed on the motherboard.

>Nope, sounds like the rules are not installed or the card is not
>inserted (but I assume it is built-in, so the latter is probably
>not it)
>
It's installed correctly and a SIM card is plugged in. This
exact configuration works perfectly when booting Ubuntu (with
network-manager) on the same netbook.

Okay but we were looking in the wrong place...

  meego$ ls /lib/udev/rules.d/*ofono*
  97-ofono.rules

  meego$ grep -i '03f0.*271d' /lib/udev/rules.d/97-ofono.rules
  # HP hs2330 Mobile Broadband Module
  ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"271d", ENV{OFONO_DRIV=
ER}=3D"mbm"

I've confirmed that the PID/VID of my butchered (by HP) Ericsson
modem matches this entry above, which is in my udev rules directory.
It's probably the reason that /dev/.udev/db/net:\wwan0 is getting
created by udev at all.

So with this new information what should I be doing to correct this
problem? It seems to me that the ofono sources are not missing
anything.

  meego$ /usr/lib/ofono/test/list-modems
  meego$

...shouldn't that command be showing my modem?

Regards,
Michael

--===============2995597960936691814==--

