Content-Type: multipart/mixed; boundary="===============7895490505932368866=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Wed, 22 Mar 2017 18:23:10 +0000
Message-ID: <71104ef0-1e92-7317-a29c-eac560a3625f@gmail.com>
In-Reply-To: <ed2ddd68-7c58-ab7a-981c-d15096746291@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7895490505932368866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I investigated this further today. The Telit modem exposes two interfaces A=
T commands and QMI.
What you are describing matches what the AT interface reports:
- modem powers on already registered to the network with 5 contexts, and on=
e of them is active

However, the QMI interface is quite different. None of the "profiles" as QM=
I calls them is active.
The user needs to explicitly activate one of them with a "start network" co=
mmand. Without that,
the modem's data service (WDS) appears off-line.

For now, I left it the way the original qmimodem code works - the user prov=
ides an APN.
This works fine - the QMI "start network" command uses the user's entry fro=
m a context, and
the modem is happy with that.

As an enhancement the wds-get-default-settings command could be used to pre=
-fill the context
with APN, IP type and auth. But the ofono gprs context still needs to be ac=
tivated in order
to send the QMI "start network" command.

Lukasz



On 21/03/17 18:57, Denis Kenzior wrote:
> Hi Lukasz,
> =

>> I am still a little bit confused about ofono_gprs_cid_activated(). As fa=
r as I can see only atmodem calls it. No other driver does that.
> =

> That's because only the ublox devices have been properly enabled for LTE =
:)
> =

>> I am not sure if a context is automatically created. I can see that the =
sim card has a few profiles, and the user can select which APN to use, star=
t/stop ip network, etc.
> =

> Yes, that's how LTE works.  An initial context (default bearer) is always=
 activated on LTE.  The device can provide an initial attach APN (see doc/l=
te-api.txt) which is used to tell the modem which APN to attach to by defau=
lt.  From what I recall, the device can provide an empty APN (in which case=
 the network assigns one).
> =

> The default bearer varies by the carrier.  Some use it for IMS, some use =
it for the internet context.  So the modem/firmware behavior is often tweak=
ed for a particular carrier.  Some modems might not report the default cont=
ext at all in which case the device acts more like a 3G modem than an lte o=
ne.
> =

> Regards,
> -Denis

--===============7895490505932368866==--

