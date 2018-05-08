Content-Type: multipart/mixed; boundary="===============0814713867784419804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Tue, 08 May 2018 17:08:25 -0500
Message-ID: <bb8c59dd-db99-f86d-2ca1-ed746809327d@gmail.com>
In-Reply-To: <20180508215102.GA5253@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0814713867784419804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 05/08/2018 04:51 PM, Pavel Machek wrote:
> Hi!
> =

> I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0
> =

>> AT+CNMI=3D?
> < +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
> < OK
> ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
> ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
>> AT+CNMI=3D1,2,2,1,0
> < OK
> ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0
> =

> ... unfortunately, with that configuration no messages are comming to
> ofono and the other phone sees them as "delievery failed".

So you're saying the modem firmware is lying about supporting all these =

modes :)

> =

> I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
> PDU) messages. That works well enough for me.

oFono doesn't support text mode...

> =

> Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
> work well, either.

You could try using value of '1' for the <mt> parameter and see if the =

modem will route messages to memory first and send a +CMTI indication..

> =

> Any ideas how to debug this / what to try?
> =


I think you have to play with some combinations, not really sure what to =

tell you. Refer to 3GPP 27.005 for details on the SMS related AT commands.

Regards,
-Denis

--===============0814713867784419804==--

