Content-Type: multipart/mixed; boundary="===============4864605031754841551=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Fri, 14 Dec 2018 10:27:37 +0100
Message-ID: <CAKSBH7HN2y6Py7mK86=2vRucVmLsX66UjxNL7M+FuQHFbh8xFg@mail.gmail.com>
In-Reply-To: <45f1f97e-d04b-253b-e897-ae30b9deadeb@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4864605031754841551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,
On Fri, Dec 14, 2018 at 10:19 AM Christophe Ronco <c.ronco@kerlink.fr> wr=
ote:
>
> Hi,
>
> On 12/13/18 11:06 PM, Pavel Machek wrote:
> > On Thu 2018-12-13 23:01:45, Pavel Machek wrote:
> >> Hi!
> >>
> >>> If a firmware crashes on a device with a PIN lock and the user was br=
owsing
> >>> the internet at that time, it would be quite intrusive to interrupt t=
he user
> >>> and prompt them for a PIN (after all, they already entered the PIN).
> >>> Additionally, if the PIN was stored for just this case and the firmwa=
re
> >>> reboots fast enough, a crash might not even be noticed by the user at=
 all.
> >>> Now one can argue that the firmware shouldn't crash, and I agree, but
> >>> realistically the chances of that never happening are NIL.
> >> Can I have another scenario?
> >>
> >> User is waiting for important call, phone in his pocket, expecting it
> >> to ring. Firmware crashes, reboots... and asks for a PIN.
> >>
> >> When the important call comes, phone is not available... as it is
> >> waiting for PIN...
> > And when user realizes what happened, he disables the PIN on his SIM
> > card. When his phone is stolen, thief is able to do many expensive
> > calls on his account...
> >
> >                                                                       P=
avel
>
> Just my 2 cents on this subject.
>
> I used to develop phone firmwares 15 years ago back when we did not have
> a kernel inside a phone. This means that any application (mail, WAP,
> your favorite game, L1, ...) crash ends up in a phone reboot. Of course
> PIN was not asked in this case. Feature name was "silent reboot" if I
> remember well.

In ofono there is an additional difficulty. It does not restore the
situation all by itself.
Ofono provides mechanisms, not policies, so its client shall send the
powered, online, roaming, pdp params and activation.
I don't see why not also the PIN.

>
> So I do confirm this used to be implemented. Maybe it was not compliant
> with 3GPP and a security hole, maybe it was a bad idea.
>
> Christophe Ronco
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============4864605031754841551==--

