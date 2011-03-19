Content-Type: multipart/mixed; boundary="===============0245958436564718697=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2 1/9] bluetooth: add functions for sco connection
Date: Sat, 19 Mar 2011 13:06:21 +0200
Message-ID: <20110319110621.GA5863@jh-x301>
In-Reply-To: <4D83C03B.4060703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0245958436564718697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 18, 2011, Denis Kenzior wrote:
> > ---
> >  plugins/bluetooth.c |  122 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  plugins/bluetooth.h |    7 +++
> >  2 files changed, 129 insertions(+), 0 deletions(-)
> =

> So before you run too far with this I suggest you speak to Marcel and
> Johan on whether handling SCO audio inside oFono is a good idea.
> Personally I'd rather see this piece remain inside BlueZ, but I'm no
> longer an expert in this area.

AFAIK the plan is still to have only one interface towards PulseAudio as
far as Bluetooth audio is concerned, and that's the Media interface in
BlueZ. So oFono shouldn't need any SCO support as such. What will be
needed though is for oFono to indicate to BlueZ once the SLC
establishment signaling commands are complete (so SCO connections are
neither accepted nor initiated before that) as well as for BlueZ to
indicate to oFono when SCO has been established (so e.g. RING
indications aren't sent prematurely in the case of in-band ring tone).

Johan

--===============0245958436564718697==--

