Content-Type: multipart/mixed; boundary="===============9105140959998141845=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 16:06:05 +0300
Message-ID: <2fc0bde9-9ebb-6103-40fe-952fc810e36f@jolla.com>
In-Reply-To: <4b22d49e-81f5-4068-ec75-e5646e9bec03@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9105140959998141845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/09/17 12:47, Jonas Bonn wrote:
> On 09/07/2017 06:23 AM, Nishanth V wrote:
>> added new DBUS methods RegisterAgent and UnregisterAgent to
>> Networkmonitor interface so that any client of ofono can register for
>> serving cell updates. Added new agent interface NetworkMonitorAgent
>> with two methods, ServingCellInformationChanged and Release.
>
> My spontaneous reaction to this is that it feels like the wrong =

> approach.  Why not make the properties actual DBus properties and =

> provide PropertiesChanged events for them?  That begets you the same =

> functionality for "free".

The implementation also seems to limit the number of clients receiving =

those cell change notifications to just one. Why? In real life more than =

one process may need those.

Cheers,
-Slava

--===============9105140959998141845==--

