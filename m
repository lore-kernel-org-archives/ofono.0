Content-Type: multipart/mixed; boundary="===============1417842597336978004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Thu, 17 Oct 2013 14:52:55 -0500
Message-ID: <52604017.9030003@gmail.com>
In-Reply-To: <CACM4vuAVG+Z3W7Peq1Qbv4BrGWz+_+vyjYOFuEqgKZ9jnRqwhQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1417842597336978004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/17/2013 11:20 AM, Alfonso Sanchez-Beato wrote:
> Hi Denis,
>
>>
>> I think you're trying to solve a problem that doesn't need to be solved.
>> Its 2013, I've not seen 2G sims available for ages now.  3G sims mandate
>> EFad data to be properly populated.  I really fail to see the point,
>> especially breaking the core to do so.
>
> I can see that your opinion is that it is not an important issue
> because it is supposed not to affect too many people.
>
> But the fact is that at least two operators, one from Sweden and
> another one from Pakistan provide (compliant) SIMs with non-fully
> populated EFad.

The real question is what exactly is happening with these SIMs.  For =

example, if a SIM is an old 2G SIM that has a length 3 EFad, then likely =

it is simply a European SIM with a 2 character MNC.

Whereas if EFad is not populated at all, then you're really in trouble.

For example, I have 2x T-Mobile SIMs on my desk and 2x AT&T SIMs.  Both =

AT&T SIMs have fully populated EFad when used in a 3G device.  When you =

insert these into a Freerunner, they both report EFad as non-existent. =

One T-Mobile 3G SIM has everything populated properly both times.  The =

other SIM reports EFad as length 3 (e.g. no MNC length is included) on a =

3G device and has no EFad whatsoever on the Freerunner.

The last SIM is an older SIM, but as you can see even well-established =

operators can get things wrong.  Being as pedantic as possible is the =

safest approach.  The core is written to be as conservative as possible =

and not try to pick things randomly.  If the SIM is configured wrongly, =

well then there's nothing we can do.

So again, you can try to guess, but you need to do this outside of the =

core.  If you want to run heuristics against IMSI based on some =

database, then just extend the provisioning API to do so.

>
> One new SIM from a MVNO that came to my hands a few weeks ago was SIM
> and not USIM (although EFad was fully populated). 3G phones do work
> with SIMs, and if the operator can buy slightly cheaper cards, it
> might use them. And there are many areas in the world where you just
> have 2G+EDGE coverage, so the operator does not really need to provide
> USIM. So they will provide SIMs, and some of them might no have full
> EFad.
>

Again, I think you're confusing the issue.  The issue is not a 2G sim vs =

3G sim.  The issue is whether EFad was populated properly.  If the =

operator bothers to include it, then likely they will put proper data in =

there, but even then you don't really know for sure.

If EFad is missing completely, well that is a different story.

> So I see your point, but it is not backed by numbers, and I have the
> feeling that this *might* affect more users than expected, especially
> if we think of Asia or Africa.
>

You have to pick your battles.  There's no way you can make this work in =

a foolproof way for every single operator out there.  Too many of them =

just do not follow standards or have not followed them in the past.

>> Fallback to manual user provisioning and give the user a list to choose
>> from.
>
> I think we can make life easier for many users if we provide a
> fail-safe mechanism that will be triggered only for
> non-fully-populated EFad and that in that case will work in most, if
> not all, the cases. I do not say that the patch I sent first would be
> the solution, we can think a different way of solving this.
>

Patches are always welcome, but please keep in mind the core policies I =

outlined.  Plugins have much less restrictions and you can get a bit =

more creative there.  If you want to maintain a MCC -> MNC length =

database based on ITU E.212, then I definitely encourage you to do so.

Regards,
-Denis

--===============1417842597336978004==--

