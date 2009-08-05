Content-Type: multipart/mixed; boundary="===============3459761871177351586=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Re: How to dismiss incoming call?
Date: Wed, 05 Aug 2009 12:42:18 +0300
Message-ID: <4A7953FA.1000009@gmail.com>
In-Reply-To: <4A782F30.70803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3459761871177351586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Nokia 6100 responds ERROR when AT+CLCC is sent:

AT+CLCC
ERROR

With 6100 the Hangup returns timeout:

$ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
/modem1/voicecall01 org.ofono.VoiceCall.Hangup
Error org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
Possible causes include: the remote application did not send a reply,
the message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.


When sending Busy with the nokia 6100 the first time it seems to works
as it should (Even though CLCC is returning ERROR). When trying second
time in a row, without closing ofonod, it also sends busy to the
originator, but to the dbus message Error
org.freedesktop.DBus.Error.NoReply is returned.



With Nokia E51 when Hangup is sent to incoming call the result is following:

$ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
/modem1/voicecall01 org.ofono.VoiceCall.Hangup
Error org.ofono.Error.Failed: Operation failed

And during this the ofonod prints following:

...
ofonod[1812]: clcc_poll_cb got result: 1
ofonod[1812]: Final response: OK
ofonod[1812]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
ofonod[1812]: release_id_cb got result: 0
ofonod[1812]: Final response: ERROR
ofonod[1812]: command failed with error: (null)
ofonod[1812]: clcc_poll_cb got result: 1
ofonod[1812]: Final response: OK
ofonod[1812]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
...

Ps. Nokia 6290 has similar behavior than Nokia E51.


These tests were done with the latest git version.


Regards,
Marko

--===============3459761871177351586==--

