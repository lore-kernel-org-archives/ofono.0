Content-Type: multipart/mixed; boundary="===============6355551845718653937=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Thu, 17 Oct 2013 18:20:01 +0200
Message-ID: <CACM4vuAVG+Z3W7Peq1Qbv4BrGWz+_+vyjYOFuEqgKZ9jnRqwhQ@mail.gmail.com>
In-Reply-To: <525F14C9.3020709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6355551845718653937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> I think you're trying to solve a problem that doesn't need to be solved.
> Its 2013, I've not seen 2G sims available for ages now.  3G sims mandate
> EFad data to be properly populated.  I really fail to see the point,
> especially breaking the core to do so.

I can see that your opinion is that it is not an important issue
because it is supposed not to affect too many people.

But the fact is that at least two operators, one from Sweden and
another one from Pakistan provide (compliant) SIMs with non-fully
populated EFad.

One new SIM from a MVNO that came to my hands a few weeks ago was SIM
and not USIM (although EFad was fully populated). 3G phones do work
with SIMs, and if the operator can buy slightly cheaper cards, it
might use them. And there are many areas in the world where you just
have 2G+EDGE coverage, so the operator does not really need to provide
USIM. So they will provide SIMs, and some of them might no have full
EFad.

So I see your point, but it is not backed by numbers, and I have the
feeling that this *might* affect more users than expected, especially
if we think of Asia or Africa.

> Fallback to manual user provisioning and give the user a list to choose
> from.

I think we can make life easier for many users if we provide a
fail-safe mechanism that will be triggered only for
non-fully-populated EFad and that in that case will work in most, if
not all, the cases. I do not say that the patch I sent first would be
the solution, we can think a different way of solving this.

Regards,
Alfonso

--===============6355551845718653937==--

