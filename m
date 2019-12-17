Content-Type: multipart/mixed; boundary="===============5988562310627305192=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Tue, 17 Dec 2019 23:50:53 +0000
Message-ID: <CABBYNZKpKyK0Hj2PwD7OmC1yuJU7uniyLd62t5RyVpP7miYqBg@mail.gmail.com>
In-Reply-To: <20191216091521.reh2urr25husschv@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5988562310627305192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Mon, Dec 16, 2019 at 1:15 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
>
> Hi!
>
> On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > >
> > > On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > > > possible, then that's not possible.
> > > >
> > > > I do not know if bluez developers are interested in having this cod=
e as
> > > > part of bluez project, specially when in bluez4 HFP profile was the=
re
> > > > and in bluez5 was HFP code completely removed.
> > >
> > > Hello, could someone from bluez developers comment this Tanu's point?
> >
> > I would have to say no, we are definitely not interested in yet
> > another daemon for AT parsing, we actually have too many of these
> > around, either in a form of Modem Manager, oFono, etc.
>
> Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> implementing logic around HSP and HFP profiles and export either native
> interfaces (linux uinput) or DBus interfaces for features provided by
> HSP and HFP specifications and also for current and future vendor
> extensions. And part of this HSP/HFP implementation is of course needed
> parsing and interpreting some of AT commands. Look into my design and
> API proposal. Current daemons which provides AT parsing (like ofono or
> modem manager) are not suitable for for whole HSP and HFP profiles with
> all those extensions (like all possible ways for reporting battery
> level), so for HFP is needed some of custom AT parser.

Not following you on this one, oFono is intended for telephony
functionality and afaik it could parse battery, etc. Also would your
daemon include such functionality or you are to combine that with
oFono? I do appreciate the effort you have put into the SBC modes and
codec support but Im afraid you are going to experience some real pain
to maintain such a system all in your own, there are a lot of features
being exposed via AT commands and we risk to have yet another daemon
that just do parts of them until the next person comes with a
different use case and we are back to square one.

> > That said one
> > simpler way to resolve all of this is to maintain a plugin to
> > bluetoothd that way HSP/HFP becomes native again, that can either be
> > maintained in the tree or out of the tree.
>
> I do not see how could just plain plugin for bluez without AT parser
> could help. This seems to just complicate whole implementation. I
> already implemented prototype implementation of hsphfpd to see how
> complicated it is and what is needed...

Well the exactly the same thing with yet another daemon, we obviously
will need an AT parser, but the nice thing of being a native plugin is
that it can detect if another entity register for HSP/HFP and disable
itself (or have a policy to control that), the implementation can be
exactly what you have but without the extra rounds trips involved to
communicate back and forth with your daemon, so it is pretty straight
forward in terms o implementation.

> So if bluez daemon is not the right place for hsphpfd, it would be
> separate daemon outside of bluez.
>
> --
> Pali Roh=C3=A1r
> pali.rohar(a)gmail.com



-- =

Luiz Augusto von Dentz
--===============5988562310627305192==--

