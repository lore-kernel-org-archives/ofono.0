Content-Type: multipart/mixed; boundary="===============4072784498940947994=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Fri, 21 Jan 2011 11:44:24 -0600
Message-ID: <4D39C5F8.4040004@gmail.com>
In-Reply-To: <1295595558.21986.35.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4072784498940947994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/21/2011 01:39 AM, Jukka Saunamaki wrote:
> Hi
> =

> On Thu, 2011-01-20 at 15:51 -0600, Denis Kenzior wrote:
>> So I don't really see the point in an asynchronous provisioning driver.
>>  If you want to do this over D-Bus or something then you might as well
>> provision via the ConnectionManager interface.  The other problem with
>> being async is that is nearly impossible to support multiple
>> provisioning plugins properly.  I'd rather not deal with the race
>> conditions.
>>
>> If we can't make the lookup fast enough to be done synchronously, then I
>> think we should give up.
> =

> The reason for asyncronous API is still that SPN value reading from SIM.
> Is there any way to make sure it is available synchronously when
> provisioning is run?

Not really. So you're introducing a boatload of extra complexity just
because of the need for EFspn?  Are you 100% sure that you really need
this?  Can some of these corner cases be covered differently?

> And what do you mean with it being impossible to support multiple
> provisioning plugins properly? Plugins are run one after another until
> first returns something.
> Race conditions I tried to address in gprs, so if gprs atom goes away
> while provisioning is running nothing bad should happen. But sure, there
> might something else, and hopefully someone could point them.

How exactly are you guaranteeing that 'nothing bad should happen'?
There is no cancellation mechanism that I see.  Not to mention that the
current ofono_sim_read API is not even safe either.  For exactly the
same reasons.

Regards,
-Denis

--===============4072784498940947994==--

