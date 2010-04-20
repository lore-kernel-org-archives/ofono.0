Content-Type: multipart/mixed; boundary="===============4617892105364507012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: Free some resources after client disconnects.
Date: Tue, 20 Apr 2010 15:42:53 -0500
Message-ID: <201004201542.53995.denkenz@gmail.com>
In-Reply-To: <1271738648-21745-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4617892105364507012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Also zero SimRules::toolkitApp to avoid segfaults before the field
> is initialised.
> =

> Note there may be more places leaking resources.
> ---
>  src/phonesim.cpp |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)

Patch has been applied, thanks.

Regards,
-Denis

--===============4617892105364507012==--

