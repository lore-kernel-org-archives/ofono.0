Content-Type: multipart/mixed; boundary="===============2738005623729299289=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [RFC at-export 0/2] Export AT-modem functions to other drivers
Date: Mon, 22 Apr 2019 19:33:23 +0200
Message-ID: <e1c7344a-2bd8-1258-4eb7-24a1f308a590@norrbonn.se>
In-Reply-To: <ed150a98-08f4-28c4-4fba-e3e1e316e46b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2738005623729299289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 22/04/2019 17:52, Denis Kenzior wrote:

> What is actually different for uBlox that requires such a drastic =

> approach?=C2=A0 Right now I'm seeing a duplication of CMER/CIEV and NITZ =

> logic.=C2=A0 Not much else.

For the TOBY L4 I hit this:
ofono_error("This driver is not setup with Signal Strength reporting"
             " via CIND indications, please write proper netreg"
             " handling for this device");

This device requires _polling_ ECSQ to get this info (no async signal =

strenght reporting).  Other uBlox models don't have this issue.

So we need to have UBLOX_TOBY_L4, UBLOX_TOBY_L2, etc. "vendor" types to =

differentiate not only the vendor but the model.  Is that ok?  Not =

enough to warrant a custom driver?

Is NITZ really a thing?  I interpreted it as "No immediate timezone"...

/Jonas

--===============2738005623729299289==--

