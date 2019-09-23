Content-Type: multipart/mixed; boundary="===============3760657040665769120=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv3] quectel: handle sim states
Date: Tue, 24 Sep 2019 00:11:19 +0200
Message-ID: <521961fe-d63f-583b-0b03-0f0e65d8312c@geanix.com>
In-Reply-To: <c7dc3c8a-9d22-3415-fb0c-0cb181102f5d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3760657040665769120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 10/09/2019 16.10, Denis Kenzior wrote:
> Hi Martin,
> =

> On 9/5/19 5:33 AM, Martin Hundeb=C3=B8ll wrote:
>> The quectel M95 and MC60 modems are picky about when the sim is properly
>> initialized, so the logic to detect this needs to be in the quectel
>> plugin.
>>
>> After doing basic initialization, a CPIN query is issued to detect sim
>> state.
>>
>> If the sim is unlocked and ready, a timer is created to wait for the
>> modem state (AT+QINISTAT) to complete. At this point ofono is notified
>> about the initialized sim.
>>
>> If the sim is locked, a listener for "+CPIN: READY" is set up to
>> know when a pin is entered. Once the indication is received, the timer
>> is set up as if the sim was unlocked from the beginning.
>>
>> If the sim is busy/resetting, the CPIN query is issued again.
>> ---
>> =C2=A0 plugins/quectel.c | 336 ++++++++++++++++++++++++++++++++---------=
-----
>> =C2=A0 1 file changed, 237 insertions(+), 99 deletions(-)
>>
> =

> So what changed in this version?

Sorry, forgot this.

I added the logic to create atoms in or after quectel_post_sim() was caled.

>> +=C2=A0=C2=A0=C2=A0 if (data->sim_state =3D=3D OFONO_SIM_STATE_READY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when initializing wi=
th a non-locked sim card, the sim atom
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * isn't created until =
now to avoid accessing it before the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * modem is ready.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * call ofono_modem_set=
_powered() to make ofono call
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * quectel_pre_sim() wh=
ere the sim atom is created.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(mode=
m, true);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When initialized wit=
h a locked sim card, the modem is already
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * powered up, and the =
inserted signal has been sent to allow
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the pin to be entere=
d. So simply update the state, and notify
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * about the finished i=
nitialization below.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->sim_state =3D OFONO_SI=
M_STATE_READY;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_sim_initialized_notify(data->sim);
> =

> I don't know what you're doing here?=C2=A0 So sim_initialized_notify is m=
eant =

> to be called after PIN entry by the user, e.g. via +CPIN.=C2=A0 Many mode=
ms =

> need some time to actually read the SIM file system and perform other =

> initializations prior to functioning properly.=C2=A0 So oFono lets the dr=
iver =

> tell us when this is complete.=C2=A0 Calling this when the PIN is locked =

> seems wrong?

In case the sim is locked, two things are done in cpin_query():

1) we can be sure that "+CPIN: READY" appears at some point
    after a pin is entered. So we register sim_watch_cb() to
    initiate the AT+QINISTAT dance after receiving
    "+CPIN: READY".

2) Also, ofono_modem_set_powered() is called to make ofono call
    quctel_pre_sim(), so that the sim atom is created, which
    allows the pin to be entered.

Once the modem reports ready in the AT+QINISTAT response, =

ofono_sim_initialized_notify() is called to finish the initialization.

The other case, where the sim is not locked, the AT+QINISTAT dance is =

started directly from cpin_query(). Once the modem is ready, =

ofono_modem_set_powered() is called to create the sim atom in =

quectel_pre_sim(), and then ofono_sim_initialized_notify() afterwards.

> Also, it isn't clear whether data->sim is valid here at this point in =

> all cases?

I know it a bit of a hack, but I've noticed the pre_sim function is =

called unconditionally when doing ofono_modem_set_powered(true), so I =

exploited that fact here.

>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If quectel_post_sim() has not yet been calle=
d, then postpone atom
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * creation until it is called. Otherwise creat=
e the atoms now.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (data->state !=3D QUECTEL_STATE_POST_SIM) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->state =3D QUECTEL_STAT=
E_READY;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_sms_create(modem, data->vendor, "atmodem", dat=
a->aux);
>> +=C2=A0=C2=A0=C2=A0 ofono_phonebook_create(modem, data->vendor, "atmodem=
", data->aux);
>> +=C2=A0=C2=A0=C2=A0 ofono_voicecall_create(modem, data->vendor, "atmodem=
", data->aux);
>> +=C2=A0=C2=A0=C2=A0 ofono_call_volume_create(modem, data->vendor, "atmod=
em", data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->state =3D QUECTEL_STATE_INITIALIZED;
> =

> I'm lost here as well?=C2=A0 How do you even get into this path if we're =
in =

> post_sim?=C2=A0 Is it because you called sim_initialized when you shouldn=
't =

> have and trying to take care of the weirdness?

I've tried to work-around quectel_post_sim() being called after the PIN =

is entered, but before I call ofono_sim_initialized_notify():

../git/drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 1
../git/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, =

tocopy: 1
Aux: > AT+CIMI\r
../git/plugins/quectel.c:init_timer_cb() 0x610000000d40
Aux: < \r\n238013814764391\r\n\r\nOK\r\n
../git/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 238013814764391
../git/src/sim.c:call_state_watches()
../git/src/modem.c:modem_change_state() old state: 1, new state: 2
../git/plugins/quectel.c:quectel_post_sim() 0x610000000d40

So after reading the CIMI, the SIM is marked as ready, and =

call_state_watches() is called. (I added a DBG() there.)

Is there a way to avoid that?

> For a locked SIM you should be doing something like:
> =

> ofono_set_powered(modem, TRUE);
> ofono_sim_inserted(sim, TRUE);
> =

> g_at_chat_register("CPIN: Ready", sim_ready_cb);
> sim_ready_cb: poll QINISTAT.=C2=A0 If ready, call ofono_sim_initialized
> =

> This last part may or may not need to be synced up with the sim atom =

> driver.
> =

> Many modems actually provide a proper unsolicited notification that =

> makes logic like this much simpler and can be handled inside the modem =

> driver.

The M95 modem shows "Call Ready" when QINISTAT =3D=3D 2, but that is not =

enough. The M60 actually does show "SMS Ready" at the right time. I did =

ask Quectel directly to update the firmware to do QINISTAT unsolicited, =

but they are afraid to break exisiting users :(

> Move all the atom creation into post_sim.=C2=A0 Voicecalls probably belon=
g in =

> pre_sim.

I would really like to. But to do so, I need a way to avoid post_sim =

being called after the PIN is entered, but before QINISTAT returns 3. =

Otherwise, sms is broken:

Aux: > AT+CSMS?\r
Aux: < \r\n+CMS ERROR: 3\r\n
SMS not supported by this modem.  If this is an error please submit =

patches to support this hardware
../git/src/sms.c:sms_remove() atom: 0x604000026dd0


// Martin

--===============3760657040665769120==--

