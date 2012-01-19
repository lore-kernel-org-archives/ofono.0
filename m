Content-Type: multipart/mixed; boundary="===============8424227357463092328=="
MIME-Version: 1.0
From: Pranay Bahadur Singh - ERS, HCL Tech <Pranay.Singh@hcl.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Thu, 19 Jan 2012 14:51:46 +0530
Message-ID: <0F68B52D2432864190BC72F760407FE923CF24E999@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
In-Reply-To: <4F17B24B.70606@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8424227357463092328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

Thanks for your valuable time.

As suggested by you, I have uninstall all things related to ofono and phone=
sim.

Now I have downloaded ofono-1.2. I have build the same and install it as wr=
itten in README.

After that I have downloaded phonesim-1.16. I have build the same and insta=
ll it as written in README.

Now I want to run ofono-phonesim simulator using the below command: (I have=
 update the conf file in /etc/ofono/phonesim.conf)

phonesim -p 12345  -gui  /ofono/phonesim/src/default.xml

It's goes in hang mode and nothing is displayed on terminal.

Please verify the command in case I am using wrong.

I found on forum that we should use command "ofono-phonesim -p 12345  -gui =
 /ofono/phonesim/src/default.xml"

But for this we should have installed ofono-phonesim on my system. If it's =
correct way to run then please let me know that how to build and install of=
ono-phonesim on my system.

Please let me share the user guide if you have that how to use this as a co=
mplete scenario.

Thanks,
Pranay


-----Original Message-----
From: Antti Kaijanm=C3=A4ki [mailto:antti.kaijanmaki(a)canonical.com]
Sent: 19 January 2012 11:34
To: ofono(a)ofono.org
Cc: Pranay Bahadur Singh - ERS, HCL Tech
Subject: Re: How to start ofono-phonesim in ubuntu-10.04 -reg

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello!

On 19.01.2012 07:06, Pranay Bahadur Singh - ERS, HCL Tech wrote:
> I am getting problem while starting ofono-phonesim-1.16 in
> ubuntu-10.04. I installed ofono-phonesim from synaptic package
> manager in ubuntu lucid

It seems that you are mixing different versions of oFono and
ofono-phonesim. Lucid comes with ofono-phonesim 1.0-2 in universe, but
still you are using some local copy of a never version in your home
directory.

I suggest that you remove packages ofono and ofono-phonesim and then
download the latest release from ofono.org and compile it manually.


- --
Antti Kaijanm=C3=A4ki
Software Engineer
Canonical Ltd.
+358 40 0243 413
https://launchpad.net/~kaijanmaki
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPF7JLAAoJEPzFBNE+d1r0UhAH/3MJ6y0GpfepNXkZBC38iqKw
bnIBWk2C1ppcpbcKQIqnDhScAF9hCaQPZC1YVlSKN/h/APRRiF2DxADgUidJQkMp
2oj75fpyVY8WRpyjn5NfLp8S1EHRAuOybEMIQnfkK5HhLxAiglbq3I+bZ8h7157N
1v4cezrhXxkSrLd+qLMGqr06fI8C3mz6rl4DZS3cBljlPjxd41e6x1iYIMsZzKMs
6ejyWfZK6gw9XDqaULZFEu0VWy3CT5fFs5OIBFXRYCA3BpSl1h9hUFITbp2R02zE
wuI4cdr97+0m0P9ek8cvaSI3U1g3/Mcm4a3zKhTnVWJYmHyd/B9jf4ynitloDFA=3D
=3DEobX
-----END PGP SIGNATURE-----

::DISCLAIMER::
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.
It shall not attach any liability on the originator or HCL or its affiliate=
s. Any views or opinions presented in
this email are solely those of the author and may not necessarily reflect t=
he opinions of HCL or its affiliates.
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited. If you have
received this email in error please delete it and notify the sender immedia=
tely. Before opening any mail and
attachments please check them for viruses and defect.

---------------------------------------------------------------------------=
--------------------------------------------

--===============8424227357463092328==--

