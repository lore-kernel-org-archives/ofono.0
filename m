Content-Type: multipart/mixed; boundary="===============4307897172669145743=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: How to hangup outgoing call, before terminating end answers?
Date: Mon, 17 Aug 2009 12:26:57 +0300
Message-ID: <4A892261.40504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4307897172669145743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Currently when a call is created with Dial method the object path for
the call (e.g. /modem1/voicecall01) is returned only after the
terminating end has answered to the call. So is it possible to Hangup
the call from the originating end before terminating end answers the call?


Create the call:
$ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
org.ofono.VoiceCallManager.Dial string:"+358000000000" string:"default"

The following do not work as the /modem1/voicecall01 does not exist:
$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
org.ofono.VoiceCall.Hangup
Error org.freedesktop.DBus.Error.UnknownMethod: Method "Hangup" with
signature "" on interface "org.ofono.VoiceCall" doesn't exist

$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
org.ofono.VoiceCall.Busy
Error org.freedesktop.DBus.Error.UnknownMethod: Method "Busy" with
signature "" on interface "org.ofono.VoiceCall" doesn't exist


The VoiceCallManager.HangupAll does not work either:
$ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
org.ofono.VoiceCallManager.HangupAll
Error org.ofono.Error.InProgress: Operation already in progress


Regards,
Marko

--===============4307897172669145743==--

