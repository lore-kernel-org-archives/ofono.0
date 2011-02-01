Content-Type: multipart/mixed; boundary="===============0478124288159256874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Tue, 01 Feb 2011 09:14:10 -0600
Message-ID: <4D482342.6070205@gmail.com>
In-Reply-To: <1296556685.1520.248.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0478124288159256874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 02/01/2011 04:38 AM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>> On Thu, 2011-01-27 at 15:22 +0200, Jukka Saunamaki wrote:
>>>> Here is an asynchronous implementation of SIM Service Provider Name (E=
F-SPN) getter API.
>>>> The trick is to delay setting sim ready until spn reading is finished.
>>>
>>> Any comments about this? =

>>> So, yes, it slightly delays SIM initialisation (usually SPN value should
>>> come from disk cache), but then netreg can use it immediately when it
>>> registers. =

>>> Alternative is still to create an asyncronous API now that there is a
>>> patch for safe SIM file reading.
>>
>> So my main problem here is that you require the SPN a handful of times
>> in the phone's lifetime, more likely once.  Yet you pay the cost of
>> reading and delaying the initialization every time.  In my view this is
>> not really acceptable.
> =

> does it really matter in the end? It gets read once and after that we
> are caching it on disk anyway.
> =


Of course it does, while SIM is initializing everything else is blocked.
 Once we're in sim ready you can have n atoms initializing at the same
time.  On good hardware with proper muxing that can shave tremendous
amount of time off your startup cost.

Regards,
-Denis

--===============0478124288159256874==--

