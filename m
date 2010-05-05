Content-Type: multipart/mixed; boundary="===============4580431993534514975=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Modem emulator and DUN server side for oFono and BlueZ
Date: Wed, 05 May 2010 08:57:11 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E6578C9@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <20100430080319.GA11712@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4580431993534514975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
> Hi Zhenhua,
> =

> * Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-04-27 15:53:54
> +0800]: =

> =

>> Hi,
>> =

>> I am now working on modem emulator and one usage is for DUN
> server role. Since Padovan is working on client role, it's
> good to share my rough thinking for server side
> implementation. Here are the simple steps I have:
>> =

>> 1. Create an oFono emulator atom in oFono. It's the emulator
> manager that could create DUN, HFP AG or SPP type emulators.
> It exposes dbus methods like CreateEmulator, DestroyEmulator,
> GetProperty, etc.
>> =

>> 2. DUN agent server in BlueZ watch oFono and call
> CreateEmulator and pass the file descriptor to oFono. This
> server could further implement HFP AG and SPP connection.
> =

> =

> Shouldn't the emulator register itself on the BlueZ agent server?

It's fine to register the emulator like HFP client. In this way, we might a=
ble to share the agent with DUN server as well. Thanks.

> =

> --
> Gustavo F. Padovan
> http://padovan.org
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============4580431993534514975==--

