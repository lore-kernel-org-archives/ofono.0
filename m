Content-Type: multipart/mixed; boundary="===============6628125514608900786=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Thu, 25 May 2017 11:31:27 -0500
Message-ID: <794d8ee7-5da4-4b30-f804-a73c1d9998e7@gmail.com>
In-Reply-To: <20170523122607.vc2mwptes7zpybjd@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6628125514608900786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

Sorry for the late reply, I've been traveling...

> But then, as I iterated in my previous mail, there are plenty of modems
> in solder type (LGA), mPCIe and M.2/NGFF form-factor that expose voice
> capabilities via QMI.  There's a bunch of Sierra Wireless ones (like
> MC7304 & co) as well as EC-20 and EC-25 from Quectel.  I also have some
> Hauwei branded here that do QMI for voice.

If you can get these to work, that'd be nice.  I remember looking at the =

Voice control interface over QMI and it should be fairly simple to write =

a driver for it.

>
> And yes, we will in some way or another interface QMI for voice on at
> least a subset of those modems.  The question is whether we spend time
> on hand-crafting messages [error prone] or use the existing JSON
> description and generated parser/encoders.  I'm not sure which way is
> faster/easier.  If you are fundamentally against code genreation (which
> you are not, AFAICT), we would skip that option.  But if you're open to
> it within the constraints regarding glib and external dependencies, it
> might be an idea to try.

If it were me, I'd just use the JSON description to bootstrap the code =

and then proceed with the 'hand-crafted' option.  I think this is the =

path of least resistance.  We can always add unit tests to minimize the =

errors from this process.  I would expect such an approach to be faster =

overall.

Auto generated code would only make sense if each platform has its own =

(significantly different) dialect of QMI.  But in this case your entire =

premise of using QMI as a baseline to test multiple vendor's products no =

longer holds.

>> Yes, but at least the gobi cards I=E2=80=99ve seen only expose a single
>> network interface.  So multiple contexts are not possible.
>
> I think this has all slightly changed a bit in the last 3+ years when
> the Qualcomm LE stack is used on modern MDM chips.  There you have a
> Linux kernel (and adb, but real glibc and no android userland) inside a
> Cortex-A5 on the modem itself.  In those devices, you can at runtime
> change the configuration/coposition of the USB interface and expose many
> more things that are otherwise not exposed.
>

If you can get this to work, there would be many happy people.  In =

theory it might also be possible to run an extra context over AT/PPP =

channel.  But that would be quite ugly.

>> No such documentation exists.  We had to pick and choose our battles
>> and thus never had the resources for something like that.  I=E2=80=99m h=
appy
>> to host such a matrix in case someone is interested in contributing
>> it.
>
> Well, hosting/maintaining the document (which could just be in git) is
> the easy part.  The more difficult part is collecting information of who
> has actually successfully used which feature on which modem using which
> modem firmware version and which ofono version.

True, hence the resources comment above :)

>
> In the best case, we are able to provide such information based on the
> osmo-gsm-tester in the future.  Our main use case is to test a fixed
> and trusted combination of (ofono + modem + modem firmware) against our
> changing GSM/GPRS/UTMS cellular network stack.  But the same setup (or a
> copy of it) could of course also be used to have a fixed version of the
> GSM/GPRS/UMTS network and test a given [new] ofono version/commit
> against one or multiple modems as part of continuous automation.
>
> So I think there's something for both projects to benefit from.

Definitely!

>> Agreed.  But then I=E2=80=99m a bit confused on what you=E2=80=99re tryi=
ng to
>> accomplish?
>
> We want to test our GSM/GPRS/UMTS network side protocol stack and
> network elements, preferably with as many different modems as
> possible, but starting with Qualcomm modems with QMI and DIAG as that
> gives us additional insight into what's happening inside the modem-side
> protocol stack.

Okay, the DIAG tidbit makes things a bit more clear now.

> Let me re-iterate that question: Which modem should I buy today for the
> most feature-complete + reliable ofono support?  Please specify an exact
> model number and preferably firmware version.  Then we can buy one of
> these and compare the results of that "known good" vs. whatever we're
> trying on other modems.  That also helps to differentiate while
> debugging between what might be a modem/driver specific issue and a more
> general ofono issue.
>

I don't have an easy answer for you unfortunately.  I can tell you this:
We took oFono with an IFX 6160 modem to a test lab and passed all =

certification tests (Release 8).  plugins/ifx.c is a good example of a =

complete AT command based modem driver.  oFono core has not changed much =

since then besides adding some additional LTE support.

This of course doesn't help you since this device/firmware combination =

is not available.

 From looking at the current set of drivers, the best supported ones in =

my estimation are for Telit and uBlox.

I would also take a look at the Telit xN930 modules.  Their AT command =

spec has a striking similarity to the AT commands being used by the IFX =

driver and is different from the other Telit modules.

Regards,
-Denis

--===============6628125514608900786==--

