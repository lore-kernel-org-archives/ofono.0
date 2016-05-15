Content-Type: multipart/mixed; boundary="===============1860233702274250593=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 15:24:25 +0200
Message-ID: <57387889.4040204@chini.tk>
In-Reply-To: <573874C3.4010001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1860233702274250593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 15:08, Marco Trapanese wrote:
> Il 15/05/2016 15:01, Georg Chini ha scritto:
>> To me it still looks like this is an issue with your dbus access =

>> rights. Everything else
>> looks fine - even the loopback modules are loaded but don't receive / =

>> send any audio.
>
> I would try to run all services as normal user, but it is different =

> than your experience.
> Your dbus policies are different than mine?

No, they are not different. But as I said, I have not used/tested it for =

quite a while.

>
>> Something else I noticed: It looks like you can't get high priority =

>> and also no timer based
>> scheduling for pulseaudio. This means that your audio quality will =

>> probably be really bad.
>
> It is. I've already asked to the pulseaudio guys how to improve the =

> audio quality, but currently I'm still here.

It looks like something is missing on your system.

>
>
>> Also there are lots of other errors in the PA log. It seems that =

>> there is still something
>> broken in your build. Or is that due to the embedded system?
>
> PA itself works fine with paplay and parecord. The problems rise only =

> when I try to use bluetooth audio.
> For example the a2dp "works" (apart the poor quality) but every time =

> the stream is suspended the bluez source is released and I need to =

> disconnect and reconnect again the phone to hear the audio another time.
>
> This isn't the expected behavior, but nobody knows why this happens!

Well, this is expected behavior (at least partly). The source goes away, =

when the bluetooth connection
ends, which is usually the case after playing something. But the source =

should re-appear automatically
when the connection is re-established.

>
>
> I'm fighting against these problems for over 10 days... I need to find =

> a solution!
> Because Buildroot compiles all packets from the sources it MUST be =

> just a matter of configuration.
>
>
Might be missing dependencies, see above, then it is not only configuration.

--===============1860233702274250593==--

