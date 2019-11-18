Content-Type: multipart/mixed; boundary="===============4425571166224013269=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim 01/13] Use nullptrs
Date: Mon, 18 Nov 2019 14:05:29 -0600
Message-ID: <0ae304e4-11bd-6131-d1b7-dda664df2e3d@gmail.com>
In-Reply-To: <20191112213719.9309-2-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4425571166224013269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 11/12/19 3:37 PM, Jonah Br=C3=BCchert wrote:
> Done using the modernize-use-nullptr check of clang-tidy
> ---
>   src/aidapplication.h              |  2 +-
>   src/callmanager.h                 |  2 +-
>   src/conformancesimapplication.cpp |  2 +-
>   src/control.cpp                   |  2 +-
>   src/control.h                     |  2 +-
>   src/gsmspec.cpp                   | 20 ++++++------
>   src/hardwaremanipulator.h         |  2 +-
>   src/main.cpp                      |  6 ++--
>   src/phonesim.cpp                  | 54 +++++++++++++++----------------
>   src/phonesim.h                    |  2 +-
>   src/qatresult.cpp                 |  2 +-
>   src/qatresultparser.cpp           |  8 ++---
>   src/qatutils.cpp                  | 12 +++----
>   src/qcbsmessage.cpp               |  2 +-
>   src/qsmsmessage.cpp               |  8 ++---
>   src/qsmsmessage_p.h               |  4 +--
>   src/qwsppdu.cpp                   |  4 +--
>   src/server.cpp                    |  4 +--
>   src/simapplication.cpp            | 22 ++++++-------
>   src/simapplication.h              |  6 ++--
>   20 files changed, 83 insertions(+), 83 deletions(-)
> =


Patches 1 & 2 applied, thanks.

Regards,
-Denis

--===============4425571166224013269==--

