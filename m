Content-Type: multipart/mixed; boundary="===============8239982942488095335=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Setting "RoamingAllowed" on by default; or storing persistently
Date: Wed, 24 Jul 2019 17:15:20 +0300
Message-ID: <65e65c13-ee97-03ed-45e6-4a24779440b1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8239982942488095335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'd like for my device to automatically connect to 3G data in roaming =

wherever the GSM network permits it. I'd very much like to set this up =

as default during manufacturing regardless of the SIM inserted. ofono =

version 1.21 (debian buster).

I can tell ofono to enable roaming manually - either via the config file =

(e.g. /var/lib/ofono/248030010014875/gprs) or dbus interface (e.g. =

dbus-send --system --print-reply --dest=3Dorg.ofono /quectel_0 =

org.ofono.ConnectionManager.SetProperty string:"RoamingAllowed" =

variant:boolean:true), but it does not seem to be stored persistently. =

After a reboot ofono has disabled roaming again and the config file =

holds "RoamingAllowed=3D0".

So my questions are:
1. can I set up ofono to always permit data connections in roaming?
2. if not, can I at least store RoamingAllowed persistently per SIM card?

As context: working on a 3G-equipped gateway device, factory-installed =

with a roaming-enabled SIM card and typically shipped to a foreign =

country (mostly within EU where data roaming incurs no penalty). It's =

rather desirable that 3G comes online without requiring any setup =

whatsoever once the gateway is powered on in destination country.

-- =

Kind regards
Tarmo Kuuse

--===============8239982942488095335==--

