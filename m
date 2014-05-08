Content-Type: multipart/mixed; boundary="===============2328177968721361971=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v2 1/1] he910: reset modem after IO disconnect
Date: Thu, 08 May 2014 08:41:13 +0200
Message-ID: <536B2709.7040200@southpole.se>
In-Reply-To: <536A5F13.3080405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2328177968721361971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

(Merging your two responses into one here...)

On 05/07/2014 06:03 PM, Denis Kenzior wrote:> Hi Jonas,
>
> <snip>
>
>>
>> The control port is still usable so it doesn't appear that it HUP's.
>
> Hah, so why would they HUP the modem port instead of sending a NO CARRIER.

That I can't tell you... but nothing with this modem surprises me
anymore! :)

>
> By the way, the newer HE910 firmware does not turn off the SIM card when
> CFUN=3D4 is issued.

Interesting...  I'll need to try to get some updated documentation from
Telit then.


>
>>  Somehow we need to be able to recreate this data structure, but since
>> it's created in the modem's init function it won't be unless we "power
>> down" the modem (or something along those lines).
>
> You would need to re-create the affected atoms.  In this case this would
> be the gprs-context atom.

The gprs-context is created in post_online... we require functioning
communication to the modem to get that far.

When the modem or aux port HUP's, io_disconnect cleans up the at_chat
and chat structures associated with it.  This means that the
command_queue disappears and no more commands can be sent to the modem
via that chat (which we still reference).  We can hook into
user_disconenct to find out that the chat has been cleaned up and drop
our references, but we need to get the modem back on its feet again by
reopening the modem and aux ports and redoing the modem initialization.

>
>>
>> Suggestions for a better way forward welcome...
>>
>
> Is SIM hotswap actually supported by this hardware?  The only HE910
> samples I have are miniPCI Express cards.  For those it is unlikely that
> a hotswap function is even possible.  Are you getting proper QSS
> notifications on the control port when the SIM is removed / inserted?

SIM hotswap is definitely supported by this hardware.

QSS notifications work perfectly and ofono_simi_inserted_notify is
invoked properly via the switch_sim_status function.  The modem I have
is BGA-type soldered onto board and SIM holder pops out through unit's
case to allow for easy SIM swap.

And SIM hotswap works fine with the patches I have sent... even if
thoses patches maybe aren't 100% correct.  But I'm not really sure what
100% correct would be for this case since we're essentially trying to
work around a modem quirk (bug?) in that it HUP's occasionally.  That's
where I need your help! :)

On 05/07/2014 06:28 PM, Denis Kenzior wrote:
> Hi Jonas,
> =

> <snip>
>>
>> This patch also addresses a secondary issue whereby killing ofono during
>> an active connection causes the AUX port to report HUP when ofono is
>> restarted.
>>
> =

> I'm not quite sure how this patch would fix the above.  The order of
> events is the same between kill/restart and a modem reset.  I guess the
> only difference is that you don't send a CFUN=3D4 during a modem reset.
> =


I think it might be related to the fact that the modem (according to
documentation) requires that 10 seconds elapse between transitions from
CFUN 1 to 4 and vice versa.  Restarting ofono presumably is quicker than
this and results in a CFUN  1 - > 4 -> 1 transition that is too fast and
the AUX port HUP's as a result.  Simply retrying the initialization (as
the modem_reset patch does) gets us around this.

(I haven't really checked, but maybe the AUX port doesn't HUP if we wait
a bit before restarting ofono).

>> How about this approach instead?  Using ofono_modem_reset has pretty
>> much the same effect as my previous patch and _feels" correct...
> =

> ofono_modem_reset is intended for firmware crashes and getting back to
> previous state quickly.  This is a creative hack, but has some
> side-effects you might not intend (e.g. the modem might go online
> without being told explicitly)
> =

> I don't really mind the patch, but would explore the 'proper' avenues
> (e.g. ofono_sim_inserted_notify) first.

Like I said above, this is in place and works in the unpatched code.
The issue at hand is that the modem HUP's: the modem port when the SIM
card is pulled and the aux port when ofono is restarted.

Maybe this issue goes away with a firmware update... will need to look
into that, too.

/Jonas

--===============2328177968721361971==--

