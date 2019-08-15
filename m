Content-Type: multipart/mixed; boundary="===============4377353860468012975=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Unsalble cellular connection
Date: Thu, 15 Aug 2019 13:33:56 +0200
Message-ID: <06302577-e253-2279-3fcd-2f3871c5e4a7@monom.org>
In-Reply-To: <315c5382-35c5-2407-d7c6-9fb198ae4f8b@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4377353860468012975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8/14/19 3:00 PM, Jonas Bonn wrote:
> Well, the log _seemed_ to indicate that connman does an NTP request to a =

> server that isn't available and thereby decides to take the link down... =


NTP lookup failures won't trigger a disconnect. As long oFono or the =

kernel via RNTL changes the state ConnMan doesn't change the routing.

> off the top of my head I can't say whether that's something connman =

> actually does so hopefully somebody else will jump in here.=C2=A0 Did ofo=
no =

> indicate the context as still established after that?

Mabye checking what monitor-ofono shows.

> Seeing the issue with complete logs would be useful.=C2=A0 I thought your =

> previous logs indicated connman trying to deactivate the context when it =

> took the link down, but the ofono logs didn't show any of that... what's =

> going on there?

Yes, that is a good question. If oFono doesn't tell ConnMan anything, =

then ConnMan reacts to a state change of the device.

Thanks,
Daniel

--===============4377353860468012975==--

