Content-Type: multipart/mixed; boundary="===============4522664416666388750=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Mon, 23 Nov 2009 09:14:46 +0100
Message-ID: <1258964086.2993.20.camel@violet>
In-Reply-To: <359c5480911220638u422e7c09scabfdeb175fd494f@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4522664416666388750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

> >>The forth and worring is that a developer may be forced to use
> >>ofono, as the target device has some closed parts necessary for the os
> >>that does not work anymore if you remove ofono and use FSO.
> >
> > Please do not post these crazy conspiracy theories here.  oFono is GPLe=
d for
> > exactly this reason.
> =

> May you elaborate about that? May not a close source project use oFono
> by calling it's DBus API?

see my other email I wrote to explain it a little bit more. Yes, you can
write an UI and keep it closed source. This is on purpose.

However the D-Bus API is designed in a way that your UI is simple to
begin with since we moved all the logic into the daemon. This is the big
difference to the FSO GSM part. oFono does the heavy and complex work
and all that is 100% GPL. Exactly how it should be.

Regards

Marcel



--===============4522664416666388750==--

