Content-Type: multipart/mixed; boundary="===============8809116382887814890=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] phonesim: Add Timer Management commands to sim app
 menu.
Date: Thu, 25 Nov 2010 16:50:45 -0600
Message-ID: <4CEEE845.40106@gmail.com>
In-Reply-To: <1290519286-25046-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8809116382887814890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/23/2010 07:34 AM, Andrzej Zaborowski wrote:
> I changed uint8_t to unsigned char here, but strangely the old version
> still compiles for me.
> ---
>  src/qsimcommand.cpp          |   83 ++++++++++++++++++++
>  src/qsimcommand.h            |    3 +
>  src/qsimterminalresponse.cpp |   59 ++++++++++++++
>  src/qsimterminalresponse.h   |    3 +
>  src/simapplication.cpp       |  171 ++++++++++++++++++++++++++++++++++++=
++++++
>  src/simapplication.h         |    6 ++
>  6 files changed, 325 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============8809116382887814890==--

