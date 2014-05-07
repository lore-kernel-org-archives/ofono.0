Content-Type: multipart/mixed; boundary="===============1943538655230848641=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] he910: set modem unpowered after IO disconnect
Date: Wed, 07 May 2014 11:03:54 -0500
Message-ID: <536A596A.50407@gmail.com>
In-Reply-To: <5369D2D5.20705@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1943538655230848641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

<snip>

>
> The control port is still usable so it doesn't appear that it HUP's.

Hah, so why would they HUP the modem port instead of sending a NO CARRIER.

> As the control port is usable, I presume so.  Setting CFUN=3D4 kills power
> to the SIM, though, so we wouldn't be able to detect SIM reinsertion if
> we did this (though I don't think that's what you're asking for).

Yes, I know.  But you're turning the device off.  Hence why I asked.

By the way, the newer HE910 firmware does not turn off the SIM card when
CFUN=3D4 is issued.

>> When the modem is turned off, the application really has no idea why it
>> was turned off (whether due to an administrative action or due to SIM
>> being removed).   So the proposed patch is not a good implementation of
>> 'SIM hotplug'.  One should implement this via
>> ofono_sim_inserted_notify().  Any reason why this can't be done?
> =

> I'm not sure that's sufficient...
> =

> When the modem port HUP's, io_disconnect is called which results in
> modem->chat being cleaned up; not unref'd, either, but forcibly free'd.

Well it is not forcibly freed.  Just the internal state is.  This is why
the disconnect callback is provided.

>  Somehow we need to be able to recreate this data structure, but since
> it's created in the modem's init function it won't be unless we "power
> down" the modem (or something along those lines).

You would need to re-create the affected atoms.  In this case this would
be the gprs-context atom.

> =

> Suggestions for a better way forward welcome...
> =


Is SIM hotswap actually supported by this hardware?  The only HE910
samples I have are miniPCI Express cards.  For those it is unlikely that
a hotswap function is even possible.  Are you getting proper QSS
notifications on the control port when the SIM is removed / inserted?

Regards,
-Denis


--===============1943538655230848641==--

