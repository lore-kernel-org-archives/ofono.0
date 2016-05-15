Content-Type: multipart/mixed; boundary="===============7323823983459733723=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 13:43:51 +0200
Message-ID: <573860F7.2040104@chini.tk>
In-Reply-To: <57385D0C.60001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7323823983459733723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 13:27, Marco Trapanese wrote:
> Il 15/05/2016 13:15, Georg Chini ha scritto:
>> One thing I have seen on first inspection:
>>
>> It looks like a line
>>
>> <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
>>
>> is missing in your ofono.conf.
>> There are messages indicating that in your dbus-log:
>>
>> error time=3D1463309285.724282 sender=3Dorg.freedesktop.DBus -> =

>> destination=3D:1.13 error_name=3Dorg.freedesktop.DBus.Error.AccessDenied =

>> reply_serial=3D69
>> ...
>> method call time=3D1463309305.723208 sender=3D:1.13 -> destination=3D:1.=
14 =

>> serial=3D70 path=3D/HandsfreeAudioAgent; =

>> interface=3Dorg.ofono.HandsfreeAudioAgent; member=3DNewConnection
>>
>>
>> Could you add the line and retry?
>
>
> Of course!
> I added the linne, rebooted and followed again the procedure. It seems =

> the errors are still there.
>
Did you try to run pulseaudio as normal user? You should avoid system =

mode if possible.
It still looks like there is something wrong with your dbus access =

rights, this time the reply
from pulseaudio is denied.

Maybe you could try and add something like

   <policy user=3D"pulse">
     <allow send_destination=3D"org.ofono"/>
   </policy>

to your ofono.conf, but that is just a wild guess. I am not too familiar =

with dbus.

--===============7323823983459733723==--

