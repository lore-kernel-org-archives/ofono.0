Content-Type: multipart/mixed; boundary="===============0103914027498594943=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: If I send a sms I can't send another or make a call
Date: Mon, 26 Mar 2012 14:13:51 +0200
Message-ID: <op.wbr1ldx5yxxkfz@pohanka-pc>
In-Reply-To: <op.wbmmcezhyxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0103914027498594943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have done deeper investigation why I'm stuck with sms sending. SMS is  =

sent by the function tx_next which registers the callback tx_finished with  =

the line

sms->driver->submit(sms, pdu->pdu, pdu->pdu_len, pdu->tpdu_len,
				send_mms, tx_finished, sms);

Unfortunately the tx_finished is never called and hence the sms is left in  =

the queue even if it was sent.
submit function pointer calls atmodem/sms.c which creates AT command sends  =

it and also registers a callback at_cmgs_cb. I have added some debugging  =

messages there and it seems that it is never called either.

Could please someone give me some advice where to search further? It seems  =

that modem does not respond to the CMGS command, but if I tried it  =

manually in minicom the modem returns +CMGS and OK correctly.


Here is the log
ofonod[253]: src/network.c:ofono_netreg_status_notify() /telit2_0 status 1  =

tech 0
ofonod[253]: Modem: > AT+COPS=3D3,2\r
ofonod[253]: Modem: < \r\nOK\r\n
ofonod[253]: src/sms.c:tx_next() tx_next: 0x11dd80
ofonod[253]: Modem: > AT+COPS?\r
ofonod[253]: Modem: < \r\n+COPS: 0,2,"23002",0\r\n\r\nOK\r\n
ofonod[253]: drivers/atmodem/network-registration.c:cops_numeric_cb() Cops  =

numeric got mcc: 230, mnc: 02
ofonod[253]: Modem: > AT+CIND?\r
ofonod[253]: Modem: < \r\n+CIND: 0,99,1,0,0,0,0,0,5\r\n\r\nOK\r\n
ofonod[253]: src/network.c:ofono_netreg_strength_notify() strength 100
ofonod[253]: Modem: > AT+CMGS=3D41\r
ofonod[253]: Modem: < \r\n>
ofonod[253]: Modem: >  =

001100098177740744F60000A7206FF3DBFD368741E8373B0C0AB3E76BB2DA0C0AA3C3EC39D=
9BC06A9D1<CtrlZ>


best regards
Jan


Dne Fri, 23 Mar 2012 14:56:28 +0100 Jan Pohanka <xhpohanka@gmail.com>  =

napsal(a):

> Excuse me for double posting but I have forgotten one line in the  =

> command sequence
>
>> test/enable-modem
>> test/online-modem
>> test/dial-number xxxxxxxxx
>> test/hangup-all
>> test/send-sms xxxxxxxxx "test sms" 0
>
> test/dial-number xxxxxxxxx
>
>> the last command (dialing) fails with a timeout
>
>


-- =

Tato zpr=C3=A1va byla vytvo=C5=99ena p=C5=99evratn=C3=BDm po=C5=A1tovn=C3=
=ADm klientem Opery:  =

http://www.opera.com/mail/

--===============0103914027498594943==--

