Content-Type: multipart/mixed; boundary="===============5392898957541503897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] phonesim: Refactor SimApplication api, add a UI.
Date: Fri, 16 Apr 2010 15:06:53 -0500
Message-ID: <201004161506.54015.denkenz@gmail.com>
In-Reply-To: <1270795455-7067-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5392898957541503897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Try to move all the AT parsing / generating out of applications, just send
> ready envelopes, terminal responses, commands between the application
> and the SimRules class.
> ---
>  src/control.cpp             |   35 +++++++++++
>  src/control.h               |    1 +
>  src/controlbase.ui          |   71 ++++++++++++++++++++++
>  src/hardwaremanipulator.cpp |   42 +++++++++++++
>  src/hardwaremanipulator.h   |    7 ++
>  src/phonesim.cpp            |  138
>  +++++++++++++++++++++++++++++++++++++++---- src/phonesim.h              =
| =

>    6 ++
>  src/simapplication.cpp      |  137
>  ++++++++++++++---------------------------- src/simapplication.h        |=
  =

>  27 +++++----
>  9 files changed, 349 insertions(+), 115 deletions(-)

This patch has now been applied, thanks.

Regards,
-Denis

--===============5392898957541503897==--

