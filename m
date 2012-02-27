Content-Type: multipart/mixed; boundary="===============6930823909150243823=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: trying to understand context creation
Date: Mon, 27 Feb 2012 11:25:03 +0200
Message-ID: <CAHiDW_FBNXfZWhLDBX8aWG6e4vD-nFgejCSNREi3dWy5cmXOTQ@mail.gmail.com>
In-Reply-To: <4F473A5B.8040202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6930823909150243823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2012 at 9:20 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>> HW problems any more than I'm "fixing" connman crashes in my UI --
>> both are still events I'd rather handle (witihin limits) if that makes
>> the UX better.
>
> Sure, the UI should handle the basics, e.g. connman service being
> stopped by the administrator. =C2=A0However, going out of your way to
> 'handle' connman crashes or ofono HW issues is clearly the wrong thing
> to do. =C2=A0A system service crashing is a major problem and should be
> addressed by the project responsible, not by the UI.

From a UI point of view, connman crashing and connman being stopped
are 100% same -- the only thing the UI can do is inform the user that
there is a critical  problem, so they won't just wait there expecting
that Wifi AP to show up any moment now... I hope the users would never
have to see that but they sometimes do.

I'm not sure what you mean by "going out of my way". I either handle
this situation or I don't. The same goes for ofono contexts that are,
from my POV, broken.

>> We are in total agreement. I will gladly remove this whole UI when you
>> or someone else with knowledge on this tells me that ofono + mbpi can
>> handle things. Likewise, if you tell me I can drop the manual settings
>> part and that won't harm many users, I will do it in a heart beat.
>>
>
> I would guesstimate that it works in 90% of the cases today, the other
> 5-9% are handled using a simple dialog. =C2=A0If this is not the case, th=
en
> we would like to know what is failing / not working.
>
> Dropping the settings UI is probably never going to be feasible, but it
> should be made into an avenue of last resort. =C2=A0E.g. something that t=
he
> user can be guided through by tech support at the carrier for instance.
> =C2=A0Not something that the user should ever see under 99% of circumstan=
ces.

Let's work on this then -- that is my goal as well, but my
understanding of current situation was just way grimmer: maybe I've
missed some bit about how the provisioning works. This is my
understanding:
  * connman shows a cellular service for every internet context
  * ofono creates a internet context for every modem that is capable
  * if there are multiple APNs defined in mbpi for the carrier, the
ofono context will be empy
  * mbpi has lots and lots of carriers with multiple APNs, most of the
big names I checked seem to have multiple ones.

This seems to imply that by far the most common use case is this:
  * user plugs in a new modem
  * ofono creates an empty context (because of multiple APNs defined
for carrier)
  * connman shows a broken cellular service that does absolutely
nothing -- it stays in "idle" forever and does not react to anything.

You said 90% of the cases should just work -- where does this
difference in experiences come from?

 - Jussi

--===============6930823909150243823==--

