Content-Type: multipart/mixed; boundary="===============9159677687142796710=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Thu, 13 Jan 2011 09:15:30 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140D4EDD@008-AM1MPN1-002.mgdnok.nokia.com>
In-Reply-To: <1294849744.3873.89.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9159677687142796710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On 12 Jan 2011, Marcel Holtmann wrote:
> Are we expecting that all modems will just establish a normal voice
> call
> and only later on signal that it is a TTY call? Any input from
> different
> vendors other than IFX. What about STE, ISI?

not later, but as part of standard call setup. E.g. on ISI, CTM is =

a property of a voice call. And this makes sense as TTY calls _are_ =

essentially voice calls, with just a bit indicating to the network that =

the voice circuit should be free of any transcoder/audioprocessing/etc =

that is not compatible with CTM. And this is negotiated as part of standard =

call setup (same way as supported codecs).

My understanding so far has been that TextTelephony.Enabled=3DTRUE =

means that the CTM bit is set in all subsequent MO calls, and
it is set by default when answering to MT calls. And the one special =

case is receiving a CTM-enabled call when TTY is not enabled (in oFono). =

In this case it should be possible to enable TTY (for at least that
call) and respond to the call (and ifxmodem seems to provide support =

for this scenario).

This should be standard stuff to all modems as this is a heavily =

regulated feature.


--===============9159677687142796710==--

