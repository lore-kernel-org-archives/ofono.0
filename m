Content-Type: multipart/mixed; boundary="===============8958909805512592581=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3] quectel: handle sim states
Date: Tue, 10 Sep 2019 09:10:46 -0500
Message-ID: <c7dc3c8a-9d22-3415-fb0c-0cb181102f5d@gmail.com>
In-Reply-To: <20190905103320.114207-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8958909805512592581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/5/19 5:33 AM, Martin Hundeb=C3=B8ll wrote:
> The quectel M95 and MC60 modems are picky about when the sim is properly
> initialized, so the logic to detect this needs to be in the quectel
> plugin.
> =

> After doing basic initialization, a CPIN query is issued to detect sim
> state.
> =

> If the sim is unlocked and ready, a timer is created to wait for the
> modem state (AT+QINISTAT) to complete. At this point ofono is notified
> about the initialized sim.
> =

> If the sim is locked, a listener for "+CPIN: READY" is set up to
> know when a pin is entered. Once the indication is received, the timer
> is set up as if the sim was unlocked from the beginning.
> =

> If the sim is busy/resetting, the CPIN query is issued again.
> ---
>   plugins/quectel.c | 336 ++++++++++++++++++++++++++++++++--------------
>   1 file changed, 237 insertions(+), 99 deletions(-)
> =


So what changed in this version?

<snip>

> +	if (data->sim_state =3D=3D OFONO_SIM_STATE_READY) {
> +		/*
> +		 * when initializing with a non-locked sim card, the sim atom
> +		 * isn't created until now to avoid accessing it before the
> +		 * modem is ready.
> +		 *
> +		 * call ofono_modem_set_powered() to make ofono call
> +		 * quectel_pre_sim() where the sim atom is created.
> +		 */
> +		ofono_modem_set_powered(modem, true);
> +	} else {
> +		/*
> +		 * When initialized with a locked sim card, the modem is already
> +		 * powered up, and the inserted signal has been sent to allow
> +		 * the pin to be entered. So simply update the state, and notify
> +		 * about the finished initialization below.
> +		 */
> +		data->sim_state =3D OFONO_SIM_STATE_READY;
> +	}
> +
> +	ofono_sim_initialized_notify(data->sim);

I don't know what you're doing here?  So sim_initialized_notify is meant =

to be called after PIN entry by the user, e.g. via +CPIN.  Many modems =

need some time to actually read the SIM file system and perform other =

initializations prior to functioning properly.  So oFono lets the driver =

tell us when this is complete.  Calling this when the PIN is locked =

seems wrong?

Also, it isn't clear whether data->sim is valid here at this point in =

all cases?

> +
> +	/*
> +	 * If quectel_post_sim() has not yet been called, then postpone atom
> +	 * creation until it is called. Otherwise create the atoms now.
> +	 */
> +	if (data->state !=3D QUECTEL_STATE_POST_SIM) {
> +		data->state =3D QUECTEL_STATE_READY;
> +		return;
> +	}
> +
> +	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
> +	data->state =3D QUECTEL_STATE_INITIALIZED;

I'm lost here as well?  How do you even get into this path if we're in =

post_sim?  Is it because you called sim_initialized when you shouldn't =

have and trying to take care of the weirdness?

For a locked SIM you should be doing something like:

ofono_set_powered(modem, TRUE);
ofono_sim_inserted(sim, TRUE);

g_at_chat_register("CPIN: Ready", sim_ready_cb);
sim_ready_cb: poll QINISTAT.  If ready, call ofono_sim_initialized

This last part may or may not need to be synced up with the sim atom driver.

Many modems actually provide a proper unsolicited notification that =

makes logic like this much simpler and can be handled inside the modem =

driver.

Move all the atom creation into post_sim.  Voicecalls probably belong in =

pre_sim.

> +}
> +

Regards,
-Denis

--===============8958909805512592581==--

