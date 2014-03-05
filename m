Content-Type: multipart/mixed; boundary="===============6390276287239413422=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 10:29:50 -0800
Message-ID: <02CB7E5D-B6EC-49EB-B47B-6307E1A86918@holtmann.org>
In-Reply-To: <531760EF.6040203@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6390276287239413422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

>>> What do you think about extending org.ofono.ConnectionContext API with
>>> Add/RemoveProperty calls and PropertyAdded/Removed signals to allow
>>> platform/application specific properties of type string? Use cases
>>> include marking connections as preferred/default or assigning priorities
>>> to them, tracking the origin of the context (OTA, local provision or
>>> manually edited) and who knows what else.
>>> =

>> =

>> There are practical considerations that make this a bad idea, e.g. secur=
ity concerns or the fact that our dbus bindings do not handle dynamic prope=
rties.  Putting that aside...
>> =

>> Your suggestion would be completely against our three core design values=
, e.g. "Minimal and Complete"; "Consistent" and "Easy to Use".
>> =

>> I'm open to adding additional properties the "old way" if you can argue =
good use cases for them.
> =

> A couple of examples.
> =

> Suppose, we have a UI that allows the user to switch between "Automatic" =
and "Custom" MMS or GPRS settings. One of the ways to implement that would =
be to create a new context marked as "manual" and allow the user to edit it=
. The old context remains but it's marked as "automatic" or whatever. Manua=
l context has a precedence over the automatic one. Switching back to automa=
tic means destroying the "manual" context or marking it as "disabled". All =
that stuff gets saved to the ofono SIM-specific gprs file so that these con=
text properties don't get lost after swapping SIMs.
> =

> Suppose, we have a different connection management system, which shows th=
e entire list of available access points to the user and allows to choose w=
hich one to use. The selected context needs to be marked as "default" or so=
mething. Again, this context property needs to survive SIM swap. With a cus=
tom context property that's pretty easy to do.

I am not even sure what=E2=80=99s your goal here? Are just trying to plain =
copy the horrible crap that Android puts in front of their users? You do re=
alize that their list of APNs just purely exists since they never figured o=
ut on how to do the automatic provisioning properly and user friendly.

I have to second Denis here that time is better spent in creating a proper =
provision database instead of just copying what AOSP provides. For example =
many operators are using SPN or IMSI prefixes to clearly identify their MNV=
O. We made the provisioning a plugin design for exactly that reason so that=
 every product can provide its own database.

You might also think this through once more. What does default actually mea=
n. Can every context have a default tag? Which one do you pick then? Who is=
 making this policy and who is ensuring what is active at what time. oFono =
is happily supporting multiple Internet contexts and have them all active. =
Our own modem hardware supports many contexts. We have run this with 4 Inte=
rnet contexts at the same time (different and same ones).

And I have to note that oFono never establishes contexts by itself. The onl=
y thing that oFono does is attach to the GPRS (packet switched) part of net=
work. The APN establishment is a policy enforced by ConnMan for Internet co=
ntexts and mmsd for MMS contexts.

The simplest approach we found with our devices is to only provide one Inte=
rnet context from the user interface. If it is wrong for whatever reason or=
 provisioning can not identify it, then the user gets asked once. If user w=
ants to change it they can go through the APN setup process once more. Work=
ed smoothly for us and is super user friendly.

> Every project may have requirements that are more or less unique, often i=
nfluenced by the UI design. There's no need to push support for unique proj=
ect specific requirements into the common code, there's nothing here to arg=
ue about. It's a matter of whether you want to make ofono a bit more usable=
 as is or you are fine with it being cloned and heavily modified for each p=
articular project.

Do what we want or we fork your project. Nice :)

Regards

Marcel


--===============6390276287239413422==--

