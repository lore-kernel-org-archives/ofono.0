Content-Type: multipart/mixed; boundary="===============4586130229134293547=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] plugins: add a new driver for Quectel UC15 modules
Date: Tue, 24 Jun 2014 13:44:04 -0500
Message-ID: <53A9C6F4.9030308@gmail.com>
In-Reply-To: <20140624183408.GK33006@rincewind.trouble.is>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4586130229134293547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

>
> I don't think there's any reason this needs to be there specifically.  I
> probably put it there when I was debugging a USB-related reset problem.
> It can probably either go away (I've not done more than cursory testing
> with the modem connected to a UART - many things may be broken) or move
> to quectel_enable() (in which case the modem will behave a little bit
> more like one expects a modem to behave when connected to a UART).

Just wondering.  We usually send &C0 fairly early in the process.

> =

>> Any reason for checking that CFUN succeeded?  If so, then it might be a
>> good idea to document that in comments / commit description.
> =

> It turns out that AT+CFUN=3D0 -> AT+CFUN=3D1 transitions can return OK
> before the SIM is completely out of reset (temperature related).  In
> that case, AT+CPIN will return any number of bizarre error codes (from
> SIM not inserted to memory failure).  Trying again a bit later just
> works.

Should you be using at_util_sim_state_query_new for this?  Or does
CFUN=3D1 needs to be sent again?

> =

>> What if it failed?  Are you relying on the core timeout mechanisms?
> =

> It it doesn't behave as expected after retrying as often and waiting as
> long as this, it's unlikely to ever work.  The core will timeout waiting
> for the driver to indicate the modem is powered.  I would expect higher
> layers to see this as a hint that something may be wrong with powering
> up the modem.
> =

> Can you suggest a better way to fail here?

I was thinking that the driver should notify the core as soon as it
determines that the hardware is inoperable.  The core timeout handling
is really just a failsafe.  But either way works...

> =

>>> +	if (!ok) {
>>> +		if (data->enable_tries > MAX_RETRIES) {
>>> +			g_at_chat_unref(data->aux);
>>> +			data->aux =3D NULL;
>>> +			g_at_chat_unref(data->modem);
>>> +			data->modem =3D NULL;
>>> +			ofono_modem_set_powered(modem, FALSE);
>>> +			DBG("modem won't enable - giving up");
>>> +		}
>>> +		goto retry;
>>
>> Is the timer still running in case MAX_RETRIES is reached?  In general
>> we prefer using single-shot timers and re-starting them if the command
>> fails.  Certain commands might take several seconds to return on some
>> hardware.
> =

> I am fairly confident it's safe: I ran into this failure case quite
> often during development and testing.  I schedule quectel_start() in
> quectel_enable() and quectel_start() keeps rescheduling cfun_enable()
> until it succeeds or runs out of retries.  I carefully check if the
> timer is still running everywhere I try to tear things down.

The thing is that running out of retries does not stop the timer.  At
least I don't see g_source_remove for it here.  Neither does the
quectel_start() function check for max retries.

> =

> It's probably not too hard to rework this to use a single-shot timer.
> =


That might make things a bit more reliable and readable as well.

>>> +	/* Give the modem a bit more time to power up completely. */
>>> +	data->enable_tries =3D 0;
>>> +	data->enable_timer =3D g_timeout_add_seconds(RESET_DELAY,
>>> +					quectel_start, modem);
>>
>> Is this delay always necessary?  enable() is called in other situations
>> besides a hot-plugging...
> =

> I mainly tested this with hot-plugging and not-so-hot-plugging (keeping
> the module powered but kicking its reset line) and it seems necessary in
> both cases.  I haven't tested toggling enable in software much, but just
> doing AT+CFUN=3D0 ; AT+CFUN=3D1 in a loop shows a fair amount of variance
> even without touching power or reset.  May be a hardware issue, but I've
> not talked to Quectel about it.
>  =


Just wondering whether upping the max retries and sending this command
right away might be 'better' for the non-hotplug case.

>>> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
>>> +					cfun_disable, modem, NULL);
>>
>> What behavior does this modem exhibit when using CFUN=3D0?  Many devices
>> jump off the USB bus when this is sent.  Hence why most drivers use CFUN=
=3D4.
> =

> It stays on the bus but turns off the radio and goes into lower power
> mode.  I have no strong feelings about using CFUN=3D4 instead, but
> intuitively that feels more like "offline" than "disabled".  Am I
> missing some other distinction between set_online and enable/disable?

If the modem stays on the bus, using CFUN=3D0 is just fine.  As I said,
most others jump off the bus, which makes using CFUN=3D0 not a good idea :)

Regards,
-Denis

--===============4586130229134293547==--

