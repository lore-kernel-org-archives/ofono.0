Content-Type: multipart/mixed; boundary="===============4026646915150605029=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Mon, 27 Jul 2009 18:13:46 -0500
Message-ID: <200907271813.47067.denkenz@gmail.com>
In-Reply-To: <1248106322-5885-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4026646915150605029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This uses plain files in /var/cache/ofono for storing contents of the
> operator lists to avoid possibly numerous queries to the SIM on every
> startup.  Files are indexed with IMSI.  I'm not 100% sure about the
> autoconf magic.
>
> Users need to rerun bootstrap-configure after applying this.
>
> Depends on [PATCH] Return SIM file access conditions from read_file_info.

This patch has been pushed.  Thanks.

Regards,
-Denis


--===============4026646915150605029==--

