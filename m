Content-Type: multipart/mixed; boundary="===============0896028877011735089=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: Upstreaming patches and Modem Manager support for MMSD
Date: Sun, 07 Feb 2021 12:53:14 +0000
Message-ID: <20210207125314.2958.3194@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0896028877011735089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Good Morning,

I have been working to add modem manager support to mmsd, as well as making=
 several improvements to the mmsd. For Modem Manager, I have had it tested =
across several carriers in the US as well as in Canada, Sweden, and France.=
 I think it is stable enough to warrant upstreaming the changes. What would=
 be the procedure to start upstreaming it? I assume have two set of patches:

1) A set of patches to enable modem manager support
2) A set of general improvement patches =


My repository lives here: https://source.puri.sm/kop316/mmsd/  The original=
 code from upstream is here: https://source.puri.sm/kop316/mmsd/-/tree/mast=
er , with all of the changes I have been making are here: https://source.pu=
ri.sm/kop316/mmsd/-/tree/ModemManager . I also made Debian packaging for th=
e Modem Manager plug in here: https://source.puri.sm/kop316/mmsd/-/tree/deb=
ian/modemmanager/latest

Thank you!

Respectfully,
Chris
--===============0896028877011735089==--

