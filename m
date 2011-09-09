Content-Type: multipart/mixed; boundary="===============1248058596364068220=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/12] Add handsfree atom for HFP-specific capabilities
Date: Fri, 09 Sep 2011 00:13:48 -0500
Message-ID: <4E69A08C.2060107@gmail.com>
In-Reply-To: <1316104483-13144-3-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1248058596364068220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 09/15/2011 11:34 AM, Mikel Astiz wrote:
> ---
>  Makefile.am         |    6 +-
>  include/dbus.h      |    1 +
>  include/handsfree.h |   57 +++++++++++++
>  src/handsfree.c     |  223 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/ofono.h         |    1 +
>  5 files changed, 286 insertions(+), 2 deletions(-)
>  create mode 100644 include/handsfree.h
>  create mode 100644 src/handsfree.c
> =


Patch has been applied, however thanks to the magic of git I split it
into three patches in line with our 'Submitting patches' guidelines.

When adding new atoms I like the patches to be structured this way:

- patch against include/dbus.h
- patch adding new include/fooatom.h + Makefile.am changes
- patch including new src/foo.c + Makefile.am and ofono.h changes

Regards,
-Denis

--===============1248058596364068220==--

