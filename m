Content-Type: multipart/mixed; boundary="===============8509223083698413546=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 11:47:22 +0200
Message-ID: <4b22d49e-81f5-4068-ec75-e5646e9bec03@southpole.se>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8509223083698413546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 06:23 AM, Nishanth V wrote:
> added new DBUS methods RegisterAgent and UnregisterAgent to
> Networkmonitor interface so that any client of ofono can register for
> serving cell updates. Added new agent interface NetworkMonitorAgent
> with two methods, ServingCellInformationChanged and Release.

My spontaneous reaction to this is that it feels like the wrong =

approach.  Why not make the properties actual DBus properties and =

provide PropertiesChanged events for them?  That begets you the same =

functionality for "free".

It's interesting that you posted this now because I've spent the last =

week grumbling over this API myself as I'm putting support for the =

NetworkMonitor interface into the QMI modem class.  My thoughts:

i)  There's duplicate information all over the place.  MNC, LAC, etc. =

are provided in three different interefaces: NetworkRegistration, =

NetworkMonitor, and NetworkOperator.
ii)  The NetworkOperator interface caught me off guard as it appeared =

out of nowhere!  There is no documentation for the interface and the =

implementation seems to be missing from most device classes.
iii)  The polled nature of the NetworkMonitor object surprised me. This =

seems like a natural case for notifications and the patch series in this =

email thread underscores this fact.
iv)  For QMI, at least, the NetworkRegistration atom is monitoring =

asynchronous events that contain essentially all the information needed =

by the NetworkMonitor atom.  The NetworkRegistration atom could just =

save these values and provide the NetworkMonitor interface in the same =

module instead of having an additional netmon module, but:

a)  We end up monitoring unnecessary state in case nobody is actually =

listening to the NetworkMonitor updates.  This seems to have a =

negligible impact on performance so it probably does not matter.

b)  ofono does not use this approach anywhere else that I can see... =

every atom/interface is provided in it's own module.

v)  Point iv) applies to the NetworkOperator interface, as well, if we =

decide to implement it... should we?

vi)  I suspect that other device classes (AT, etc.) provide asynchronous =

network quality updates, as well; if they do not, however, then it seems =

natural to move the polling of this state into the device class driver.

Sorry for hijacking this for a bit of QMI implementation discussion but =

it seems relevant in trying to understand what it is that the =

NetworkMonitor interface is supposed to be.

Thoughts?

/Jonas

> ---
>   doc/networkmonitor-api.txt | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
> index ddace7e..0855329 100644
> --- a/doc/networkmonitor-api.txt
> +++ b/doc/networkmonitor-api.txt
> @@ -22,6 +22,34 @@ Methods		a{sv} GetServingCellInformation()
>   			are available, their valid value ranges and
>   			applicability to different cell types.
>   =

> +		void RegisterAgent(object path)
> +
> +			Registers an agent which will be called whenever the
> +			modem registers to or moves to a new cell.
> +
> +		void UnregisterAgent(object path)
> +
> +			Unregisters an agent.
> +
> +NetworkMonitorAgent Hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.NetworkMonitorAgent
> +Object path	freely definable
> +
> +Methods		void ServingCellInformationChanged(a{sv})
> +
> +			This method is called whenever the serving cell
> +			information has been updated.
> +
> +			Possible Errors: None
> +
> +		void Release() [noreply]
> +
> +			Agent is being released, possibly because of oFono
> +			terminating, NetworkMonitor interface is being torn
> +			down or modem off.  No UnregisterAgent call is needed.
>   =

>   Network Monitor Property Types
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D



--===============8509223083698413546==--

