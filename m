Content-Type: multipart/mixed; boundary="===============1722171898797272994=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: trying to understand context creation
Date: Thu, 23 Feb 2012 23:12:10 -0600
Message-ID: <4F471C2A.8070704@gmail.com>
In-Reply-To: <CAHiDW_EvdQigDvFeWnJG08GQaT2yJiTQGuYe2jhedTWRKQ3fjg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1722171898797272994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/24/2012 05:55 AM, Jussi Kukkonen wrote:
> Hi Dennis,
> =

> On Wed, Feb 22, 2012 at 11:19 AM, Denis Kenzior <denkenz@gmail.com> wro=
te:
>>>> And no, there is absolutely no way to know whether a given context
>>>> settings are valid, but a good indication would be that a context
>>>> activation fails.
>>>
>>> Aha... would you consider it a good/bad idea if a configuration UI
>>> activated/deactivated the context after modifications to check for
>>> this? This could be useful to say "We couldn't connect to the network
>>> with these settings, would you like try another configuration?"
>>>
>>
>> I'm generally in favor of not over-complicating this, but instead
>> relying on the provisioning data as much as possible.
> =

> Well... we do that pretty well already, right? ofono autoconfigures if
> there's a single match for the MMC/MNC. If there are several matches,
> my 3G wizard consists of a single Dropdown list with the plans and a
> OK-button.
> =

> I'm trying to improve the two problem cases:
>  1. user has to run 3G wizard and makes poor selections
>  2. There's a HW problem
> As far as I can see the only way to do that is to fail as early as
> possible. Currently we fail as late as possible and that's a confusing
> user experience.
> =


I don't see how you are ever going to fix the HW problem part with a
better 3G settings wizard.  If it doesn't work, no amount of helpful UIs
will make it work.

And if the user is entering information without good understanding of
the questions he's answering then either the provisioning database needs
to be updated or we should be asking better questions.

Of course, preferably we shouldn't even ask the user any questions if
possible ;)

>> Look at iOS for a
>> good example, the user doesn't have any UI to edit context settings, it
>> is all provisioned using carrier profiles.  Granted, the provisioning
>> database in use is a little bit better than what
>> mobile-broadband-provider-info provides, so some way to manually enter
>> details would still be required in our case; however we should strive to
>> make this as rarely used as possible.
>>
>> What you suggest is a good idea, but might be overkill...
> =

> Since we have to let the user make a choice on something he does not
> understand, I don't see good alternatives: currently we do the worst
> possible thing: claim that everything is ok (by accepting the APN
> settings and even showing the cellular service) and then later fail
> when connecting -- and user has absolutely no way of knowing what the
> failure was about*. I'll gladly take suggestions for simpler solutions
> that lead to a UI that isn't confusing when things go wrong.
> =


If the user doesn't understand the choices he's making, then no amount
of helpful UIs will help here.  Imagine you walk into a store with a
very helpful salesman, unfortunately you're speaking a different
language.  If you don't have a very good idea of what you're looking
for, there's nothing he can do to help you.

My point here is that we should re-examine what we can do to make
provisioning more fool proof, rather than trying to band-aid a settings
UI that is inherently not understandable to anyone who isn't a GSM geek.

Regards,
-Denis

--===============1722171898797272994==--

