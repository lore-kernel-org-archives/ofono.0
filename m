Content-Type: multipart/mixed; boundary="===============8801162808271532945=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Tue, 14 May 2019 08:43:45 +0200
Message-ID: <CAHB-Pjn19N9jKWYsY9rbhKczkpmK-Y8Fu-=9_+os0XDZE649=A@mail.gmail.com>
In-Reply-To: <2e34b6e3-8d0b-d8c8-294e-4836aabd6976@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8801162808271532945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 13 maj 2019 kl 23:57 skrev Denis Kenzior <denkenz@gmail.com>:
>
> Hi Richard,
>
> On 05/13/2019 01:20 AM, Richard R=C3=B6jfors wrote:
> > Hi,
> >
> > I got this case again.
> >
> > Killed ofono and checked the statuses manually. The output is below.
> > Its clear that creg and cereg both reports roaming, while cgreg reports=
 unknown.
>
> This is a different case?  Your originally case had CREG reporting
> unknown while UREG reporting LTE.

I really hope I didn't confuse CREG and CGREG.

>
> >
> > Denis if netreg would be updated, I still think we have an issue with
> > atmodem/gprs.c.
> > The problematic part is when at modem received the cgreg and calls
> > ofono_gprs_status_notify, the gprs core part will then detach.
> >
> > The log when this happened:
> >
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+CREG: 5,"0080","00000006",6\r=
\n
>
> So we are roaming...
>
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/network.c:ofono_netreg_status_notify() /ublox_0
> > status 5 tech 6
> > May 13 05:33:37  ofonod[741]: ../ofono-1.29/src/gprs.c:netreg_status_ch=
anged() 5
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/gprs.c:gprs_netreg_update() attach: 1,
> > driver_attached: 1
> > May 13 05:33:37  ofonod[741]: Aux: > AT\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]: Aux: Finally woke up the modem
>
> Weird that you're using this magic.  I thought only the Freerunner modem
> had this issue.  But ok...

Not sure we need to ;-) It seems to me like gatchat always does this
is the command list is empty, putting a single AT first..I didn't know
it was "optional".

I have seen the ublox to lock up and not reply to AT commands, but
that was after the wake anyway so that did not help.

>
> > May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,2\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIEV: 2,5\r\n
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/network.c:ofono_netreg_strength_notify() strength
> > 100
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,2,"24007",6\r\n
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/drivers/atmodem/network-registration.c:cops_numeric_cb()
> > Cops numeric got mcc: 240, mnc: 07
> > May 13 05:33:37  ofonod[741]: Aux: > AT+CIND?\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIND: 5,5,0,0,0,0,1,0,2,0,0,1=
\r\n
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,0\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,0,"Tele2",6\r\n
> > May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/drivers/atmodem/network-registration.c:cops_cb()
> > cops_cb: Tele2, 240 07 6
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/network.c:current_operator_callback() 0x1fd2980,
> > 0x1fe2c88
> > May 13 05:33:37  ofonod[741]: Aux: < \r\n+CGREG: 4\r\n
>
> So for whatever reason the modem (or network?) decides to detach GPRS...
>
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status
> > unknown (4)
> > May 13 05:33:37  ofonod[741]:
> > ../ofono-1.29/src/gprs.c:gprs_set_attached_property() 1 -> 0
> >
>
> My memory is fuzzy now, but I'm not sure if we ever put in the logic to
> attempt a re-attach in such a situation (e.g. we didn't request a
> detach).  For all devices we cared about the modem re-attached for us.
> It looks like there's still a TODO for this in src/gprs.c

I guess the thing is that the modem has switched to 4G. Do we actually
need to care about re-attaching to gprs? I mean the modem
automatically hand over to 4G and the context continues to work.
Wouldn't it make sense if gprs kept the "combined packet status"?
(combine CGREG, CEREG and whatever for 5G).
The name GPRS would be confusing but it would keep the complete packet
switched status in one place.
In this case that could would not consider us being roaming instead of
unknown, since that whats CEREG reports.

--Richard

--===============8801162808271532945==--

