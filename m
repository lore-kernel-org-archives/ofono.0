Content-Type: multipart/mixed; boundary="===============1733057708278599657=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 13:15:30 +0200
Message-ID: <57385A52.9090108@chini.tk>
In-Reply-To: <5738564B.9080700@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1733057708278599657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 12:58, Marco Trapanese wrote:
> Il 15/05/2016 12:39, Georg Chini ha scritto:
>> I've only seen the pulseaudio logs. ofono and bluetoothd also might =

>> provide some information.
>> Try also dbus-monitor --system. You should see the messages passing =

>> between the components.
>
>
> Attached there are all the logs:
>
> - pulseaudio
> - bluez
> - dbus
> - ofono
>
> I also attached the dbus policy configuration - perhaps there is =

> something wrong there.
>
> What I did:
>
> 1. launched all services: dbus, bluetooth, ofono, pulseaudio
> 2. connected the phone for both a2dp and hfp profiles
> 3. from ofono/test:
>     a) enable-modem
>     b) online-modem
>     c) dial-number
>
> What happened:
>
> - the phone recognized both bluetooth profiles (it said: connected to =

> multimedia audio and phone)
> - when I dialed the number, the phone actually made the call
> - the bluetooth audio icon on the phone was highlighted
> - but the audio was coming from the phone's speakers
>
> About the last point: sometimes (but I really don't know when) I don't =

> hear nothing, neither from the phone nor from the raspberry. Other =

> times (like now) the audio is coming from the phone.
>
> Thank you for you support
> Marco
One thing I have seen on first inspection:

It looks like a line

<allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>

is missing in your ofono.conf.
There are messages indicating that in your dbus-log:

error time=3D1463309285.724282 sender=3Dorg.freedesktop.DBus -> =

destination=3D:1.13 error_name=3Dorg.freedesktop.DBus.Error.AccessDenied =

reply_serial=3D69
...
method call time=3D1463309305.723208 sender=3D:1.13 -> destination=3D:1.14 =

serial=3D70 path=3D/HandsfreeAudioAgent; =

interface=3Dorg.ofono.HandsfreeAudioAgent; member=3DNewConnection


Could you add the line and retry?

--===============1733057708278599657==--

