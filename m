Content-Type: multipart/mixed; boundary="===============0709560136087080540=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 06:31:33 +0200
Message-ID: <01DCB5CE-E309-4864-A722-5E5D8723162E@holtmann.org>
In-Reply-To: <bb8c59dd-db99-f86d-2ca1-ed746809327d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0709560136087080540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>> I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0
>>> AT+CNMI=3D?
>> < +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
>> < OK
>> ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
>> ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
>>> AT+CNMI=3D1,2,2,1,0
>> < OK
>> ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0
>> ... unfortunately, with that configuration no messages are comming to
>> ofono and the other phone sees them as "delievery failed".
> =

> So you're saying the modem firmware is lying about supporting all these m=
odes :)
> =

>> I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
>> PDU) messages. That works well enough for me.
> =

> oFono doesn't support text mode=E2=80=A6

and it is impossible to support in a sane and complete manner.

>> Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
>> work well, either.
> =

> You could try using value of '1' for the <mt> parameter and see if the mo=
dem will route messages to memory first and send a +CMTI indication..

I remember vaguely that I dealt with a modem that had some issue with the i=
ndications. Maybe we already have a quirk for that in one of the drivers. S=
o look for SIMCOM or CINTERION vendor quirks. There are bunch of comments i=
n drivers/atmodem/sms.c for this. You need to figure out on what level this=
 modem is broken.

Regards

Marcel


--===============0709560136087080540==--

