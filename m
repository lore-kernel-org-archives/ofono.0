Content-Type: multipart/mixed; boundary="===============5322245637502084254=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to hangup outgoing call, before terminating end answers?
Date: Mon, 17 Aug 2009 10:40:27 -0500
Message-ID: <200908171040.27848.denkenz@gmail.com>
In-Reply-To: <4A892261.40504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5322245637502084254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Hi,
>
> Currently when a call is created with Dial method the object path for
> the call (e.g. /modem1/voicecall01) is returned only after the
> terminating end has answered to the call. So is it possible to Hangup
> the call from the originating end before terminating end answers the call?

So this very much depends on the modem.  Most (sane) modems return an OK fi=
nal =

response to the ATD when they start dialing.  Some will then accept regular =

AT+CHLD commands to terminate the outgoing call, others have a vendor speci=
fic =

command for doing so.  The broken ones return an OK/BUSY/NO CARRIER for the =

ATD only when connected/busy/timed out, in which case there's no standard w=
ay =

to abort that I know of.

This might be an area where I'd like to hear some feedback, whether an =

additional dial_abort function pointer is required in the voicecall plugin.

However, the entire 27.007 spec for voice calls is utterly broken, there's =
no =

way to get it right.  If your modems support vendor extensions for call =

control, in particular call state reporting, I suggest using those.  I expe=
ct =

all major vendors have implemented such features in their modems.  I don't =

expect the reference implementation to be used in practice, as it is too =

battery inefficient.

>
>
> Create the call:
> $ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
> org.ofono.VoiceCallManager.Dial string:"+358000000000" string:"default"
>
> The following do not work as the /modem1/voicecall01 does not exist:
> $ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
> org.ofono.VoiceCall.Hangup
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "Hangup" with
> signature "" on interface "org.ofono.VoiceCall" doesn't exist
>
> $ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
> org.ofono.VoiceCall.Busy
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "Busy" with
> signature "" on interface "org.ofono.VoiceCall" doesn't exist

So you can only use this one on an incoming or waiting call.

>
>
> The VoiceCallManager.HangupAll does not work either:
> $ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
> org.ofono.VoiceCallManager.HangupAll
> Error org.ofono.Error.InProgress: Operation already in progress

Regards,
-Denis

--===============5322245637502084254==--

