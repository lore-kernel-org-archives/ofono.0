Content-Type: multipart/mixed; boundary="===============7714904692468140304=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Tue, 01 Feb 2011 19:20:11 -0600
Message-ID: <4D48B14B.8030108@gmail.com>
In-Reply-To: <1296592705.2619.78.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7714904692468140304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/01/2011 02:38 PM, Aki Niemi wrote:
> Hi Denis,
> =

> On Tue, 2011-02-01 at 09:14 -0600, ext Denis Kenzior wrote:
>>> does it really matter in the end? It gets read once and after that we
>>> are caching it on disk anyway.
>>>
>>
>> Of course it does, while SIM is initializing everything else is blocked.
>>  Once we're in sim ready you can have n atoms initializing at the same
>> time.  On good hardware with proper muxing that can shave tremendous
>> amount of time off your startup cost.
> =

> I agree.
> =

> There is also this weird corner case when the SIM has no SPN available.
> AFAIK, a failed read isn't cached, so bootstrapping that particular SIM
> will incur a penalty every single time for information that isn't even
> available, as opposed to the GPRS atom incurring it just once during its
> lifetime.

The proposal from Jukka reads EFspn from the sim atom before obtaining
the IMSI, so no caching is possible anyway.  But you are right that we
do not cache if an error occurs during a file info request, so that is
something else to watch out for.

Regards,
-Denis

--===============7714904692468140304==--

