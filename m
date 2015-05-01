Content-Type: multipart/mixed; boundary="===============0931856699903638159=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] cinterion: Replace tc65 plugin with vendor generic
 cinterion plugin
Date: Fri, 01 May 2015 09:05:50 -0500
Message-ID: <5543883E.4090900@gmail.com>
In-Reply-To: <1430420897-31084-2-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0931856699903638159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 04/30/2015 02:08 PM, Alex J Lennon wrote:
> On the basis that cinterion tx6x, ehsx, other devices will likely
> have similar firmware requirements, implement a generic cinterion
> plugin.
>
> The udev implementation retains support for "tc65" device for
> backwards compatibility, and adds support for  "ehs6" and generic
> "cinterion" devices.
> ---
>   Makefile.am         |   4 +-
>   plugins/cinterion.c | 249 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   plugins/tc65.c      | 245 ---------------------------------------------=
------

Might be easier & cleaner to start off with this patch first.  Copying =

the virgin tc65.c to cinterion.c.

>   plugins/udev.c      |  11 ++-

Then add quirk handling in patch 1 and add ehs6 specific logic to =

plugins/udev.c in follow on commits.

>   4 files changed, 259 insertions(+), 250 deletions(-)
>   create mode 100644 plugins/cinterion.c
>   delete mode 100644 plugins/tc65.c
>

Regards,
-Denis


--===============0931856699903638159==--

