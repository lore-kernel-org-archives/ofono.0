Content-Type: multipart/mixed; boundary="===============3324201081228586620=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Monitor current technology
Date: Fri, 25 Jun 2010 10:47:34 -0500
Message-ID: <201006251047.34825.denkenz@gmail.com>
In-Reply-To: <1277387707-18928-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3324201081228586620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> This series adds a new property to DCM to export the
> current technology used.
> =


So I've been reviewing your patches and also thinking about solving this =

technology problem nicely.  First a bit of background on the state of hardw=
are =

today:

27.007 (The Standard):
- +CREG - Reports CS netreg parameters, including tech.
- +CGREG - Same as above for PS netreg parameters
- +CPSB - Reports the current packet switched bearer for a given context.  =

Presumably this can change quite dynamically during a GPRS session.

MBM:

- *EREG - Reports CS netreg parameters, including status/lac/ci and tech (0=
 - =

GSM, 2 - UMTS).  Essentially same as CREG with addition of tech reporting.
- +CGREG - Reports PS netreg parameters, including status/lac/ci/tech (per =

27.007)
- *ERINFO - Reports current Cell capability, gprs/egprs/umts/hsdpa, nothing =

new over +CGREG
- *EPSB - Reports current packet switched bearer.  This is only available o=
n =

recent devices.  This one is supposed to tell the actual packet bearer and =

acts similar to 27.007 +CPSB.  The state depends on the link state, and ten=
ds =

to oscillate between 0 (no bearer) and some bearer quite often, even when =

context is active.

STE:

- Same as MBM with *ERINFO seemingly missing.

ISI:

I'm not an ISI expert, but here's what I gleamed from a quick look at that =

driver:

- Reports RAT (gsm/gsm compact/umts) and current cell capability (edge / no =

edge, hsupa availability, hsdpa availability)
- No equivalent of +CPSB

Huawei:

- ^MODE and ^SYSINFO can report current mode.  This seems to be the same as =

cell capability on other devices.

HSO:

- One of the weird ones.  There is no tech reporting through CREG/CGREG at =
all
- The current access technology (gsm / umts) is reported through OSSYSI
- Edge / no edge capability is reported through OCTI
- UMTS/HSDPA/HSUPA are reported through OUWCTI.  Unfortunately OUWCTI is no=
t =

always reported properly and can change within the cell when the context is =

activated / deactivated.  Some firmware does not report / support OUWCTI at =

all.

The consensus among the hw seems to be to report the capability of the =

currently selected cell, with the exception of HSO, which just acts stupidl=
y.

So my current thinking is to drop any Tech reporting in gprs atom for now. =
 At =

least until we actually find a usecase for EPSB/CPSB style reporting.

HSO OUWCTI reporting is still an issue.  I'd be glad to hear some alternate =

ideas about how to integrate it properly at this point.

Regards,
-Denis

--===============3324201081228586620==--

