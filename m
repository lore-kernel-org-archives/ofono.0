Content-Type: multipart/mixed; boundary="===============3682639260927745470=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: How to dismiss incoming call?
Date: Tue, 04 Aug 2009 15:53:04 +0300
Message-ID: <4A782F30.70803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3682639260927745470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

How can I dismiss incoming call without answering to it?

I tried the Busy method, as shown below:

$ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
/modem1/voicecall01 org.ofono.VoiceCall.Busy
method return sender=3D:1.277 -> dest=3D:1.284 reply_serial=3D2

Here is what the ofonod prints out:
...
ofonod[2049]: clcc_poll_cb got result: 1
ofonod[2049]: Final response: OK
ofonod[2049]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
ofonod[2049]: cring_notify got result: 1
ofonod[2049]: Final response: (null)
ofonod[2049]: Response line: +CRING: VOICE
ofonod[2049]: clip_notify got result: 1
ofonod[2049]: Final response: (null)
ofonod[2049]: Response line: +CLIP: "+358000000000",145
ofonod[2049]: clip_notify: +358000000000 145 0
ofonod[2049]: Got a voicecall event, status: 4, id: 1, number: +358000000000
ofonod[2049]: Found call with id: 1
ofonod[2049]: clcc_poll_cb got result: 1
ofonod[2049]: Final response: OK
ofonod[2049]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
...

...
ofonod[2049]: generic_cb got result: 1
ofonod[2049]: Final response: OK
...

These messages do not have any effect to the call itself. With E51 the
only way to dismiss the call in receiving end is to first answer and
then hangup.

In above tests the Nokia E51 was used (connected with USB cable).




With Nokia 6100 connected with USB cable the the busy method worked
(call was ended), however the dbus send an error message as a response:

$ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
/modem1/voicecall01 org.ofono.VoiceCall.Busy
Error org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
Possible causes include: the remote application did not send a reply,
the message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

And here is the output by ofonod:

...
ofonod[1514]: Response line: +CRING: VOICE
ofonod[1514]: cring_notify
ofonod[1514]: clip_notify got result: 1
ofonod[1514]: Final response: (null)
ofonod[1514]: Response line: +CLIP: "+358000000000",145
ofonod[1514]: clip_notify: +358000000000 145 0
ofonod[1514]: Got a voicecall event, status: 4, id: 1, number: +358000000000
ofonod[1514]: Did not find a call with id: 1
ofonod[1514]: Resetting updating flag
ofonod[1514]: clcc_poll_cb got result: 0
ofonod[1514]: Final response: ERROR
ofonod[1514]: We are polling CLCC and CLCC resulted in an error
ofonod[1514]: All bets are off for call management


after this nothing else was printed even when the busy was sent.


oFono version 0.2 was used.



Regards,
Marko

--===============3682639260927745470==--

