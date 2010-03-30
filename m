Content-Type: multipart/mixed; boundary="===============4293104294686176631=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 18:34:34 +0300
Message-ID: <80fd4e751003300834t57552977r2355e01810ff8964@mail.gmail.com>
In-Reply-To: <201003292350.23783.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4293104294686176631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/3/30 Denis Kenzior <denkenz@gmail.com>:
>> That is also a problem. The other problem is that the party
>> controlling the modem power state is supposed to keep GPIO lines in
>> known position for a while after the modem has indicated it has been
>> powered down. In an N900 running maemo, a daemon called sscd does
>> that. sscd exits only after modem has been safely powered down during
>> reboot and shutdown. If ofonod does the controlling, it should hang
>> around after power off for a while, too.
>
> So I'm still having trouble understanding the issue. =C2=A0When oFono cal=
ls
> disable, the driver is expected to take all necessary steps to disable the
> modem. =C2=A0If that means waiting N seconds after the command has been s=
ent, so be
> it. =C2=A0During shutdown of the daemon, oFonod waits for a grace period =
and waits
> on any devices that are being shut down. =C2=A0In effect it "hangs around=
" after
> power off.

>> Another solution is to use sscd-like daemon also with ofono (the oFono
>> Powered property would then just follow the power state of the modem).
>
> Automatic powerup is actually possible from the driver. =C2=A0See HFP dri=
ver for
> details.
>
>> > We reply with the busy error, you're correct. =C2=A0However, I don't r=
eally
>> > see anything better we can do here, do you have any suggestions?
>>
>> Keep the target state around somewhere, or call enable/disable
>> regardless of the current state of the Powered property?
>>
>
> Note that oFono does not record the powered preferences, ConnMan is
> responsible for that.
>
> Sending a disable when we are already disabled would be wrong and would b=
reak
> some plugins.
>
> And I'm still having trouble understanding why you want this. =C2=A0Pleas=
e give
> concrete use-cases.

Sure.

I want Powered-1 that controls the atoms. Atoms should be loaded when
modem is in responsive state and removed when, e.g., modem reboots.
This we can do now, iow, if you connect a Nokia phone via USB, oFono
can follow its state via the MTC indications it sends on top of the
phonet link running over USB.

I want Powered-2 that controls the modem power. When ofonod starts in
N900, it should power up the internal modem. When ofonod terminates
itself, it should shut down modem nicely before calling exit().

Now, enable/disable/ofono_modem_set_powered() controls both aspects; I
want to separate them. It is also possible to implement Powered-2 in
the probe/remove methods; however, they are quite time-consuming
operations and best done from the mainloop.

It seems to me that Marcel thinks "Powered" should control the RF
state, too. So, a separate property for enabling he RF would be nice,
too.

-- =

Pekka.Pessi mail at nokia.com

--===============4293104294686176631==--

