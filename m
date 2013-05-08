Content-Type: multipart/mixed; boundary="===============4805253847521789149=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Testing the iPhone 5
Date: Wed, 08 May 2013 15:59:21 +0200
Message-ID: <CANT-zCXWAX0JjjDnD5bwc7UuftV0d8vh=sABmTw0mDN6AJU6+g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4805253847521789149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I promised Denis I'd send some traces after testing the iPhone 5 and
observing some strange states such as two active calls (test 1) or
active+dialing state (test 2).

I currently don't have a phone to test with but let me reuse some
previous logs. In the second log, the AT commands are not visible so
I'm hoping to repeat the experiment fairly soon.

The first test is probably a bug in oFono while the second one might
be the phone's behavior, to be confirmed.

Cheers,
Mikel

TEST 1:

Steps: Two numbers dialer from the phone while 3-way calling not
available in network
Result: Two active calls in oFono (but phone shows only the first one)

ofonod[14366]: < \r\n+CIEV: 3,2\r\n
ofonod[14366]: > AT+CLCC\r
ofonod[14366]: < \r\n+CLCC: 1,0,2,0,0,"<phone-number-1>",145\r\n
ofonod[14366]: < \r\nOK\r\n
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 2, id: 1, number: <phone-number-1>
called_number: , called_name
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 1
ofonod[14366]: < \r\n+CIEV: 3,3\r\n
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 3, id: 1, number: <phone-number-1>
called_number: , called_name
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with id:=
 1
ofonod[14366]: < \r\n+CIEV: 5,5\r\n
ofonod[14366]: src/network.c:ofono_netreg_strength_notify() strength 100
ofonod[14366]: < \r\n+CIEV: 2,1\r\n
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 0, id: 1, number: <phone-number-1>
called_number: , called_name
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with id:=
 1
ofonod[14366]: < \r\n+CIEV: 3,0\r\n

(At this point, a second call is dialed from the phone)

ofonod[14366]: < \r\n+CIEV: 3,2\r\n
ofonod[14366]: > AT+CLCC\r
ofonod[14366]: < \r\n+CLCC: 1,0,0,0,0,"<phone-number-1>",145\r\n
ofonod[14366]: < \r\n+CLCC: 2,0,2,0,0,"<phone-number-2>",129\r\n
ofonod[14366]: < \r\nOK\r\n
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 2, id: 2, number: <phone-number-2>
called_number: , called_name
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 2
ofonod[14366]: < \r\n+CIEV: 3,0\r\n
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 0, id: 2, number: <phone-number-2>
called_number: , called_name
ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with id:=
 2


TEST 2:

Steps: Two numbers dialer from the phone (3-way calling available)
Result: oFono reports a active+dialing state until held+alerting is reached.

ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
event, status: 2, id: 1, number: <phone-number-1> called_number: ,
called_name
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 1
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
event, status: 3, id: 1, number: <phone-number-1> called_number: ,
called_name
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Found call with id: 1
ofonod[3281]: src/network.c:ofono_netreg_strength_notify() strength 100
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
event, status: 0, id: 1, number: <phone-number-1> called_number: ,
called_name
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Found call with id: 1
ofonod[3281]: src/network.c:ofono_netreg_strength_notify() strength 80

(At this point, a second call is dialed from the phone)

ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
event, status: 2, id: 2, number: <phone-number-2> called_number: ,
called_name
ofonod[3281]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 2
ofonod[3281]: src/modem.c:modem_change_state() old state: 3, new state: 0

--===============4805253847521789149==--

