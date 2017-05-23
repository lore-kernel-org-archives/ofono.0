Content-Type: multipart/mixed; boundary="===============0796968351733730071=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Tue, 23 May 2017 14:26:08 +0200
Message-ID: <20170523122607.vc2mwptes7zpybjd@nataraja>
In-Reply-To: <E01D60E0-B3AC-417D-83A3-6CD4E23EC8AD@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0796968351733730071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, May 22, 2017 at 04:03:16PM -0500, Denis Kenzior wrote:
> I=E2=80=99m confused.  Are you talking about voice capable modems in gene=
ral
> or the QMI ones?  =


Both.  I may have misinterpreted your statement in general towards
modems.

> I=E2=80=99m of course aware of various Huawei, etc modems that support vo=
ice
> via AT commands, RIL, ISI, etc.  =


Ok, sorry.

> I=E2=80=99m not aware of any QMI based devices.  QMI protocol does support
> voice, so I=E2=80=99m sure they exist.  Just not aware of any.  That is w=
hy we
> never bothered to write the voicecall atom driver for QMI.  If you
> want to contribute that, I=E2=80=99m happy to take it.

On the one hand, I believe virtually any Qualcomm(Android?) based
smartphone is using QMI to control voice.  It might be hidden from the
normal user behind rild, an it might be that virtuall nobody is using
ofono on those devices.

But then, as I iterated in my previous mail, there are plenty of modems
in solder type (LGA), mPCIe and M.2/NGFF form-factor that expose voice
capabilities via QMI.  There's a bunch of Sierra Wireless ones (like
MC7304 & co) as well as EC-20 and EC-25 from Quectel.  I also have some
Hauwei branded here that do QMI for voice.

And yes, we will in some way or another interface QMI for voice on at
least a subset of those modems.  The question is whether we spend time
on hand-crafting messages [error prone] or use the existing JSON
description and generated parser/encoders.  I'm not sure which way is
faster/easier.  If you are fundamentally against code genreation (which
you are not, AFAICT), we would skip that option.  But if you're open to
it within the constraints regarding glib and external dependencies, it
might be an idea to try.

Having spent close to a decade of my life implementing GSM protocols
from hand vs. implementing some using code generation, I am very much in
favor of the latter, whenever possible.

> Yes, but at least the gobi cards I=E2=80=99ve seen only expose a single
> network interface.  So multiple contexts are not possible.

I think this has all slightly changed a bit in the last 3+ years when
the Qualcomm LE stack is used on modern MDM chips.  There you have a
Linux kernel (and adb, but real glibc and no android userland) inside a
Cortex-A5 on the modem itself.  In those devices, you can at runtime
change the configuration/coposition of the USB interface and expose many
more things that are otherwise not exposed.

Basically, on those modern Qualcomm modems, the USB device you're
talking to from the ofono side is not the baseband processor, but it is
a composite android Linux kernel USB gadget.  See the 33C3 talk Holger
and I gave, as well as the information collected on
http://osmocom.org/projects/quectel-modems/wiki

We are not there yet, but after voice, USSD and all the classic features
we'll definitely look into multiple PDP contexts / EPS bearers.

Also, some modern Qualcomm chipsets also seem to have an "IPA" (Internet
Packet Accelerator) which can filter the packets in hardware.  I haven't
fully analyzed it yet (hard without documentation) but it might be that
this can be used to filter devices from one "USB network interface" into
multiple queues / bearers / contexts on the baseband side.  Still
subject to further study.  The Qualcomm kernel patches are only 2
million lines of code, AFAIR ;)

> No such documentation exists.  We had to pick and choose our battles
> and thus never had the resources for something like that.  I=E2=80=99m ha=
ppy
> to host such a matrix in case someone is interested in contributing
> it.

Well, hosting/maintaining the document (which could just be in git) is
the easy part.  The more difficult part is collecting information of who
has actually successfully used which feature on which modem using which
modem firmware version and which ofono version.

In the best case, we are able to provide such information based on the
osmo-gsm-tester in the future.  Our main use case is to test a fixed
and trusted combination of (ofono + modem + modem firmware) against our
changing GSM/GPRS/UTMS cellular network stack.  But the same setup (or a
copy of it) could of course also be used to have a fixed version of the
GSM/GPRS/UMTS network and test a given [new] ofono version/commit
against one or multiple modems as part of continuous automation.

So I think there's something for both projects to benefit from.

But before we can do any of the above, we first have to establish a
reliably working base line configuration.

> Regardless, this isn=E2=80=99t really important.  If you=E2=80=99re set o=
n QMI, then
> its not my place to discourage you. =


Well, I hear you. But for now we will continue down the QMI path for
stated reasons.  The question is probably more whether we can get it to
work inside ofono the way we want/need, or whether we have to consider
alternatives like using libqmi or uqmi directly.  I don't like the
latter part, because eventually we will want to talk to non-QMI /
non-Qualcomm modems, and then we need our own abstraction across those
different modems - which is the same purpose as ofono has, at least from
my point of view.

> Agreed.  But then I=E2=80=99m a bit confused on what you=E2=80=99re tryin=
g to
> accomplish?  =


We want to test our GSM/GPRS/UMTS network side protocol stack and
network elements, preferably with as many different modems as
possible, but starting with Qualcomm modems with QMI and DIAG as that
gives us additional insight into what's happening inside the modem-side
protocol stack.

> If you want to enable more QMI features in oFono, then
> I=E2=80=99m all for you doing that.  Contributions are always welcome.

We have already started to contribute (see some smaller patches by
Alexander Couzens and Pau Espin), and there will almost certainly be
more.  But before we attempt to create some new QMI driver based on
generated code, it was worth to discuss whether or not there is any
chance for that to be merged at all.

So we want to (and will!) contribute, in terms of bug reports, patches
as well as testing.

Trying to use ofono in this context with several different modems for
more than a year now (on and off) it just seems quite a lot harder than
I would have ever anticipated.  In order to enable quicker adoption, I
strongly suggest to create a list of tested/supported modems (+ modem fw
versions) that people can start with, if they want to get the best
out-of-the-box experience.

That list doesn't have to include 100 modems.  So even if it's two
models only on that list, this is more useful than outdated documents
indicating what devices (no longer available today) worked 10 years ago.

It is of course your own discretion to do as you please in ofono.
Please don't treat this as a complaint, but just a kind suggestion from
a friend.  I would argue that if somebody with my combined telecom +
Linux / FOSS background and knowledge has serious issues to get things
to work, then many other people with less knowledge in either or both of
the fields must have given up over time.

Let me re-iterate that question: Which modem should I buy today for the
most feature-complete + reliable ofono support?  Please specify an exact
model number and preferably firmware version.  Then we can buy one of
these and compare the results of that "known good" vs. whatever we're
trying on other modems.  That also helps to differentiate while
debugging between what might be a modem/driver specific issue and a more
general ofono issue.

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

--===============0796968351733730071==--

