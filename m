Content-Type: multipart/mixed; boundary="===============7860430689217798103=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 23:15:32 +0200
Message-ID: <531793F4.3030107@jolla.com>
In-Reply-To: <02CB7E5D-B6EC-49EB-B47B-6307E1A86918@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7860430689217798103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
> I am not even sure what=E2=80=99s your goal here? Are just trying to plai=
n copy the horrible crap that Android puts in front of their users? You do =
realize that their list of APNs just purely exists since they never figured=
 out on how to do the automatic provisioning properly and user friendly.
>
> I have to second Denis here that time is better spent in creating a prope=
r provision database instead of just copying what AOSP provides. For exampl=
e many operators are using SPN or IMSI prefixes to clearly identify their M=
NVO. We made the provisioning a plugin design for exactly that reason so th=
at every product can provide its own database.
>
> You might also think this through once more. What does default actually m=
ean. Can every context have a default tag? Which one do you pick then? Who =
is making this policy and who is ensuring what is active at what time. oFon=
o is happily supporting multiple Internet contexts and have them all active=
. Our own modem hardware supports many contexts. We have run this with 4 In=
ternet contexts at the same time (different and same ones).
>
> And I have to note that oFono never establishes contexts by itself. The o=
nly thing that oFono does is attach to the GPRS (packet switched) part of n=
etwork. The APN establishment is a policy enforced by ConnMan for Internet =
contexts and mmsd for MMS contexts.
>
> The simplest approach we found with our devices is to only provide one In=
ternet context from the user interface. If it is wrong for whatever reason =
or provisioning can not identify it, then the user gets asked once. If user=
 wants to change it they can go through the APN setup process once more. Wo=
rked smoothly for us and is super user friendly.

I simply gave you a couple of more or less real life examples as why =

people may want to associate additional information with connection =

contexts and keep it persistent across SIM swaps. It doesn't means that =

I'm actually doing exactly what I have described. And in any case it's =

not my job as a middleware developer to design the UI. But in the end =

when it's decided which settings should be per-SIM and which are global, =

I see ofono which I'm already using and which implements persistent =

per-SIM storage, property change notifications and other niceties and =

wish I could just add a few little properties there.

I thought I suggested a simple, flexible and perfectly backward =

compatible solution which would allow to avoid both a) unnecessary =

forking of ofono and b) public arguments about "horrible Android-like =

crap", "you are doing it all wrong", "you don't really need that" and =

such. And yet let people do what they think is right for their own =

project. Doesn't that sound good?

Regards,
-Slava

--===============7860430689217798103==--

