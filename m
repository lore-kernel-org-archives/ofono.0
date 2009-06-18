Content-Type: multipart/mixed; boundary="===============7459299240370254563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Change sim_ops plugin interface to allow acces to linear
 fixed files
Date: Thu, 18 Jun 2009 02:28:38 -0500
Message-ID: <200906180228.39043.denkenz@gmail.com>
In-Reply-To: <1245296684-15235-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7459299240370254563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wednesday 17 June 2009 22:44:44 Andrzej Zaborowski wrote:
> (iow record based files), both read and update access.
> Implement writing sim files through AT.
>
> Depends on "[PATCH] Use GET RESPONSE sim command to retrieve EF length."

Patch has been applied.  Can you also add capability to write to cyclic fil=
es?  =

This can be useful to update EFoci and EFici.  This is essentially the same=
 as =

write_file_linear except no record parameter is used.

Regards,
-Denis

--===============7459299240370254563==--

