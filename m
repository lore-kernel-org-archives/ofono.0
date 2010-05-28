Content-Type: multipart/mixed; boundary="===============3731669238367661079=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] Bluetooth DUN modem prototype
Date: Fri, 28 May 2010 09:19:42 -0500
Message-ID: <201005280919.42676.denkenz@gmail.com>
In-Reply-To: <1274849503-18388-6-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3731669238367661079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> Add a still dummy DUN code, now it can only creates and removes modems.
> The DUN plugin follows the HFP one a lot, the is basics a copy of some
> HFP plugin's parts.
> =


Me and Marcel talked about this a few weeks ago, and we decided that we'd =

prefer the DUN client to be a separate daemon shipped within oFono source, =

with its own D-Bus interface.

The reason is that DUN client needs to accept a custom dial string for most =

modems out there, and there's no way to do this in oFono today.  However, y=
ou =

can re-use most of oFono's plumbing for this work, including gatchat & =

bluetooth.c

Regards,
-Denis

--===============3731669238367661079==--

