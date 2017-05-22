Content-Type: multipart/mixed; boundary="===============3854900508782064569=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 17:50:20 +0200
Message-ID: <20170522155020.ixybooykvdprjmdj@nataraja>
In-Reply-To: <cf9effcc-7c93-8186-6ae1-bcf8682f0e61@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3854900508782064569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, May 22, 2017 at 10:01:03AM -0500, Denis Kenzior wrote:
> > I can follow that argument.  However, it only applies to libqmi, and not
> > to uqmi, which doesn't use glib.  On the other hand, it appears to be
> > using libubox, which is very OpenWRT/LEDE specific.
> =

> Didn't know uqmi existed.  Looks like that project started about a year
> after qmi driver was functional.  So again, wasn't really a consideration.

Nobody argues that things should or could have done different in the
past. My comments are strictly reserved to the future.

Does it make sense to extend the hand-written QMI encoder/decoder code,
or does it make more sense to invest time in re-using the apparently
more complete description [and work] in the libqmi+uqmi world?

> But just to make it clear: anything we introduce would have to depend only
> on libc and perhaps on the bare minimum set of features we use from glib =
at
> the moment.

That's perfectly fine and I don't think it would be an issue.

> complete, sure.  But then we only use a very small subset of QMI. Pointle=
ss
> to generate all this code if you use 5-10% of it.

As far as I know, the ofono qmi driver does not cover yet all the ofono
dbus interfaces that are documented (at least not for all the QMI
versions seen out there?).  So to get 100% of the ofono interfaces
implemented, you probably will need to implement more of QMI.

Also, with modems/phones implementing things like IMS for LTE (and WiFi
calling), isn't it likely that ofono will also have to cover/implement
related parts of QMI that deal with that?

To me it seemed ofono always wanted to have a more feature-complete
code base to talk to various modems, well beyond the basic voice call +
sms capabilities offered by other projects (openmoko gsmd,
freesmartphone.org) or the single-purpose data-only ModemManager..  I
mean, why else are there topics like SIM toolkit, call hold,
supplementary services, etc. covered in the mission statement and some
of the code?

> Generated code is rarely pretty, or maintainable.  =


it is not supposed to be.  You are editing the templates in the
generator, not the generated code...

> The code generator itself can also be quite large.  We played with the
> idea initially, but didn't think the cost-benefit was there.

The benefit might not be there for you alone, but the issue is that
there are different FOSS QMI implementations out there (libqmi, uqmi,
ofono and possibly more), and implementing encoding and parsing of each
new message or interface N number of times by hand in each project seems
rather inefficient use of the constantly limited resources that FOSS
projects seem to have.

> > Would you think it as worth-while to merge such a QMI driver, either as
> > separate driver, or even as a replacement to the current one?
> =

> I can understand auto-generating qmi data structures and parsers / builde=
rs,
> but how are you going to auto-generate the driver?

the driver of course has to be written by hand.  But not the
encoding/decoding of routines.

> You'll have to educate me on that, so far it seems QMI has been frozen for
> 5+ years.

What are you referring to specifically? The QMI you see in modems out
there? The ofono implementation of it? The specific sub-set used by
ofono so far?

For the sake of an argument: It might even be that the modem/baseband
side is fixed for the past 5 years.  But does ofono implement all
"relevant" features that were present in QMI modems 5 years ago in its
qmimodem driver?

"relevant" to me is pretty much anything that can be done from a phone
side, i.e. anything related to
* device identification + control (on/off/airplane)
* network selection (scanning, manual selection, ...)
* voice call including call hold / multiple calls, dtmf, supplementary serv=
ices
* SMS MO + MT, including delivery reports, *, setting SMSC, ...
* USSD
* activation/deactivation of PDP contexts [including multiple parallel]

We're using ofono from osmo-gsm-tester (see
ftp://ftp.osmocom.org/docs/latest/osmo-gsm-tester-manual.pdf and
http://git.osmocom.org/osmo-gsm-tester/) in order to do full end-to-end
tests on the Osmocom GSM stack including OsmoBTS, OsmoNITB, etc.

From the what the team working on this at sysmocom (Pau Espin, Alexander
Couzens, formerly myself...) have seen so far, it is very hard to have
even only a subset of the above work reliably on any given modem tested
so far.  We originally started with some AT-command based Sierra
Wireless modems (and gave up on that about a year ago) and have since
re-build the tester hardware towards using QMI-based modems.

We've been looking at modern LTE-capable devices like Quectel EC-20,
EC-25, Sierra Wireless MC7304 or even older devices like Gobi2000
and Gobi3000.

I am not complaining here.  I just want to figure out what is the best
strategy to get ofono to work reliably for all "relevant" features on
initially at least one QMI based modem, later on hopefully with many
other modems [using different baseband chipsets and stacks, to test
interoperability of our stack].

Regards,
	Harald
-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============3854900508782064569==--

