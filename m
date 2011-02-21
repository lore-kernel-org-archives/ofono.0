Content-Type: multipart/mixed; boundary="===============5828365608551370637=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: Problem with SIM lock states not showing correctly in Ofono API.
Date: Mon, 21 Feb 2011 11:46:03 +0200
Message-ID: <1298281563.8797.20.camel@jussi-desktop>
In-Reply-To: <4D5EAC7E.5070307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5828365608551370637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2011-02-18 at 19:29 +0200, Denis Kenzior wrote:

> I have pushed experimental patch
> e8553f53376a33504dd18c4d7bb6d6f309973e0a to take care of this.  Let me
> know if this works for you.
> =

> Regards,
> -Denis

It seems to be showing the states correctly except in case when you make
PIN2 blocked using call meter API. If PIN2 goes blocked when using
callmeter nothing is shown in API. (My patch did not do that either.
Plan was to fix it in separate patch)

Another issue is that your patch brings the API:s down when PIN2 goes
blocked. ( using ChangePin ) That is not correct. Blocked PIN2 does not
force phone to drop from network and it does prevent the usage of SIM. =


There seems to be also some problem when API shows PUK2 required and PIN
and PIN2 locked. Reset-pin opens the PUK2 but API does not get the
response it's looking for and oFono needs to be booted before states are
showed correctly again. I suspect that's a separate issue however and
not caused by this patch. =


Br,
-Jussi




--===============5828365608551370637==--

