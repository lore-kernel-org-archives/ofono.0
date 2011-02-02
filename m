Content-Type: multipart/mixed; boundary="===============6866719414088222560=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Wed, 02 Feb 2011 09:19:48 +0200
Message-ID: <1296631188.25947.27.camel@jsaunama-desktop>
In-Reply-To: <4D48B14B.8030108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6866719414088222560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2011-02-01 at 19:20 -0600, ext Denis Kenzior wrote:
> > There is also this weird corner case when the SIM has no SPN available.
> > AFAIK, a failed read isn't cached, so bootstrapping that particular SIM
> > will incur a penalty every single time for information that isn't even
> > available, as opposed to the GPRS atom incurring it just once during its
> > lifetime.
> =

> The proposal from Jukka reads EFspn from the sim atom before obtaining
> the IMSI, so no caching is possible anyway.  But you are right that we
> do not cache if an error occurs during a file info request, so that is
> something else to watch out for.

Actually the patch does read SPN after IMSI.

But anyway, I agree, reading SPN is better done asynchronously in gprs
atom, since this provisioning is done only once.  =


--Jukka



--===============6866719414088222560==--

