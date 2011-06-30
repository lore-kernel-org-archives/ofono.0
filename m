Content-Type: multipart/mixed; boundary="===============3813510821857373508=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Incoming patch HS2330 detection, plugins/udev.c
Date: Thu, 30 Jun 2011 13:20:06 -0700
Message-ID: <1309465208.2208.59.camel@aeonflux>
In-Reply-To: <20110630194639.GA5689@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3813510821857373508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> It might interest you that I made a feature request 20386 on the
> MeeGo bugtracker [1][2] today to include PIN entry logic in the
> MeeGo network panel. Not sure how far this request will go or if
> they'll (gulp) ask me to do it myself... I'm still unclear on the
> boundaries and coupling between ofono, connman, and the UI pieces
> like the MeeGo network panel.

we do not really work on MeeGo network panel related UI details, but in
general there needs to be a split between network generic tasks and
technology specific ones. Similar to that we have a Bluetooth panel for
pairing etc.

So would expect to see a cellular panel that allows to enter the PIN
code and configure the APN settings. Since APN settings are oFono
specific and have nothing to do with ConnMan.

I leave this all up to our UX designers :)

Regards

Marcel



--===============3813510821857373508==--

