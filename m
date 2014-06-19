Content-Type: multipart/mixed; boundary="===============4693037751556928954=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH 1/3] gatchat: implement PAP authentication
Date: Thu, 19 Jun 2014 10:29:53 +0200
Message-ID: <20140619082953.GA33006@rincewind.trouble.is>
In-Reply-To: <53A210C0.9020501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4693037751556928954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-18 17:20:48 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Philip,

Thanks for your review Denis.  I'll send an updated patch in a bit.  I
hadn't noticed the doc/coding-style.txt document and just tried to be
consistent with the existing code.

> On 06/17/2014 04:57 PM, Philip Paeps wrote:
> >    This works around the amusing requirement of 3GPP TS 29.061 that
> >    modems must send a forced positive acknowledgement of the
> >    authentication method tried (i.e.: the modem will successfully
> >    accept any CHAP handshake, but if the network only supports PAP,
> >    the modem will hang up when it tries and fails to activate the
> >    PDP context)
> =

> In theory this is because CHAP authentication should always be accepted
> by the network operator, but it seems there are still a few out there
> that do not do this properly.

My reading of TS 29.061 leaves me feeling there's a misalignment between
the PPP side and the packet data side of modems and this is glossed over
by requiring that modems must send a forced positive acknowledgement to
any authentication method tried (even none).

On the network side, it looks like the authentication method could in
principle be anything you can convince RADIUS about, but there is no way
for the modem to know which methods are supported (or required) before
trying to set up the packet data context.

The modem is expected to copy the authentication parameters it gets
through PPP into protocol configuration options when it sets up the
packet data context on the network side and hang up PPP when it fails.

I couldn't find a requirement for CHAP.  Only the requirement that it
should be tried first, and the requirement that any method tried should
get a forced positive acknowledgement.  I'm not intimately familiar with
these standards though, and I've not read them all.

> > +			default:
> > +				/*
> > +				 * We only support CHAP and PAP.
> > +				 * Tough luck!
> > +				 */
> > +				return RCR_NAK;
> =

> Since this can never happen, we should probably not even include this
> statement.

I originally had g_assert() here, but since it doesn't look like that's
a popular construct for catching programmer forgetfulness in ofono, I
turned it into a reject.  As coding-style.txt points out though, the
compiler will complain if the enum changes, so I'll drop the default
case in my updated patch.

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============4693037751556928954==--

