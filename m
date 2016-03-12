Content-Type: multipart/mixed; boundary="===============6186814735711180354=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Timeout/Reliability issue with my plugin
Date: Sat, 12 Mar 2016 11:23:50 -0600
Message-ID: <56E450A6.90600@gmail.com>
In-Reply-To: <loom.20160312T175732-718@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6186814735711180354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

 >> However, the modem driver is still responsible for cleaning up after
>> itself, since the core has no visibility into what resources are being
>> used by the modem driver.
>
> How would it do it? Should it start it's own glib timer next to the AT+CF=
UN?
> I have added an abort in the code. As you have guessed it is a standard AT
> modem. What happens is that somehow the _enable times out, on disable
> the _disable will not be called (as the modem was probably never powered
> up) and then on the next _enable we create a second GAtChat.

You could do a timer, or forcefully unref the g_at_chat object if the =

GAtChat already exists when set_powered() is being called.  However, its =

best to drive a modem in such a way that the firmware doesn't reset and =

keeps responding to AT commands properly.

Sometimes this is easier said than done :)

>
>
> test/enable-modem test/disable-modem in a loop
>
> Connecting modem /wavecom_15...
> Traceback (most recent call last):
>    File "./test/enable-modem", line 20, in <module>
>      modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
>    File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 70, in __c=
all__
>      return self._proxy_method(*args, **keywords)
>    File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in __=
call__
>      **keywords)
>    File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651, in
>      call_blocking message, timeout)
> dbus.exceptions.DBusException: org.ofono.Error.Timedout: Operation failur=
e due
> to timeout
> Disconnecting modem /wavecom_15...
> Connecting modem /wavecom_15...
>
>
> printf + at commands
>
> ofonod[18642]: 0x7955f0: wavecom_enable
> ofonod[18642]: 0x78f300 0x7955f0 reset res 2
> ofonod[18642]: > AT+WIND=3D32767\r
> ofonod[18642]: < \r\nOK\r\n
> ofonod[18642]: wind_set
> ofonod[18642]: > AT+CFUN=3D1,1\r

Doesn't this second ,1 parameter cause a reset?

> ofonod[18642]: 0x7955f0: wavecom_enable
> ofonod[18642]: 0x7955f0 the chat is still there!!!!
>
> so _enable is called twice without a _disable inbetween. The _enable rout=
ine
> returns -EINPROGRESS and the AT+CFUN=3D1,1 probably too much time then
> or failed somehow differently. In this specific case the GAtChat will not=
 be
> unrefed which means the fd will be leaked.

Try using CFUN=3D1, and CFUN=3D4.

>
> So how can the plugin figure out that the core has decided not to move fo=
rward?
>

The set_powered() method should succeed in a second or two, maybe 5.  I =

think the core uses a 20 second timer, so if you're hitting that, then =

there's something fundamentally wrong.

Fundamentally the driver needs to ensure that the core callback is =

called within a decent time frame.  The timeout handling in the core is =

just a failsafe for the applications to be notified that the hardware is =

not available.

Regards,
-Denis


--===============6186814735711180354==--

