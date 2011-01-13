Content-Type: multipart/mixed; boundary="===============8826371941490791895=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add CDIP support
Date: Thu, 13 Jan 2011 16:11:01 -0600
Message-ID: <4D2F7875.1050405@gmail.com>
In-Reply-To: <1294830432-6618-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8826371941490791895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/12/2011 05:07 AM, Lucas De Marchi wrote:
> With CDIP phonesim can tell the Called Line Identification within the
> RING comand according to 27.007 section 7.9.
> ---
>  src/callmanager.cpp       |   21 +++++++++++++++------
>  src/callmanager.h         |    8 +++++---
>  src/control.cpp           |    8 ++++++--
>  src/control.h             |    2 +-
>  src/default.xml           |   19 +++++++++++++++++++
>  src/hardwaremanipulator.h |    2 +-
>  src/phonesim.cpp          |    4 ++--
>  7 files changed, 49 insertions(+), 15 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============8826371941490791895==--

