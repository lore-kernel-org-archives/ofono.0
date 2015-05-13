Content-Type: multipart/mixed; boundary="===============5119272366419739045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] tc65: Replace tc65 plugin with cinterion plugin
Date: Wed, 13 May 2015 09:58:25 -0500
Message-ID: <55536691.6060909@gmail.com>
In-Reply-To: <1431451382-7788-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5119272366419739045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 05/12/2015 12:22 PM, Alex J Lennon wrote:
> On the basis that tc6x and other Cinterion devices will likely
> have similar firmware requirements, provide a generic Cinterion
> plugin which is functionally identical to the replaced tc65 plugin.
>
> The udev implementation retains support for "tc65" name for
> backwards compatibility, and adds support for the new "cinterion"
> name.
> ---
>   Makefile.am         |   4 +-
>   plugins/cinterion.c | 248 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   plugins/tc65.c      | 245 ---------------------------------------------=
------
>   plugins/udev.c      |   9 +-
>   4 files changed, 256 insertions(+), 250 deletions(-)
>   create mode 100644 plugins/cinterion.c
>   delete mode 100644 plugins/tc65.c
>

Patch has been applied, thanks.

Regards,
-Denis

--===============5119272366419739045==--

