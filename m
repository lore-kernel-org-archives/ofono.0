Content-Type: multipart/mixed; boundary="===============8492916046768410629=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] he910: reset modem after IO disconnect
Date: Thu, 08 May 2014 09:06:29 -0500
Message-ID: <536B8F65.7010903@gmail.com>
In-Reply-To: <536B2709.7040200@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8492916046768410629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>>
>>>  Somehow we need to be able to recreate this data structure, but since
>>> it's created in the modem's init function it won't be unless we "power
>>> down" the modem (or something along those lines).
>>
>> You would need to re-create the affected atoms.  In this case this would
>> be the gprs-context atom.
> =

> The gprs-context is created in post_online... we require functioning
> communication to the modem to get that far.

So here's the thing, when you pull the SIM and call
ofono_sim_inserted_notify(modem, FALSE) all post_sim and post_online
atoms get destroyed.  So everything would be re-created anyway once you
reach post_sim/post_online state again.  So in theory, the only thing
you need to take care of is re-open the modem chat port and re-set the
slave.

> =

> When the modem or aux port HUP's, io_disconnect cleans up the at_chat
> and chat structures associated with it.  This means that the
> command_queue disappears and no more commands can be sent to the modem
> via that chat (which we still reference).  We can hook into
> user_disconenct to find out that the chat has been cleaned up and drop
> our references, but we need to get the modem back on its feet again by
> reopening the modem and aux ports and redoing the modem initialization.
> =


So I'm confused, you said that the aux port is not HUPed.  If that is
the case, then the AUX queue (which is used by every atom except
gprs-context) is not cleared.  Essentially you need to issue an
ofono_sim_inserted_notify(modem, FALSE) and re-create the modem chat.
After that things should just work.

> SIM hotswap is definitely supported by this hardware.

Okay, cool.  That is good to know.

Regards,
-Denis

--===============8492916046768410629==--

