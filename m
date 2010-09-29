Content-Type: multipart/mixed; boundary="===============3390967996042662624=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: simulate Send USSD in sim app
Date: Wed, 29 Sep 2010 05:03:15 -0500
Message-ID: <4CA30EE3.8000606@gmail.com>
In-Reply-To: <1285754259.3417.22.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3390967996042662624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 09/29/2010 04:57 AM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>> ---
>>>  src/default.xml        |   23 +++++++++-
>>>  src/qsimcommand.cpp    |    6 ++-
>>>  src/simapplication.cpp |  114 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  src/simapplication.h   |    2 +
>>>  4 files changed, 142 insertions(+), 3 deletions(-)
>>>  mode change 100644 =3D> 100755 src/simapplication.cpp
> =

> what was wrong with the clear indication that this patch is messed up.
> =

> This patch comes from a stupid Windows system that tries to change every
> single mode to 0755. Please fix this.

Whoops, my fault totally missed this.  I wonder if there are git
settings that can warn about this...

Regards,
-Denis

--===============3390967996042662624==--

