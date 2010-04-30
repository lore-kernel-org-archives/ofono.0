Content-Type: multipart/mixed; boundary="===============4178648906424268219=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: Modem emulator and DUN server side for oFono and BlueZ
Date: Fri, 30 Apr 2010 05:03:19 -0300
Message-ID: <20100430080319.GA11712@vigoh>
In-Reply-To: <33AB447FBD802F4E932063B962385B351D9FE1FA@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4178648906424268219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

* Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-04-27 15:53:54 +0800]:

> Hi,
> =

> I am now working on modem emulator and one usage is for DUN server role. =
Since Padovan is working on client role, it's good to share my rough thinki=
ng for server side implementation. Here are the simple steps I have:
> =

> 1. Create an oFono emulator atom in oFono. It's the emulator manager that=
 could create DUN, HFP AG or SPP type emulators. It exposes dbus methods li=
ke CreateEmulator, DestroyEmulator, GetProperty, etc.
> =

> 2. DUN agent server in BlueZ watch oFono and call CreateEmulator and pass=
 the file descriptor to oFono. This server could further implement HFP AG a=
nd SPP connection.


Shouldn't the emulator register itself on the BlueZ agent server?


-- =

Gustavo F. Padovan
http://padovan.org

--===============4178648906424268219==--

