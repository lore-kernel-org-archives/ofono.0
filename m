Content-Type: multipart/mixed; boundary="===============6025264494122587358=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Thu, 12 May 2016 09:55:45 -0500
Message-ID: <57349971.4060909@gmail.com>
In-Reply-To: <57349501.30804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6025264494122587358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On 05/12/2016 09:36 AM, Marco Trapanese wrote:
> Il 12/05/2016 16:09, Denis Kenzior ha scritto:
>> Are you running BlueZ 5 on your system?  This interface is only
>> available if BlueZ5 support has been enabled.  E.g.
>> plugins/hfp_ag_bluez5.c or plugins/hfp_hf_bluez5.c
>
> I found the problem: there was a dependency from bluez4 instead of
> bluez5 and then the it was compiled with --disable-bluetooth.
>
> Now the error about the dbus is gone! Thanks for putting me on the right
> direction.
> I also verified now the phone is connecting also for headset.
>
> But where I can find the documentation about ofono? I mean, where I can
> learn how to receive and make calls, etc...
>

Have a look at ofono.git/doc directory.  All D-Bus APIs are described =

there.  doc/voicecallmanager-api.txt is the one you want.

Also look at the various test scripts in the test/ directory.  They show =

how to exercise the oFono APIs in practice.

Regards,
-Denis


--===============6025264494122587358==--

