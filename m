Content-Type: multipart/mixed; boundary="===============1077974939529578270=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [pulseaudio-discuss] [RFC] [PATCH 0/2] HFP AG integration with
 PulseAudio
Date: Wed, 03 Feb 2010 16:38:40 -0200
Message-ID: <aa32413d1002031038h1d5c8e99udc38053e166263e6@mail.gmail.com>
In-Reply-To: <20100202111019.GA27346@tango.0pointer.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1077974939529578270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 2, 2010 at 09:10, Lennart Poettering <lennart@poettering.net>=
 wrote:
> On Fri, 29.01.10 12:53, Jo=C3=A3o Paulo Rechi Vita (jprvita(a)gmail.com) =
wrote:
>
>> > Any help on testing and getting this working together or comments on t=
he
>> > topic would be appreciated.
>> >
>> > [1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
>> > [2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html
>> >
>> >
>> >
>>
>> I forgot to add, suspending of the sink/source seemed to cause
>> disconnection by the AG, so you might want to disable
>> module-suspend-on-idle when testing. BTW, Lennart, is there any way to
>> mark a source/sink to not be suspended?
>
> Not really. As Colin mentioned you can make suspending a simple NOOP
> which does what you want. That said I do believe it makes a lot of
> sense to actually mark sinks as "suspendable". I.e. Introduce a sink
> flag PA_SINK_SUSPENDABLE or so that we flag for all sinks that
> actually support suspending and leave unset fo all others, like yours.
>

Even after figuring out suspending wasn't really causing any problem
to my tests, it sounds like a good thing to have support for.

> Anyway, the patches look really good to me. I'd be happy to merge
> this, though is the bluez counterpart merged yet? (sorry, haven't
> closely followed bluez development for a while)
>

BlueZ part is still not merged, the code is under peer-review now but
it's likely to be merged soon. There may be some modification on which
signals to listen in order to load module-bluetooth-device (for HFP
case only), also. I'll send a patch rebased against git's head when
the merging time comes.

> Lennart
>
> --
> Lennart Poettering =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Red Hat, Inc.
> lennart [at] poettering [dot] net
> http://0pointer.net/lennart/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GnuPG 0x1=
A015CC4
> _______________________________________________
> pulseaudio-discuss mailing list
> pulseaudio-discuss(a)mail.0pointer.de
> https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss
>



-- =

Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/

--===============1077974939529578270==--

