Content-Type: multipart/mixed; boundary="===============6869597506985088449=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SimManager properties and hotswap
Date: Fri, 12 Jun 2015 11:01:42 -0500
Message-ID: <557B0266.8010707@gmail.com>
In-Reply-To: <CAAVgdeF_trBzArPR9zhKN-pSY1fdj0YRTKjmcfVENV3vKHjbYQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6869597506985088449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 06/12/2015 08:05 AM, Tommi Kenakkala wrote:
> Greetings
>
> There's an issue for which I'd like to hear your opinion.
> ofono_sim_inserted_notify signals org.ofono.SimManager Present property t=
rue,
> but PinRequired and LockedPins are known only after
> __ofono_sim_recheck_pin asks them from driver.

In general, the client has to assume that SimManager is not initialized =

until SubscriberIdentity is present, or PinRequired is set.

> Problem can arise at startup but I've met this especially during
> hotswap i.e. when I remove and insert the same/different card.
> If a driver completes query_passwd_state synchronously there's less
> room for problems, but if driver has to find out the values
> asynchronously the time window is longer.
> I'm using an implementation of rilmodem, but even the default atmodem
> driver asks password state asynchronously (AT+CPIN?).

In general oFono tries to do two things to alleviate issues of =

incomplete state:

- We only register DBus interfaces once the initial state has been queried.
- We delay GetProperties() return until we queried the needed states and =

cached them.  This is mostly used for interfaces which are unlikely to =

be used by multiple clients (which would need to deal with Error.Busy)

The above are not really a good fit for SimManager, so it has always =

been 'special'.

>
> Problem1
> If a client, for example triggered by the Present property change
> signal, asks GetProperties during the time window then PinRequired &
> LockedPins values are not updated yet.
>

Then the client should simply wait for the relevant signal to arrive. =

Either SubscriberIdentity or PinRequired.

> Problem2
> A client can't work around Problem1, it doesn't know when after a
> hotswap PinRequired becomes available. sim_pin_query_cb checks
> "sim->pin_type =3D pin_type" before emitting PinRequired changed signal.
> Works for boot when pin_type is 0 but not for card hotswap because
> sim->pin_type is not reset, instead the old value is preserved.

Sounds like a bug.  Are you hot-swapping two PIN-locked SIMs?  Can you =

share a log of what's happening?

> One fix proposal to Problem2 is to reset pin_type to
> OFONO_SIM_PASSWORD_INVALID in ofono_sim_inserted_notify when removed.
> That requires skipping appending PinRequired in sim_get_properties()
> if value is OFONO_SIM_PASSWORD_INVALID, otherwise
> ofono_dbus_dict_append crashes because sim_passwd_name() didn't have a
> value for OFONO_SIM_PASSWORD_INVALID.
> (I would've put resetting to sim_free_main_state(), but that's called
> when changing PIN fails due to wrong passwords and sim app switches
> PUK lock (OFONO_SIM_STATE_LOCKED_OUT), it would reset the password
> type already set as puk.)

Setting it to OFONO_SIM_PASSWORD_INVALID is definitely not the right way =

to go.  But there might be other ways to take care of the problem.  Can =

you share the logs of what is happening first?

>
> Problem3
> Similar for LockedPins, but there reason is sim_pin_query_cb() doesn't
> emit property change all.
> Fix proposal to Problem3 is to emit a change signal sim_pin_query_cb()
> if "sim->locked_pins[pin_type]" wasn't already TRUE.
>
> Please let me know your comments and improvement ideas. I can submit
> patches if you're interested.
>

Regards,
-Denis

--===============6869597506985088449==--

