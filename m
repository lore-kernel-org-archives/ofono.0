Content-Type: multipart/mixed; boundary="===============0972855187915254711=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: PPP LCP configuration issue
Date: Fri, 02 Apr 2010 16:17:14 -0700
Message-ID: <20100402161714.7847690a@kcaccard-MOBL3>
In-Reply-To: <1270242118.22331.101.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0972855187915254711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Apr 2010 14:01:58 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> > > so I added some debug code to actually print the options during the
> > > configuration stage. And something seems to be wrong here.
> > > =

> > > lcp: pppcp_open_event: current state 0:INITIAL
> > > lcp: pppcp_up_event: current state 1:STARTING
> > > lcp: pppcp_initialize_restart_count: current state 1:STARTING
> > > lcp: pppcp_send_configure_request: current state 1:STARTING
> > > lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> > > lcp: pppcp_process_configure_request: current state 6:REQSENT
> > > lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> > > lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
> > > lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
> > > lcp: option 7 len 2 (Protocol-Field-Compression)
> > > lcp: option 8 len 2 (Address-and-Control-Field-Compression)
> > > lcp: pppcp_rcr_plus_event: current state 6:REQSENT
> > > lcp: pppcp_send_configure_ack: current state 6:REQSENT
> > > lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> > > lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
> > > lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
> > > lcp: option 7 len 2 (Protocol-Field-Compression)
> > > lcp: option 8 len 2 (Address-and-Control-Field-Compression)
> > > lcp: pppcp_process_configure_ack: current state 8:ACKSENT
> > > lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> > > oops -- found acked option 2 we didn't request
> > > lcp: pppcp_rca_event: current state 8:ACKSENT
> > > lcp: pppcp_initialize_restart_count: current state 8:ACKSENT
> > > =

> > > I see the oops comment here, but we clearly requested the async contr=
ol
> > > character map. So why does it get recognized as not requested? This is
> > > clearly a bug and needs to be fixed.
> > =

> > what is happening is that we are first send a Config-Request with =

> > the accm option as our only option.  We then receive a Config-Request
> > from the modem, with accm along with several other options requested.
> > We ack the modem's Config-Request and apply the options, and then delete
> > them from the list of options that we need to have.  Then the modem
> > response to our original Config-Request with an ack to our accm option.
> > Because we already applied this option and removed it from the list of
> > things we care about, it shows up as an option we didn't request.
> > I think I could just delete the error message, and silently ignore =

> > this condition. =

> =

> are these options really negotiated for both sides in common. Or is the
> negotiation process for each side individual?

I think you are right for accm - they are separate.  I did have a note to =

myself to figure out how to do separate transmit accm and receive accm.  I'=
ll
move that item up the priority list.

--===============0972855187915254711==--

