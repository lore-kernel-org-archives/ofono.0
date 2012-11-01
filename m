Content-Type: multipart/mixed; boundary="===============8868100651966234460=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: Re: [PATCH] modem: Make it possible to identify the physical device
 of the modemy
Date: Thu, 01 Nov 2012 17:16:08 +0100
Message-ID: <20121101161608.GH26158@xiaoyu.lan>
In-Reply-To: <509245B1.5000804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8868100651966234460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 04:49:37AM -0500, Denis Kenzior wrote:
> Hi Holger,
 =

> I really do not think exposing the device name is a good idea.
> First of all, no normal application can make use of it anyway.  Once
> the modem is powered on oFono takes exclusive rights to it.
> Secondly, most USB sticks are actually multi-device groupings
> anyway, so this property really makes no sense.

the alternative would be to add the sysfs path directly but this
probably doesn't change your argument.

> =

> Why don't you simply assign a name to the modem using
> ofono_modem_set_name.  This can be done by assigning the name
> directly in the udev rule and having the necessary magic inside
> plugins/udev.c. The name can be anything you wish in that case.

I will have to take a look at this. I never wrote advanced udev
rules and I don't know how much sense it makes to put handling
for our product into plugins/udev.c.

h

--===============8868100651966234460==--

