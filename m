Content-Type: multipart/mixed; boundary="===============3453793133827919705=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 11:03:13 -0500
Message-ID: <69c70303-0412-f457-c54b-72dc1248f898@gmail.com>
In-Reply-To: <4b22d49e-81f5-4068-ec75-e5646e9bec03@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3453793133827919705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 04:47 AM, Jonas Bonn wrote:
> On 09/07/2017 06:23 AM, Nishanth V wrote:
>> added new DBUS methods RegisterAgent and UnregisterAgent to
>> Networkmonitor interface so that any client of ofono can register for
>> serving cell updates. Added new agent interface NetworkMonitorAgent
>> with two methods, ServingCellInformationChanged and Release.
> =

> My spontaneous reaction to this is that it feels like the wrong =

> approach.  Why not make the properties actual DBus properties and =

> provide PropertiesChanged events for them?  That begets you the same =

> functionality for "free".

Because most clients don't care about these properties, so there's no =

sense in broadcasting them out to the wide world.  Even if nobody =

actually subscribes to the PropertyChanged signal on this interface we =

still must send messages to the dbus daemon, and that means extra =

context switches, extra cpu time, etc.

Besides, this interface will be eventually expanded to cover neighbor =

cells as well.  And that can get quite chatty.

> =

> It's interesting that you posted this now because I've spent the last =

> week grumbling over this API myself as I'm putting support for the =

> NetworkMonitor interface into the QMI modem class.  My thoughts:
> =

> i)  There's duplicate information all over the place.  MNC, LAC, etc. =

> are provided in three different interefaces: NetworkRegistration, =

> NetworkMonitor, and NetworkOperator.

Why is this a problem?  And strictly speaking NetworkOperator only =

provides MNC/MCC which can be different from the current serving cell. =

This can be used by the user to select a particular operator to register =

with.

> ii)  The NetworkOperator interface caught me off guard as it appeared =

> out of nowhere!  There is no documentation for the interface and the =

> implementation seems to be missing from most device classes.

You might want to read doc/network-api.txt more carefully then :)  It =

has been documented since 2009.  Note that there is no 1:1 =

correspondence between atoms and interfaces.  NetworkOperator does not =

have an underlying atom and is managed entirely by netreg.

> iii)  The polled nature of the NetworkMonitor object surprised me. This =

> seems like a natural case for notifications and the patch series in this =

> email thread underscores this fact.

Polled?  The GetServingCellInformation() method call is polled.  But it =

isn't meant to be used often.  The agent version leaves it up to the =

driver on how to implement the periodic update.  We looked at a few AT =

command specifications for this and while some of them support true =

unsolicited notifications, most don't.  For example, XMM 71xx modems =

only support direct query and periodic mode while others only support =

direct query.

The interface is quite experimental and the exact semantics of the =

period parameter need to be figured out.  I suspect it is mostly going =

to be a hint that the application can provide for how often the updates =

are needed.  If true unsolicited notifications are supported then the =

driver can ignore it.

> iv)  For QMI, at least, the NetworkRegistration atom is monitoring =

> asynchronous events that contain essentially all the information needed =

> by the NetworkMonitor atom.  The NetworkRegistration atom could just =

> save these values and provide the NetworkMonitor interface in the same =

> module instead of having an additional netmon module, but:

Unfortunately we have more than QMI modems to worry about.  All this is =

generally done via proprietary AT commands, so having it inside the =

netreg atom will not work.

Also consider that we will not be able to support this for all hardware, =

either due to lack of support in the firmware or lack of documentation. =

So having this on a separate atom/interface makes it easy for =

applications to adjust their behavior.  E.g. if the interface is =

present, then one can count on the functionality being there.  If not =

present, then behave accordingly.

> =

> a)  We end up monitoring unnecessary state in case nobody is actually =

> listening to the NetworkMonitor updates.  This seems to have a =

> negligible impact on performance so it probably does not matter.

Well, you could enable / register to these notifications only if =

periodic updates have been enabled...

> =

> b)  ofono does not use this approach anywhere else that I can see... =

> every atom/interface is provided in it's own module.

This is preferred.  Besides, qmi_service_register can support multiple =

clients, no?

> =

> v)  Point iv) applies to the NetworkOperator interface, as well, if we =

> decide to implement it... should we?

I won't comment until you familiarize yourself with src/netreg.c

> =

> vi)  I suspect that other device classes (AT, etc.) provide asynchronous =

> network quality updates, as well; if they do not, however, then it seems =

> natural to move the polling of this state into the device class driver.
> =


See above.  Many of them don't.

> Sorry for hijacking this for a bit of QMI implementation discussion but =

> it seems relevant in trying to understand what it is that the =

> NetworkMonitor interface is supposed to be.
> =


Don't be sorry, it is nice that others are looking at this and providing =

feedback.

Regards,
-Denis

--===============3453793133827919705==--

