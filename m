Content-Type: multipart/mixed; boundary="===============4702134460464891417=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ICCID not requested when PIN is locked
Date: Sat, 01 Nov 2014 22:09:34 -0500
Message-ID: <5455A06E.1020209@gmail.com>
In-Reply-To: <CAH4ZQws3o=KqPhXeFiwzQB8Y+XY_AYUFR5sU5XvRZRno_oT8ng@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4702134460464891417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/29/2014 03:42 AM, Enrico Sau wrote:
>
>     You can also add code to try re-reading the ICCID when PIN is
>     entered. Patches are always welcome.
>
> =E2=80=8BOk, this is what I would like to do, but code is quite complex i=
n sim
> interface, can you give me some hint?
>

You can always try to read ICCID again after the PIN has been retrieved =

if the ICCID is missing.  e.g. something like:

if (sim->iccid =3D=3D NULL)
	sim_iccid_changed(SIM_EF_ICCID_FILEID, sim);

in sim_initialize_after_pin()

Regards,
-Denis

--===============4702134460464891417==--

