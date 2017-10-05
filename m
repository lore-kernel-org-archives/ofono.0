Content-Type: multipart/mixed; boundary="===============3053323651705580126=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 1/5] comp128: GSM algorithm (comp128) implementation.
Date: Thu, 05 Oct 2017 12:16:36 +0800
Message-ID: <20171005041636.wwefmcrg3cunb6yc@nataraja>
In-Reply-To: <1507048516-15623-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3053323651705580126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

there are three COMP128 algorithms: v1, v2 and v3.

The code you're submitting only implements COMP128v1, so I suggest you docu=
ment
that in the commit log / subject to avoid any misunderstandings.

Just stating "COMP128" typically refers to the entire family of algorithms.

A GPLv2+ licensed implementation for v2 and v3 can be found at
http://cgit.osmocom.org/libosmocore/plain/src/gsm/comp in case you ever nee=
d it.

-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============3053323651705580126==--

