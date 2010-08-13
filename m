Content-Type: multipart/mixed; boundary="===============8972298593142827864=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Removal of modemconf plugin
Date: Fri, 13 Aug 2010 11:06:40 +0300
Message-ID: <87r5i35433.fsf@potku.valot.fi>
In-Reply-To: <1281625211.12579.279.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8972298593142827864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann <marcel@holtmann.org> writes:

> Using special udev rules for special devices (in conjunction with the
> oFono auto-detection rule) make the process of setting up oFono for the
> system integrator a lot simpler. No manual configuration file patching
> anymore. Just installation of an additional udev rule.
>
> The open here is the ISI modem detection, but this should be clearly
> done via a Phonet plugin. And also the N900 specific case inside
> modemconf is just wrong. This needs to be fixed and just auto-detected
> via Phonet or maybe just via RTNL directly.

What about old style serial port modems? How can we configure them if
you remove modemconf?

-- =

Kalle Valo

--===============8972298593142827864==--

