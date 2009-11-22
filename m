Content-Type: multipart/mixed; boundary="===============4051145476217343074=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Sun, 22 Nov 2009 15:24:03 +0100
Message-ID: <1258899843.8454.23.camel@localhost.localdomain>
In-Reply-To: <200911200708.31068.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4051145476217343074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

> >The forth and worring is that a developer may be forced to use
> >ofono, as the target device has some closed parts necessary for the os
> >that does not work anymore if you remove ofono and use FSO.
> =

> Please do not post these crazy conspiracy theories here.  oFono is GPLed =
for =

> exactly this reason.

let me point this out once again. oFono is 100% GPL source code and this
means that all plugins, drivers or extensions have to be released under
GPL. This was our first and important item when creating oFono. We want
a full open source telephony stack. No binary code running inside the
daemon ever.

Seems like everybody assumes that a GSM telephony system needs to have
closed source components, but on the host CPU, we disagree with this and
strongly enforce open source.

We only draw the line with the UI elements like dialer etc. These are
components that involve branding, customization and differentiation of
products and since they talk via D-Bus they can be closed source. And to
keep the complexity in the UI components minimal we handle all the
details in the daemon.

Regards

Marcel



--===============4051145476217343074==--

