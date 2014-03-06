Content-Type: multipart/mixed; boundary="===============6500469464941661448=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 19:04:09 -0800
Message-ID: <C4F890CA-C25A-4C43-9B53-607EA95CE031@holtmann.org>
In-Reply-To: <5317CC39.706@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6500469464941661448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

>>>>> What do you think about extending org.ofono.ConnectionContext API with
>>>>> Add/RemoveProperty calls and PropertyAdded/Removed signals to allow
>>>>> platform/application specific properties of type string? Use cases
>>>>> include marking connections as preferred/default or assigning priorit=
ies
>>>>> to them, tracking the origin of the context (OTA, local provision or
>>>>> manually edited) and who knows what else.
>>>>> =

>>>> =

>>>> There are practical considerations that make this a bad idea, e.g. sec=
urity concerns or the fact that our dbus bindings do not handle dynamic pro=
perties.  Putting that aside...
>>>> =

>>>> Your suggestion would be completely against our three core design valu=
es, e.g. "Minimal and Complete"; "Consistent" and "Easy to Use".
>>>> =

>>>> I'm open to adding additional properties the "old way" if you can argu=
e good use cases for them.
>>> =

>>> A couple of examples.
>>> =

>>> Suppose, we have a UI that allows the user to switch between "Automatic=
" and "Custom" MMS or GPRS settings. One of the ways to implement that woul=
d be to create a new context marked as "manual" and allow the user to edit =
it. The old context remains but it's marked as "automatic" or whatever. Man=
ual context has a precedence over the automatic one. Switching back to auto=
matic means destroying the "manual" context or marking it as "disabled". Al=
l that stuff gets saved to the ofono SIM-specific gprs file so that these c=
ontext properties don't get lost after swapping SIMs.
>>> =

>>> Suppose, we have a different connection management system, which shows =
the entire list of available access points to the user and allows to choose=
 which one to use. The selected context needs to be marked as "default" or =
something. Again, this context property needs to survive SIM swap. With a c=
ustom context property that's pretty easy to do.
>> =

>> I am not even sure what=E2=80=99s your goal here? Are just trying to pla=
in copy the horrible crap that Android puts in front of their users?
>> You do realize that their list of APNs just purely exists since they nev=
er figured out on how to do the automatic provisioning properly and user fr=
iendly.
> =

> No, I didn't realize this.  I've generally had positive experiences with =
the Android phones ( mostly Nexus*, except for a G1 ) I've owned.

it is pretty bad. I have used it in many difference countries and it gets a=
 lot of stuff horrible confused. Fun stuff if you enter Canada and for some=
 reason it decided to configure APNs from Italy after you get out of flight=
 mode.

It also gets re-provisioned once you switch SIM cards which makes this horr=
ible annoying. Something that the iPhone does as well. oFono has this lucki=
ly persistent.

> That said, apns-conf has a lot more content than mbpi, especially with re=
gards to MMS support.  There are grand total of 16 MMS APNs defined in the =
latest version of mbpi:
> =

> https://git.gnome.org/browse/mobile-broadband-provider-info/

The MBPI database is pretty much a joke when it comes to MMS. It is also a =
joke when it comes to automated provisioning since they stuffed everything =
in there. So it is hard to make a choice. Then again, the Gnome guys used t=
hat for UI based configuration and for that it is not that bad.

For example in one of our devices we used a combined approach. If the APN e=
ntries could be clearly identified it gets auto-provisioned by oFono=E2=80=
=99s plugin. If that failed the UI realizes this and starts a first time se=
tup UI that lets you chose the APN based on the plan information or what no=
t. So the database got used twice.

With the information that oFono provided for the SIM cards MCC and MNC (and=
 the MNC length determination from SIM filesystem is important here), the f=
irst time setup agent could be as smart as human possible. So it normally j=
ust showed the list of MNVOs and you had to pick one. That was it. After th=
at it was persistently saved by oFono and the user never had to deal with t=
hese details again (unless manually triggered by user through settings).

As mentioned in the other email, we realized that the MBPI is not the best =
database available and we made certain improvements to it already. However =
the content never got where it needs to be. That is why for oFono it is plu=
gin based. You can just use your own database format and then have your plu=
gin do the job.

Personally I think some simple CSV based format would work just fine. I thi=
nk that is what Nokia used in the Maemo/MeeGo devices. The real hard job is=
 to go through all the operator information and create a good database. Tha=
t is the key here. Ignoring that fact is just silly.

>> I have to second Denis here that time is better spent in creating a prop=
er provision database instead of just copying what AOSP provides.
> =

> Sure, but how long has mbpi been around for, and why isn't it in better s=
hape?  Also, as explained earlier Android supports combined contexts, which=
 is not compatible with mbpi's schema.
> =

> I'm not against improving mbpi or even working to help create a new datab=
ase.  For us right now, apns-conf is a viable alternative which gives us de=
cent provisioning for both Internet and MMS, so we'd like to ensure we can =
support it.

I can just repeat the fact that we made this plugin based for exactly that =
reason. Both databases have crap in it that is utterly useless and presente=
d wrongly. We decided to not provide a database of our own since we are not=
 in that business. That is an OEM customization.

>> For example many operators are using SPN or IMSI prefixes to clearly ide=
ntify their MNVO.
>> We made the provisioning a plugin design for exactly that reason so that=
 every product can provide its own database.
> =

> This is exactly what we're trying to do, however as my original email sai=
d, we ran into a few stumbling blocks=E2=80=A6

It will not always work. There are some network operators that are just a l=
ost cause. The way we have designed oFono and used auto-provisioning in pro=
ducts is that when oFono can not figure it out, then you need to ask the us=
er. See my comment above.

>> You might also think this through once more. What does default actually =
mean. Can every context have a default tag?
> =

> As far as I understand it, "default" indicates support for Internet.

In Android terms, yes. Which has no meaning whatsoever anywhere else. As I =
said, Android has not done a good job with the auto-provisioning. Better th=
an Symbian though ;)

> Also, please understand that the UI examples that Slava included apply to=
 Sailfish's UI, not Ubuntu Touch.
> =

>> Which one do you pick then? Who is making this policy and who is ensurin=
g what is active at what time.
> =

> We give preference to the first context of type "default" ( for which we =
create an INET context ), unless this has been overriden by the user from a=
 settings UI.  I'd considered making my new "ExtraData" propertly write-abl=
e, so that the UI could add some tag/attribute to denote this.
> =

> The other choice of course is to store this meta-data somewhere else... w=
hich would impact Network Manager, as it's the process responsible for acti=
vating/deactivating contexts for Touch.
> =

>> oFono is happily
>> supporting multiple Internet contexts and have them all active. Our own =
modem hardware supports many contexts.
>> We have run this with 4 Internet contexts at the same time (different an=
d same ones).
> =

> Understood, as mentioned we need to support multiple contexts for the cas=
e where a MMS APN is not shared with any other type.
> =

>> And I have to note that oFono never establishes contexts by itself. The =
only thing that oFono does is attach to the GPRS (packet switched) part of =
network.
>> The APN establishment is a policy enforced by ConnMan for Internet conte=
xts and mmsd for MMS contexts.
> =

> In our case it's NetworkManager responsible for both, with help from a fe=
w other system components ( such as our Download Manager ).

We decided clearly against involving ConnMan in the MMS context part. It ju=
st creates a horrible complicated system. If it is not giving you Internet =
connectivity, ConnMan stays away from it.

>> The simplest approach we found with our devices is to only provide one I=
nternet context from the user interface.
> =

> Did you expose the MMS context anywhere in your user interface?

The telephony settings application allowed for manual or wizard based confi=
guration. So yes, you were able to see it if you went into telephony settin=
gs.

However ConnMan never exposed this and so the networking settings only show=
ed Internet contexts. Keep in mind that the configuration of the Internet c=
ontext is a telephony/cellular setting detail. ConnMan settings only allowe=
d activated or deactivating the context.

>> If it is wrong for whatever reason or provisioning can not identify it, =
then the user gets asked once. If user wants to change it they can go throu=
gh the APN setup process once more. Worked smoothly for us and is super use=
r friendly.
> =

> Makes sense.

Regards

Marcel


--===============6500469464941661448==--

