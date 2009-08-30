Content-Type: multipart/mixed; boundary="===============5634396856379221568=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: driver callback naming
Date: Sun, 30 Aug 2009 15:10:55 -0500
Message-ID: <200908301510.56094.denkenz@gmail.com>
In-Reply-To: <20090830160026.75672609@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5634396856379221568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> > > Of course, I'm also wondering why there needs to be two separate
> > > layers of calls in the first place.  Why not have drivers register
> > > everything from within probe, call ofono_set_powered(modem, TRUE)
> > > once the device is ready, and be done with it?
> >
> > The reason for this is e.g. airplane mode, where you physically want
> > to turn off the device.  Another case is for battery / power reasons,
> > e.g. a netbook with a USB modem that is not being used.
>
> Fair enough.  In the kernel, we have callbacks named suspend/resume
> to handle that.

Power down is different from suspend / resume though.  Suspend implies a =

different usecase, particularly on embedded devices.  In fact, I'm already =

considering adding suspend and resume to the driver API...

> My criticism is simply w/ the naming.  'enable'/'disable' doesn't imply
> anything about power.  powerup/powerdown, poweron/poweroff,
> suspend/resume would all imply power state changes (at least the latter
> would be familiar to those who do kernel stuff).  Having comments that
> describe what the callbacks do would also work, though.
>

Fair enough.

Regards,
-Denis

--===============5634396856379221568==--

