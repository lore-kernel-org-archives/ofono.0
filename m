Content-Type: multipart/mixed; boundary="===============4133289972424151122=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Where are ofono dbus paths for RSRQ and RSRP?
Date: Wed, 22 Jan 2020 10:07:53 -0600
Message-ID: <411442f4-07b2-4870-c4c9-ce2e4a747272@gmail.com>
In-Reply-To: <CAA=hcWQhKGuSNSqNfUujYgeAm-KHtP89xJaC1pEbULBJPrA8Ug@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4133289972424151122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1/21/20 7:56 PM, JH wrote:
> Hi,
> =

> I have been looking for getting RSRQ and RSRP values from ofono dbus
> commands, but I could not find much information how to get RSRQ and
> RSRP in debus-send commands, which following interface contains RSRQ
> and RSRP? And how could I access thos RSRQ and RSRP in debus-send?

What exactly is RSRP and RSRQ?  Are you referring to =

ReferenceSignalReceivedQuality and ReferenceSignalReceivedPower on LTE? =

If so, these would be available on the NetworkMonitor interface assuming =

your modem / driver reports these.

Regards,
-Denis
--===============4133289972424151122==--

