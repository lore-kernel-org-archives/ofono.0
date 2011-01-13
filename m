Content-Type: multipart/mixed; boundary="===============5084328546702850634=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: fix for sigsegv fault
Date: Thu, 13 Jan 2011 10:03:45 -0600
Message-ID: <4D2F2261.3040304@gmail.com>
In-Reply-To: <1294907400-25120-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5084328546702850634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/13/2011 02:30 AM, Jeevaka Badrappan wrote:
> Fixes the issue in List count handling which might result
> in sigsegv during destruction. Also added additional check
> for start button handling.
> ---
>  src/control.cpp  |    3 ++-
>  src/phonesim.cpp |   10 +++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> =


Patch has been applied, thanks.

--===============5084328546702850634==--

