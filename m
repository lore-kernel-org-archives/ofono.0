Content-Type: multipart/mixed; boundary="===============1758465424103710676=="
MIME-Version: 1.0
From: Andrea Furin <andrea.furin@slacky.it>
Subject: Re: ERROR:Reject SCO: Agent not registered. HSP vs A2DP in Debian8
Date: Sun, 10 Jan 2016 19:50:28 +0000
Message-ID: <loom.20160110T204631-712@post.gmane.org>
In-Reply-To: <loom.20160110T162103-945@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1758465424103710676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

UPDATES
About parameters of "load-module module-bluetooth-discover":
headset=3Dnative -> only a2dp
headset=3Dofono -> only headset
headset=3Dauto -> a2dp and headset !!!

so in /etc/pulse/default.pa =

add "headset=3Dauto" to line "load-module module-bluetooth-discover":

load-module module-bluetooth-discover headset=3Dauto

It works!


--===============1758465424103710676==--

