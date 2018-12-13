Content-Type: multipart/mixed; boundary="===============7041982020775538606=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 23:01:45 +0100
Message-ID: <20181213220145.GA28696@amd>
In-Reply-To: <b8877863-c2bf-84af-cf9b-307a942351dd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7041982020775538606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> If a firmware crashes on a device with a PIN lock and the user was browsi=
ng
> the internet at that time, it would be quite intrusive to interrupt the u=
ser
> and prompt them for a PIN (after all, they already entered the PIN).
> Additionally, if the PIN was stored for just this case and the firmware
> reboots fast enough, a crash might not even be noticed by the user at all.
> Now one can argue that the firmware shouldn't crash, and I agree, but
> realistically the chances of that never happening are NIL.

Can I have another scenario?

User is waiting for important call, phone in his pocket, expecting it
to ring. Firmware crashes, reboots... and asks for a PIN.

When the important call comes, phone is not available... as it is
waiting for PIN...

I believe even pretty old Nokia's did cache the PIN so .. exactly this
did not happen.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7041982020775538606==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd1Mxc2tBQ2drUU1PZndhcFhiK3ZMakpnQ2VPVnVCU24xQzNqT0pkK0lqWDV1RzBRNWoK
cDJJQW9Ldm45UXc2dEFBZkpZQnRyU2pkV0dOSm5LNDQKPWRqTmkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7041982020775538606==--

