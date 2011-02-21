Content-Type: multipart/mixed; boundary="===============0852574127645847051=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem with SIM lock states not showing correctly in Ofono API.
Date: Mon, 21 Feb 2011 09:21:59 -0600
Message-ID: <4D628317.4010909@gmail.com>
In-Reply-To: <1298281563.8797.20.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0852574127645847051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/21/2011 03:46 AM, Jussi Kangas wrote:
> Hi,
> =

> On Fri, 2011-02-18 at 19:29 +0200, Denis Kenzior wrote:
> =

>> I have pushed experimental patch
>> e8553f53376a33504dd18c4d7bb6d6f309973e0a to take care of this.  Let me
>> know if this works for you.
>>
>> Regards,
>> -Denis
> =

> It seems to be showing the states correctly except in case when you make
> PIN2 blocked using call meter API. If PIN2 goes blocked when using
> callmeter nothing is shown in API. (My patch did not do that either.
> Plan was to fix it in separate patch)
> =


Please do.  Most modems do not support PIN2 entry via CPIN, and
implement this using a vendor extension.  PIN2 / PUK2 support seems to
be a rather recent addition to the specs.

> Another issue is that your patch brings the API:s down when PIN2 goes
> blocked. ( using ChangePin ) That is not correct. Blocked PIN2 does not
> force phone to drop from network and it does prevent the usage of SIM. =

> =


If your modem reports the PIN2 in CPIN, then yes that is a bug.

> There seems to be also some problem when API shows PUK2 required and PIN
> and PIN2 locked. Reset-pin opens the PUK2 but API does not get the
> response it's looking for and oFono needs to be booted before states are
> showed correctly again. I suspect that's a separate issue however and
> not caused by this patch. =

> =


I'm having trouble visualizing this one.  Can you provide an AT debug
log to illustrate?

Regards,
-Denis

--===============0852574127645847051==--

