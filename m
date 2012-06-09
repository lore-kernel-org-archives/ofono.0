Content-Type: multipart/mixed; boundary="===============0138202092752533701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Implement signal strength polling in plugin/driver
Date: Sat, 09 Jun 2012 01:16:41 -0500
Message-ID: <4FD2EA49.8060805@gmail.com>
In-Reply-To: <d9e9c17c27aa80d12803dbaa87b8b971@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0138202092752533701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Audric,

> I found by looking in include/netreg.h that it should be up to the
> plugin to
> implement CSQ polling, however I can't find how it is supposed to be done.
> Indeed, the plugin has no access to the netreg atom nor structure, so
> how is it
> supposed to update one of these properties ?

Drivers do not modify DBus properties directly.  Instead you should be =

signaling the change to the core the regular way, via =

ofono_netreg_strength_notify.

If you want to implement periodic signal strength reporting, then use =

g_idle_add_seconds to periodically send the +CSQ query.  Please note =

that doing it this way you'd have to keep track of other states.  For =

example, you might want to stop polling when the registration is lost, etc.

Ideally you should be asking your vendor why the signal strength isn't =

reported properly.

Regards,
-Denis

--===============0138202092752533701==--

