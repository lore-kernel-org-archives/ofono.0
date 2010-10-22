Content-Type: multipart/mixed; boundary="===============5133712584618185983=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC sim-ready-v1 PATCH 3/3] atmodem/sim: use
 ofono_sim_ready_notify
Date: Fri, 22 Oct 2010 13:55:13 -0500
Message-ID: <4CC1DE11.3000307@gmail.com>
In-Reply-To: <1287416435-4307-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5133712584618185983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> By default the driver don't trust the modem to do the right thing and
> adds a delay of 1000 milliseconds after entering the PIN/PUK.  It is
> possible to remove the delay by adding a suitable quirk in
> at_wait_for_ready().
> =

> However, the delay seems to be SIM-card-specific and 1000 ms might not
> be enough. Finding a suitable default value might require experimenting
> with a number of different SIM cards and modems.

I really don't like this aspect.  Perhaps polling +CIMI, +CPBS / +CPMS
might be a better idea?

Regards,
-Denis

--===============5133712584618185983==--

