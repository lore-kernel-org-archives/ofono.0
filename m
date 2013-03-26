Content-Type: multipart/mixed; boundary="===============8145808216604705499=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Tue, 26 Mar 2013 09:25:54 -0500
Message-ID: <5151AFF2.6070501@gmail.com>
In-Reply-To: <CAAs3wMghwuHCe3WFDGUV4HnE6PjStC2a_EzU1L91TWzN41epvA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8145808216604705499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On 03/26/2013 04:07 AM, Freedreamer wrote:
> Hi Everybody,
>
> I'm developing a driver for an embedded system which uses a sagem HiloNC
> v2 and I really should need your help. It's my will to commit everything
> when shall be ready and working.
> First of all I will tell you what i did..I created a plugin sagem.c
> ,added a new Vendor ,  modified makefile & other stuff and seems to work
> properly. I started from calypso driver 'cause the modem is based on a
> Uart and I needed the MUX over that.
> With a very raw/dirty code I was able to use PPP/SMS/net service over
> virtual com.. Very good work dude! :)
>
> Now I would like to clean up my code and get a better understanding of
> the stack. Unfortunately I saw that functions/modules are not always
> commented so I have to ask u a lot of questions (maybe also trivial):
>
> 1) AT cmds sent with "g_at_chat_send" are always async , is that right ?
> Is there any chance to get them sync ?

There is not, we do not want to encourage any sort of blocking behavior =

in the daemon.  Remember there are potentially multiple modems being =

operated on and we do not use threads.

> 2) in enable fnc the modem is powered but The sim is not ready so
> sometimes It hangs up...Do I have to to poll the sim status until is
> ready  , or the driver will do  that by itself ?

oFono never polls for anything.  It is the driver's responsibility to do =

that in the best possible way for the hardware.  Also, powering on the =

modem is separate from the sim being ready.  The general flow is this:

-Enable modem
-Wait for the modem to power on and use ofono_modem_set_powered when =

that happens successfully / fails.
- Figure out if the SIM is inserted and signal using =

ofono_sim_inserted_notify.  Do this step only once the SIM is ready to =

be queried for its PIN status and perform any I/O on SIM files that are =

always accessible (e.g. ICCID)


> 3) could u explain me what should I really do in virtual fnc  set_online
> / post_online ? i tried to stub them but they have not never been called.=
..

oFono has 3 basic states:
- Off
- Radio Off, Sim On
- Radio On, Sim On

set_online turns radio on / off
post_online populates the atoms that are available in radio 'On' state.

> 4) unfortunately this modem has a SIM detection URC but it reset itself
> every time the status changes... so i should call the disable function
> and the enable again in order to have the MUX working... how can i do tha=
t?

I'm not following.  Care to elaborate?

> 5) I created and started the MUX as the first thing in enable fnc but is
> that right ? sometimes seems that the modem hangs up if just powered up.
> Put a delay but don't like it very much as a solution...moreover when I
> power up the modem all the URC have been lost 'cause the MUX has not
> been created yet..

That is what we do for most devices with a MUX, put it into MUX state =

right away after basic initialization.  The devices we have can be =

queried for their state in addition to URCs, so it works out very well.

Regards,
-Denis

--===============8145808216604705499==--

