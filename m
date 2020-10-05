Content-Type: multipart/mixed; boundary="===============2813119786285331000=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v2] quectel: Power on/off with a gpio pulse
Date: Mon, 05 Oct 2020 17:10:55 +0200
Message-ID: <20201005151055.te5kn5rrscrvrxzu@lem-wkst-02.lemonage>
In-Reply-To: <0efb10fd-e3d6-e128-2a8d-f38aab091cf9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2813119786285331000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 09:50:22AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 10/1/20 6:42 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > Current implementation uses a gpio level of 1 for powering on quectel
> > modems using a gpio and a level of 0 for powering off.
> > This is wrong. Quectel modems use pulses for either power on and power
> > off. They turn on by the first pulse and turn then off by the next
> > pulse. The pulse length varies between different modems.
> > For power on the longest I could in the quectel hardware is "more than
> > 2 seconds" from Quectel M95 Hardware Design Manual.
> > For Quectel EC21 this is ">=3D 100 ms".
> > For Quectel MC60 this is "recommended to be 100 ms".
> > For Quectel UC15 this is "at least 0.1 s".
> > For power off the four modems in question vary between a minimum pulse
> > length of 600-700ms.
> > This implements a 2100ms pulse for power on and 750ms for power off.
> > ---
> >   plugins/quectel.c | 33 ++++++++++++++++++++++++++++++---
> >   1 file changed, 30 insertions(+), 3 deletions(-)
> > =

> > diff --git a/plugins/quectel.c b/plugins/quectel.c
> > index 6456775d..61ac906e 100644
> > --- a/plugins/quectel.c
> > +++ b/plugins/quectel.c
> > @@ -234,10 +234,21 @@ static void close_ngsm(struct ofono_modem *modem)
> >   		ofono_warn("Failed to restore line discipline");
> >   }
> > +static gboolean gpio_power_off_cb(gpointer user_data)
> > +{
> > +	struct ofono_modem *modem =3D (struct ofono_modem *)user_data;
> > +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> > +	const uint32_t gpio_value =3D 0;
> > +
> > +	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > +	ofono_modem_set_powered(modem, FALSE);
> > +	return false;
> > +}
> > +
> =

> Ok, this makes sense now...
> =

> >   static void close_serial(struct ofono_modem *modem)
> >   {
> >   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> > -	uint32_t gpio_value =3D 0;
> > +	uint32_t gpio_value =3D 1;
> >   	DBG("%p", modem);
> > @@ -258,8 +269,12 @@ static void close_serial(struct ofono_modem *modem)
> >   	else
> >   		close_ngsm(modem);
> > -	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > -	ofono_modem_set_powered(modem, FALSE);
> > +	if (data->gpio) {
> > +		l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > +		g_timeout_add(750, gpio_power_off_cb, modem);
> =

> Have you considered what happens if the gpio_power_on_cb timeout is still
> running here?  For example, if the modem is turned on / off quickly?
> =

> Maybe the old timeout should be canceled just in case?

I am in a big luck here! :-)
Setting "Powered" on "org.ofono.Modem" is synchronous. And even if
another process is trying to unset "Powered" in the meantime. This is
blocked:

dbus.exceptions.DBusException: org.ofono.Error.InProgress: Operation alread=
y in progress

And powering on the modem is taking as long as the first replies from
the modem are received. This a lot of time after the timeout happened.

> > +	} else
> > +		ofono_modem_set_powered(modem, FALSE);
> > +
> >   }
> >   static void dbus_hw_reply_properties(struct dbus_hw *hw)
> > @@ -1096,6 +1111,15 @@ static void init_timeout_cb(struct l_timeout *ti=
meout, void *user_data)
> >   	l_timeout_modify_ms(timeout, 500);
> >   }
> > +static gboolean gpio_power_on_cb(gpointer user_data)
> > +{
> > +	struct quectel_data *data =3D user_data;
> > +	const uint32_t gpio_value =3D 0;
> > +
> > +	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > +	return false;
> > +}
> =

> It seems that this timeout is completely independent of
> ofono_modem_set_powered(TRUE), so the core won't prevent the modem from
> being powered off while this is running...

What exactly are you concerned about ? What should not work ?
The ofono_modem_set_powered(TRUE) is done later either in cpin_cb or
qinistat_cb, after communication with the modem and mux are properly
set up.
Powering off during this phase is prevented by ofono:

root(a)bboxvx:/usr/lib/ofono/test# ./enable-modem & sleep 11; ./disable-mod=
em

ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y SystemPath
Connecting modem /quectel_0...
ofonod[507]: ../git/plugins/quectel.c:quectel_enable() 0x583b80
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Device
ofonod[507]: ../git/plugins/quectel.c:open_serial() 0x583b80
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y RtsCts
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Device
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: UART: < \r\nR
ofonod[507]: UART: < DY\r\n
ofonod[507]: UART: < \r\n
ofonod[507]: UART: < +CFUN: 1\r\n
ofonod[507]: ../git/plugins/quectel.c:init_timeout_cb() 0x583b80
ofonod[507]: UART: > AT\r
ofonod[507]: UART: < A
ofonod[507]: UART: < T\r\r\nOK\r
ofonod[507]: UART: < \n
ofonod[507]: ../git/plugins/quectel.c:init_cmd_cb() 0x583b80
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y RtsCts
ofonod[507]: UART: > ATE0\r
ofonod[507]: UART: < ATE
ofonod[507]: UART: < 0\r
ofonod[507]: UART: < \r
ofonod[507]: UART: < \nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:ate_cb() 0x583b80
ofonod[507]: UART: > AT+CGMM\r
ofonod[507]: UART: < \r
ofonod[507]: UART: < \nEC21\r\n
ofonod[507]: UART: < \r\nOK\r
ofonod[507]: ../git/plugins/quectel.c:cgmm_cb() 0x583b80 ok 1
ofonod[507]: ../git/plugins/quectel.c:cgmm_cb() 0x583b80 model EC21
ofonod[507]: UART: > AT+CMUX=3D0,0,5,127,10,3,30,10,2\r
ofonod[507]: UART: < \n
ofonod[507]: UART: < \r
ofonod[507]: UART: < \nOK\r\n
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Mux
ofonod[507]: ../git/plugins/quectel.c:cmux_cb() 0x583b80
ofonod[507]: ../git/plugins/quectel.c:cmux_ngsm() 0x583b80
ofonod[507]: ../git/src/modem.c:set_modem_property() modem 0x583b80 propert=
y Modem
ofonod[507]: ../git/src/modem.c:unregister_property() property 0x57b088
ofonod[507]: ../git/src/modem.c:set_modem_property() modem 0x583b80 propert=
y Aux
ofonod[507]: ../git/src/modem.c:unregister_property() property 0x581070
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/quectel.c:mux_ready_cb() 0x583b80
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Modem
ofonod[507]: ../git/plugins/quectel.c:open_ttys() 0x583b80
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Modem
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y Aux
ofonod[507]: ../git/plugins/quectel.c:setup_aux() 0x583b80
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: Aux: > ATE0; &C0; +CMEE=3D1\r
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: Aux: < \r\nOK\r\n
ofonod[507]: Aux: > AT+QURCCFG=3D"urcport","uart1"\r
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: Aux: < \r\nOK\r\n
ofonod[507]: Aux: > AT+CFUN?\r
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: ../git/plugins/udevng.c:add_serial_device() Device is missing =
required OFONO_DRIVER property
ofonod[507]: Aux: < \r\n+CFUN: 1\r\n\r\nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:cfun_query() 0x583b80 ok 1
ofonod[507]: ../git/plugins/quectel.c:cfun_enable() 0x583b80 ok 1
ofonod[507]: Aux: > AT+CFUN=3D4\r
ofonod[507]: ../git/src/modem.c:get_modem_property() modem 0x583b80 propert=
y SystemPath
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Disconnecting modem /quectel_0...
Traceback (most recent call last):
  File "./disable-modem", line 20, in <module>
    modem.SetProperty("Powered", dbus.Boolean(0), timeout =3D 120)
  File "/usr/lib/python3.8/site-packages/dbus/proxies.py", line 72, in __ca=
ll__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python3.8/site-packages/dbus/proxies.py", line 141, in __c=
all__
    return self._connection.call_blocking(self._named_service,
  File "/usr/lib/python3.8/site-packages/dbus/connection.py", line 652, in =
call_blocking
    reply_message =3D self.send_message_with_reply_and_block(
dbus.exceptions.DBusException: org.ofono.Error.InProgress: Operation alread=
y in progress
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
root(a)bboxvx:/usr/lib/ofono/test# ofonod[507]: Aux: < \r\nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:cfun_cb() 0x583b80 ok 1
ofonod[507]: ../git/plugins/quectel.c:dbus_hw_enable() 0x583b80
ofonod[507]: Aux: > AT+CPIN?\r
ofonod[507]: Aux: < \r\n+QIND: PB DONE\r\n
ofonod[507]: ../git/plugins/quectel.c:qind_notify() 0x583b80
ofonod[507]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:sim_state_cb() 0x583b80 present 1
ofonod[507]: Aux: > AT+CPIN?\r
ofonod[507]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:cpin_cb() 0x583b80
ofonod[507]: ../git/plugins/quectel.c:init_timer_cb() 0x583b80
ofonod[507]: Aux: > AT+QINISTAT\r
ofonod[507]: Aux: < \r\n+QINISTAT: 7\r\n\r\nOK\r\n
ofonod[507]: ../git/plugins/quectel.c:qinistat_cb() 0x583b80
ofonod[507]: ../git/plugins/quectel.c:qinistat_cb() qinistat: 7
ofonod[507]: ../git/src/modem.c:modem_change_state() old state: 0, new stat=
e: 1
ofonod[507]: ../git/plugins/quectel.c:quectel_pre_sim() 0x583b80

I highlighted the output of ./disable-modem between the =3D=3D=3D=3D
As disable-modem is done before AT+QINISTAT returned in my case, this
does give "Operation already in progress". The same for everything less
than the 10 seconds.
If I do sleep a few seconds longer in between enable-modem and
disable-modem, the disable-modem does fire after AT+QINISTAT and that
then does power down the modem successfully.

> > +
> >   static int open_serial(struct ofono_modem *modem)
> >   {
> >   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> > @@ -1139,6 +1163,9 @@ static int open_serial(struct ofono_modem *modem)
> >   		return -EIO;
> >   	}
> > +	if (data->gpio)
> > +		g_timeout_add(2100, gpio_power_on_cb, data);
> > +
> =

> Generally it is a good idea to keep track of any timeout objects you're
> adding. This is especially true on hot-plug/unplug capable hardware since
> the modem object and its data might go away, but the timer would still be
> running, causing a SIGSEGV later.
> =

> Granted this is a serial device, so this won't likely happen in this case=
...

Ok, you mean it is better to use l_timeout_create_ms and keep track of
the returned object manually ?
As a first guess: Either the timeout fired and I destroy it in the cb
or I destroy it in close_serial. close_serial is part of quectel_disable.
I can try that if you want.

Regards,
Lars
--===============2813119786285331000==--

