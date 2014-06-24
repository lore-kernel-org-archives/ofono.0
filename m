Content-Type: multipart/mixed; boundary="===============5043722474360930461=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH 3/4] plugins: add a new driver for Quectel UC15 modules
Date: Tue, 24 Jun 2014 20:34:08 +0200
Message-ID: <20140624183408.GK33006@rincewind.trouble.is>
In-Reply-To: <53A9B859.9040007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5043722474360930461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-24 12:41:45 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> Philip Paeps <philip@paeps.cx> wrote:

Thanks for the review, Denis!

> > +static void verify_enable(gboolean ok, GAtResult *result, gpointer use=
r_data)
> > +{
> > +	struct ofono_modem *modem =3D user_data;
> > +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> > +
> > +	if (ok) {
> > +		ofono_modem_set_powered(modem, TRUE);
> > +		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
> > +		g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);
> =

> Why do you do send AT&C0 here?  Can it be done earlier?

The module can be connected to USB or a regular UART.  In the case of a
regular UART, AT&C0 will keep DCD on regardless of whether the modem is
connected.

I don't think there's any reason this needs to be there specifically.  I
probably put it there when I was debugging a USB-related reset problem.
It can probably either go away (I've not done more than cursory testing
with the modem connected to a UART - many things may be broken) or move
to quectel_enable() (in which case the modem will behave a little bit
more like one expects a modem to behave when connected to a UART).

> Any reason for checking that CFUN succeeded?  If so, then it might be a
> good idea to document that in comments / commit description.

It turns out that AT+CFUN=3D0 -> AT+CFUN=3D1 transitions can return OK
before the SIM is completely out of reset (temperature related).  In
that case, AT+CPIN will return any number of bizarre error codes (from
SIM not inserted to memory failure).  Trying again a bit later just
works.

> What if it failed?  Are you relying on the core timeout mechanisms?

It it doesn't behave as expected after retrying as often and waiting as
long as this, it's unlikely to ever work.  The core will timeout waiting
for the driver to indicate the modem is powered.  I would expect higher
layers to see this as a hint that something may be wrong with powering
up the modem.

Can you suggest a better way to fail here?

> > +	if (!ok) {
> > +		if (data->enable_tries > MAX_RETRIES) {
> > +			g_at_chat_unref(data->aux);
> > +			data->aux =3D NULL;
> > +			g_at_chat_unref(data->modem);
> > +			data->modem =3D NULL;
> > +			ofono_modem_set_powered(modem, FALSE);
> > +			DBG("modem won't enable - giving up");
> > +		}
> > +		goto retry;
> =

> Is the timer still running in case MAX_RETRIES is reached?  In general
> we prefer using single-shot timers and re-starting them if the command
> fails.  Certain commands might take several seconds to return on some
> hardware.

I am fairly confident it's safe: I ran into this failure case quite
often during development and testing.  I schedule quectel_start() in
quectel_enable() and quectel_start() keeps rescheduling cfun_enable()
until it succeeds or runs out of retries.  I carefully check if the
timer is still running everywhere I try to tear things down.

It's probably not too hard to rework this to use a single-shot timer.

> > +	g_at_chat_send(data->aux, "AT+CPIN?", NULL, verify_enable,
> > +					modem, NULL);
> =

> Using prefixes is a good idea, otherwise any unsolicited notifications
> will be missed.  git show 35feae07e50f89ea3c42566c765f501ec768bd44 for
> an example of what might happen.

Thanks for the pointer.  I'll take a look and rework.

> > +	/* Give the modem a bit more time to power up completely. */
> > +	data->enable_tries =3D 0;
> > +	data->enable_timer =3D g_timeout_add_seconds(RESET_DELAY,
> > +					quectel_start, modem);
> =

> Is this delay always necessary?  enable() is called in other situations
> besides a hot-plugging...

I mainly tested this with hot-plugging and not-so-hot-plugging (keeping
the module powered but kicking its reset line) and it seems necessary in
both cases.  I haven't tested toggling enable in software much, but just
doing AT+CFUN=3D0 ; AT+CFUN=3D1 in a loop shows a fair amount of variance
even without touching power or reset.  May be a hardware issue, but I've
not talked to Quectel about it.
 =

> > +	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
> > +					cfun_disable, modem, NULL);
> =

> What behavior does this modem exhibit when using CFUN=3D0?  Many devices
> jump off the USB bus when this is sent.  Hence why most drivers use CFUN=
=3D4.

It stays on the bus but turns off the radio and goes into lower power
mode.  I have no strong feelings about using CFUN=3D4 instead, but
intuitively that feels more like "offline" than "disabled".  Am I
missing some other distinction between set_online and enable/disable?

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============5043722474360930461==--

