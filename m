Content-Type: multipart/mixed; boundary="===============2732822238080828117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 12:37:35 -0500
Message-ID: <cd83c11b-ed8d-16b5-41dd-0e36a17fccd0@gmail.com>
In-Reply-To: <20170522155020.ixybooykvdprjmdj@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2732822238080828117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

>
> Does it make sense to extend the hand-written QMI encoder/decoder code,
> or does it make more sense to invest time in re-using the apparently
> more complete description [and work] in the libqmi+uqmi world?
>

Or simply use the JSON description as an aid to generate the =

'hand-written' code.

>> complete, sure.  But then we only use a very small subset of QMI. Pointl=
ess
>> to generate all this code if you use 5-10% of it.
>
> As far as I know, the ofono qmi driver does not cover yet all the ofono
> dbus interfaces that are documented (at least not for all the QMI
> versions seen out there?).  So to get 100% of the ofono interfaces
> implemented, you probably will need to implement more of QMI.
>

It is probably not complete, but it actually does cover quite a bit of =

the cases.  I remember looking at the QMI specs long ago and thinking =

that we wouldn't use even half of the stuff in there.  Think of it this =

way, AT modems come with hundreds of AT commands.  We only use a fairly =

small percentage of them to implement our drivers.

> Also, with modems/phones implementing things like IMS for LTE (and WiFi
> calling), isn't it likely that ofono will also have to cover/implement
> related parts of QMI that deal with that?
>

So in theory yes.  But in practice do such devices actually exist?  When =

we made QMI work, only data cards were available.

> To me it seemed ofono always wanted to have a more feature-complete
> code base to talk to various modems, well beyond the basic voice call +
> sms capabilities offered by other projects (openmoko gsmd,
> freesmartphone.org) or the single-purpose data-only ModemManager..  I
> mean, why else are there topics like SIM toolkit, call hold,
> supplementary services, etc. covered in the mission statement and some
> of the code?
>

So yes, oFono implements a bunch of these features that other projects =

do not have.  But you do need actual hardware/firmware that supports =

these features and documentation on how these features are implemented =

on that hardware/firmware.

In practice consumer-level devices never exposed this stuff.  So there =

has always been great disparity in terms of what oFono could do and what =

it was able to do on in a particular driver/device.  It is now getting =

better with vendors such as Telit, uBlox, etc which is encouraging.

>> The code generator itself can also be quite large.  We played with the
>> idea initially, but didn't think the cost-benefit was there.
>
> The benefit might not be there for you alone, but the issue is that
> there are different FOSS QMI implementations out there (libqmi, uqmi,
> ofono and possibly more), and implementing encoding and parsing of each
> new message or interface N number of times by hand in each project seems
> rather inefficient use of the constantly limited resources that FOSS
> projects seem to have.
>

So again, I don't disagree.  But ultimately, each project should do what =

is right for that project.

>> You'll have to educate me on that, so far it seems QMI has been frozen f=
or
>> 5+ years.
>
> What are you referring to specifically? The QMI you see in modems out
> there? The ofono implementation of it? The specific sub-set used by
> ofono so far?

The first one.

>
> For the sake of an argument: It might even be that the modem/baseband
> side is fixed for the past 5 years.  But does ofono implement all
> "relevant" features that were present in QMI modems 5 years ago in its
> qmimodem driver?
>

No, not all of it.  We got enough working for our particular project. =

We have not developed it actively since, as you can probably tell.

> "relevant" to me is pretty much anything that can be done from a phone
> side, i.e. anything related to

So off the top of my head here:

> * device identification + control (on/off/airplane)

yes

> * network selection (scanning, manual selection, ...)

yes

> * voice call including call hold / multiple calls, dtmf, supplementary se=
rvices

no.  Don't think there is a device that supports voice calls anyhow

> * SMS MO + MT, including delivery reports, *, setting SMSC, ...

yes

> * USSD

no

> * activation/deactivation of PDP contexts [including multiple parallel]

yes, but AFAIK no qmi device supports multiple of these.

>
> We're using ofono from osmo-gsm-tester (see
> ftp://ftp.osmocom.org/docs/latest/osmo-gsm-tester-manual.pdf and
> http://git.osmocom.org/osmo-gsm-tester/) in order to do full end-to-end
> tests on the Osmocom GSM stack including OsmoBTS, OsmoNITB, etc.
>
> From the what the team working on this at sysmocom (Pau Espin, Alexander
> Couzens, formerly myself...) have seen so far, it is very hard to have
> even only a subset of the above work reliably on any given modem tested
> so far.  We originally started with some AT-command based Sierra
> Wireless modems (and gave up on that about a year ago) and have since
> re-build the tester hardware towards using QMI-based modems.
>
> We've been looking at modern LTE-capable devices like Quectel EC-20,
> EC-25, Sierra Wireless MC7304 or even older devices like Gobi2000
> and Gobi3000.
>
> I am not complaining here.  I just want to figure out what is the best
> strategy to get ofono to work reliably for all "relevant" features on
> initially at least one QMI based modem, later on hopefully with many
> other modems [using different baseband chipsets and stacks, to test
> interoperability of our stack].
>

Why are you using QMI then?  I would recommend using something that is =

actually meant to be fully featured.  E.g. pass full blown GCF (not just =

the limited subset for data-only devices.)  Something that comes with =

developer documentation, so that if a feature is not supported in the =

current oFono driver, it is easy to add.  Look at Telit or uBlox.

Regards,
-Denis

--===============2732822238080828117==--

