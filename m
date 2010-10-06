Content-Type: multipart/mixed; boundary="===============3110947961602896210=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Handling of Fixed Dialing
Date: Wed, 06 Oct 2010 17:17:54 +0300
Message-ID: <1286374677-2932-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3110947961602896210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch checks if Fixed Dialing is enabled in the SIM-card
by reading FD-activated bit from EFsst or EFest. If FDN is enabled, =

SIM initialization procedure is stopped, and modem will stay in the PRE-SIM=
 state. =

If FD is enabled, this is signaled via DBUS.

I haven't been abled to test this in my 2G-modem properly. Response for
EF-phase is 3. So oFono-API starts to access EFust/EFest files. =

But reading of EFest gives next error:

'technical problem with no diagnostic given'. =


So FD-status is no reachable, although I have activated it in the SIM-card.
I also checked if the FD-status could be located in EFsst (well, accessed w=
ith same code as with EFust), =

but I couldn't give any change for allocated/activated bits for FDN,
even though I enabled/disabled FDN.

Please comment/test.




--===============3110947961602896210==--

