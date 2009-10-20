Content-Type: multipart/mixed; boundary="===============2947213520399822969=="
MIME-Version: 1.0
From: DJDAS <djdas@djdas.net>
Subject: Re: How to talk with FreeRunner?
Date: Tue, 20 Oct 2009 10:09:06 +0200
Message-ID: <4ADD7022.9040905@djdas.net>
In-Reply-To: <fb249edb0910191122sbcf5747i4f937f711dfb5520@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2947213520399822969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Andrzej Zaborowski ha scritto:
> Hi,
>
> 2009/10/19 Denis Kenzior <denkenz@gmail.com>:
>   =

>>>       I just got a Openmoko FreeRunner and I wonder how oFono can talk =
with it.
>>> Use ser2net, but how? Can someone help on some simple steps or
>>> instructions? Thanks a lot! By the way, the OS installed in it is Andro=
id
>>> Cupcake. Need I change to other OS?
>>>       =

>> There are a couple of ways:
>>        - Cross compile oFono itself to run directly on the device using =
the calypso
>> driver.
>>        - Cross compile ser2net, but run oFono on the desktop using the p=
honesim
>> driver.
>>
>> Either way you will need the cross compiler and toolchain here:
>> http://wiki.openmoko.org/wiki/Toolchain
>>
>> Note that my device came stock with the OpenMoko rootfs, so I have no
>> experience with Android.
>>
>> For ser2net:
>>  - Cross compile ser2net using the supplied toolchain, I don't remember
>> exactly, but I think this will get you there: ./configure --prefix=3D/us=
r --
>> sysconfdir=3D/etc --host=3Darm-angstrom-linux-gnueabi
>>     =

>
> You can possibly avoid the cross compiling if you're going to run
> oFono on PC anyway, by using netcat instead of ser2net.  Either
> "netcat" or "nc" is usually in the packages repo of any distribution.
> The command would be
> # nc -l -p 2000 < /dev/ttySAC0 > /dev/ttySAC0
>
> All other steps would be same as Denis outlined.
>
> If you find that the port is spitting corrupt data, it's probably not
> initialised.  I use picocom to initialise ttys, it's:
> # picocom /dev/ttySAC0
> then ^a^q to quit picocom without resetting the port and then re-run nc.
>
> Regards
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>   =

Hi all,
I'm the project leader of a new Freerunner distribution which claims to =

be AT MOST a stable telephone instead of replicate all the other =

distributions who claim to port the desktop-style distribution paradigm =

to the Freerunner. In this way of think we planned to use oFono as the =

main telephone stack because, following the mailing list since the =

starting of the project, I believe oFono is a very well planned and =

developed platform.
At the moment I am able to cross compile oFono with my toolchain and it =

works quite well on my Freerunner so if someone needs a tarball with =

ofonod and everything "make install" produces I can provide them without =

problems :)
Thank you very much for your great work good bye.
Dario.


--===============2947213520399822969==--

