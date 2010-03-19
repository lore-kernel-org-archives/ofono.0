Content-Type: multipart/mixed; boundary="===============7176358874370193861=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 1/8][RFC] Add functions to notify core of SIM
 insertion/removal or request polling.
Date: Fri, 19 Mar 2010 12:41:07 +0100
Message-ID: <fb249edb1003190441h295cadd9t7a7b2b274d62ecbd@mail.gmail.com>
In-Reply-To: <201003171801.40175.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7176358874370193861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 18 March 2010 00:01, Denis Kenzior <denkenz@gmail.com> wrote:
>> Implement optional polling. =C2=A0Polling is mandatory according to the
>> specification but on most hardware it will me impractical because
>> there will be vendor specific unsolicited notifications that can be
>> used instead. =C2=A0Modem plugins need to handle them.
>> ---
>
> So I've been going back and forth on this one and my opinion is we should=
 not
> do the poll in the core. =C2=A0The modem has to do it anyway, so let the =
modem do
> it and tell us when it happens. =C2=A0Most vendors provide unsolicited no=
tifications
> for SIM Toolkit events anyway. =C2=A0Let us treat it the same way as voic=
ecalls.
> The standard does not define any unsolicited responses for call state
> notifications, yet in practice all modem vendors provide this.

I'm fine with that, but note that we will lose the ability to have STK
working out of the box on a AT compliant modem or emulator, this would
be useful even just during the early development.  The spec
specifically says the ME that supports STK needs to poll and with what
interval.

>
> Keep this code around and let us re-examine this decision if we ever need=
 to
> implement POLLING ON / POLLING OFF / POLLING INTERVAL commands. =C2=A0Bas=
ed on all
> the vendor specific docs I have these are intercepted by the modem and we=
 never
> see them anyway.
>
>> =C2=A0include/sim.h | =C2=A0 21 ++++++-
>> =C2=A0src/sim.c =C2=A0 =C2=A0 | =C2=A0197
>> =C2=A0++++++++++++++++++++++++++++++++++++++++++++++++++------- 2 files
> changed,
>> =C2=A0195 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/sim.h b/include/sim.h
>> index 6ff29f7..fdfe2e8 100644
>> --- a/include/sim.h
>> +++ b/include/sim.h
>> @@ -106,6 +106,8 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const str=
uct
>> =C2=A0ofono_error *error, typedef void (*ofono_sim_locked_cb_t)(const st=
ruct
>> =C2=A0ofono_error *error, int locked, void *data);
>>
>> +typedef void (*ofono_sim_cb_t)(const struct ofono_error *error, void
>> =C2=A0*data); +
>> =C2=A0struct ofono_sim_driver {
>> =C2=A0 =C2=A0 =C2=A0 const char *name;
>> =C2=A0 =C2=A0 =C2=A0 int (*probe)(struct ofono_sim *sim, unsigned int ve=
ndor, void *data);
>> @@ -152,6 +154,12 @@ struct ofono_sim_driver {
>> =C2=A0 =C2=A0 =C2=A0 void (*envelope)(struct ofono_sim *sim, int length,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const guint8 *command,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_read_cb_t cb, void *data);
>> + =C2=A0 =C2=A0 void (*status)(struct ofono_sim *sim, ofono_sim_cb_t cb,=
 void *data);
>> + =C2=A0 =C2=A0 void (*fetch)(struct ofono_sim *sim, int length,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_sim_read_cb_t cb, void *data);
>
> So three things here: First the STK details should be moved to a separate=
 atom
> since they are highly vendor specific.
>
> Second, why are we bothering with fetch, can't we simply use
> ofono_sim_proactive_command_notify to send us the apdu directly?

Yes, good idea.  Do we want to still call
ofono_sim_proactive_command_notify from atmodem/sim.c or will we just
count on modem driver to do that?

I noticed that we also need to cancel all commands already sent to
GAtChat when we conclude that STATUS timed out and am not sure where
to do this cancellation.

Regards

--===============7176358874370193861==--

