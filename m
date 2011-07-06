Content-Type: multipart/mixed; boundary="===============5851653219497260803=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: Re: [Meego-handset] ofono-qt - anything to add/improve?
Date: Wed, 06 Jul 2011 10:32:37 -0700
Message-ID: <20110706173237.GF9901@cyclone.jf.intel.com>
In-Reply-To: <CAA=2nCauqwr5zS=sGn7LJ_RbVnW6hOda1CiUz83KfMHw+jdkug@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5851653219497260803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2011 at 09:21:10AM -0400, Antoine Reversat wrote:
> Also from what I've heard the dialer is going to use ofono-qt at some
> point. It would probably be good to have the insight of Shane or Tom
> on what's missing, what needs to be improved, etc.

Correct, and true for git master but not yet in a released "package".

I just SR'd the 0.1.4 version of libofono-qt prior to this weekend
and it's in Trunk:Testing at this point.  I can't release a new
package for dialer until this moves into Trunk and/or one of the
MeeGo 1.2 branches since it depends on the multiparty call APIs I
added a few weeks back.

FYI... An added complication was just revealed to me, all MTF packages
have been deleted/removed from Trunk.  So until dialer is completely
purged of all MTF deps (modulo anything provided by libmlite of course)
I can't push a new release of dialer into Trunk :(

Roland is doing a bunch of that work, and expects to be done around
July 18th.  As I've not seen any of it yet, and we're still trying
to completely merge the HRP fork *and* migrate to libofono-qt, I
expect some added time (~1 week is a guess) to work through any merge
conflicts that arise.

> Unfortunately I think Shane is on vacation.

Back now...

> > L=C3=A4hett=C3=A4j=C3=A4: meego-handset-bounces(a)lists.meego.com [meeg=
o-handset-bounces(a)lists.meego.com] k&#228;ytt&#228;j&#228;n Alexander Kan=
avin [alex.kanavin(a)gmail.com] puolesta
> > L=C3=A4hetetty: 4. hein=C3=A4kuuta 2011 16:01
> > Vastaanottaja: ofono(a)ofono.org; meego-handset(a)lists.meego.com
> > Aihe: [Meego-handset] ofono-qt - anything to add/improve?
> >
> > Hi,
> >
> > I am the maintainer of ofono-qt library, which provides Qt bindings to
> > ofono services and licensed under LGPL 2.1:
> > http://meego.gitorious.org/meego-cellular/ofono-qt
> >
> > I would like to get in touch with everyone who is using it, or perhaps
> > would like to use it, and find out if there is anything incomplete,
> > missing or possible to improve there. Let me know please.

Alexander

Two things come to mind:

1) A document that identifies which version of oFono the libofono-qt is
   targeted for and some metric, like what percent of that version oFono's
   API is complete/covered by this library.

2) A bit harder to do, espcially for the currently used CallHistory plugin,
   but we need an API for getting call history signals and methods from the
   agent providing that data.

On a matter related to 1) above, what is your plan for keeping pace with
oFono upstream releases and (maybe more important to this list) keeping
pace with oFono package updates in MeeGo OBS?  No plan is a fine answer,
which should (hopefully) spark offers for help, but if you *do* have a
plan, I (and I assume others) would like to know what it is.

As usual I am happy to continue helping, but my responsiveness will still
only be as my time permits.

> > Also, if you know an easy way to find out what is dependent on this
> > library in Meego, that would be great too.

As Timo noted, rpm -q --whatrequires <package> does the trick on an
installed host.

I thought there was a zypper command to do something similar, but it's
not coming to me and a quick glance at the man pages is not revealing
an obvious answer... if anyone knows, please inform us ;)

Regards,

-- =

Shane...

--===============5851653219497260803==--

