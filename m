Content-Type: multipart/mixed; boundary="===============4561682055159750663=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 0/6] Add location-reporting atom
Date: Wed, 23 Feb 2011 18:55:26 -0600
Message-ID: <4D65AC7E.5000804@gmail.com>
In-Reply-To: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4561682055159750663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/22/2011 12:35 PM, Lucas De Marchi wrote:
> From: Lucas De Marchi <lucas.de.marchi@gmail.com>
> =

> This is the 4th version of the location-reporting patches (previous title=
 was
> "Add GPS atom"). I worked with Rafael Ignacio Zurita to implement this la=
st
> version, making some changes in order to fit the new design as discussed =
on irc.
> =

> Now when a client calls 'Request()' we give it a file
> descriptor in which the location reporting will be written. By checking t=
he
> 'Type' property the client can decide what to do with such information. A=
s of
> now only NMEA is supported and it's implemented on mbm modem.
> =

> If client exits or calls 'Release()', the location reporting is disabled.
> =

> Rafael Ignacio Zurita (6):
>   location-reporting: add public header
>   location-reporting: add atom implementation
>   mbmmodem: add location-reporting driver implementation
>   mbm: add location-reporting atom
>   udev: add location-reporting device to mbm
>   location-reporting: add documentation
> =

>  Makefile.am                           |   11 +-
>  doc/location-reporting-api.txt        |   39 ++++
>  drivers/mbmmodem/location-reporting.c |  247 +++++++++++++++++++++
>  drivers/mbmmodem/mbmmodem.c           |    2 +
>  drivers/mbmmodem/mbmmodem.h           |    3 +
>  include/location-reporting.h          |   81 +++++++
>  plugins/mbm.c                         |    8 +
>  plugins/udev.c                        |    5 +-
>  src/location-reporting.c              |  393 +++++++++++++++++++++++++++=
++++++
>  src/ofono.h                           |    2 +
>  10 files changed, 785 insertions(+), 6 deletions(-)
>  create mode 100644 doc/location-reporting-api.txt
>  create mode 100644 drivers/mbmmodem/location-reporting.c
>  create mode 100644 include/location-reporting.h
>  create mode 100644 src/location-reporting.c
> =


So I applied all of these patches, however see my comments for patch 3.

Regards,
-Denis

--===============4561682055159750663==--

