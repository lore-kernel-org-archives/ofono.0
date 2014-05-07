Content-Type: multipart/mixed; boundary="===============3533774187511982680=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] he910: set modem unpowered after IO disconnect
Date: Wed, 07 May 2014 08:29:41 +0200
Message-ID: <5369D2D5.20705@southpole.se>
In-Reply-To: <5368E5DC.1040409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3533774187511982680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 05/06/2014 03:38 PM, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 05/02/2014 09:15 AM, Jonas Bonn wrote:
>> This patch address an issue with SIM hotplug.  If the SIM card is removed
>> while there is an active connection then the io_disconnect function
>> of gatchat.c pulls the rug out from under us by cleaning up the modem
>> chat that we hold a reference to.
> =

> So what actually happens when the SIM is pulled?  This seems to imply
> that the modem port at least sends a HUP and is no longer usable.  Is
> the control port also HUPed?

The control port is still usable so it doesn't appear that it HUP's.

> =

>>
>> This patch addresses this by hooking into the notification from
>> io_disconnect and setting the modem to 'unpowered' state in order to for=
ce
>> a reinitialization when the SIM is reinserted.
>>
>> The modem is not actually powered off as that would turn off SIM detecti=
on
>> as well.
> =

> Are you able to at least turn off radio circuits, e.g. via CFUN=3D4?

As the control port is usable, I presume so.  Setting CFUN=3D4 kills power
to the SIM, though, so we wouldn't be able to detect SIM reinsertion if
we did this (though I don't think that's what you're asking for).

> =

>>
>> With this patch, SIM hotplug works reliably.
> =

> When the modem is turned off, the application really has no idea why it
> was turned off (whether due to an administrative action or due to SIM
> being removed).   So the proposed patch is not a good implementation of
> 'SIM hotplug'.  One should implement this via
> ofono_sim_inserted_notify().  Any reason why this can't be done?

I'm not sure that's sufficient...

When the modem port HUP's, io_disconnect is called which results in
modem->chat being cleaned up; not unref'd, either, but forcibly free'd.
 Somehow we need to be able to recreate this data structure, but since
it's created in the modem's init function it won't be unless we "power
down" the modem (or something along those lines).

Suggestions for a better way forward welcome...

/Jonas


> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============3533774187511982680==--

