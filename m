Content-Type: multipart/mixed; boundary="===============8801283056403350260=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 08:42:52 +0100
Message-ID: <CAKSBH7HtNp7kw6MY-kRHb4+rGP9nFDyQ3E29pKMmgJsOdspp9g@mail.gmail.com>
In-Reply-To: <6b1bc42a-7bc6-f5b1-776f-f707fffe683f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8801283056403350260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Dec 12, 2018 at 5:44 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> Can you cite the 3GPP specification number and section that this would
> >> be violating?

21.111 (USIM and IC card requirements), or predecessors/successors.
I have taken the rel.7, whose paragraph 5.3 (User Data Stored in ME) mentio=
ns:

"User related security codes such as PIN and Unblock PIN may only be
stored by the ME during the procedures involving such a code and shall
be discarded by the ME immediately after completion of the procedure."

Is this forbidding enough?

> >
> > I will check this, but I remember that it is forbidden for at least two=
 reasons:
>
> FYI, I have seen modems from Nokia & Intel do this.  They would store

I know that Nokia used to do what they wanted. It is the problem of a
de facto monopoly.

> the PIN in the NVRAM and if the firmware crashed, the PIN would be
> entered automagically.  That is why we have the ofono_modem_reset API.
> So you really need to cite a spec when you use such strong wording as
> 'forbidden'.
>
> > - the PIN can be changed (in another phone/application), and then it
> > would be blocked
>
> Yes, and I've already made Nandini aware of this concern.  However, the
> cache is not kept across ofono daemon restarts and is only meant for
> modem crashes.
>
> Perhaps we need to clear the cache in a few additional scenarios to
> mitigate the above concern.  E.g. if the Modem was powered off via
> D-Bus, then any inserted SIM ICCID/PIN combo can be cleared.  Or if the
> modem driver issues an ofono_sim_inserted_notify(false) (because the
> user decided to physically remove the SIM), then any cache entries for
> the current ICCID/PIN can also be cleared.
>
> >    this would make the pin cache feature also quite complicated,
> > because it must be deleted when the presentation is wrong, and if the
>
> This already happens...
>
> > SIM is blocked, then also the application is more complicated because
> > it must consider that it needs to unblock the PIN under some
> > conditions. Also, if the PIN is changed by ofono, it must also be
> > tracked by the caching feature.
>
> And this already happens as well.
>
> > - the PIN presentation is prerogative and privilege of the user. It
> > cannot be delegated to the ME. Otherwise there would be no need for a
> > PIN at all. I have to say, I have seen several SIM with the PIN
> > disabled (especially in the US), but the user can always enable it if
> > he likes, and then wouldn't welcome that the device can be used
> > without his consent.
> >    from an operator point of view, it attributes the responsibility to
> > network access and use to the user, just like with the credit cards
> > chip&pin.
>
> As I mentioned above, the PIN cache is not persisted.  So the user would
> still need to enter the PIN on a reboot / insertion.
>
> The cache is really only meant for the case where a modem goes down
> unexpectedly.  One could in theory argue that it is possible to trigger
> this with USB sticks and maybe we need an additional hint from the
> driver to enable this behavior.  E.g. make it opt-in rather than a
> default for everyone.
>
> Do note that projects like NM/MM persist the PIN across reboots, though
> they do it for different reasons...
>
> Regards,
> -Denis

Regards,
Giacinto

--===============8801283056403350260==--

