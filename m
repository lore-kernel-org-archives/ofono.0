Content-Type: multipart/mixed; boundary="===============8833762501702669932=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] add default property setter for modemconf
Date: Mon, 09 Aug 2010 04:58:19 -0400
Message-ID: <1281344299.12579.196.camel@localhost.localdomain>
In-Reply-To: <AANLkTimGZLPZfUcecYk0ZJPiXJi3jG5-LfZO_UYfh3gc@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8833762501702669932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leaf,

a gentle reminder that this mailing list has a NO top posting policy.
Like many open source mailing lists.

> On common linux distros, suse, ubuntu, fedora.., ofono do auto-detect wel=
l,
> However, on my meego netbook, ofono won't auto detect any devices.
> That is the reason why i do this.
> =

> For N900, we could use as an atgen modem
> for Huawei, we can use it with current modemconf system.
> so this patch becomes as the only way for me to use huawei stick on the n=
etbook.

For the N900 you can use ISI plugin. Using AT commands is a pretty bad
idea with the N900 actually.

And why should MeeGo be different than any other distro. That sounds
more like a udev ofono.rules bug than an actual issue. I think that we
fixed all of these issues in the latest oFono release. So you should
update and then this patch seems to be not needed anymore.

Regards

Marcel



--===============8833762501702669932==--

