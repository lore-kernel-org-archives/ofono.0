Content-Type: multipart/mixed; boundary="===============3904668054160845321=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 01/19] write_file: make transaction-safe
Date: Thu, 05 Aug 2010 12:03:34 -0500
Message-ID: <4C5AEEE6.4040504@gmail.com>
In-Reply-To: <53fe712f7b5927ee95d34c9d3d66751136e6ee6f.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3904668054160845321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 08/03/2010 06:50 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> write_file(), as written wasn't transaction-safe; a crash bewtween a
> file being open and the buffer being written before a safe close would
> leave the file with a set of undetermined contents.
> =

> Modified to the file is written to a temporary file name; once
> completed, it is renamed to the final name. This way, a crash in the
> middle doesn't leave half-baked files.

This patch has now been applied.

Regards,
-Denis

--===============3904668054160845321==--

