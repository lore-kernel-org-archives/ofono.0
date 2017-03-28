Content-Type: multipart/mixed; boundary="===============2243690831406789451=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Missing udev rules
Date: Tue, 28 Mar 2017 15:31:25 +0200
Message-ID: <422ed278-1d3e-73d6-8d73-4321a2deb0df@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2243690831406789451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've been poking at the udevng/udev modules a bit recently.  There are =

many places where references are made to settings that come from udev =

but for which are there are no corresponding udev rules anywhere in the =

source code tree.

i)  Almost all the setup_*() functions reference device node labels but =

there are almost no rules that set these labels anywhere.
ii)  There are references to some environment variables from udev that =

aren't set in ofono rules.

Not knowing whether these rules actually exist in the wild means that =

it's difficult to just clean this up.  Unfortunately,
I suspect that most of the device labelling rules are non-existant and =

that the code looks like it does because these functions get =

cut-and-pasted everytime support for a new device is added.

I think, as a general matter of policy, that any reference to a setting =

from udev needs to be accompanied by a rule that makes the setting.  If =

there's no rule, we can assume it's unused and make the according cleanups.

Thoughts?

/Jonas

--===============2243690831406789451==--

