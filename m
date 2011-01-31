Content-Type: multipart/mixed; boundary="===============1582068012067230888=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Support for pkg-config
Date: Mon, 31 Jan 2011 10:53:51 +0100
Message-ID: <1296467631.1520.196.camel@aeonflux>
In-Reply-To: <201101311035.01012.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1582068012067230888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Name: @PACKAGE@
> > Description: oFono - Open Source Telephony
> > Requires: glib-2.0 dbus-1
> =

> Hmm, wasn't the goal to not leak glib through the public API? I could not=
 find =

> any glib type from a quick check in include/ofono/ ...

let's face it, you will integrate with glib one way or another in your
plugin. That we don't wanna our API to be using glib types is a
different story.

Regards

Marcel



--===============1582068012067230888==--

