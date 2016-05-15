Content-Type: multipart/mixed; boundary="===============0982978132466655938=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 15:01:42 +0200
Message-ID: <57387336.5070809@chini.tk>
In-Reply-To: <57386BDF.50702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0982978132466655938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 14:30, Marco Trapanese wrote:
> Il 15/05/2016 14:15, Georg Chini ha scritto:
>> Not sure if the other daemons must be run as root, but at least it =

>> works for me to start
>> ofono and bluetooth during system startup and run pulseaudio as a =

>> normal user (not
>> as user pulse)
>
>
> I'm afraid about all these variables!
> Anyway, I did the following:
>
> - added the dbus policies for both user "pulse" and "user" (the actual =

> one)
> - started bluetooth and ofono as system service (as root)
> - started pulseaudio as normal user
> - followed the usual test procedure
>
> The behavior is exactly the same: connected, enabled and call made but =

> no audio.
> Thank for the patience!
>
To me it still looks like this is an issue with your dbus access rights. =

Everything else
looks fine - even the loopback modules are loaded but don't receive / =

send any audio.

Something else I noticed: It looks like you can't get high priority and =

also no timer based
scheduling for pulseaudio. This means that your audio quality will =

probably be really bad.
Also there are lots of other errors in the PA log. It seems that there =

is still something
broken in your build. Or is that due to the embedded system?

--===============0982978132466655938==--

