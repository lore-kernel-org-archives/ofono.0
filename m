Content-Type: multipart/mixed; boundary="===============0794490033227760060=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 21:05:11 +0200
Message-ID: <CAKSBH7E15UrnzmF+GENagRUMwUONq2BR+PR8EDAeYNkhG2Dnaw@mail.gmail.com>
In-Reply-To: <dbf1fa8d-fd15-0890-ebfe-e0b8e4ad82c8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0794490033227760060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> Then memcpy the pending structure (or the needed members) into an area
> with lifetime you control.

that's better, excellent even: I only need chat as a matter of fact.

>
> >>
> >> Why are you removing the destructor.  This will cause leaks whenever a
> >> hot-unplug event happens and this command is queued...
> >>
> >> If you want to use cbd across multiple commands, the proper way to do
> >> that is with a reference counted structure.
> >
> > is there an example elsewhere in the code?
> >
>
> drivers/ubloxmodem/netmon.c
> drivers/hfpmodem/slc.c

oh, it's done by hand. Like this I knew how to do it :)
Nevertheless, good example. I will do the same.

>
> There may be a few other places that get this wrong and should be fixed.
>   Feel free to point them out when/if you see these.

ok. It is difficult to grep because the lines are broken (and
therefore cannot grep for it), so it is just in case I step on them by
chance.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============0794490033227760060==--

