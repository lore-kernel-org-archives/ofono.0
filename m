Content-Type: multipart/mixed; boundary="===============1066744036349751440=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 09:12:26 -0500
Message-ID: <4E088FCA.6010603@gmail.com>
In-Reply-To: <20110627154528.GA26618@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1066744036349751440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
> =

> Hello list,
> =

> when using distros integrating network-manager, I can connect to the
> Internet using my GSM/GPRS/UMTS WWAN modem and would like to be able
> to do so with Linux distros (MeeGo) which integrate ofono and
> connman. This is not very well documented, so please help.
> =

> GOAL
> ----
> I want to be able to select from between eth0, wlan0, and wwan0
> from the ofono/connman connection applet in MeeGo.
> =

> PROBLEM
> -------
> Ofono (or connman, not sure which) presents connection options after
> detecting that wired and wireless ethernet interfaces exist. In my
> netbook, no option to use the F3607gw (labeled Hewlett-Packard below)
> WWAN modem device wwan0 is available.
> =

> ENVIRONMENT
> -----------
> $ lsusb
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> [...]
> Bus 001 Device 006: ID 03f0:271d Hewlett-Packard =

> =

> $ ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 12:34:56:78:9A:BC  =

> [...]
> lo        Link encap:Local Loopback  =

> [...]
> wlan0     Link encap:Ethernet  HWaddr 12:34:56:78:9A:BC  =

> [...]
> wwan0     Link encap:Ethernet  HWaddr 12:34:56:78:9A:BC
>           BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 =

>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> =

> $ /usr/lib/ofono/test/list-modems
> $
> =

> $ dmesg | grep wwan
> [   11.385780] cdc_ether 1-5:1.6: wwan0: register 'cdc_ether' at usb-0000=
:00:1d.7-5, Mobile Broadband Network Device, 02:80:37:ec:02:00
> [ 2505.050955] cdc_ether 1-5:1.6: wwan0: unregister 'cdc_ether' usb-0000:=
00:1d.7-5, Mobile Broadband Network Device
> [ 2505.609492] cdc_ether 1-5:1.6: wwan0: register 'cdc_ether' at usb-0000=
:00:1d.7-5, Mobile Broadband Network Device, 02:80:37:ec:02:00
> =

> $ lsmod
> Module                  Size  Used by
> iptable_nat             3545  0 =

> nf_nat                 16042  1 iptable_nat
> ath9k                  65740  0 =

> ideapad_laptop          3529  0 =

> zaurus                  3045  0 =

> battery                 8862  0 =

> uvcvideo               50368  0 =

> ath9k_common            1977  1 ath9k
> cdc_ether               5744  1 zaurus
> cdc_acm                15767  0 =

> serio_raw               3821  0 =

> joydev                  8205  0 =

> cdc_wdm                 8885  0 =

> ath9k_hw              243316  2 ath9k,ath9k_common
> usbnet                 19620  2 zaurus,cdc_ether
> =

> What could the problem be?
> =


The 3607GW based modems are well supported by oFono, however we have not
tested all of the possible ones.  So assuming that you have installed
ofono.rules file correctly the only other problem might be that your
device manufacturer has named the port / network devices slightly
differently from other manufacturers.

See plugins/udev.c add_mbm() for more details.  I see that we definitely
do not cover the "Broadband Network Device" case that your modem is
reporting.

Running ofono with -n -d 'udev*' command line options should help you
quickly diagnose the issue.

Regards,
-Denis

--===============1066744036349751440==--

