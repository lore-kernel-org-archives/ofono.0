Content-Type: multipart/mixed; boundary="===============3498647392252739521=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Fri, 14 Jan 2011 01:22:59 +0100
Message-ID: <1294964579.3873.113.camel@aeonflux>
In-Reply-To: <1294912175-12026-4-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3498647392252739521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  Makefile.am    |    9 +++++++--
>  src/ofono.conf |    2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)

<snip>
 =

>    <policy user=3D"root">
>      <allow own=3D"org.ofono"/>
> +    <allow own=3D"com.meego"/>
>      <allow send_destination=3D"org.ofono"/>
>      <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
>      <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
>      <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
> +    <allow send_interface=3D"org.ofono.NetworkTime"/>
>    </policy>
>  =

>    <policy at_console=3D"true">

I am now lost in what you are trying to achieve here. I thought we
agreed that we send a D-Bus method to timed. For that you neither have
to have a well known name nor have a D-Bus interface present.

And surely ofonod will not claim com.meego as service name.

Regards

Marcel



--===============3498647392252739521==--

