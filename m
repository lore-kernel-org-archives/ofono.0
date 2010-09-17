Content-Type: multipart/mixed; boundary="===============7348835508774137219=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Fri, 17 Sep 2010 10:18:11 +0900
Message-ID: <1284686291.2405.176.camel@localhost.localdomain>
In-Reply-To: <53bb2abc324cd8002bbeaab6db1164e1@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7348835508774137219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> >> >> That is the goal if and when we have up-to-date kernel, but
> >> >> we are not there yet.
> >> >
> >> > I don't see the point of adding temporary cruft to the main oFono
> >> > repository then.
> >>
> >> Well, I see value in having oFono upstream work as-is with the current
> >> MeeGo kernel. The plugin could of course reside somewhere else, but
> >> that is just adding extra work for packagers. And it's not like we
> >> can't fix the plugin once MeeGo has a proper kernel in place.
> > =

> > what is the current state of Phonet support (including N900) and the
> > current MeeGo kernel? Are we missing patches?
> =

> I did not fully grasp what the extra Netlink code does. There should be no
> need to CONFIGURE the Phonet stack via Netlink. If there is, then it's a
> kernel bug.

you are the expert here and have to give us some guideline on how we
should use Phonet the right way. If you say that we should remove the
netlink code from oFono, I am all for it.

Regards

Marcel



--===============7348835508774137219==--

