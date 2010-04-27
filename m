Content-Type: multipart/mixed; boundary="===============0296505013872604720=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 04:07:13 +0200
Message-ID: <1272334033.22838.117.camel@localhost.localdomain>
In-Reply-To: <20100427012059.GG12813@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0296505013872604720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> I'm starting the DUN Client implementation for the Linux Stack. DUN is
> the Bluetooth dial-up network profile. It makes possible share internet
> connection between two Bluetooth devices. That is my Google Summer of Code
> project for this year.
> =

> Here follows a simple, and possible not complete, roadmap:
> =

> 1. Put send_method_call() and send_method_call_with_reply() on gdbus: tho=
se
> functions are very useful for DBus operations. You can send a DBus message
> just calling them with the right parameters. Patch for that work already =

> on the mailing list.
> =

> 2. Create a bluetooth.c file with the bluetooth helpers. oFono plugins fo=
r HFP,
> DUN and SAP will be able to share the same bluetooth code to access BlueZ
> stuff. This is a ongoing work.
> =

> 3. plugin/dun.c prototype. A simple prototype for the DUN client.
> =

> 4. Agent server on BlueZ. This one is very similar to the HFP Agent serve=
r. At
> the end of the DUN agent project I plan to merge the both agent servers. =
SAP
> will take advantage of that merge too.
> =

> 5. oFono DUN agent. Implement the agent handling for DUN.
> =

> 6. AT command parser and PPP stack integration with DUN. The biggest task,
> where the core of the project is.

this is pretty clear. oFono carries the GAtChat library that comes with
AT command and PPP support. So oFono should carry the DUN client.

Regards

Marcel



--===============0296505013872604720==--

