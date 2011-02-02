Content-Type: multipart/mixed; boundary="===============5649155557947532833=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Wed, 02 Feb 2011 10:01:40 -0600
Message-ID: <4D497FE4.8070906@gmail.com>
In-Reply-To: <1296631188.25947.27.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5649155557947532833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 02/02/2011 01:19 AM, Jukka Saunamaki wrote:
> Hi Denis,
> =

> On Tue, 2011-02-01 at 19:20 -0600, ext Denis Kenzior wrote:
>>> There is also this weird corner case when the SIM has no SPN available.
>>> AFAIK, a failed read isn't cached, so bootstrapping that particular SIM
>>> will incur a penalty every single time for information that isn't even
>>> available, as opposed to the GPRS atom incurring it just once during its
>>> lifetime.
>>
>> The proposal from Jukka reads EFspn from the sim atom before obtaining
>> the IMSI, so no caching is possible anyway.  But you are right that we
>> do not cache if an error occurs during a file info request, so that is
>> something else to watch out for.
> =

> Actually the patch does read SPN after IMSI.
> =


Ah yes you're right.

FYI: we have maintained an unwritten rule that the presence of IMSI
indicates the sim is initialized to D-Bus clients; so it should be
signaled immediately before post_sim atoms are added.

Regards,
-Denis

--===============5649155557947532833==--

