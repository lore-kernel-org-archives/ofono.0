Content-Type: multipart/mixed; boundary="===============0575016568016115294=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Add CNAP support
Date: Thu, 16 Dec 2010 18:49:20 -0600
Message-ID: <4D0AB390.8060905@gmail.com>
In-Reply-To: <1291746792-8061-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0575016568016115294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 12/07/2010 12:33 PM, Gustavo F. Padovan wrote:
> With CNAP phonesim can tell the Caller Name within the RING comand
> ---
>  src/callmanager.cpp       |   16 +++++++++-------
>  src/callmanager.h         |    5 +++--
>  src/control.cpp           |    4 ++--
>  src/control.h             |    2 +-
>  src/controlbase.ui        |   16 ++++++++++++++++
>  src/default.xml           |   19 +++++++++++++++++++
>  src/hardwaremanipulator.h |    2 +-
>  src/phonesim.cpp          |    4 ++--
>  8 files changed, 53 insertions(+), 15 deletions(-)
> =


Patch has been applied, thanks.  I added a bit more refinement to
CLIP/CNAP handling afterwards.  Let me know if I broke anything.

Regards,
-Denis

--===============0575016568016115294==--

