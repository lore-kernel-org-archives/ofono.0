Content-Type: multipart/mixed; boundary="===============5351855621327335157=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: return all serial numbers
Date: Fri, 05 Apr 2019 12:46:40 -0500
Message-ID: <3ab1aeab-f079-61e7-fb64-9234ef8be41d@gmail.com>
In-Reply-To: <20190405161525.7342-1-JPEWhacker@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5351855621327335157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom/Joshua

On 04/05/2019 11:15 AM, Joshua Watt wrote:
> From: Tom Nguyen <tom.nguyen@garmin.com>
> =

> ESN and MEID are used for CDMA devices. IMEI is used for GSM devices.
> Some modems, eg. Quectel EC25E, have variants that support each network
> for in various regions. So, the modems may return the ESN, MEID, and
> IMEI regardless of the variant. To support this case, the ESN, MEID,
> and IMEI should all be reported. Then the user application can decide
> which to use.

So you want to be running the Quectel driver as a multi-mode device, =

either CDMA or GSM mode?  I imagine you saw that CDMA support is rather =

unfinished...?

So here's the problem.  The Modem.Serial property was really always =

meant to be the IMEI or the ESN/MEID.  It was never meant to contain =

weird strings, or combinations of IDs or anything else of that sort. =

The apps using Modem.Serial really just expect to display this as a =

number.  So the approach of stuffing IMEI: Foo ESN: Bar MEID: Baz into =

the Serial string is not going to work.

So the obvious consequence of the above is that we never really =

considered multi-mode devices, and CDMA support was abandoned pretty =

shortly after.

Given that the D-Bus API is frozen, we can't really mess with the Serial =

property at this point.  We can add additional properties however...

> ---
>   drivers/qmimodem/devinfo.c | 33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> =


Regards,
-Denis

--===============5351855621327335157==--

