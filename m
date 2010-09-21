Content-Type: multipart/mixed; boundary="===============0439919825371805479=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Description of Voice call history plugin patch
Date: Tue, 21 Sep 2010 11:37:44 +0900
Message-ID: <1285036664.20811.46.camel@localhost.localdomain>
In-Reply-To: <E1A1564674E5754FB00AB9AC949D5E3260C826DE47@rrsmsx501.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0439919825371805479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

just a friendly reminder here to not do top posting. We are not allowing
this on an open source mailing list. It is a good way of actually
getting ignored ;)

> What is the call history agent idea? Can you explain clearly? =


It is like the SIM Toolkit agent, the PIN agent in BlueZ. Read the
documentation and the examples. It is really simple.

In the end an agent is a callback interface inside the UI or an
application outside of oFono. It is were oFono asks for further
information or were it relays information to. In this case the call
history information.

The agent design has the advantage the oFono knows when an agent is
present and when not. So until no agent is present it can spool the
history to disk. And once an agent becomes available replay it to the
agent.

> When the client is up, is the history plug-in sends data instead of any s=
ignal? How about acknowledgement for data delivery especially when we are s=
ending data cached on disk?

The agent are like callbacks. They are D-Bus method calls. The
acknowledgment is implicit here with the method return or error in case
of problems.

> If we forefeit the memory mapped idea, is the plugin writing & reading di=
rectly from the file? =


I personally would just write to the file. However if you wanna do
memory mapped file in round-robin fashion, then that works as well.
However in case of round-robin files you need to think about the memory
layout of your file.

> I will send out a simple algorithm once I understand what you are propros=
ing and once we are on the same page I will implement that and send you the=
 patch. =


Send a D-Bus API document first. See the SIM Toolkit API for an example.

> Can I send the patch with is developer tested code? Does it need to be te=
sted by QA? =


You can even send non-working or non-complete code for review at any
time. Just mark them as RFC (request for comments).

Regards

Marcel



--===============0439919825371805479==--

