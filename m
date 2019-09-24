Content-Type: multipart/mixed; boundary="===============0047263666594460683=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3] quectel: handle sim states
Date: Mon, 23 Sep 2019 21:50:03 -0500
Message-ID: <46ffe50f-2af2-bab8-8508-2253c1afd68d@gmail.com>
In-Reply-To: <521961fe-d63f-583b-0b03-0f0e65d8312c@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0047263666594460683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

<snip>

>> I don't know what you're doing here?=C2=A0 So sim_initialized_notify is =

>> meant to be called after PIN entry by the user, e.g. via +CPIN.=C2=A0 Ma=
ny =

>> modems need some time to actually read the SIM file system and perform =

>> other initializations prior to functioning properly.=C2=A0 So oFono lets =

>> the driver tell us when this is complete.=C2=A0 Calling this when the PI=
N =

>> is locked seems wrong?
> =

> In case the sim is locked, two things are done in cpin_query():
> =

> 1) we can be sure that "+CPIN: READY" appears at some point
>  =C2=A0=C2=A0 after a pin is entered. So we register sim_watch_cb() to
>  =C2=A0=C2=A0 initiate the AT+QINISTAT dance after receiving
>  =C2=A0=C2=A0 "+CPIN: READY".
> =


Yes I'm with you.  I thought it weird to send CPIN: READY uninitialized. =

  But okay, I got this part.

> 2) Also, ofono_modem_set_powered() is called to make ofono call
>  =C2=A0=C2=A0 quctel_pre_sim(), so that the sim atom is created, which
>  =C2=A0=C2=A0 allows the pin to be entered.

Okay, but why bother calling CPIN? here at all.  Just call =

ofono_modem_set_powered, which will create the sim atom, which will =

issue a CPIN? anyway...

> =

> Once the modem reports ready in the AT+QINISTAT response, =

> ofono_sim_initialized_notify() is called to finish the initialization.

Right, but if you register to +CPIN: READY always, then in case 1 above =

it will fire and you can do the QINISTAT dance as before.  Unless CPIN? =

query response of READY doesn't mean its really ready?  But then you can =

loop over QINISTAT until it is ready.  And this part still seems to =

belong in the sim atom if your vendor doesn't support unsolicited =

QINISTAT events...

> =

> The other case, where the sim is not locked, the AT+QINISTAT dance is =

> started directly from cpin_query(). Once the modem is ready, =

> ofono_modem_set_powered() is called to create the sim atom in =

> quectel_pre_sim(), and then ofono_sim_initialized_notify() afterwards.

This last part is a no-op or even wrong...

> =

>> Also, it isn't clear whether data->sim is valid here at this point in =

>> all cases?
> =

> I know it a bit of a hack, but I've noticed the pre_sim function is =

> called unconditionally when doing ofono_modem_set_powered(true), so I =

> exploited that fact here.
> =


Don't do that.  We provide no such guarantees :)

>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If quectel_post_sim() has not yet been call=
ed, then postpone =

>>> atom
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * creation until it is called. Otherwise crea=
te the atoms now.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (data->state !=3D QUECTEL_STATE_POST_SIM) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->state =3D QUECTEL_STA=
TE_READY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ofono_sms_create(modem, data->vendor, "atmodem", da=
ta->aux);
>>> +=C2=A0=C2=A0=C2=A0 ofono_phonebook_create(modem, data->vendor, "atmode=
m", data->aux);
>>> +=C2=A0=C2=A0=C2=A0 ofono_voicecall_create(modem, data->vendor, "atmode=
m", data->aux);
>>> +=C2=A0=C2=A0=C2=A0 ofono_call_volume_create(modem, data->vendor, "atmo=
dem", =

>>> data->aux);
>>> +=C2=A0=C2=A0=C2=A0 data->state =3D QUECTEL_STATE_INITIALIZED;
>>
>> I'm lost here as well?=C2=A0 How do you even get into this path if we're=
 in =

>> post_sim?=C2=A0 Is it because you called sim_initialized when you should=
n't =

>> have and trying to take care of the weirdness?
> =

> I've tried to work-around quectel_post_sim() being called after the PIN =

> is entered, but before I call ofono_sim_initialized_notify():
> =

> ../git/drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 1
> ../git/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, =

> tocopy: 1
> Aux: > AT+CIMI\r
> ../git/plugins/quectel.c:init_timer_cb() 0x610000000d40
> Aux: < \r\n238013814764391\r\n\r\nOK\r\n
> ../git/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 238013814764391
> ../git/src/sim.c:call_state_watches()
> ../git/src/modem.c:modem_change_state() old state: 1, new state: 2
> ../git/plugins/quectel.c:quectel_post_sim() 0x610000000d40
> =

> So after reading the CIMI, the SIM is marked as ready, and =

> call_state_watches() is called. (I added a DBG() there.)
> =

> Is there a way to avoid that?
> =


So this is what sim_initialized is for.  After the PIN is entered ofono =

will pause sim initialization until sim_initialized is called.  If =

you've gotten to the point that read_imsi is being executed, then you =

somehow called ofono_sim_initialized too early.

This is why I asked in my previous reply whether you're somehow =

triggering ofono_sim_initialized before it should be triggered?  Or =

maybe there's something else happening.

>> For a locked SIM you should be doing something like:
>>
>> ofono_set_powered(modem, TRUE);
>> ofono_sim_inserted(sim, TRUE);
>>
>> g_at_chat_register("CPIN: Ready", sim_ready_cb);
>> sim_ready_cb: poll QINISTAT.=C2=A0 If ready, call ofono_sim_initialized
>>
>> This last part may or may not need to be synced up with the sim atom =

>> driver.
>>
>> Many modems actually provide a proper unsolicited notification that =

>> makes logic like this much simpler and can be handled inside the modem =

>> driver.
> =

> The M95 modem shows "Call Ready" when QINISTAT =3D=3D 2, but that is not =

> enough. The M60 actually does show "SMS Ready" at the right time. I did =

> ask Quectel directly to update the firmware to do QINISTAT unsolicited, =

> but they are afraid to break exisiting users :(

That is just a strange argument :) They can always add AT+QINISTATU=3D1 =

(or whatever never-prior-used command) to enable unsolicited QINISTAT =

reporting and no existing user would be affected.

> =

>> Move all the atom creation into post_sim.=C2=A0 Voicecalls probably belo=
ng =

>> in pre_sim.
> =

> I would really like to. But to do so, I need a way to avoid post_sim =

> being called after the PIN is entered, but before QINISTAT returns 3. =

> Otherwise, sms is broken:
> =

> Aux: > AT+CSMS?\r
> Aux: < \r\n+CMS ERROR: 3\r\n
> SMS not supported by this modem.=C2=A0 If this is an error please submit =

> patches to support this hardware
> ../git/src/sms.c:sms_remove() atom: 0x604000026dd0

This is actually fairly typical behavior.  There are several drivers =

that initialize sms / phonebook as a result of an unsolicited =

notification.  The xmm7xxx plugin does this.

I do keep meaning to add a way to force bind a particular atom to a =

given state.  To cover the case where you need to create sms/phonebook =

in post_sim but have to rely on some unsolicited notification which =

might result in you calling __ofono_atom_add when the state went to =

online for example.  Something like __ofono_modem_add_atom_offline.

Regards,
-Denis

--===============0047263666594460683==--

