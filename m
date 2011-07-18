Content-Type: multipart/mixed; boundary="===============8139232930135930347=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Mon, 18 Jul 2011 17:17:22 +0200
Message-ID: <1311002244.21109.161.camel@aeonflux>
In-Reply-To: <4E242B30.201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8139232930135930347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > On 07/15/2011 09:18 PM, Denis Kenzior wrote:
> >> Does mobile-broadband-provider actually have multiple settings yet? If
> >> not, then this might need to be set to 1 until it does.
> > =

> > Actually, it does.
> > =

> =

> Are you sure? Briefly looking through serviceproviders.xml I only
> noticed different plans within the same provider.  You might be right of
> course, but even if you are, we have no way of distinguishing between a
> different plan and a different APN type.

I think you are right. It currently has multiple entries, but it misses
any kind of type declaration.

> >> I'm a little unclear on how we handle multiple matches of the same
> >> mcc/mnc.  To my understanding these are different plans within the same
> >> provider and some user intervention is required to select the right
> >> plan.  Or it could be that the operator is actually an MVNO, which is
> >> why the SPN provided by oFono in order to to distinguish between them.
> >>
> >> So it sounds like that if we encounter entries where multiple matches
> >> are possible, we should not actually provision the context.
> > =

> > To my understanding, multiple matches of the same mcc/mnc might be
> > because of:
> > =

> >  - Different kind of settings (internet/mms/wap).
> >  - Different plans for the same kind of setting (prepaid/postpaid).
> >  - MVNO.
> > =

> > A few possible solutions in order to avoid the ambiguity would be:
> > =

> > 1. One could try guess the type of settings out of the access point
> > name. This should work with a few exceptions, which could be handled
> > case by case.
> > =

> > 2. Same as item 1, except when the kind of settings can't be guessed,
> > just not to provision the context and let the user possibility to choos=
e.
> > =

> > 3. To introduce additional tags (internet, mms, wap, prepaid, postpaid).
> =

> Option 2 sounds like the most likely candidate right now.  Option 3 is
> the direction where we need mobile-broadband-provider-info to go in.  In
> particular adding the internet/mms/wap tags and SPN entries to its databa=
se.

Oleg, please work with the NetworkManager/ModemManager guys to get the
XML extended and get these tags and additional information merged into
to the upstream database.

Regards

Marcel



--===============8139232930135930347==--

