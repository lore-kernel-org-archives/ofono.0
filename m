Content-Type: multipart/mixed; boundary="===============0336148746805822935=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Sat, 12 May 2018 09:37:52 +0200
Message-ID: <20180512073752.GD9313@nataraja>
In-Reply-To: <5c13ea21-e159-6881-9a4a-8b4071c69289@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0336148746805822935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, Pavel, Marcel,

On Fri, May 11, 2018 at 08:02:01PM -0500, Denis Kenzior wrote:
> This reminds me... Weren't you the one who mentioned that you got voiceca=
lls
> working on QMI devices?  Does that include the circuit switched control
> operations (e.g. dial, etc) as well?  Any chance that code might be
> upstream-able?

let me pull in Alexander "lynxis" Couzens into the loop, he has been doing =
all
QMI / ofono related developments for us in the Osmocom project.

My knowledge is that we're testing our network-side stack with voice calls
related tests (via ofono/QMI) for quite some months, but lynxis would know
all related details.

As there are no modems that reliably can deliver the actual audio data via =
USB
(aside some non-supported outdated experimental firmwares), we're only test=
ing
the signaling plane so far.

We're building a custom board that contains four PCM bus slaves (at differe=
nt clocks!)
in order to pick up the audio/voice data, but this doesn't exist yet.

See http://laforge.gnumonks.org/blog/20170902-cellular_modems-voice/ for mo=
re background
on the user/voice plane.

-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============0336148746805822935==--

