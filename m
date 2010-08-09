Content-Type: multipart/mixed; boundary="===============7985191263393944620=="
MIME-Version: 1.0
From: Leaf John <leafjohn@gmail.com>
Subject: Re: [PATCH] add default property setter for modemconf
Date: Mon, 09 Aug 2010 21:19:12 +0800
Message-ID: <AANLkTikACCyFboLAXubGHLGUYP656okw65LowfMwqQXc@mail.gmail.com>
In-Reply-To: <1281344299.12579.196.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7985191263393944620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 9, 2010 at 4:58 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> a gentle reminder that this mailing list has a NO top posting policy.
> Like many open source mailing lists.
>

Sorry for that, I haven't read the convention of this community.


> For the N900 you can use ISI plugin. Using AT commands is a pretty bad
> idea with the N900 actually.
>
> And why should MeeGo be different than any other distro. That sounds
> more like a udev ofono.rules bug than an actual issue. I think that we
> fixed all of these issues in the latest oFono release. So you should
> update and then this patch seems to be not needed anymore.
>

My company network was down during this morning. so I missed a
week-ends' update. :-) .

However, in the N900 case,  I don't think this is a bug of ofono. When
plugged N900 to a opensuse system, there will be two network interface
usb0 and usbpn0, and from the source code I know the isi plugin will
use usbpnx ( x is specify by the Interface property of modem) net
interface to communicate with the phone. But in meego there is only
usb0 interface that isi driver simply ignored.

I'll try to update the meego udev-rules packages tommorrow and see
whether it works. Thank you for your time.



-- =

Best Reagres,
Leaf Johnson<leafjohn@gmail.com>

--===============7985191263393944620==--

