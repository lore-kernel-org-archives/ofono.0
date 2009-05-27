Content-Type: multipart/mixed; boundary="===============3800977938807338097=="
MIME-Version: 1.0
From: Leandro Dorileo <ldorileo@gmail.com>
Subject: Re: two patches for voicecall.c
Date: Wed, 27 May 2009 08:58:17 -0400
Message-ID: <d68f80d90905270558v73463b22w9568875781c924a5@mail.gmail.com>
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709D989BF6F@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3800977938807338097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Minjun

On Wed, May 27, 2009 at 3:46 AM, Li, Minjun <minjun.li@intel.com> wrote:
> Hi Folks,
> I have made 2 patches for minor bugs in functions of voicecall_busy and d=
ial_callback in /src/voicecall.c.
> The first one is to use the function pointer set_udub to replace release_=
specific.
> The second one is to delete the repeated calling of voicecall_create in d=
ial_callback function, since it was called in previous line in the same fun=
ction.


I re-read your patch and voicecall.c source code comparing your
changes, your patch seems to be ok, but your log message doesn`t seem
to describe well your changes, your first patch tells in the
subject(file name and so on) you changed the function pointer(on
something not specified) but you changed the verification of it.

Regards...

-- =

(=C2=B0=3D   Leandro Dorileo
//\    ldorileo(a)gmail.com   -   http://www.dorilex.net
V_/  Software is a matter of freedom.

--===============3800977938807338097==--

