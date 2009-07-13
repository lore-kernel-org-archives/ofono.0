Content-Type: multipart/mixed; boundary="===============4760826019303125541=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Mon, 13 Jul 2009 10:47:36 -0500
Message-ID: <200907131047.37127.denkenz@gmail.com>
In-Reply-To: <4A5AD086.7040103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4760826019303125541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Hi,
>
> I'm trying to make a voice call with oFono. I'm using Option GlobeSurfer
> ICON 225 HSDPA/UMTS USB as the modem. If I understood correctly voice
> call should be possible with the dbus-messages used below. However, I
> end up with an error "Operation failed".

Operation failed literally means the modem replied with an error of some so=
rt.

>
> $ dbus-send --system --print-reply --dest=3Dorg.ofono /
> org.ofono.at.Manager.Create string:"dev:/dev/ttyHS0" string:"at"
> method return sender=3D:1.540 -> dest=3D:1.544 reply_serial=3D2
>    object path "/modem1"

Looks good.

>
> $ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1
> org.ofono.VoiceCallManager.Dial string:"+000000000000" string:"default"
> Error org.ofono.Error.Failed: Operation failed

For wrong arguments, the error would be something like InvalidArguments or =

InvalidFormat.

>
> When the second dbus-message is sent the following messages are printed
> by the ofonod:
>
> ofonod[19113]: atd_cb got result: 0
> ofonod[19113]: Final response: ERROR
> ofonod[19113]: Dial callback returned error: (null)

This means that ATD final response was ERROR.  Are you sure your modem actu=
ally =

supports voice calls?

Regards,
-Denis

--===============4760826019303125541==--

