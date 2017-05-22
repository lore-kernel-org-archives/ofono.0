Content-Type: multipart/mixed; boundary="===============2140446411335760726=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 20:26:57 +0200
Message-ID: <20170522182657.oqmizeaadoekpuz2@nataraja>
In-Reply-To: <cd83c11b-ed8d-16b5-41dd-0e36a17fccd0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2140446411335760726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, May 22, 2017 at 12:37:35PM -0500, Denis Kenzior wrote:
> > Does it make sense to extend the hand-written QMI encoder/decoder code,
> > or does it make more sense to invest time in re-using the apparently
> > more complete description [and work] in the libqmi+uqmi world?
> =

> Or simply use the JSON description as an aid to generate the 'hand-writte=
n'
> code.

indeed, an option.

> > Also, with modems/phones implementing things like IMS for LTE (and WiFi
> > calling), isn't it likely that ofono will also have to cover/implement
> > related parts of QMI that deal with that?
> =

> So in theory yes.  But in practice do such devices actually exist?  When =
we
> made QMI work, only data cards were available.

Yes, they do exist.  Based on my reverse-engineering efforts on the
EC-20 / EC-25, I can definitely confirm this.  And they are using quite
old base versions from Qualcomm..

Actually, quite a lot of the complicated software architecture on those
more modern 4G-enabled Qualcomm MDM chipsets seems to be a result of the
support for features like wifi-offloading and voice call support,
including SRVCC across different RAN technologies (2G/3G/4G/WiFi).  You
should see the amount of alsa controls exposed on the Linux
inside those modems (that's the voice side, but just for illustration).

As Sierra Wireless are also using the Linux-based stack for the modems,
I would assume they have related LTE voice capability, too.

> So yes, oFono implements a bunch of these features that other projects do
> not have.  But you do need actual hardware/firmware that supports these
> features and documentation on how these features are implemented on that
> hardware/firmware.

In theory, yes.  In practise, you can do a lot without documentation
simply based on the information that can be found in from leaked QMI
source code in various places.  Basically just like with any other piece
of hardware/firmware that's supported by FOSS without any help from its
vendor.

> In practice consumer-level devices never exposed this stuff.  So there has
> always been great disparity in terms of what oFono could do and what it w=
as
> able to do on in a particular driver/device.  It is now getting better wi=
th
> vendors such as Telit, uBlox, etc which is encouraging.

I agree for AT-based modems. But I think this is where for Qualcomm
based devices QMI makes a big difference: The individual modem maker
would actively have to disrupt it from working e.g. by removing parts of
the QMI implementation / interfaces in the firmware..

> > * network selection (scanning, manual selection, ...)
> yes

was not working out-of-the-box with the qmi driver,

> > * voice call including call hold / multiple calls, dtmf, supplementary =
services
> =

> no.  Don't think there is a device that supports voice calls anyhow

Of course there are plenty!  Even with documented voice features from
various manufacturers.  In some cases you can buy variants with and
without voice functionality (probably related to different patent fees
whether or not voice support is included).

You can find modems that
* expose voice only on analog mic/speaker pads, that's typically the
  case for solder/lga-type modems, whether from Gemalto, Telit, Simcom,
  Quectel, u-blox or virtually any other vendor.  Voice signalling is
  then done via AT commands or QMI.
* expose voice via PCM bus on some otherwise unused non-standard pins of
  the mPCIe.  This is the case for some Huawei and Sierra Wireless
  devices, and the reason why we built
  http://osmocom.org/projects/mpcie-breakout/wiki
* expose voice via USB-Audio profile (possible with a lot of modern
  Sierra Wireless modems in mPCIe or M.2 form-factor)
* expose voice via some proprietary "GSM codec frame over USB Serial"
  which is ugly but better than having to attach a codec IC to the PCM
  bus.  Seen in some older 2G/3G-only quectel devices, for example.

And hey, even the Openmoko phones (which were/are supported by ofono,
AFAIR) had voice support more than a decade ago.  Not with QMI, though.

> > * activation/deactivation of PDP contexts [including multiple parallel]
> =

> yes, but AFAIK no qmi device supports multiple of these.

ok, we'll have to look at this.  at least with LTE modems, it is the
normal operation to have multiple EPS bearers active in parallel.  At
least one for signalling and one for data, maybe more for voice, etc.

> > I am not complaining here.  I just want to figure out what is the best
> > strategy to get ofono to work reliably for all "relevant" features on
> > initially at least one QMI based modem, later on hopefully with many
> > other modems [using different baseband chipsets and stacks, to test
> > interoperability of our stack].
> =

> Why are you using QMI then?  =


* Because AT command suck badly. Every vendor gets it wrong in a subtly
  different way, and every modem vendor has it's own incompatible
  extensions to it
* QMI is something present in almost all devices based on Qualcomm,
  which is the largest supplier of baseband chips for quite some time.
  So by having QMI supported well, we unlikely will have to worry about
  differences between a Quectel or a Sierra Wireless device.  If we use
  AT commands, we do.
* QMI is much easier and more natural to parse in a program than the
  string-based AT commands, particularly thinking of mixture of
  unsolicited results codes vs, request-response style commands, the
  issue of voice related commands "blocking" an AT command channel,
  having to use TS 07.10 multiplex, etc.

> I would recommend using something that is actually meant to be fully
> featured.  E.g. pass full blown GCF (not just the limited subset for
> data-only devices.)  =


Where is the list of current hardware that is supported best by ofono?
the information contained in its documentation seems like it's a decade
(I may exaggerate) old and not maintained.

Why do you claim that the devices we currently use (or evaluate to use)
are data-only?

> Something that comes with developer documentation, so that if a
> feature is not supported in the current oFono driver, it is easy to
> add.  Look at Telit or uBlox.

There is no shortage in terms of "developer" style documentation from
vendors like Sierra Wireless, Huawei and Quectel.  More recently also
ZTE. In fact, you would be surprised at the level of detail that some of
them have.  The ZTE documentation even goes as low as to show you the
message sequence chart of what happens inside the GSM radio and core
network for each singla AT command you issue towards it.

I'm not sure in which way Telit or u-blox should differ here, except
maybe that they u-blox (like Gemalto, I don't know bout Telit)
artificially lock out their users from using the diagnostic features of
modems, so the use of things like osmo-qcdiag to get protocol traces for
debugging is made impossible.

So the problem is not really to know how to make a modem perform a given
function.  The problem is how to abstract away the difference between
many different modems (possibly even based on different chipsets/stack
vendors) without having to start from scratch.  And that's exactly what
I thought ofono was created for :)

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

--===============2140446411335760726==--

