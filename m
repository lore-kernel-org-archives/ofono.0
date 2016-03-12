Content-Type: multipart/mixed; boundary="===============8617559370101365174=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: Re: Timeout/Reliability issue with my plugin
Date: Sat, 12 Mar 2016 17:10:20 +0000
Message-ID: <loom.20160312T175732-718@post.gmane.org>
In-Reply-To: <56E43B20.9090100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8617559370101365174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@...> writes:


Dear Denis,

>

thank you for the quick answer.
 =

> Without seeing the modem driver code, I can't comment.  The core does =

> set a timeout whenever .set_powered() method is called.  If the method =

> does not return in that time, the core does what cleanup that it can. =

> Refer to src/modem.c for details.
> =

> However, the modem driver is still responsible for cleaning up after =

> itself, since the core has no visibility into what resources are being =

> used by the modem driver.

How would it do it? Should it start it's own glib timer next to the AT+CFUN?
I have added an abort in the code. As you have guessed it is a standard AT
modem. What happens is that somehow the _enable times out, on disable
the _disable will not be called (as the modem was probably never powered
up) and then on the next _enable we create a second GAtChat.


test/enable-modem test/disable-modem in a loop

Connecting modem /wavecom_15...                                            =
     =

Traceback (most recent call last):                                         =
     =

  File "./test/enable-modem", line 20, in <module>                         =
     =

    modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)         =
       =

  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 70, in __call=
__   =

    return self._proxy_method(*args, **keywords)                           =
     =

  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in __cal=
l__  =

    **keywords)                                                            =
     =

  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651, in   =
     =

    call_blocking message, timeout)                                        =
     =

dbus.exceptions.DBusException: org.ofono.Error.Timedout: Operation failure =
due   =

to timeout                                                                 =
     =

Disconnecting modem /wavecom_15...                                         =
     =

Connecting modem /wavecom_15...                                            =
     =

                                                                           =
     =


printf + at commands
                                                                           =
     =

ofonod[18642]: 0x7955f0: wavecom_enable                                    =
     =

ofonod[18642]: 0x78f300 0x7955f0 reset res 2                               =
     =

ofonod[18642]: > AT+WIND=3D32767\r                                         =
       =

ofonod[18642]: < \r\nOK\r\n                                                =
     =

ofonod[18642]: wind_set                                                    =
     =

ofonod[18642]: > AT+CFUN=3D1,1\r                                           =
       =

ofonod[18642]: 0x7955f0: wavecom_enable                                    =
     =

ofonod[18642]: 0x7955f0 the chat is still there!!!!                        =
     =


so _enable is called twice without a _disable inbetween. The _enable routine
returns -EINPROGRESS and the AT+CFUN=3D1,1 probably too much time then
or failed somehow differently. In this specific case the GAtChat will not be
unrefed which means the fd will be leaked.

So how can the plugin figure out that the core has decided not to move forw=
ard?

holger



--===============8617559370101365174==--

