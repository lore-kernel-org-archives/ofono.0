Content-Type: multipart/mixed; boundary="===============6324719516010106830=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 5/5] cell-info: Documentation
Date: Wed, 29 Dec 2010 12:39:24 +0200
Message-ID: <AANLkTinQbeL8XubiBW+UpjYfm+F8Co-BDe-oNUShM71k@mail.gmail.com>
In-Reply-To: <1293607085.11345.53.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6324719516010106830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

2010/12/29 Antti Paila <antti.paila@nokia.com>:
> The GetProperties was kind of last minute glue-on but it was not without
> a reason. This atom is about cell info and hence I implicitly assumed
> that when you want to query the properties of a cell you would mean the
> cell that is your current serving cell. Since nearly all atoms have
> GetProperties method, this would be in line with oFono conventions and
> services that assume that interface has GetProperties -method could
> utilize the cell info. As an example, 'list-modems'-script would nicely
> print the serving cell info for a modem.

I agree with Marcel here. A GetProperties is not necessary here,
especially since the backend is still the same poll-only interface
which means there won't be a PropertyChanged ever.

Also, the list-modems script is a weak argument. It is trivial to
change to make it call the GetNeighbors method. Let's not forget the
use case this is trying to solve, which is positioning engine
requesting nmr data. Likely other clients that need cell info are
mostly going to follow NetworkRegistration and its LAC and CI
properties.

> If the client wants the measurement result of neighboring cells, it
> needs to call the GetNeighbors method explicitly. Even if internally
> these two methods lead to same hardware call, I don't believe this
> should effect the design of DBUS interface, that is visible to client
> applications.
>
> That was the reasoning behind the decision to include GetProperties
> -method. If you still believe it is not right I can remove the method.

Yeah, I'd say take it out.

>> What is the reason behind a{sv}aa{sv} here? Wouldn't it be simpler to
>> just go with aa{sv} and declare that the first dict is always the
>> current serving cell? Are the information from the current cell really
>> that different than from the neighbors?
>
> The rationale is that this is the format OMA-TS-ULP-V2_0-20100816-C and
> 3GPP RRC define for user plane location. Also, all modems don't provide
> the same information for serving and neighbor cells; e.g. isimodem
> follows the above mentioned specs. I believe that for location purposes
> the information included in the a{sv} part is not needed for neighbors.
> Hence making the structure flat would not really make things simpler.

I originally suggested a{sv}aa{sv}, but I don't see a problem this
being just a flat aa{sv}. The keys in dicts can always be different,
and if the documentation clearly states that the first dict is always
meta-data, followed by the actual neighbor measurements, it'll work
just the same.

Cheers,
Aki

--===============6324719516010106830==--

