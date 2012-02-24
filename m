Content-Type: multipart/mixed; boundary="===============0006440965655301586=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: trying to understand context creation
Date: Fri, 24 Feb 2012 18:13:23 +0200
Message-ID: <CAHiDW_H5u561E7kd4aNOmNVXni_-mBCASKzSQ4RS_HCdFA7QYg@mail.gmail.com>
In-Reply-To: <4F471C2A.8070704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0006440965655301586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2012 at 7:12 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>> I'm trying to improve the two problem cases:
>> =C2=A01. user has to run 3G wizard and makes poor selections
>> =C2=A02. There's a HW problem
>> As far as I can see the only way to do that is to fail as early as
>> possible. Currently we fail as late as possible and that's a confusing
>> user experience.
>
> I don't see how you are ever going to fix the HW problem part with a
> better 3G settings wizard. =C2=A0If it doesn't work, no amount of helpful=
 UIs
> will make it work.

User experience issues have more shades of grey than middleware
issues... Failing early and clearly is significantly better UX than
failing but leading the user to believe things work. I'm not "fixing"
HW problems any more than I'm "fixing" connman crashes in my UI --
both are still events I'd rather handle (witihin limits) if that makes
the UX better.

> And if the user is entering information without good understanding of
> the questions he's answering then either the provisioning database needs
> to be updated or we should be asking better questions.
>
> Of course, preferably we shouldn't even ask the user any questions if
> possible ;)

We are in total agreement. I will gladly remove this whole UI when you
or someone else with knowledge on this tells me that ofono + mbpi can
handle things. Likewise, if you tell me I can drop the manual settings
part and that won't harm many users, I will do it in a heart beat.

>>> Look at iOS for a
>>> good example, the user doesn't have any UI to edit context settings, it
>>> is all provisioned using carrier profiles. =C2=A0Granted, the provision=
ing
>>> database in use is a little bit better than what
>>> mobile-broadband-provider-info provides, so some way to manually enter
>>> details would still be required in our case; however we should strive to
>>> make this as rarely used as possible.
>>>
>>> What you suggest is a good idea, but might be overkill...
>>
>> Since we have to let the user make a choice on something he does not
>> understand, I don't see good alternatives: currently we do the worst
>> possible thing: claim that everything is ok (by accepting the APN
>> settings and even showing the cellular service) and then later fail
>> when connecting -- and user has absolutely no way of knowing what the
>> failure was about*. I'll gladly take suggestions for simpler solutions
>> that lead to a UI that isn't confusing when things go wrong.
>>
>
> If the user doesn't understand the choices he's making, then no amount
> of helpful UIs will help here. =C2=A0Imagine you walk into a store with a
> very helpful salesman, unfortunately you're speaking a different
> language. =C2=A0If you don't have a very good idea of what you're looking
> for, there's nothing he can do to help you.
>
> My point here is that we should re-examine what we can do to make
> provisioning more fool proof, rather than trying to band-aid a settings
> UI that is inherently not understandable to anyone who isn't a GSM geek.

Yes, we should. As upstream project developers we have the luxury of
making statements like that (you here, I can do it in dawati-shell)
and that is definitely what actually improves the whole stack in the
long term.

Unfortunately I also have a role closer to an actual product where
"yeah, the provisioning should be better" is not an acceptable answer
to a bug report about the connectivity UI. My job is to make the UI
work as well as it can with the middleware and provisining db we have
right now. You can call it band-aiding but it's still my job.

- Jussi

--===============0006440965655301586==--

