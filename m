Content-Type: multipart/mixed; boundary="===============8923072246006021957=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: trying to understand context creation
Date: Fri, 24 Feb 2012 01:20:59 -0600
Message-ID: <4F473A5B.8040202@gmail.com>
In-Reply-To: <CAHiDW_H5u561E7kd4aNOmNVXni_-mBCASKzSQ4RS_HCdFA7QYg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8923072246006021957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> User experience issues have more shades of grey than middleware
> issues... Failing early and clearly is significantly better UX than
> failing but leading the user to believe things work. I'm not "fixing"

UI has more shades of grey than a telephony stack? That is an argument
we should have over beer sometime ;)

> HW problems any more than I'm "fixing" connman crashes in my UI --
> both are still events I'd rather handle (witihin limits) if that makes
> the UX better.
> =


Sure, the UI should handle the basics, e.g. connman service being
stopped by the administrator.  However, going out of your way to
'handle' connman crashes or ofono HW issues is clearly the wrong thing
to do.  A system service crashing is a major problem and should be
addressed by the project responsible, not by the UI.

> We are in total agreement. I will gladly remove this whole UI when you
> or someone else with knowledge on this tells me that ofono + mbpi can
> handle things. Likewise, if you tell me I can drop the manual settings
> part and that won't harm many users, I will do it in a heart beat.
> =


I would guesstimate that it works in 90% of the cases today, the other
5-9% are handled using a simple dialog.  If this is not the case, then
we would like to know what is failing / not working.

Dropping the settings UI is probably never going to be feasible, but it
should be made into an avenue of last resort.  E.g. something that the
user can be guided through by tech support at the carrier for instance.
 Not something that the user should ever see under 99% of circumstances.

>> My point here is that we should re-examine what we can do to make
>> provisioning more fool proof, rather than trying to band-aid a settings
>> UI that is inherently not understandable to anyone who isn't a GSM geek.
> =

> Yes, we should. As upstream project developers we have the luxury of
> making statements like that (you here, I can do it in dawati-shell)
> and that is definitely what actually improves the whole stack in the
> long term.

Please don't make this an upstream vs downstream issue.  It is not.
Nobody is knocking what you're trying to do, just disagreeing on the
approach ;)

> =

> Unfortunately I also have a role closer to an actual product where
> "yeah, the provisioning should be better" is not an acceptable answer
> to a bug report about the connectivity UI. My job is to make the UI
> work as well as it can with the middleware and provisining db we have
> right now. You can call it band-aiding but it's still my job.

You are spending time optimizing the 1-5% case, clearly something is
wrong here.  If provisioning isn't working properly then we should fix
it in either oFono or MBPI.  And there's always the option of using
another provisioning database for the carriers being targeted for our
products...

Regards,
-Denis

--===============8923072246006021957==--

