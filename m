Content-Type: multipart/mixed; boundary="===============8193684786848696882=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Startup sequence for Online / offline mode
Date: Thu, 12 Aug 2010 14:06:52 -0400
Message-ID: <1281636412.12579.289.camel@localhost.localdomain>
In-Reply-To: <4C643159.7070409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8193684786848696882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > Modem drivers that support Online / offline mode default to offline when
> > oFono loads them. Which component is responsible for calling oFono and
> > switch the modem to online mode? Will that component be part of MeeGo?
> =

> This feature is still highly experimental and not all of the details
> have been figured out (only ISI supports it today).
> =

> Our current thinking is to have ConnMan manage the Online state of the
> GSM modems (e.g. replace Powered handling with Online handling.)
> However, we're still pretty far from that; we'd need to migrate all
> existing modem drivers to manage Online/Offline state properly first.

I agree with Denis here. The Online state needs to be controlled by
ConnMan, but we haven't done that change yet. It would break current
users since we haven't migrated all modems to handle Online state
properly or emulate it if needed.

Regards

Marcel



--===============8193684786848696882==--

