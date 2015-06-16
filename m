Content-Type: multipart/mixed; boundary="===============3207184189299181333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono Digest, Vol 74, Issue 5
Date: Tue, 16 Jun 2015 11:53:33 -0500
Message-ID: <5580548D.2000900@gmail.com>
In-Reply-To: <557FDE36.3010000@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3207184189299181333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 06/16/2015 03:28 AM, Tommi Kenakkala wrote:
> On 12.06.2015 22:00, ofono-request(a)ofono.org wrote:
>> Date: Fri, 12 Jun 2015 11:01:42 -0500
>> From: Denis Kenzior<denkenz@gmail.com>
>> To:ofono(a)ofono.org
>> Subject: Re: SimManager properties and hotswap
>> Message-ID:<557B0266.8010707@gmail.com>
>> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
>>> >Problem1
>>> >If a client, for example triggered by the Present property change
>>> >signal, asks GetProperties during the time window then PinRequired &
>>> >LockedPins values are not updated yet.
>>> >
>> Then the client should simply wait for the relevant signal to arrive.
>> Either SubscriberIdentity or PinRequired.
> Thanks for the comments. What about LockedPins? Do you consider emitting
> it inappropriate?

Today LockedPins is emitted only as a result of locking or unlocking the =

PIN.  We can certainly look into emitting it when PinRequired is =

emitted.  Do you already have a patch for this handy?

>
>>> >Problem2
>>> >A client can't work around Problem1, it doesn't know when after a
>>> >hotswap PinRequired becomes available. sim_pin_query_cb checks
>>> >"sim->pin_type =3D pin_type" before emitting PinRequired changed signa=
l.
>>> >Works for boot when pin_type is 0 but not for card hotswap because
>>> >sim->pin_type is not reset, instead the old value is preserved.
>> Sounds like a bug.  Are you hot-swapping two PIN-locked SIMs?  Can you
>> share a log of what's happening?
> Sure, please see [1] & [2].
>
> [2]:
> Do correct me if there's a mistake, but sequence is as follows and there
> problem is
> async steps 2. and 3+4. complete independently.
> As a result to me it's not clear to which property or signalling clients
> should rely on.
> 1. ofono_sim_inserted_notify > emit "Present" > sim_initialize
> 2. sim_iccid_read_cb > emit "CardIdentifier"
> 3. sim_efpl_read_cb > __ofono_sim_recheck_pin
> 4. sim_pin_query_cb
>       > "PinRequired" emitted at startup but not on pin-enabled hotswaps

Yes, this sounds like a bug.  We should always emit PinRequired on =

pin-enabled hotswaps.

>       > "LockedPins" never emitted
>
> Whether this produces problems depends on timing.
>
>
>>> >One fix proposal to Problem2 is to reset pin_type to
>>> >OFONO_SIM_PASSWORD_INVALID in ofono_sim_inserted_notify when removed.
>>> >That requires skipping appending PinRequired in sim_get_properties()
>>> >if value is OFONO_SIM_PASSWORD_INVALID, otherwise
>>> >ofono_dbus_dict_append crashes because sim_passwd_name() didn't have a
>>> >value for OFONO_SIM_PASSWORD_INVALID.
>>> >(I would've put resetting to sim_free_main_state(), but that's called
>>> >when changing PIN fails due to wrong passwords and sim app switches
>>> >PUK lock (OFONO_SIM_STATE_LOCKED_OUT), it would reset the password
>>> >type already set as puk.)
>> Setting it to OFONO_SIM_PASSWORD_INVALID is definitely not the right way
>> to go.  But there might be other ways to take care of the problem.  Can
>> you share the logs of what is happening first?
> See [1] & [2].
> Ok, did you have alternatives already on your mind?
> OFONO_SIM_PASSWORD_INVALID was used because at startup it's the initial

Actually, it isn't.  OFONO_SIM_PASSWORD_NONE is the initial value.

> value before state is properly read from card. It seemed logical to
> "back up" into that state when card is removed and when looking at
> sim_pin_query_cb .
>

So setting it to OFONO_SIM_PASSWORD_NONE is where I would start...

>>> >Problem3
>>> >Similar for LockedPins, but there reason is sim_pin_query_cb() doesn't
>>> >emit property change all.
>>> >Fix proposal to Problem3 is to emit a change signal sim_pin_query_cb()
>>> >if "sim->locked_pins[pin_type]" wasn't already TRUE.
>>> >
>>> >Please let me know your comments and improvement ideas. I can submit
>>> >patches if you're interested.
>>> >
>> Regards,
>> -Denis
>
>
> [1]:
> Logs about use-case: remove & insert a pin-required usim card.
> - Same results if same or different pin-enabled card is inserted back.
> - Driver implementation waits until password state is available and only
> then notifies ofono core via ofono_sim_inserted_notify.
> There's an additional __ofono_sim_recheck_pin call seen here after
> ofono_sim_inserted_notify from driver to core trigger a password query.
> Now when I look at it I'm not sure if it's still needed, but
> nevertheless even if it's removed monitor-ofono does not show
> "LockedPins" or "PinRequired" being emitted
> (logs and code analysis confirm that).
>
> - monitor-ofono output:
> {SimManager} [/ril_0] Present =3D False
> {VoiceCallManager} [/ril_0] EmergencyNumbers =3D 08 000 999 110 112 911
> 118 119
>
> {SimManager} [/ril_0] Present =3D True
> {VoiceCallManager} [/ril_0] EmergencyNumbers =3D 110 08 112 999 911 000
> {SimManager} [/ril_0] CardIdentifier =3D <...>
> {SimManager} [/ril_0] PreferredLanguages =3D fi sv en
>
> {SimManager} [/ril_0] Present =3D False
> {VoiceCallManager} [/ril_0] EmergencyNumbers =3D 08 000 999 110 112 911
> 118 119
>
> {SimManager} [/ril_0] Present =3D True
> {VoiceCallManager} [/ril_0] EmergencyNumbers =3D 110 08 112 999 911 000
> {SimManager} [/ril_0] CardIdentifier =3D <...>
> {SimManager} [/ril_0] PreferredLanguages =3D fi sv en
>
> - Truncated ofono src/sim.c output, including some custom log prints:
> oFono version 1.16
> ...
> src/modem.c:modem_change_state() old state: 0, new state: 1
> src/sim.c:ofono_sim_add_state_watch() 0xdae2a0
> src/sim.c:ofono_sim_add_state_watch() 0xdae2a0
> src/sim.c:ofono_sim_inserted_notify() inserted: 1, sim->state: 0
> src/sim.c:sim_initialize()
> src/sim.c:__ofono_sim_recheck_pin()

??? This seems wrong.  Are you running upstream?  We should not be =

querying the PIN until after we read EFpl

> src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 1
> src/sim.c:sim_pin_query_cb() Here could add emit  "LockedPins" changed
> src/sim.c:sim_pin_query_cb() Emitting PinRequired property changed
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
> src/sim.c:sim_efpl_read_cb()
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change, not
> emitting PinRequired
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
> src/sim.c:ofono_sim_add_state_watch() 0xdae2a0
> Requested file structure differs from SIM: 6fb7
>
> src/sim.c:ofono_sim_inserted_notify() inserted: 0, sim->state: 1
> src/modem.c:modem_change_state() old state: 1, new state: 1
> src/sim.c:ofono_sim_inserted_notify() Here one could reset sim->pin_type
> src/sim.c:sim_free_early_state()
> src/sim.c:sim_free_main_state()
>
> src/sim.c:ofono_sim_inserted_notify() inserted: 1, sim->state: 0
> src/sim.c:sim_initialize()
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
> Requested file structure differs from SIM: 6fb7
> src/sim.c:ofono_sim_inserted_notify() inserted: 1, sim->state: 1
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
> src/sim.c:sim_efpl_read_cb()
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
>
> src/sim.c:ofono_sim_inserted_notify() inserted: 0, sim->state: 1
> src/modem.c:modem_change_state() old state: 1, new state: 1
> src/sim.c:ofono_sim_inserted_notify() Here one could reset sim->pin_type
> src/sim.c:sim_free_early_state()
> src/sim.c:sim_free_main_state()
>
> src/sim.c:ofono_sim_inserted_notify() inserted: 1, sim->state: 0
> src/sim.c:sim_initialize()
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
>   src/sim.c:sim_pin_retries_query_cb()
> Requested file structure differs from SIM: 6fb7
> src/sim.c:ofono_sim_inserted_notify() inserted: 1, sim->state: 1
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
> src/sim.c:sim_efpl_read_cb()
> src/sim.c:__ofono_sim_recheck_pin()
> src/sim.c:sim_pin_query_cb() sim->pin_type: 1, pin_type: 1
> src/sim.c:sim_pin_query_cb() Methinks pin_type didn't change so didn't
> emit change
> src/sim.c:sim_pin_retries_check()
> src/sim.c:sim_pin_retries_query_cb()
>
>
> Ps. What's the mailing list practise on attachments, in case there's a
> need to provide longish logs?

Attaching logs is as good a solution as any.

>
> Thanks for the answers,
> Br.

Regards,
-Denis

--===============3207184189299181333==--

