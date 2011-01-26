Content-Type: multipart/mixed; boundary="===============5927382029757042897=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of
 GPRS context settings
Date: Wed, 26 Jan 2011 12:18:44 +0100
Message-ID: <1296040724.1520.121.camel@aeonflux>
In-Reply-To: <AANLkTinWmPRj2J6RPVs__7pm-d9yxO17erggMjm1kY9r@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5927382029757042897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > lets get this merged without support for SPN for now. We can easily add
> > this later. So please fix Denis' comments and re-submit this without the
> > SPN change.
> >
> > Andrew is currently looking into fixing the SIM reading race. Once that
> > is done we can tackle the SPN part. Feel free to add a TODO item for
> > adding access to SPN information.
> =

> By SIM race do you mean an atom getting removed while it has a pending
> ofono_sim_read?

exactly that one. See discussion on IRC.

> > Right now I think we need to do that in the SIM atom, store it, and then
> > provide it for netreg and other plugins that might want it. However we
> > might need to discuss this a bit further.
> =

> I think this is actually easy to fix internally to the sim atom. The
> first ofono_sim_read() to EFspn would initiate an async read, and any
> call to ofono_sim_read() after the fact would pend on that single read
> results, or return immediately with cached results if available.

<snip>

I let Andrew to comment on this. He is already looking into this.

> So I don't see the point in removing the SPN code from provisioning
> right now. It is a necessary part of the solution, so at least we need
> to keep the task open as long as SPN is not in.

The SPN is not required by provisioning itself. It is required by the
provisioning plugins. That is why I said we should put a new item in the
TODO list to track it.

Or maybe just storing SPN in the SIM atom with a proper API for plugins
and netreg to access it. However I do wanna decouple this from this set
of patches now. Otherwise we are turning in circles and not getting
anywhere. Same as we decoupled the SIM MCC/MNC getter patches.

Regards

Marcel



--===============5927382029757042897==--

