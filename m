Content-Type: multipart/mixed; boundary="===============7929058370588249411=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 16:03:16 -0500
Message-ID: <E01D60E0-B3AC-417D-83A3-6CD4E23EC8AD@gmail.com>
In-Reply-To: <20170522182657.oqmizeaadoekpuz2@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7929058370588249411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,
> =

>>> * voice call including call hold / multiple calls, dtmf, supplementary =
services
>> =

>> no.  Don't think there is a device that supports voice calls anyhow
> =

> Of course there are plenty!  Even with documented voice features from
> various manufacturers.  In some cases you can buy variants with and
> without voice functionality (probably related to different patent fees
> whether or not voice support is included).
> =

> You can find modems that
> * expose voice only on analog mic/speaker pads, that's typically the
>  case for solder/lga-type modems, whether from Gemalto, Telit, Simcom,
>  Quectel, u-blox or virtually any other vendor.  Voice signalling is
>  then done via AT commands or QMI.
> * expose voice via PCM bus on some otherwise unused non-standard pins of
>  the mPCIe.  This is the case for some Huawei and Sierra Wireless
>  devices, and the reason why we built
>  http://osmocom.org/projects/mpcie-breakout/wiki
> * expose voice via USB-Audio profile (possible with a lot of modern
>  Sierra Wireless modems in mPCIe or M.2 form-factor)
> * expose voice via some proprietary "GSM codec frame over USB Serial"
>  which is ugly but better than having to attach a codec IC to the PCM
>  bus.  Seen in some older 2G/3G-only quectel devices, for example.
> =

> And hey, even the Openmoko phones (which were/are supported by ofono,
> AFAIR) had voice support more than a decade ago.  Not with QMI, though.

I=E2=80=99m confused.  Are you talking about voice capable modems in genera=
l or the QMI ones?  I=E2=80=99m of course aware of various Huawei, etc mode=
ms that support voice via AT commands, RIL, ISI, etc.  I=E2=80=99m not awar=
e of any QMI based devices.  QMI protocol does support voice, so I=E2=80=99=
m sure they exist.  Just not aware of any.  That is why we never bothered t=
o write the voicecall atom driver for QMI.  If you want to contribute that,=
 I=E2=80=99m happy to take it.

> =

>>> * activation/deactivation of PDP contexts [including multiple parallel]
>> =

>> yes, but AFAIK no qmi device supports multiple of these.
> =

> ok, we'll have to look at this.  at least with LTE modems, it is the
> normal operation to have multiple EPS bearers active in parallel.  At
> least one for signalling and one for data, maybe more for voice, etc.

Yes, but at least the gobi cards I=E2=80=99ve seen only expose a single net=
work interface.  So multiple contexts are not possible.

> =

> * Because AT command suck badly. Every vendor gets it wrong in a subtly
>  different way, and every modem vendor has it's own incompatible
>  extensions to it

I agree there, but it is not really that bad any more.

> * QMI is something present in almost all devices based on Qualcomm,
>  which is the largest supplier of baseband chips for quite some time.
>  So by having QMI supported well, we unlikely will have to worry about
>  differences between a Quectel or a Sierra Wireless device.  If we use
>  AT commands, we do.

Fair enough, but you have to make a working QMI driver first.  QMI has its =
own share of idiosyncrasies. =


> * QMI is much easier and more natural to parse in a program than the
>  string-based AT commands, particularly thinking of mixture of
>  unsolicited results codes vs, request-response style commands, the
>  issue of voice related commands "blocking" an AT command channel,
>  having to use TS 07.10 multiplex, etc.

There are very few AT commands that block, and oFono solves the multiplexin=
g, unsolicited results, etc for you.  I think you=E2=80=99re overstating th=
e issue, but I do not disagree with you.

> =

>> I would recommend using something that is actually meant to be fully
>> featured.  E.g. pass full blown GCF (not just the limited subset for
>> data-only devices.)  =

> =

> Where is the list of current hardware that is supported best by ofono?
> the information contained in its documentation seems like it's a decade
> (I may exaggerate) old and not maintained.

No such documentation exists.  We had to pick and choose our battles and th=
us never had the resources for something like that.  I=E2=80=99m happy to h=
ost such a matrix in case someone is interested in contributing it.

> =

> Why do you claim that the devices we currently use (or evaluate to use)
> are data-only?

This was not my intent.  You=E2=80=99re using ofono + QMI to auto test your=
 base station software.  Yet our driver doesn=E2=80=99t support voice calls=
.  And I=E2=80=99ve never seen a voice capable QMI device, though they prob=
ably exist.

Regardless, this isn=E2=80=99t really important.  If you=E2=80=99re set on =
QMI, then its not my place to discourage you. =


> =

>> Something that comes with developer documentation, so that if a
>> feature is not supported in the current oFono driver, it is easy to
>> add.  Look at Telit or uBlox.
> =

> There is no shortage in terms of "developer" style documentation from
> vendors like Sierra Wireless, Huawei and Quectel.  More recently also
> ZTE. In fact, you would be surprised at the level of detail that some of
> them have.  The ZTE documentation even goes as low as to show you the
> message sequence chart of what happens inside the GSM radio and core
> network for each singla AT command you issue towards it.
> =

> I'm not sure in which way Telit or u-blox should differ here, except
> maybe that they u-blox (like Gemalto, I don't know bout Telit)
> artificially lock out their users from using the diagnostic features of
> modems, so the use of things like osmo-qcdiag to get protocol traces for
> debugging is made impossible.
> =

> So the problem is not really to know how to make a modem perform a given
> function.  The problem is how to abstract away the difference between
> many different modems (possibly even based on different chipsets/stack
> vendors) without having to start from scratch.  And that's exactly what
> I thought ofono was created for :)
> =


Agreed.  But then I=E2=80=99m a bit confused on what you=E2=80=99re trying =
to accomplish?  If you want to enable more QMI features in oFono, then I=E2=
=80=99m all for you doing that.  Contributions are always welcome.

Regards,
-Denis


--===============7929058370588249411==--

