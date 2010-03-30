Content-Type: multipart/mixed; boundary="===============8525131059528276285=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Mon, 29 Mar 2010 23:50:23 -0500
Message-ID: <201003292350.23783.denkenz@gmail.com>
In-Reply-To: <80fd4e751003300436i46cb721fv4b9c6e56113241a3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8525131059528276285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> That is also a problem. The other problem is that the party
> controlling the modem power state is supposed to keep GPIO lines in
> known position for a while after the modem has indicated it has been
> powered down. In an N900 running maemo, a daemon called sscd does
> that. sscd exits only after modem has been safely powered down during
> reboot and shutdown. If ofonod does the controlling, it should hang
> around after power off for a while, too.

So I'm still having trouble understanding the issue.  When oFono calls =

disable, the driver is expected to take all necessary steps to disable the =

modem.  If that means waiting N seconds after the command has been sent, so=
 be =

it.  During shutdown of the daemon, oFonod waits for a grace period and wai=
ts =

on any devices that are being shut down.  In effect it "hangs around" after =

power off.

If I'm still on the wrong track, someone please explain it to me better.

> =

> Another solution is to use sscd-like daemon also with ofono (the oFono
> Powered property would then just follow the power state of the modem).

Automatic powerup is actually possible from the driver.  See HFP driver for =

details.

> > We reply with the busy error, you're correct.  However, I don't really
> > see anything better we can do here, do you have any suggestions?
> =

> Keep the target state around somewhere, or call enable/disable
> regardless of the current state of the Powered property?
> =


Note that oFono does not record the powered preferences, ConnMan is =

responsible for that.

Sending a disable when we are already disabled would be wrong and would bre=
ak =

some plugins.

And I'm still having trouble understanding why you want this.  Please give =

concrete use-cases.

Regards,
-Denis

--===============8525131059528276285==--

