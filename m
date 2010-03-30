Content-Type: multipart/mixed; boundary="===============3055035449847278074=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 19:40:22 +0300
Message-ID: <80fd4e751003300940m1a6d9005se0de6e0de03f6e49@mail.gmail.com>
In-Reply-To: <1269963903.11714.254.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3055035449847278074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/30 Marcel Holtmann <marcel@holtmann.org>:
>> > So I'm still having trouble understanding the issue. =C2=A0When oFono =
calls
>> > disable, the driver is expected to take all necessary steps to disable=
 the
>> > modem. =C2=A0If that means waiting N seconds after the command has bee=
n sent, so be
>> > it. =C2=A0During shutdown of the daemon, oFonod waits for a grace peri=
od and waits
>> > on any devices that are being shut down. =C2=A0In effect it "hangs aro=
und" after
>> > power off.
>>
>> >> Another solution is to use sscd-like daemon also with ofono (the oFono
>> >> Powered property would then just follow the power state of the modem).
>> >
>> > Automatic powerup is actually possible from the driver. =C2=A0See HFP =
driver for
>> > details.
>> >
>> >> > We reply with the busy error, you're correct. =C2=A0However, I don'=
t really
>> >> > see anything better we can do here, do you have any suggestions?
>> >>
>> >> Keep the target state around somewhere, or call enable/disable
>> >> regardless of the current state of the Powered property?
>> >>
>> >
>> > Note that oFono does not record the powered preferences, ConnMan is
>> > responsible for that.
>> >
>> > Sending a disable when we are already disabled would be wrong and woul=
d break
>> > some plugins.
>> >
>> > And I'm still having trouble understanding why you want this. =C2=A0Pl=
ease give
>> > concrete use-cases.
>>
>> Sure.
>>
>> I want Powered-1 that controls the atoms. Atoms should be loaded when
>> modem is in responsive state and removed when, e.g., modem reboots.
>> This we can do now, iow, if you connect a Nokia phone via USB, oFono
>> can follow its state via the MTC indications it sends on top of the
>> phonet link running over USB.
>>
>> I want Powered-2 that controls the modem power. When ofonod starts in
>> N900, it should power up the internal modem. When ofonod terminates
>> itself, it should shut down modem nicely before calling exit().
>>
>> Now, enable/disable/ofono_modem_set_powered() controls both aspects; I
>> want to separate them. It is also possible to implement Powered-2 in
>> the probe/remove methods; however, they are quite time-consuming
>> operations and best done from the mainloop.
>
> I am with Denis here. I am missing the point in what you are trying to
> achieve. The complexity you propose should not be exposed to the
> applications at all. This can be all handled internally. Or I am missing
> something essential, but right now, I don't see it.

I'm trying to
1) load atoms only after when isimodem is up and running and reset the
state of the isimodem atoms in case the isimodem reboots (or user
turns off a Nokia handset connected via USB)
2) have asyncronous probe and remove
3) separate rf state and availablity of the atoms, especially the SIM atoms.

With the current enable/disable/ofono_modem_set_powered, I can do 1)
or 2), but not both. I can not do 3 at all.

>> It seems to me that Marcel thinks "Powered" should control the RF
>> state, too. So, a separate property for enabling he RF would be nice,
>> too.
>
> That is what I call RFKILL and we have a proper subsystem for that.

Huh? How do you plan to rfkill a modem behind serial line (over
bluetooth? over USB? over SSI?)? Should we add a kernel driver for all
the modems? How do you plan to solve the interaction between ofonod at
commands and the rfkill driver?

Phonet is just a glorified serial line with binary protocol. Kernel
drivers do not care what is at the other end of that serial line.
There are gpio lines to wake up the thing at the end of serial line;
gpio lines have their own kernel driver. That is all we need from
kernel.

-- =

Pekka.Pessi mail at nokia.com

--===============3055035449847278074==--

