Content-Type: multipart/mixed; boundary="===============4815135899211082618=="
MIME-Version: 1.0
From: Vincent CESSON <vincent.cesson@smile.fr>
Subject: Atoms for hardware monitoring
Date: Tue, 09 May 2017 17:45:42 +0200
Message-ID: <fdd120b37a09f9414b227ba8083ecc10@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4815135899211082618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am currently working with Gemalto modem Cinterion PHS8. This modem =

has hardware related commands to check voltage and temperature. For =

example read the temperature (enable temperature output and read it):

AT^SCTM=3D0,1
OK
AT^SCTM?
^SCTM: 0,0,32

I would like to read these parameters with Ofono but I didn't find in =

documentation any existing interface that can handle hardware =

monitoring. Maybe I could hack Ofono to add custom properties to an =

existing interface for instance, or create my own interface. But if more =

modems propose the same kind of features it could be interesting to find =

a generic API.

I don't know how to process because I am not totally aware of Ofono =

structure and I know a single modem. Should I add a new atom? Is there a =

developer guide for this?

Thanks for your help.

Regards,
Vincent




--===============4815135899211082618==--

