Content-Type: multipart/mixed; boundary="===============8177783060855179708=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 15:07:00 -0600
Message-ID: <4D278074.1030909@gmail.com>
In-Reply-To: <201101071052.19202.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8177783060855179708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/07/2011 02:52 AM, R=C3=A9mi Denis-Courmont wrote:
> On Thursday 06 January 2011 02:17:09 ext Denis Kenzior, you wrote:
>>>> If such context is not found create a new one with "Internet" type.
>>>
>>> I don't really agree that we should create a context if no match is
>>> found. I think the better sensible strategy is to hold this information
>>> internally and only map it to a context once the user or provisioning
>>> creates it.
>>
>> From what I understood it should be quite safe to assume it is an
>> internet context.  All IMS contexts will have a well-known APN and the
>> only other one that would make sense for the network to activate
>> automatically would be the internet one.
>>
>> Perhaps this is the missing piece in the description? The fact that
>> either the IMS or an Internet context is created.
> =

> It could be MMS(/WAP) or it could be some private corporate VPN. Or it co=
uld =

> even be some other silliness from some operator(s). I have seen such thin=
g, =

> but I am unsure I can talk freely about the details :-(
> =

> I would definitely advise against marking unknown context as Internets.
> =


So there might be two things going on here:

- Default Bearer when attaching to LTE.  From what I understood this is
unlikely to ever be anything but an Internet context.  Maybe an IMS
default bearer, but then the APN should be well known.  So the proposed
approach should work well enough in my view.  We might need some extra
sanity checking here.  E.g. we're in LTE domain, and this is the first
context active.

- Random Primary / Secondary PDN activation from the network.  This
context can indeed be just about anything.  Fortunately this isn't
really used all that often.  So if we got one of these activated and we
don't have any idea what this context is (e.g. no provisioning info),
then about the only sane thing to do is to deactivate it.

Exposing "unknown" contexts is the wrong approach in my view.  Unless of
course someone plans to ship a psychic with every phone..

Regards,
-Denis

--===============8177783060855179708==--

