Content-Type: multipart/mixed; boundary="===============3807350359364312463=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Tue, 10 Jan 2012 04:21:18 +0100
Message-ID: <4F0BAEAE.9070402@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3807350359364312463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have got a custom board with a SIMCOM INCORPORATED SIM5216E modem, a =

device not so common. I was able to successfully use it with Ofono, but =

I want to get some advise to polish the work, as I have observed a =

couple of strange things.

The modem is connected by the USB and report: vendor=3D0x05c6 =

product=3D0x9000. This seem to indicate that it use a Qualcomm chip. It =

expose 5 serial interfaces, where the 2 and 3 (starting from 0) are for =

the AT commands. Since the "atgen" driver is no more, I tested it with =

the "g1" driver. It was only a guess and I would like to know if an =

other driver is a better choice.

The first problem I faced is that I use Buildroot and the uClibc without =

udev (only devtmpfs) on the target system. Dependencies problemes into =

Buildroot make it hard to provides the libudev at the needed version =

form Ofono 1.2. So I passed --disable-udev to the configure the get ride =

of it. While compiling for a uClibc system I have to remove the =

backtrace code from src/log.c since it is not available on the uClibc. =

As others might like to use Ofono on the uClibc, I suggest to test the =

presence of <execinfo.h>, but this is only a small glitch. Now the =

difficult part is to find a way to call ofono_modem_register() without =

the udev plugin, since the modem.conf support have been removed. I did =

not find an other solution than writing a very small plugin that just do =

this in his init function:
         modem =3D ofono_modem_create("simcom", "g1");
         ofono_modem_set_string(modem, "Device", "/dev/ttyUSB3");
         ofono_modem_register(modem);
It work perfectly well, but look a bit overkill to force to write a =

plugin for a such simple action. I have the feeling to have missed =

something but I can't figure how I should have done this in a proper =

way. At one point I hesitate to add a AddModem method into the =

org.ofono.Manager interface, but the plugin solution was a quicker hack.

The resulting executable work on the target. I can power up, power down =

the modem, enter the SIM pin code, dial and receive call, as well as =

sending a SMS. But the operations are not reliable. This is where I =

needs some hint if this is the normal consequence of the modification I =

have made, or if I need to go into a deep debug session.

While getting a call indication, sometimes I got this:
ofonod[1346]: < \r\n+CDIP: "",128\r\n
ofonod[1346]: < \r\n+CLIP: "0786577442",129,,,,0\r\n
ofonod[1346]: CDIP for unknown call
ofonod[1346]: CLIP for unknown call
ofonod[1346]: < \r\n+CRING: VOICE\r\n
ofonod[1346]: < \r\n+CLIP: "0786577442",129,,,,0\r\n\r\n+CDIP: "",128\r\n
ofonod[1346]: drivers/atmodem/voicecall.c:cring_notify()
ofonod[1346]: drivers/atmodem/voicecall.c:clip_notify() 0786577442 129 0
ofonod[1346]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall =

event, status: 4, id: 1, number: 0786577442 called_number: , called_name
ofonod[1346]: src/voicecall.c:ofono_voicecall_notify() Did not find a =

call with id: 1
ofonod[1346]: drivers/atmodem/voicecall.c:cdip_notify()  128
ofonod[1346]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall =

event, status: 4, id: 1, number: 0786577442 called_number: , called_name
ofonod[1346]: src/voicecall.c:ofono_voicecall_notify() Found call with id: 1
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[1346]: > AT+CLCC\r
ofonod[1346]: < \r\n+CME ERROR: unknown\r\n
ofonod[1346]: We are polling CLCC and received an error
ofonod[1346]: All bets are off for call management
ofonod[1346]: < \r\nMISSED_CALL: 09:34AM 0786577442\r\n
After that Ofono seem to be lost and only able to be terminated.

While receiving a SMS I sometimes got this:
ofonod[7191]: > AT+CIND?\r
ofonod[7191]: < \r\n+CIND: 4,3,1,0,0,0,1,0\r\n\r\nOK\r\n
ofonod[7191]: > AT+COPS=3D3,0\r
ofonod[7191]: < \r\nOK\r\n
ofonod[7191]: > AT+COPS?\r
ofonod[7191]: < \r\n+COPS: 0,0,"orange CH",0\r\n\r\nOK\r\n
ofonod[7191]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: =

orange CH, 228 03 0
ofonod[7191]: src/network.c:current_operator_callback() 0xf4eb8, 0xf69d8
solution ofonod[7191]: < \r\n+CMT: =

,24\r\n07911487777770F0040B911487567744F200002110013094744
ofonod[7191]: < 005C3F79B1D02\r\n
ofonod[7191]: drivers/atmodem/sms.c:at_cmt_notify() Got new SMS Deliver =

PDU via CMT: =

07911487777770F0040B911487567744F200002110013094744005C3F79B1D02, 24
ofonod[7191]: src/sms.c:ofono_sms_deliver_notify() len 32 tpdu len 24
ofonod[7191]: src/sms.c:handle_deliver()
ofonod[7191]: src/sms.c:sms_dispatch()
ofonod[7191]: src/sms.c:sms_dispatch() dst -1 src -1
ofonod[7191]: drivers/atmodem/sms.c:at_ack_delivery()
ofonod[7191]: > AT+CNMA=3D1,2\r
ofonod[7191]: < \r\n>
ofonod[7191]: > 0000<CtrlZ>
ofonod[7191]: < \r\n\r\n+CMS ERROR: Invalid PDU mode parameter\r\n
ofonod[7191]: CNMA acknowledgement failed: Further SMS reception is not =

guaranteed

And finally, when I send a SMS it could end badly this way:
ofonod[6085]: > AT+CSCA?\r
ofonod[6085]: < \r\n+CSCA: "+41787777070",145\r\n\r\nOK\r\n
ofonod[6085]: drivers/atmodem/sms.c:at_csca_query_cb() csca_query_cb: =

41787777070, 145
ofonod[6085]: src/sms.c:tx_queue_entry_new() pdu_len: 26, tpdu_len: 25
ofonod[6085]: src/sms.c:tx_next() tx_next: 0xf57c8
ofonod[6085]: > AT+CMGS=3D25\r
ofonod[6085]: < \r\n>
ofonod[6085]: > 0011000B911487567744F20000A70CC8329BFD063DCD6FF73B04<CtrlZ>
ofonod[6085]: < \r\n
ofonod[6085]: < \r\n+CREG: 1, 1778, 4333\r\n\r\n+CMGS: 23\r\n\r\nOK\r\n
ofonod[6085]: drivers/atmodem/sms.c:at_cmgs_cb() Got MR: 23
ofonod[6085]: src/sms.c:tx_finished() tx_finished 0xf57c8
ofonod[6085]: src/sms.c:sms_tx_queue_remove_entry() 0xf57c8
ofonod[6085]: > AT+COPS=3D3,2\r
ofonod[6085]: < \r\nOK\r\n
ofonod[6085]: Aborting (signal 11) [ofonod]
Since uClibc did not have the backtrace call, I have no more information.

For the 3 issues, the problem is not systematic. It could work perfectly =

well, or it could bug. Maybe a timing related problem, as I run Ofono on =

a slow ARM926 device.

As I am a newbie about Ofono, I like to get some critics on what I can =

do to quickly get a reliable operation.

Jean-Christian de Rivaz

--===============3807350359364312463==--

