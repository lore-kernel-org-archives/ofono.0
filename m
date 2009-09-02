Content-Type: multipart/mixed; boundary="===============3052208124607774273=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 10:36:09 -0500
Message-ID: <200909021036.09618.denkenz@gmail.com>
In-Reply-To: <a32762a20909020832j4084cb9dud84f7304dfc9c440@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3052208124607774273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> Hi Denis,
>
> 2009/9/2 Denis Kenzior <denkenz@gmail.com>:
> > So the general rule is that if a feature isn't explicitly allowed in
> > 27.007, we do not support it.  There are exceptions to this of course.
> >  27.007 only supports two states for context: activated and deactivated.
>
> Ahem. Just like access selection mode is not in 27.007, yet Nokia has
> it, and most AT modems have proprietary commands to query and set it
> [1]. Maybe you call that the necessary exception to the rule, but I
> think we might as well change the rule to:

So my stance on BandSelection is that we want a standard interface _if and =

only if_ we can support it reliably across the majority of modems.  You mig=
ht =

still find me telling every modem manufacturer to simply implement their ow=
n =

BandSelection interface if this cannot be done.

The same goes for Neighbor Cell Info or any other stuff that isn't mandated=
 by =

27.007.

>
> >> spec 27.007. However, the problem is that Maemo 5 already has UI
> >> support for indicating that the connection is suspended, and that
> >> makes it harder to drop the feature. Could the "suspended" status enum
> >> still be left there, and just have the modems that don't support the
> >> feature to never go to "suspended" mode?
> >
> > I'd rather not.
> >
> > If this feature is really required, then some sort of heuristic can be
> > applied.  (e.g. Powered on, Attached on, but context is deactivated most
> > likely means temporary unavailability of resources)
>
> You want the UI to implement this heuristic, when the modem plugin has
> explicit knowledge of that state, but isn't telling? Please explain
> how that makes the UI simpler?

Then expose this signal on Nokia-only interface and be done with it.  Why d=
oes =

everything have to be part of the oFono official APIs?

Regards,
-Denis

--===============3052208124607774273==--

