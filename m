Content-Type: multipart/mixed; boundary="===============5855450684164674258=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 12:32:59 +0200
Message-ID: <5738505B.4040908@chini.tk>
In-Reply-To: <57380D39.1020406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5855450684164674258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 07:46, Marco Trapanese wrote:
> Il 14/05/2016 22:43, Stephan Schmolke ha scritto:
>>
>> Hi,
>>
>> I assume you don't hear the audio on your PC. It's been 3 years since =

>> I last used ofono but at that time it was necessary to create a =

>> loopback connecting your Bluetooth audio sink and your audio sink =

>> (e.g. speakers) so that the incoming audio is routed to your speakers =

>> or headphone.
>>
>
> If I understand correctly you're saying the "Transport endpoint not =

> connected" error is not significant, because I manually need to create =

> a loopback? I understand are the pulseaudio modules which should =

> create the loopback automatically, shouldn't they? =

Yes, loopback modules are created automatically. The error message you =

are getting is relevant,
but the problem is rather somewhere on the bluetooth side. From my =

experience the fact that
you get A2DP connected does not mean that HFP is working as well. Take a =

look at the debug
logs of ofono, pulseaudio  and bluetoothd and at the dbus messages that =

are passing between
the different components. Maybe you'll find a hint there what is going =

wrong.
Did you set headset=3Dofono for module-bluetooth-discover?

> For me the integration of bluez5/pulseaudio/ofono is very hard. Is =

> there any alternative? Or there are any companies which offer a =

> technical support?

As far as I know, you don't have much of a choice.

>
> Thanks
> Marco
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============5855450684164674258==--

