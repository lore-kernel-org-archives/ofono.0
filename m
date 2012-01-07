Content-Type: multipart/mixed; boundary="===============3663309420722060738=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Sat, 07 Jan 2012 13:26:40 -0600
Message-ID: <4F089C70.6050907@gmail.com>
In-Reply-To: <1326137780.6454.151.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3663309420722060738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>>>  struct speedup_data {
>>>  	GAtChat *modem;
>>>  	GAtChat *aux;
>>>  	gboolean have_sim;
>>>  	struct at_util_sim_state_query *sim_state_query;
>>> +	gboolean have_gsm;
>>> +	gboolean have_cdma;
>>
>> It might be a good idea to use a single gboolean, or better yet an enum
>> here instead.  There's no point to waste 8 bytes when a single byte can =
do.
> =

> I did this on purpose for the Huawei driver. We can unify this later on,
> but at this moment I rather see what is actually happening.
> =

> Since we keep parsing all capabilities, I wanna avoid that a later one
> overwrites a previous one. That said, just using some flags would be
> better anyway. Especially since we also always have have_sim as well.
> =

> However that can be done as a further optimization in the Speedup and
> Huawei drivers.
> =


A flagged enum is indeed what I had in mind when I wrote this.  But fair
enough on your reasoning.

Regards,
-Denis

--===============3663309420722060738==--

