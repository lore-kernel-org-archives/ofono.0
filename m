Content-Type: multipart/mixed; boundary="===============6816353978481888315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem with dialstring ##21#
Date: Tue, 16 Jan 2018 10:00:08 -0600
Message-ID: <228d5a26-aaae-c806-74a2-16d8e5d92524@gmail.com>
In-Reply-To: <e80f263e-eb06-a0ed-f877-c752cd6e5718@torremans.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6816353978481888315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Engelbert,

On 01/16/2018 06:50 AM, Engelbert Torremans wrote:
> All,
> =

> I am looking for some help in trying to fix this problem I am =

> experiencing when using Ofono on a RaspberryPi in "carkit/HFP mode".
> =

> Currently I can make calls (originate and terminate) and audio is fine =

> in combination with Bluez5 etc. also.
> =

> But I cannot disable CallForwarding via the dial-number command.
> =


Call Forwarding isn't supported via HFP, you must be doing something evil...

> Enabling CFU via **21*destination-number# is working fine.
> =


Just FYI, all USSD requests should be sent via =

org.ofono.SupplementaryServices.Initiate() which will forward them to =

the right interface (e.g. Call Forwarding, Call Settings, etc)

> Trying to disable CFU via ##21# gives below error. Doing the same via =

> the keypad on the mobile phone works fine.
> =

> I have the impression that somwhere this ##21# is not processed =

> correctly but where? In ofono or in DBUS or?
> =

> Any clues?
> =

> Thanks,
> =

> Engelbert
> =

> pi(a)rpi-x:~/xgen/ofono $ ./dial-number BT-MAC-ADDRESS ##21#

Yep, you're doing something evil.  This is not a valid dial string =

according to 3GPP.  Your AG might be able to accept this via ATD, but =

this is not standard behavior and oFono rightly complains.

Regards,
-Denis

--===============6816353978481888315==--

