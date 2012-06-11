Content-Type: multipart/mixed; boundary="===============4107037984529030130=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Re: Implement signal strength polling in plugin/driver
Date: Mon, 11 Jun 2012 16:28:05 +0200
Message-ID: <e3040137c4170fb3c32fa98bec49ea37@toulouse.viveris.com>
In-Reply-To: <4FD5F9F7.4010005@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4107037984529030130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Guillaume,

On Mon, 11 Jun 2012 16:00:23 +0200, Guillaume Zajac wrote:
> Hi Audric,
>
> On 07/06/2012 17:20, Audric Schiltknecht wrote:
>> Hi guys,
>>
>>
>> I am currently developing an ofono-based GSM control interface, =

>> using a Sagem
>> Hilo modem (I wrote the appropriate plugin) with the atmodem driver.
>>
>> I am having trouble with signal strength reporting. The terminal =

>> does not report
>> signal strength by event. Hence, it is not possible to get the value =

>> from Ofono,
>> since Ofono expects it to be updated on a +CIEV event. I implemented =

>> a
>> new DBus method in the NetworkRegistration interface to force AT+CSQ =

>> command and
>> update the property value, but this is clearly not a valid solution.
>
> Do you know in modem specifications if Sagem is using a specific
> signal strength notifications command?
> If yes, then you should update in
> drivers/atmodem/network-registration.c the at_creg_set_cb() function
> to handle OFONO_VENDOR_SAGEM case.
> Thus you can use register to the good comman notification.

According to the modem specification, the modem should use a standard =

+CIEV
event to report signal strength.
However, I found that the strength is never notified as expected,
whereas it is correctly returned when using an AT+CSQ read command.
Moreover, the value returned in +CIEV is theoretically an integer in =

the range 0-4,
when AT+CSQ returns a well more fine-grained value (integer between =

0-31).

> Could you also give us your AT log and more particulary the
> "AT+CMER=3D3,0,0,1" answer?
> Maybe, this configuration is not supported by your modem and you
> should change it.

Indeed, mode 3 is not supported, and I modified the driver to use mode =

1.

>> I found by looking in include/netreg.h that it should be up to the =

>> plugin to
>> implement CSQ polling, however I can't find how it is supposed to be =

>> done.
>> Indeed, the plugin has no access to the netreg atom nor structure, =

>> so how is it
>> supposed to update one of these properties ?
>
> Indeed, if you use it for instance with ConnMan signal strength
> notification won't work or maybe I miss something.

I use my own DBus client, but the effect is the same: no notification =

of signal
strength change, unless I explicitly call the custom function I added =

in src/network.c
to force polling of the strength.

Thanks for your support.
Audric



--===============4107037984529030130==--

