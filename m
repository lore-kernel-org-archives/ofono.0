Content-Type: multipart/mixed; boundary="===============8136936110128029949=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Howto about Qt QML and Ofono
Date: Thu, 22 Jul 2010 08:25:16 -0700
Message-ID: <1279812316.2621.8.camel@localhost.localdomain>
In-Reply-To: <AANLkTinmdxG-ALgn1pHPI1KaCE2bdpgT3AFAosV2X9Jp@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8136936110128029949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joao,

> >>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-=
1/
> >>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-=
2/
> >>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-=
3/
> >>>>
> >>>> I hope this helps people out there to create cool new phone
> >>>> applications. You're welcome to leave a note here or on the howto di=
rectly.
> >>>>
> >>>
> >>> Your lovely program gives a good demo on how to writing an applicatio=
n based on
> >>oFono. oFono does claim it will help on building application in a conve=
nient way, so
> >>the prosperity of application will definitely bring feedback to oFono a=
nd make oFono
> >>grow better.
> >>> I have two comments on your first part: 1) configure is not in the gi=
t tree of oFono, so
> >>we will use bootstrap-configure instead. 2) I'm sure your phonesim work=
s well. But we
> >>also have another phonesim derived from your repo, which we had some mo=
dification
> >>and enhancement in. The repo is
> >>"git://git.kernel.org/pub/scm/network/ofono/phonesim.git". The building=
 command is
> >>same as oFono, and the execution command is "./phonesim -p 12345 -gui
> >>src/default.xml".
> >>
> >>Thanks Yang, I've added the ./bootstrap command to the listing. I also
> >>wrote down a hint to the ofono branch of phonesim.
> >
> > "bootstrap-configure" is a single script, rather than two different one=
s.
> >
> =

> There is a bootstrap script also, and bootstrap-configure basically
> runs it and then runs configure with a pre-set of switches.

and more important with a pre-set of switches that every developer
should use since it enables proper debug and maintainer mode. With these
switches the compiler becomes your best test tool before submitting
patches.

However bootstrap and bootstrap-configure is not intended for packaging.
And that is why you only find these in the ofono.git repository and not
in the tarballs.

Regards

Marcel



--===============8136936110128029949==--

