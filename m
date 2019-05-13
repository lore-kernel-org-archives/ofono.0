Content-Type: multipart/mixed; boundary="===============0677287271452342919=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Mon, 13 May 2019 08:20:51 +0200
Message-ID: <CAHB-Pj=K_LKLqr9PrWmAMZvgotU98QZpggk6SvOtwdXy4pjQvw@mail.gmail.com>
In-Reply-To: <a2443d38-e50b-65fb-0df8-f70939529f19@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0677287271452342919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I got this case again.

Killed ofono and checked the statuses manually. The output is below.
Its clear that creg and cereg both reports roaming, while cgreg reports unk=
nown.

Denis if netreg would be updated, I still think we have an issue with
atmodem/gprs.c.
The problematic part is when at modem received the cgreg and calls
ofono_gprs_status_notify, the gprs core part will then detach.

The log when this happened:

May 13 05:33:37  ofonod[741]: Aux: < \r\n+CREG: 5,"0080","00000006",6\r\n
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/network.c:ofono_netreg_status_notify() /ublox_0
status 5 tech 6
May 13 05:33:37  ofonod[741]: ../ofono-1.29/src/gprs.c:netreg_status_change=
d() 5
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
May 13 05:33:37  ofonod[741]: Aux: > AT\r
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]: Aux: Finally woke up the modem
May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,2\r
May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIEV: 2,5\r\n
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/network.c:ofono_netreg_strength_notify() strength
100
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,2,"24007",6\r\n
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]:
../ofono-1.29/drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 240, mnc: 07
May 13 05:33:37  ofonod[741]: Aux: > AT+CIND?\r
May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIND: 5,5,0,0,0,0,1,0,2,0,0,1\r\n
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,0\r
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,0,"Tele2",6\r\n
May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
May 13 05:33:37  ofonod[741]:
../ofono-1.29/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: Tele2, 240 07 6
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/network.c:current_operator_callback() 0x1fd2980,
0x1fe2c88
May 13 05:33:37  ofonod[741]: Aux: < \r\n+CGREG: 4\r\n
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status
unknown (4)
May 13 05:33:37  ofonod[741]:
../ofono-1.29/src/gprs.c:gprs_set_attached_property() 1 -> 0

Private log above, we got dettached, and will not reattach.

May 13 05:33:38  ofonod[741]: Aux: < \r\n+UREG: 0\r\n\r\n+CIEV:
9,1\r\n\r\n+UREG: 7\r\n\r\n+CIEV: 9,2\r\n


I killed ofono and checked the *reg manually:

at+creg?
+CREG: 2,5,"2AFF","01B19A04",7

OK
at+cgreg?
+CGREG: 2,4

OK
at+cereg?
+CEREG: 0,5

OK

Den tors 9 maj 2019 kl 16:35 skrev Denis Kenzior <denkenz@gmail.com>:
>
> Hi Philippe,
>
> <snip>
>
> > https://lists.ofono.org/pipermail/ofono/2018-September/018514.html
> > https://lists.ofono.org/pipermail/ofono/2019-February/019134.html
> > https://lists.ofono.org/pipermail/ofono/2019-February/019136.html
>
> Yes, the thread from 2018 is a good summary.
>
> >
> > I'd like to see it fixed, and I have been spending some time on things
> > the last few days. but I have not understood yet where exactly this
> > now needs to be added and how.
>
> Essentially the netreg atom driver needs to query both CEREG and CREG,
> combine the results to give the final answer to the core.
>
> Regards,
> -Denis

--===============0677287271452342919==--

