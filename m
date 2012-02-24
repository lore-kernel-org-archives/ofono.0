Content-Type: multipart/mixed; boundary="===============9199825711550272749=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: trying to understand context creation
Date: Fri, 24 Feb 2012 13:55:37 +0200
Message-ID: <CAHiDW_EvdQigDvFeWnJG08GQaT2yJiTQGuYe2jhedTWRKQ3fjg@mail.gmail.com>
In-Reply-To: <4F44B31D.2050501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9199825711550272749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On Wed, Feb 22, 2012 at 11:19 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>>> And no, there is absolutely no way to know whether a given context
>>> settings are valid, but a good indication would be that a context
>>> activation fails.
>>
>> Aha... would you consider it a good/bad idea if a configuration UI
>> activated/deactivated the context after modifications to check for
>> this? This could be useful to say "We couldn't connect to the network
>> with these settings, would you like try another configuration?"
>>
>
> I'm generally in favor of not over-complicating this, but instead
> relying on the provisioning data as much as possible.

Well... we do that pretty well already, right? ofono autoconfigures if
there's a single match for the MMC/MNC. If there are several matches,
my 3G wizard consists of a single Dropdown list with the plans and a
OK-button.

I'm trying to improve the two problem cases:
 1. user has to run 3G wizard and makes poor selections
 2. There's a HW problem
As far as I can see the only way to do that is to fail as early as
possible. Currently we fail as late as possible and that's a confusing
user experience.

> Look at iOS for a
> good example, the user doesn't have any UI to edit context settings, it
> is all provisioned using carrier profiles. =C2=A0Granted, the provisioning
> database in use is a little bit better than what
> mobile-broadband-provider-info provides, so some way to manually enter
> details would still be required in our case; however we should strive to
> make this as rarely used as possible.
>
> What you suggest is a good idea, but might be overkill...

Since we have to let the user make a choice on something he does not
understand, I don't see good alternatives: currently we do the worst
possible thing: claim that everything is ok (by accepting the APN
settings and even showing the cellular service) and then later fail
when connecting -- and user has absolutely no way of knowing what the
failure was about*. I'll gladly take suggestions for simpler solutions
that lead to a UI that isn't confusing when things go wrong.

Jussi

*) emphasized by https://bugs.meego.com/show_bug.cgi?id=3D24943: connman
cell service state never seems to go to "failure".

--===============9199825711550272749==--

