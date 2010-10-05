Content-Type: multipart/mixed; boundary="===============2304671391941770847=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] TODO: ofono_sim_ready_notify()
Date: Tue, 05 Oct 2010 19:15:32 +0300
Message-ID: <AANLkTi=W+H0xg8Cy1vZUUnB6vPZYgZhPdaiUVb4Odc-7@mail.gmail.com>
In-Reply-To: <1286294341.2588.6.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2304671391941770847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/10/5 Marcel Holtmann <marcel@holtmann.org>:
> However you do remember that we had issues when we tried this the first
> time. It looked simpler on paper then it was when trying to make this
> work with all modem plugins. Remember that this has to work with all
> modem plugins and not just ISI or IFX for that matter.

Yes, this is a very tricky problem. I've sent my first stab to the list.

The core side is very simple, but the atmodem driver probably needs
different approach. Perhaps something similar to isimodem with a ready
flag and indications registered at probe time.

Also, probing SIM readiness is tricky in case oFono starts later than
the modem boots. On isimodem side I now try to read some CPHS
information which is available only when SIM is really readable. Most
atmodems probably need a similar firmware-specific hack.

-- =

Pekka.Pessi mail at nokia.com

--===============2304671391941770847==--

