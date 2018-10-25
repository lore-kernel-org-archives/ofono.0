Content-Type: multipart/mixed; boundary="===============0984474409685799179=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/atutil.h: cb_data ref/unref possibility
Date: Thu, 25 Oct 2018 10:58:20 -0500
Message-ID: <6a056030-2ed3-cab3-1b44-c13dfc157048@gmail.com>
In-Reply-To: <a3c6c6fc-0af1-f99a-95c3-1d8bb09fed4f@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0984474409685799179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/25/2018 01:55 AM, Jonas Bonn wrote:
> Hi Giacinto,
> =

> =

> On 25/10/2018 07:03, Giacinto Cifelli wrote:
>> +static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (cbd =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_atomic_int_inc(&cbd->ref_count);
>> +
> =

> Let me just vent my disagreement with using atomic accessors here again:
> =

> i)=C2=A0 If I'm a new contributor, unfamiliar with ofono, and I see this =
then =

> I think:=C2=A0 "oh oh, this is a thread-safe library... better be =

> careful."... and then I get all confused because nothing else is handled =

> in a thread-safe manner.
> =

> ii)=C2=A0 The atomic operations introduce an unnecessary memory barrier.
> =

> I _presume_ that the code is written this way because it was inherited =

> from connman and connman made an early attempt to be thread safe...??? =

> I'm not sure that legacy is worth preserving.
> =

> Anyway, enough said on the matter.=C2=A0 The implementation is fine aside =

> from my reservations.

So let me make you happy:

For all new code the policy is that g_atomic should not be used.  Once =

we switch to ell for oFono 2.x (or even before that) we should have no =

instances of g_atomic in the codebase.

If someone wants to start removing some of these now, be my guest.

Regards,
-Denis

--===============0984474409685799179==--

