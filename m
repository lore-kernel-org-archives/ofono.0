Content-Type: multipart/mixed; boundary="===============8933263465275149628=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Re: How to hangup outgoing call, before terminating end answers?
Date: Tue, 18 Aug 2009 11:16:49 -0400
Message-ID: <20090818111649.591dcdfc@mycelium.queued.net>
In-Reply-To: <4A892261.40504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8933263465275149628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2009 12:26:57 +0300
Marko Saukko <marko.saukko@gmail.com>
wrote:

> Hi,
> =

> Currently when a call is created with Dial method the object path for
> the call (e.g. /modem1/voicecall01) is returned only after the
> terminating end has answered to the call. So is it possible to Hangup
> the call from the originating end before terminating end answers the
> call?
> =

> =

> Create the call:
> $ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
> org.ofono.VoiceCallManager.Dial string:"+358000000000"
> string:"default"
> =

> The following do not work as the /modem1/voicecall01 does not exist:
> $ dbus-send --system --print-reply
> --dest=3Dorg.ofono /modem1/voicecall01 org.ofono.VoiceCall.Hangup
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "Hangup" with
> signature "" on interface "org.ofono.VoiceCall" doesn't exist

FWIW, I just tried this on my G1 and it worked fine:

localhost:~/ofono# !109
dbus-send --system --print-reply --dest=3Dorg.ofono / org.ofono.at.Manager.=
Create string:"dev:/dev/smd0" string:"at"
method return sender=3D:1.0 -> dest=3D:1.1 reply_serial=3D2
   object path "/modem1"
localhost:~/ofono# dbus-send --system --print-reply --dest=3Dorg.ofono /mod=
em1 org.ofono.VoiceCallManager.Dial string:"617501XXXX" string:"default"
method return sender=3D:1.0 -> dest=3D:1.2 reply_serial=3D2
   object path "/modem1/voicecall01"
localhost:~/ofono# dbus-send --system --print-reply --dest=3Dorg.ofono /mod=
em1/voicecall01 org.ofono.VoiceCall.Hangup
method return sender=3D:1.0 -> dest=3D:1.3 reply_serial=3D2

Hangup returned successfully prior to the other end picking up.





--===============8933263465275149628==--

