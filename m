Content-Type: multipart/mixed; boundary="===============5153204425548723902=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Thu, 19 Jan 2012 08:03:55 +0200
Message-ID: <4F17B24B.70606@canonical.com>
In-Reply-To: <0F68B52D2432864190BC72F760407FE923CF24E757@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5153204425548723902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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


- -- =

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

--===============5153204425548723902==--

