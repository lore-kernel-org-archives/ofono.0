Content-Type: multipart/mixed; boundary="===============0640577922304755741=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to dismiss incoming call?
Date: Thu, 06 Aug 2009 10:43:33 -0500
Message-ID: <200908061043.34603.denkenz@gmail.com>
In-Reply-To: <4A7953FA.1000009@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0640577922304755741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> When sending Busy with the nokia 6100 the first time it seems to works
> as it should (Even though CLCC is returning ERROR). When trying second
> time in a row, without closing ofonod, it also sends busy to the
> originator, but to the dbus message Error
> org.freedesktop.DBus.Error.NoReply is returned.

If CLCC is returning an error, there's no hope of the default plugin workin=
g.  =

You will need to do some digging to figure out whether its possible to supp=
ort =

this device.

> With Nokia E51 when Hangup is sent to incoming call the result is
> following:
>
> $ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
> /modem1/voicecall01 org.ofono.VoiceCall.Hangup
> Error org.ofono.Error.Failed: Operation failed

For hangup oFono sends a AT+CHLD=3D1<callid>, which is most likely 1.  So =

AT+CHLD=3D11.  For busy, oFono sends AT+CHLD=3D0.  If these result in error=
s, the =

default plugin will not work.

It might be that the modem is using a neutered command set.  Can you find o=
ut =

whether CHLD=3D11 works, whether AT+CHLD=3D0 works, whether AT+CHUP works a=
nd =

whether ATH works?  Most likely this hardware will need a custom driver.

Regards,
-Denis

--===============0640577922304755741==--

