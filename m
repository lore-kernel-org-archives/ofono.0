Content-Type: multipart/mixed; boundary="===============6640080451938667384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3] quectel: handle sim states
Date: Tue, 24 Sep 2019 15:40:25 -0500
Message-ID: <7f027d2d-f323-61e7-eedc-6b7a56c6eb83@gmail.com>
In-Reply-To: <41f7e5a9-2fe7-8ce3-c02e-280090fa946f@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640080451938667384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>> I tried implementing what you suggest - see the attached patch. But I =

>> still get "SMS not supported by this modem.".
>>
>> The attached log shows quectel_post_sim() being called (line 584) way =

>> before QINISTAT returns 3 (line 686).
>>
>> Is this because my SIM isn't locked, and so the =

>> ofono_sim_inserted_notify() call makes it go all the way?
>>
>> I can work around it by calling ofono_sim_inserted_notify() either if =

>> the SIM is locked, or/and when qinistat returns 3.
> =

> It also happens on a locked SIM - log attached.
> =


So in your log:

ofonod[3982107]: ../git/plugins/quectel.c:sim_watch_cb() 0x610000000d40
ofonod[3982107]: ../git/src/sim.c:sim_enter_pin_cb() Waiting for =

ofono_sim_initialized_notify

So we're supposed to be waiting here for a bit.  Somehow we're not or =

you're calling ofono_sim_initialized early.  Perhaps the default sim =

driver is doing this?  Check this first.

ofonod[3982107]: Aux: > AT+CPIN?\r
ofonod[3982107]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[3982107]: Aux: > AT+CPIN?\r
ofonod[3982107]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n

It looks like we get into recheck_pin here somehow...

ofonod[3982107]: ../git/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: =

READY
ofonod[3982107]: ../git/src/sim.c:sim_pin_query_cb() sim->pin_type: 1, =

pin_type: 0
ofonod[3982107]: ../git/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[3982107]: Aux: > AT+QTRPIN\r
ofonod[3982107]: Aux: < \r\n+QTRPIN: 3,3,10,10\r\n\r\nOK\r\n
ofonod[3982107]: Aux: > AT+CUAD\r
ofonod[3982107]: Aux: < \r\n+CME ERROR: 100\r\n

Regards,
-Denis

--===============6640080451938667384==--

