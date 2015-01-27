Content-Type: multipart/mixed; boundary="===============4374204193064369451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Serial modem and oFono
Date: Tue, 27 Jan 2015 10:03:33 -0600
Message-ID: <54C7B6D5.1020705@gmail.com>
In-Reply-To: <CAH4ZQwuFxBMfja6PMLBUG12Rnso8=DnRSV-S=Z8B9_dpfee8gw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4374204193064369451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 01/27/2015 01:28 AM, Enrico Sau wrote:
> Hi all,
> I'm now working with a serial device, which doesn't trigger udev events
> when connected. It simply works with ttyS0 device.
> First question is if there is any way for oFono to recognize this modem,
> but I believe that the answer will be: yes, if you trigger an udev event.

Sort of.  Just add a static udev rule to your system.  For an example, =

see doc/sim900-modem.txt or doc/calypso-modem.txt

> Ok, so, second question, is there any way to add a modem to oFono
> without going through udev plugin?

Sure, just make a plugin that adds the modem manually.  Won't be very =

useful to anyone else though.

Regards,
-Denis

--===============4374204193064369451==--

