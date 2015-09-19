Content-Type: multipart/mixed; boundary="===============7857483033594806900=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Hands Free/Pulse - not working well
Date: Sat, 19 Sep 2015 15:59:32 +0200
Message-ID: <55FD6A44.8070000@chini.tk>
In-Reply-To: <CAHY_EhUkVh3Ve2LgoK3=4iPxnq8nT5HwuFKCF+mUrz0W4EwYpA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7857483033594806900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18.09.2015 20:01, Jason Gauthier wrote:
> Greetings,
>
>       I've been working on getting a HFP working with bluez and =

> pulseaudio.  I'm running into an assortment of issues- I don't even =

> know where to begin!
>
> To set the stage, I'm running the latest version of bluez (5.33) =

> pulseaudio (6.0) and ofono
> (pulled out of git). I've compiled everything from source.
>
> Using PA and Bluez, I have audio sink working.  So I've verified =

> several components at this point.
> I can connect the HFP.  Once I start making calls, is when things =

> start to fall apart.
>
> (BTW, this happens with ofono 1.15, and 1.16 as well)
>
> So, as I'm writing this, the last two times after booting (debian =

> jessie), connecting, and dialing, the system reboots. I've tried =

> looking at debugging the kernel crash, and I've just not got very far.
>
> I realize no one can tell me clearly how to fix this, I would =

> appreciate some suggestions, or ways I can continue to debug this.
>
> Ultimately, my goal is to put this on a raspberry pi for a car stereo. =

> At the moment, I am just trying to get a proof of concept working.
>
> Thanks!
>
Hi Jason,

do you use headset=3Dofono as parameter to module-bluetooth-discover in =

default.pa?
Otherwise things will go wrong, although I would not expect a reboot of =

the machine.

Regards
              Georg

--===============7857483033594806900==--

