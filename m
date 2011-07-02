Content-Type: multipart/mixed; boundary="===============5629457616965630961=="
MIME-Version: 1.0
From: Michael <ofonoconn@encambio.com>
Subject: Re: Incoming patch HS2330 detection, plugins/udev.c
Date: Sat, 02 Jul 2011 21:08:23 +0200
Message-ID: <20110702190823.GA11986@debut.europalab.com>
In-Reply-To: <1309465208.2208.59.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5629457616965630961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Marcel,

On Thurs., Jun 30, 2011, Marcel Holtmann wrote:
>> It might interest you that I made a feature request 20386 on the
>> MeeGo bugtracker [1][2] today to include PIN entry logic in the
>> MeeGo network panel. Not sure how far this request will go or if
>> they'll (gulp) ask me to do it myself... I'm still unclear on the
>> boundaries and coupling between ofono, connman, and the UI pieces
>> like the MeeGo network panel.
>
>we do not really work on MeeGo network panel related UI details,
>but in general there needs to be a split between network generic
>tasks and technology specific ones. Similar to that we have a
>Bluetooth panel for pairing etc.
>
>So would expect to see a cellular panel that allows to enter the
>PIN code and configure the APN settings. Since APN settings are
>oFono specific and have nothing to do with ConnMan.
>
Well I don't think you mean 'panel' here, because they are rather
large overreaching components. Putting cellular information in its
own panel would only be a good thing if there's much more to it than
the APN typically used. Maybe I'm too new to 3G, but it seems to me
that the cellular config can be part of the network panel just as
Wifi information is as well.

Bluetooth probably has its own panel because of potential file
transfers, pairing, tethering, various profile activity... It's
a lot more to configure than just the APN of a cellular connection.

So that's why it might be good to put the PIN entry textedit just
next to the DHCP/Static selector of the cellular device. It would
be a intuitive place to look for it at least.

>I leave this all up to our UX designers :)
>
It would help to know just who that is and where or how they
communicate with the community.

Are these UX designers officially part of the ofono project or
the meego project? When you say 'our UX designers' do you mean
that 'ofono developers maintain the MeeGo network panel code'
as well?

Regards,
Michael

--===============5629457616965630961==--

