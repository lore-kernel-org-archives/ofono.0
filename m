Content-Type: multipart/mixed; boundary="===============7664416742177431432=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: Problem with dialstring ##21#
Date: Tue, 16 Jan 2018 16:09:02 +0200
Message-ID: <05dc33a3-a7cb-e0a9-75d5-dfde6491522d@jolla.com>
In-Reply-To: <e80f263e-eb06-a0ed-f877-c752cd6e5718@torremans.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7664416742177431432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 16/01/18 14:50, Engelbert Torremans wrote:
> All,
>
> I am looking for some help in trying to fix this problem I am =

> experiencing when using Ofono on a RaspberryPi in "carkit/HFP mode".
>
> Currently I can make calls (originate and terminate) and audio is fine =

> in combination with Bluez5 etc. also.
>
> But I cannot disable CallForwarding via the dial-number command.
>
> Enabling CFU via **21*destination-number# is working fine.
>
> Trying to disable CFU via ##21# gives below error. Doing the same via =

> the keypad on the mobile phone works fine.

Are you sure that the number is quoted correctly so that the hash sign =

is not interpreted by your shell as a comment? Check with dbus-monitor =

what's actually being sent over D-Bus.

Cheers,
-Slava

--===============7664416742177431432==--

