Content-Type: multipart/mixed; boundary="===============2922064683720058378=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 20:15:37 -0500
Message-ID: <5317CC39.706@canonical.com>
In-Reply-To: <02CB7E5D-B6EC-49EB-B47B-6307E1A86918@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2922064683720058378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/05/2014 01:29 PM, Marcel Holtmann wrote:
> Hi Slava,
>
>>>> What do you think about extending org.ofono.ConnectionContext API with
>>>> Add/RemoveProperty calls and PropertyAdded/Removed signals to allow
>>>> platform/application specific properties of type string? Use cases
>>>> include marking connections as preferred/default or assigning prioriti=
es
>>>> to them, tracking the origin of the context (OTA, local provision or
>>>> manually edited) and who knows what else.
>>>>
>>>
>>> There are practical considerations that make this a bad idea, e.g. secu=
rity concerns or the fact that our dbus bindings do not handle dynamic prop=
erties.  Putting that aside...
>>>
>>> Your suggestion would be completely against our three core design value=
s, e.g. "Minimal and Complete"; "Consistent" and "Easy to Use".
>>>
>>> I'm open to adding additional properties the "old way" if you can argue=
 good use cases for them.
>>
>> A couple of examples.
>>
>> Suppose, we have a UI that allows the user to switch between "Automatic"=
 and "Custom" MMS or GPRS settings. One of the ways to implement that would=
 be to create a new context marked as "manual" and allow the user to edit i=
t. The old context remains but it's marked as "automatic" or whatever. Manu=
al context has a precedence over the automatic one. Switching back to autom=
atic means destroying the "manual" context or marking it as "disabled". All=
 that stuff gets saved to the ofono SIM-specific gprs file so that these co=
ntext properties don't get lost after swapping SIMs.
>>
>> Suppose, we have a different connection management system, which shows t=
he entire list of available access points to the user and allows to choose =
which one to use. The selected context needs to be marked as "default" or s=
omething. Again, this context property needs to survive SIM swap. With a cu=
stom context property that's pretty easy to do.
>
> I am not even sure what=E2=80=99s your goal here? Are just trying to plai=
n copy the horrible crap that Android puts in front of their users?
> You do realize that their list of APNs just purely exists since they neve=
r figured out on how to do the automatic provisioning properly and user fri=
endly.

No, I didn't realize this.  I've generally had positive experiences with =

the Android phones ( mostly Nexus*, except for a G1 ) I've owned.

That said, apns-conf has a lot more content than mbpi, especially with =

regards to MMS support.  There are grand total of 16 MMS APNs defined in =

the latest version of mbpi:

https://git.gnome.org/browse/mobile-broadband-provider-info/

> I have to second Denis here that time is better spent in creating a prope=
r provision database instead of just copying what AOSP provides.

Sure, but how long has mbpi been around for, and why isn't it in better =

shape?  Also, as explained earlier Android supports combined contexts, =

which is not compatible with mbpi's schema.

I'm not against improving mbpi or even working to help create a new =

database.  For us right now, apns-conf is a viable alternative which =

gives us decent provisioning for both Internet and MMS, so we'd like to =

ensure we can support it.

> For example many operators are using SPN or IMSI prefixes to clearly iden=
tify their MNVO.
> We made the provisioning a plugin design for exactly that reason so that =
every product can provide its own database.

This is exactly what we're trying to do, however as my original email =

said, we ran into a few stumbling blocks...

> You might also think this through once more. What does default actually m=
ean. Can every context have a default tag?

As far as I understand it, "default" indicates support for Internet.

Also, please understand that the UI examples that Slava included apply =

to Sailfish's UI, not Ubuntu Touch.

> Which one do you pick then? Who is making this policy and who is ensuring=
 what is active at what time.

We give preference to the first context of type "default" ( for which we =

create an INET context ), unless this has been overriden by the user =

from a settings UI.  I'd considered making my new "ExtraData" propertly =

write-able, so that the UI could add some tag/attribute to denote this.

The other choice of course is to store this meta-data somewhere else... =

which would impact Network Manager, as it's the process responsible for =

activating/deactivating contexts for Touch.

> oFono is happily
> supporting multiple Internet contexts and have them all active. Our own m=
odem hardware supports many contexts.
> We have run this with 4 Internet contexts at the same time (different and=
 same ones).

Understood, as mentioned we need to support multiple contexts for the =

case where a MMS APN is not shared with any other type.

> And I have to note that oFono never establishes contexts by itself. The o=
nly thing that oFono does is attach to the GPRS (packet switched) part of n=
etwork.
> The APN establishment is a policy enforced by ConnMan for Internet contex=
ts and mmsd for MMS contexts.

In our case it's NetworkManager responsible for both, with help from a =

few other system components ( such as our Download Manager ).

> The simplest approach we found with our devices is to only provide one In=
ternet context from the user interface.

Did you expose the MMS context anywhere in your user interface?

> If it is wrong for whatever reason or provisioning can not identify it, t=
hen the user gets asked once. If user wants to change it they can go throug=
h the APN setup process once more. Worked smoothly for us and is super user=
 friendly.

Makes sense.

Regards,
/tony

--===============2922064683720058378==--

