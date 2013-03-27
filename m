Content-Type: multipart/mixed; boundary="===============0907496477393012984=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Wed, 27 Mar 2013 09:36:11 -0500
Message-ID: <515303DB.7020105@gmail.com>
In-Reply-To: <CAAs3wMg0g-tjeO-3fohQFmvuvN4r=qnk78bGni1QeOEx8B3h5Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0907496477393012984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

<snip>

>             2) in enable fnc the modem is powered but The sim is not
>             ready so
>             sometimes It hangs up...Do I have to to poll the sim status
>             until is
>             ready  , or the driver will do  that by itself ?
>
>
>         oFono never polls for anything.  It is the driver's
>         responsibility to do that in the best possible way for the
>         hardware.  Also, powering on the modem is separate from the sim
>         being ready.  The general flow is this:
>
>         -Enable modem
>         -Wait for the modem to power on and use ofono_modem_set_powered
>         when that happens successfully / fails.
>         - Figure out if the SIM is inserted and signal using
>         ofono_sim_inserted_notify.  Do this step only once the SIM is
>         ready to be queried for its PIN status and perform any I/O on
>         SIM files that are always accessible (e.g. ICCID)
>
>
> Ok. If Sim not "ready" , sending a signal prematurely could stuck anyhow
> the stack ? 'cause it should explain a lot of thing..
>

If you tell oFono core that the sim is inserted, the first thing it does =

is read some sim files that are always available.  e.g. ICCID, etc. =

Then it proceeds to check the PIN.  If the PIN query fails due to a sim =

busy condition, then yes the init process will stall.  This is =

considered a bug in the driver.

>
>
>             3) could u explain me what should I really do in virtual fnc
>               set_online
>             / post_online ? i tried to stub them but they have not never
>             been called...
>
>
>         oFono has 3 basic states:
>         - Off
>         - Radio Off, Sim On
>         - Radio On, Sim On
>
>         set_online turns radio on / off
>         post_online populates the atoms that are available in radio 'On'
>         state.
>
>
> This is what i thought but I do not understand why I don't see the trace
> log I put inside them...usually are called before pre_sim fn? are
> related to any signal i have to manage/post ?

enable -> pre_sim, sim_inserted -> post_sim, set_online -> post_online. =

  Generally you do not call set_online before hitting the post_sim state.

<snip>

>
> I've managing vendor URC for sim detection right now but i have
> problems.For instance if I remove it when ofonod is ready the Hilonc
> sends an URC to notify sim status changed but after that it reboots
> itself(2 sec later)... what i did is to notify the stack that the SIM
> has been removed and modem is powered off . I thought that after calling
> set_powered fnc the stack should have called my driver virtual disable
> function in order to properly close the MUX .. but it's not..

No, if you call ofono_modem_set_powered(modem, FALSE) it assumes that =

the modem powered off due to an internally generated event (e.g. not =

oFono's doing).  The driver has to clean up properly in this case.  The =

driver disable() method is only called on oFono initiated power down =

requests.

>
>
>             5) I created and started the MUX as the first thing in
>             enable fnc but is
>             that right ? sometimes seems that the modem hangs up if just
>             powered up.
>             Put a delay but don't like it very much as a
>             solution...moreover when I
>             power up the modem all the URC have been lost 'cause the MUX
>             has not
>             been created yet..
>
>
>         That is what we do for most devices with a MUX, put it into MUX
>         state right away after basic initialization.  The devices we
>         have can be queried for their state in addition to URCs, so it
>         works out very well.
>
> right now i've been using custom URC in the first power up phase to
> understand modem status. I manually set them but theoretically I should
> check the values saved on the modem every power cycle. What I was
> thinking was to test every time the values saved and enabling them if
> they were not .After that I should call an AT+cfun=3D1,1 in order to reset
> the modem and force it to send me again the needed URCs . What do u think=
 ?

I do not see anything wrong with that strategy.  Just keep in mind that =

querying things you will be resetting (potentially) anyway is likely a =

waste of time.  Only query things that are required for the =

initialization procedure.  For the rest, simply set the setting you want.

Regards,
-Denis

--===============0907496477393012984==--

