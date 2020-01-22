Content-Type: multipart/mixed; boundary="===============4807612106585309472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Where are ofono dbus paths for RSRQ and RSRP?
Date: Wed, 22 Jan 2020 15:44:09 -0600
Message-ID: <965e959a-38bf-0451-fb33-869f29ad6108@gmail.com>
In-Reply-To: <CAA=hcWSeZ6dDoz=DTs_e3RM=VkGgReRtD+A_mjGGcxqinjmSuA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4807612106585309472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Sorry, I am still learning dbus command and syntax, can the
> NetworkMonitor interface be run via
> dbus-send?

It can...  Using dbus-send is not too user-friendly though.  I'd suggest =

a UI based tool.  Something like d-feet, or qdbusviewer.

<snip>

>              dict entry(
>                 string "Interfaces"
>                 variant                   array [
>                       string "org.ofono.SmartMessaging"
>                       string "org.ofono.PushNotification"
>                       string "org.ofono.MessageManager"
>                       string "org.ofono.LongTermEvolution"
>                       string "org.ofono.NetworkRegistration"
>                       string "org.ofono.RadioSettings"
>                       string "org.ofono.ConnectionManager"
>                       string "org.ofono.NetworkMonitor"

So the modem repots NetworkMonitor support...

>                       string "org.ofono.MessageWaiting"
>                       string "org.ofono.AllowedAccessPoints"
>                       string "org.ofono.SimManager"
>                    ]
>              )

<snip>

> =

> But I got following command syntax error, what is the correct syntax
> to run NetworkMonitor?
> =

> # dbus-send --print-reply --system --dest=3Dorg.ofono /ubloxqmi_0
> org.ofono.NetworkMonitor.GetProperties

This won't work because NetworkMonitor interface does not have =

Properties.  Refer to the networkmonitor-api.txt documentation: =

https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/networkmoni=
tor-api.txt

You can invoke the org.ofono.NetworkMonitor.GetServingCellInformation or =

GetNeighbouringCellsInformation methods and see if this particular value =

would be reported.

If you're on uBlox hardware, then i think it only reports the Serving =

Cell info, not neighbor cells.

Regards,
-Denis
--===============4807612106585309472==--

