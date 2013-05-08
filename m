Content-Type: multipart/mixed; boundary="===============7560380059624698532=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Testing the iPhone 5
Date: Wed, 08 May 2013 11:42:31 -0500
Message-ID: <518A8077.2030005@gmail.com>
In-Reply-To: <CANT-zCXWAX0JjjDnD5bwc7UuftV0d8vh=sABmTw0mDN6AJU6+g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7560380059624698532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 05/08/2013 08:59 AM, Mikel Astiz wrote:
> Hi,
>
> I promised Denis I'd send some traces after testing the iPhone 5 and
> observing some strange states such as two active calls (test 1) or
> active+dialing state (test 2).
>
> I currently don't have a phone to test with but let me reuse some
> previous logs. In the second log, the AT commands are not visible so
> I'm hoping to repeat the experiment fairly soon.
>
> The first test is probably a bug in oFono while the second one might
> be the phone's behavior, to be confirmed.
>
> Cheers,
> Mikel
>
> TEST 1:
>
> Steps: Two numbers dialer from the phone while 3-way calling not
> available in network
> Result: Two active calls in oFono (but phone shows only the first one)
>
> ofonod[14366]: < \r\n+CIEV: 3,2\r\n
> ofonod[14366]: > AT+CLCC\r
> ofonod[14366]: < \r\n+CLCC: 1,0,2,0,0,"<phone-number-1>",145\r\n
> ofonod[14366]: < \r\nOK\r\n
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
> voicecall event, status: 2, id: 1, number: <phone-number-1>
> called_number: , called_name
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
> call with id: 1
> ofonod[14366]: < \r\n+CIEV: 3,3\r\n
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
> voicecall event, status: 3, id: 1, number: <phone-number-1>
> called_number: , called_name
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with i=
d: 1
> ofonod[14366]: < \r\n+CIEV: 5,5\r\n
> ofonod[14366]: src/network.c:ofono_netreg_strength_notify() strength 100
> ofonod[14366]: < \r\n+CIEV: 2,1\r\n
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
> voicecall event, status: 0, id: 1, number: <phone-number-1>
> called_number: , called_name
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with i=
d: 1
> ofonod[14366]: < \r\n+CIEV: 3,0\r\n
>
> (At this point, a second call is dialed from the phone)
>
> ofonod[14366]: < \r\n+CIEV: 3,2\r\n
> ofonod[14366]: > AT+CLCC\r
> ofonod[14366]: < \r\n+CLCC: 1,0,0,0,0,"<phone-number-1>",145\r\n
> ofonod[14366]: < \r\n+CLCC: 2,0,2,0,0,"<phone-number-2>",129\r\n

So here we have call with index 1 in state 'Active' and call with index =

2 in state 'Dialing'.  Obviously a bug with the iPhone.

> ofonod[14366]: < \r\nOK\r\n
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
> voicecall event, status: 2, id: 2, number: <phone-number-2>
> called_number: , called_name
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
> call with id: 2
> ofonod[14366]: < \r\n+CIEV: 3,0\r\n
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
> voicecall event, status: 0, id: 2, number: <phone-number-2>
> called_number: , called_name
> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with i=
d: 2
>

Regards,
-Denis


--===============7560380059624698532==--

