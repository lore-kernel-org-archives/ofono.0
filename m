Content-Type: multipart/mixed; boundary="===============3471477887300098396=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Sat, 09 Sep 2017 11:15:47 -0500
Message-ID: <d2ab5dfb-13dd-9782-1111-18c7667ff754@gmail.com>
In-Reply-To: <563aa13d-dcb1-0993-8bc7-81328fb89103@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3471477887300098396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> Why not create a second interface .AsynchNetworkMonitor that sends =

> PropertyChanged signals.  This interface can be disabled by default, but =

> can be requested by setting to =

> org.ofono.Modem.AsynchronousNetworkMonitorEnabled to 'true', at which =

> point the interface is created on the modem object...?
> =


You're of course free to do anything you want, but it doesn't mean =

upstream will take it :) I refer you to our design philosophy document =

(found in doc/ofono-paper.txt), Section 4.2 and 4.3.  What you propose =

goes fully against that philosophy.

Regards,
-Denis

--===============3471477887300098396==--

